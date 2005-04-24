From: Junio C Hamano <junkio@cox.net>
Subject: Re: [FILE] Docs update
Date: Sun, 24 Apr 2005 14:23:59 -0700
Message-ID: <7vsm1fswb4.fsf@assigned-by-dhcp.cox.net>
References: <426BF790.9070406@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
	GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 23:19:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPoVs-0000aA-RR
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 23:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbVDXVY2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 17:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbVDXVY2
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 17:24:28 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:43948 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S262434AbVDXVYD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2005 17:24:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050424212358.GDWY19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 24 Apr 2005 17:23:58 -0400
To: David Greaves <david@dgreaves.com>
In-Reply-To: <426BF790.9070406@dgreaves.com> (David Greaves's message of
 "Sun, 24 Apr 2005 20:46:24 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DG" == David Greaves <david@dgreaves.com> writes:

Looking much better than before.

DG> ################################################################
DG> commit-tree
DG> 	commit-tree <tree> [-p <parent tree>]*   < changelog
DG> Options
DG> ...
DG> -p <parent tree>
DG> 	Each -p indicates a the id of a parent commit object.

Just for consistency:

    commit-tree <tree> [-p <parent commit>]*   < changelog
    -p <parent commit>
	
DG> ################################################################
DG> git-export
DG> 	git-export top [base]

DG> probably deprecated:
DG> ...
DG> Although in Linus' distribution show-diff is not part of 'core' git.

Perhaps:

    Although in Linus' distribution, git-export is not part of 'core' git.

DG> ################################################################
DG> merge-base
DG> 	merge-base <commit> <commit>
DG> ...
DG> It essentially returns either A or B randomly.

You may want to check this with Daniel Barkalow; the commit ID
0345fb64d68ba9e1e853c0ee9526fa93c45a67f9 is the latest one that
touches merge-base.c which has an extensive rework [*1*].

DG> ################################################################
DG> merge-cache
DG> 	merge-cache <merge-program> (-a | -- | <file>*) 

DG> Typically this is run with the a script calling the merge command from
DG> the RCS package.

DG> Example script:

Drop example script and refer the reader to git-merge-one-file-script.  
The one you attached is already old and missing the last three
parameter.

Addition before rev-tree:

    rev-list <commit>

    Lists commit objects in reverse chronological order starting
    at the given commit, taking ancestry relationship into
    account.  This is useful to produce human-readable log output.

DG> ################################################################
DG> show-diff
DG> 	show-diff [-R] [-q] [-s] [-z] [paths...]

DG> Shows the difference between the version of the specified file on disk
DG> and the file in the cache.

DG> -R
DG> 	Reverse the diff

DG> -q
DG> 	Reduce verbosity

This flag means "Do not complain on non-existent files (i.e. a
dircache entry is found but corresponding file is not in the
working tree).

DG> -s
DG> 	Remain silent even on nonexisting files (forces -q)

This flag means "Do not show the diff text.  Just output SHA1
and name for changed paths."  You are correct that this implies -q.  

DG> -z
DG> 	Machine readable (including \0 line termination on output)
	
This flag changes the behaviour of the program in number of
subtle ways for script consumption:

    -z
        Machine readable.

        . Each output record has the path name at the end of the
          record, instead of the front.
        . Each record is terminated with a NUL '\0' character.
        . For unchanged files, nothing is output.
        . For an unmerged file, the following is output:
            U name
        . For a deleted file, the following is output:
            X name
        . For a modified file, the following is output:
            SHA1 name
          where SHA1 is from the dircache entry.

DG> Although in Linus' distribution show-diff is not part of 'core' git.

Perhaps:

    Although in Linus' distribution, show-diff is not part of 'core' git.


[Footnotes]

*1* Here is the jit-trackdown script to help you find out this
kind of thing.  Sample usage:

    $ jit-trackdown $(cat .git/heads/linus) merge-base.c

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
cat >jit-trackdown <<\EOF
#!/bin/sh

# Usage: jit-trackdown <commit> paths...

tmp=.jit-trackdown.$$
hits=$tmp-hits

trap 'rm -f $tmp-*' 0 1 2 3 15

tty -s || to_tty=:

head="$1"
shift
rev-list "$head" |
while read commit
do
    for p in $(cat-file commit "$commit" | sed -ne 's/^parent //p;/^$/q')
    do
      $to_tty echo >&2 -n .
      diff-tree -r -z "$p" "$commit" "$@" | jit-diff-tree-helper "$@" >$hits
      test -s "$hits" || continue;
      {
	  $to_tty echo >&2
	  echo "commit $commit"
	  cat-file commit "$commit"
	  echo
	  cat "$hits"
      } | ${PAGER-less}
      case "$to_tty" in
      '')
	  echo >&2 -n "Dig further [Y/n]? "
	  read next </dev/tty
	  case "$next" in
	  [nN]) exit 0 ;;
	  esac
      esac
    done
done
$to_tty echo >&2

EOF
cat >jit-diff-tree-helper <<\EOF
#!/usr/bin/perl -w

use strict;
use File::Temp qw(mkstemp);
use Getopt::Long;

my $reverse_diff;
GetOptions('reverse' => \$reverse_diff)
    or die "usage: $0 [ --reverse ] [paths...]";

sub cat_file {
    my ($sha1, $file) = @_;
    unless (defined $sha1) {
	return (0, "/dev/null");
    }
    if ($sha1 =~ /^0{40}$/) {
	return (0, $file);
    }
    local $/; # slurp mode
    open I, "-|", "cat-file", "blob", $sha1
	or die "$0: cannot read $sha1";
    my ($o, $filename) = mkstemp(",,jit-diff-tree-helperXXXXXX");
    print $o join("",<I>);
    close I
	or die "$0: closing cat-file pipe from $sha1";
    close $o
	or die "$0: closing write fd to $filename";
    return (1, $filename);
}
$/ = "\0";
my $rM = "[0-7]+";
my $rI = "[0-9a-f]{40}";
while (<STDIN>) {
    my ($old, $new, $file, $o_is_temp, $n_is_temp);
    chomp;
    if (/^\+$rM\tblob\t($rI)\t(.*)$/os) {
	($old, $new, $file) = (undef, $1, $2);
    }
    elsif (/^-$rM\tblob\t($rI)\t(.*)$/os) {
	($old, $new, $file) = ($1, undef, $2);
    }
    elsif (/^\*$rM->$rM\tblob\t($rI)->($rI)\t(.*)$/os) {
	($old, $new, $file) = ($1, $2, $3);
    }
    else {
	chomp;
	print STDERR "warning: $0: ignoring $_\n";
	next;
    }
    if (@ARGV) {
	my $matches = 0;
	for (@ARGV) {
	    my $l = length($_);
	    if ($file eq $_ ||
		(substr($file, 0, $l) eq $_ &&
		 substr($file, $l, 1) eq "/")) {
		$matches = 1;
		last;
	    }
	}
	next unless $matches;
    }
    ($o_is_temp, $old) = cat_file $old, $file;
    ($n_is_temp, $new) = cat_file $new, $file;
    my @a = ($reverse_diff) ? ($new, $old) : ($old, $new);
    system "diff", "-L", "k/$file", "-L", "l/$file", "-pu", @a;
    unlink $old if ($o_is_temp);
    unlink $new if ($n_is_temp);
}
EOF
chmod +x jit-trackdown jit-diff-tree-helper


