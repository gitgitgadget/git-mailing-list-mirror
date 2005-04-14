From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: Merge with git-pasky II.
Date: Thu, 14 Apr 2005 14:16:24 +0200
Message-ID: <20050414121624.GZ25711@pasky.ji.cz>
References: <20050414002902.GU25711@pasky.ji.cz> <20050413212546.GA17236@64m.dyndns.org> <20050414004504.GW25711@pasky.ji.cz> <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org> <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 14:14:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM3EZ-0007TA-Du
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 14:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVDNMRb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 08:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVDNMRb
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 08:17:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22211 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261494AbVDNMQi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 08:16:38 -0400
Received: (qmail 5260 invoked by uid 2001); 14 Apr 2005 12:16:24 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 14, 2005 at 01:14:13PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Here is a diff to update the git-merge.perl script I showed you
> earlier today ;-).  It contains the following updates against
> your HEAD (bb95843a5a0f397270819462812735ee29796fb4).

Bah, you outran me. ;-)

>  * git-merge.perl command we talked about on the git list.  I've
>    covered the changed-to-the-same case etc.  I still haven't done
>    anything about file-vs-directory case yet.
> 
>    It does warn when it needed to run merge to automerge and let
>    merge give a warning message about conflicts if any.  In
>    modify/remove cases, modified in one but removed in the other
>    files are left in either $path~A~ or $path~B~ in the merge
>    temporary directory, and the script issues a warning at the
>    end.

I think I will take it rather my working git merge implementation - it's
getting insane in bash. ;-)

I'll change it to use the cool git-pasky stuff (commit-id etc) and its
style of committing - that is, it will merely record the update-caches
to be done upon commit, and it will read-tree the branch we are merging
to instead of the ancestor. (So that git diff gives useful output.)

>  * show-files and ls-tree updates to add -z flag to NUL terminate records;
>    this is needed for git-merge.perl to work.
> 
>  * show-diff updates to add -r flag to squelch diffs for files not in
>    the working directory.  This is mainly useful when verifying the
>    result of an automated merge.

-r traditionally means recursive - what's the reasoning behind the
choice of this letter?

>  * update-cache updates to add "--cacheinfo mode sha1" flag to register
>    a file that is not in the current working directory.  Needed for
>    minimum-checkout merging by git-merge.perl.
> 
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> ---
> 
>  git-merge.perl |  247 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  ls-tree.c      |    9 +-
>  show-diff.c    |   11 +-
>  show-files.c   |   12 ++
>  update-cache.c |   25 +++++
>  5 files changed, 296 insertions(+), 8 deletions(-)
> 
> diff -x .git -Nru ,,1/git-merge.perl ,,2/git-merge.perl
> --- ,,1/git-merge.perl	1969-12-31 16:00:00.000000000 -0800
> +++ ,,2/git-merge.perl	2005-04-14 04:00:14.000000000 -0700
> @@ -0,0 +1,247 @@
> +#!/usr/bin/perl -w
> +
> +use Getopt::Long;

use strict?

> +
> +my $full_checkout = 0;
> +my $oneside_checkout = 0;
> +GetOptions("full" => \$full_checkout,
> +	   "oneside" => \$oneside_checkout)
> +    or die;
> +
> +if ($full_checkout) {
> +    $oneside_checkout = 1;
> +}
> +
> +sub read_rev_tree {
> +    my (@head) = @_;
> +    my ($fhi);
> +    open $fhi, '-|', 'rev-tree', '--edges', @head
> +	or die "$!: rev-tree --edges @head";
> +    my %common;
> +    while (<$fhi>) {
> +	chomp;
> +	(undef, undef, my @common) = split(/ /, $_);
> +	for (@common) {
> +	    if (s/^([a-f0-f]{40}):3$/$1/) {
> +		$common{$_}++;
> +	    }
> +	}
> +    }
> +    close $fhi;
> +
> +    my @common = (map { $_->[1] }
> +		  sort { $b->[0] <=> $a->[0] }
> +		  map { [ $common{$_} => $_ ] }
> +		  keys %common);
> +
> +    return $common[0];
> +}

It'd be simpler to do just

	my @common = (map { $common{$_} }
	              sort { $b <=> $a }
	              keys %common)

But I really think this is a horrible heuristic. I believe you should
take the latest commit in the --edges output, and from that choose the
base whose rev-tree --edges the_base merged_branch has the least lines
on output. (That is, the path to it is shortest - ideally it's already
part of the merged_branch.)

> +
> +sub read_commit_tree {
> +    my ($commit) = @_;
> +    my ($fhi);
> +    open $fhi, '-|', 'cat-file', 'commit', $commit
> +	or die "$!: cat-file commit $commit";
> +    my $tree = <$fhi>;
> +    close $fhi;
> +    $tree =~ s/^tree //;
> +    return $tree;
> +}
> +
> +# Reads diff-tree -r output and gives a hash that maps a path
> +# to 3-tuple (old-mode new-mode new-sha).
> +# When creating, old-mode is undef.  When removing, new-* are undef.

What about

sub OLDMODE { 0 }
sub NEWMODE { 1 }
sub NEWSHA { 2 }

and then using that when accessing the tuple? Would make the code
much more readable.

> +sub read_diff_tree {
> +    my (@tree) = @_;
> +    my ($fhi);
> +    local ($_, $/);
> +    $/ = "\0"; 
> +    my %path;
> +    open $fhi, '-|', 'diff-tree', '-r', @tree
> +	or die "$!: diff-tree -r @tree";
> +    while (<$fhi>) {
> +	chomp;
> +	if (/^\*([0-7]+)->([0-7]+)\tblob\t[0-9a-f]+->([0-9a-f]{40})\t(.*)$/s) {
> +	    $path{$4} = [$1, $2, $3];
> +	}
> +	elsif (/^\+([0-7]+)\tblob\t([0-9a-f]{40})\t(.*)$/s) {
> +	    $path{$3} = [undef, $1, $2];
> +	}
> +	elsif (/^\-([0-7]+)\tblob\t[0-9a-f]{40}\t(.*)$/s) {
> +	    $path{$2} = [$1, undef, undef];
> +	}
> +	else {
> +	    die "cannot parse diff-tree output: $_";
> +	}
> +    }
> +    close $fhi;
> +    return %path;
> +}
> +
> +sub read_show_files {
> +    my ($fhi);
> +    local ($_, $/);
> +    $/ = "\0"; 
> +    open $fhi, '-|', 'show-files', '-z'
> +	or die "$!: show-files -z";
> +    my (@path) = map { chomp; $_ } <$fhi>;
> +    close $fhi;
> +    return @path;
> +}
> +
> +sub checkout_file {
> +    my ($path, $info) = @_;
> +    my (@elt) = split(/\//, $path);
> +    my $j = '';
> +    my $tail = pop @elt;
> +    my ($fhi, $fho);
> +    for (@elt) {
> +	mkdir "$j$_";
> +	$j = "$j$_/";
> +    }
> +    open $fho, '>', "$path";
> +    open $fhi, '-|', 'cat-file', 'blob', $info->[2]
> +	or die "$!: cat-file blob $info->[2]";
> +    while (<$fhi>) {
> +	print $fho $_;
> +    }
> +    close $fhi;
> +    close $fho;
> +    chmod oct("0$info->[1]"), "$path";
> +}
> +
> +sub record_file {
> +    my ($path, $info) = @_;
> +    system ('update-cache', '--add', '--cacheinfo',
> +	    $info->[1], $info->[2], $path);
> +}
> +
> +sub merge_tree {
> +    my ($path, $info0, $info1) = @_;
> +    checkout_file(',,merge-0', $info0);
> +    checkout_file(',,merge-1', $info1);
> +    system 'checkout-cache', $path;
> +    my ($fhi, $fho);
> +    open $fhi, '-|', 'merge', '-p', ',,merge-0', $path, ',,merge-1';
> +    open $fho, '>', "$path+";
> +    local ($/);
> +    while (<$fhi>) { print $fho $_; }
> +    close $fhi;
> +    close $fho;
> +    unlink ',,merge-0', ',,merge-1';
> +    rename "$path+", $path;
> +    # There is no reason to prefer info0 over info1 but
> +    # we need to pick one.
> +    chmod oct("0$info0->[1]"), "$path";
> +}

It is a good idea to check merge's exit code and give a notice at the
end if there were any conflicts.

> +
> +# Find common ancestor of two trees.
> +my $common = read_rev_tree(@ARGV);
> +print "Common ancestor: $common\n";
> +
> +# Create a temporary directory and go there.
> +system 'rm', '-rf', ',,merge-temp';

Can't we call it just ,,merge?

> +for ((',,merge-temp', '.git')) { mkdir $_; chdir $_; }
> +symlink "../../.git/objects", "objects";
> +chdir '..';
> +
> +my $ancestor_tree = read_commit_tree($common);
> +system 'read-tree', $ancestor_tree;
> +
> +my %tree0 = read_diff_tree($ancestor_tree, read_commit_tree($ARGV[0]));
> +my %tree1 = read_diff_tree($ancestor_tree, read_commit_tree($ARGV[1]));
> +
> +my @ancestor_file = read_show_files();
> +my %ancestor_file = map { $_ => 1 } @ancestor_file;
> +
> +for (@ancestor_file) {
> +    if (! exists $tree0{$_} && ! exists $tree1{$_}) {
> +	if ($full_checkout) {
> +	    system 'checkout-cache', $_;
> +	}
> +	print STDERR "O - $_\n";

Huh, what are you trying to do here? I think you should just record
remove, no? (And I wouldn't do anything with my read-tree. ;-)

> +    }
> +}
> +
> +for my $set ([\%tree0, \%tree1, 'A'], [\%tree1, \%tree0, 'B']) {
> +    my ($treeA, $treeB, $side) = @$set;
> +    while (my ($path, $info) = each %$treeA) {
> +	# In this loop we do not deal with overlaps.
> +	next if (exists $treeB->{$path});
> +
> +	if (! defined $info->[1]) {
> +	    # deleted in this tree only.
> +	    unlink $path;
> +	    system 'update-cache', '--remove', $path;
> +	    print STDERR "$side D $path\n";
> +	}
> +	else {
> +	    # modified or created in this tree only.
> +	    print STDERR "$side M $path\n";
> +	    if ($oneside_checkout) {
> +		checkout_file($path, $info);
> +		system 'update-cache', '--add', "$path";
> +	    } else {
> +		record_file($path, $info);
> +	    }
> +	}
> +    }
> +}
..snip..

Hmm, I think I will just need to play with the script a lot. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
