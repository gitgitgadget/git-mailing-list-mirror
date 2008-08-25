From: bdowning@lavos.net (Brian Downing)
Subject: Re: [RFC] mtn to git conversion script
Date: Mon, 25 Aug 2008 11:35:31 -0500
Message-ID: <20080825163530.GJ31114@lavos.net>
References: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Cc: git@vger.kernel.org, monotone-devel@nongnu.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 18:37:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXf4I-0006ka-KW
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 18:37:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbYHYQft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 12:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbYHYQft
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 12:35:49 -0400
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:60860
	"EHLO QMTA07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753297AbYHYQfs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Aug 2008 12:35:48 -0400
Received: from OMTA12.westchester.pa.mail.comcast.net ([76.96.62.44])
	by QMTA07.westchester.pa.mail.comcast.net with comcast
	id 6aiB1a00P0xGWP857gbYNa; Mon, 25 Aug 2008 16:35:33 +0000
Received: from mnementh.lavos.net ([98.212.138.194])
	by OMTA12.westchester.pa.mail.comcast.net with comcast
	id 6gbX1a00C4BqYqi3YgbXT1; Mon, 25 Aug 2008 16:35:32 +0000
X-Authority-Analysis: v=1.0 c=1 a=powJzsOIrdUA:10 a=vpKcvTkIoZnsgkLQcE8A:9
 a=iPNaCwj6nYnd5TPKXCQA:7 a=2mc2ys2r2LglYGrw8D5-iwdC2cwA:4 a=LY0hPdMaydYA:10
 a=ni6i0uHycfKs8M5bJO8A:9 a=6GpJd8pXhp3K8MehNjsA:7
 a=FR6QGG66L-w-3zdqYMSiu_7YoCQA:4 a=dRaI7wHSYGIA:10
Received: by mnementh.lavos.net (Postfix, from userid 1000)
	id 4316A309F23; Mon, 25 Aug 2008 11:35:31 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <94a0d4530808240218j4bedbe3di99303da9addc93a4@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93640>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 24, 2008 at 12:18:50PM +0300, Felipe Contreras wrote:
> I developed a script that converts a monotone repository into a git
> one (exact clone), I want to contribute it so everybody can use it.
> 
> This is the gist of the script:
> 
> mtn update --revision #{@id} --reallyquiet
> git ls-files --modified --others --exclude-standard -z | git
> update-index --add --remove -z --stdin
> git write-tree
> git write-raw < /tmp/commit.txt
> git update-ref refs/mtn/#{@id} #{@git_id}
> 
> branches.each do |e|
>     git update-ref refs/heads/#{e} #{@git_id}
> end

You definitely want to use fast-import, but you probably want to do
something a lot closer to fast-export for monotone (read: use its
automate stdio interface and avoid expensive calls).

Here's a simple monotone to git converter I wrote.  You'll need the
Monotone::AutomateStdio perl module to use it (which I think I got it
from monotone's net.venge.monotone.contrib.lib.automate-stdio branch).
It is very fast; it can convert the OpenEmbedded repo in something like
5-10 minutes on my machine.

Note that for monotone export to go fast you absolutely /must/ avoid the
get_manifest operation.  In my converter I use the revision information
directly.  Getting the renames right with this is a little tricky; IIRC,
the ordering that works is:

* Rename all renamed files, innermost files first, to temporary names.
* Delete all deleted files, innermost first.
* Rename all temporary names to permanent names, outermost first.
* Add all new/modified files.

Conveniently, all of the above can be done by directly emitting
fast-import commands, so you don't have to keep track of trees directly.
(With one exception, which I'll elaborate on in a different email.)

-bcd

--r5Pyd7+fXNt84Ff3
Content-Type: text/x-perl; charset=us-ascii
Content-Disposition: attachment; filename="mtn-to-git.pl"

#!/usr/bin/perl
# Copyright (C) 2007-2008  Brian Downing
# This program is licensed under version 2 of the GNU GPL.

use strict;
use Monotone::AutomateStdio;
use Date::Parse;

my $D = 0;

my $m = Monotone::AutomateStdio->new($ARGV[0]);

my $revlist = [];
$m->graph($revlist);
my $sorted = [];

for my $rev (@$revlist) {
    push(@$sorted, $rev->{revision_id});
}

my $leaves = [];
$m->leaves($leaves);

$m->toposort($sorted, @$sorted);

my $marks = {};
my $mark = 1;
my $c = 0;

sub quote_file {
    $_ = shift;
    return $_;
    s/\\/\\\\/g;
    s/\n/\\n/g;
    s/"/\\"/g;
    return qq("$_");
}

sub lprint {
    my $fh = shift;
    print @_ if $D;
    print $fh @_;
}

sub lprintf {
    my $fh = shift;
    printf @_ if $D;
    printf $fh @_;
}

my $tmptag = "624d893e-ae1a-42d8-90a9-926a6ceffae8";

open my $fi, '|-', 'git-fast-import --export-marks=file';
for my $rev (@$sorted) {
    my ($time, $author, $msg) = ("0", "__UNKNOWN__", "__UNKNOWN__");
    my @certs;
    my @branches;
    $m->certs(\@certs, $rev);
    for my $cert (@certs) {
        my ($n, $v) = ($cert->{name}, $cert->{value});
        $author = $v if ($n eq 'author');
        $time = $v if ($n eq 'date');
        $msg = $v if ($n eq 'changelog');
        push(@branches, $v) if ($n eq 'branch');
    }
    my $email = $author;
    $msg .= "\nmtn-revision: $rev\n";
    for my $b (sort @branches) {
        $msg .= "mtn-branch: $b\n";
    }
    $time = str2time($time, 'UTC');
    my $mfest = [];
    $m->get_revision($mfest, $rev);
    my $orcount = 0;
    my $add_files = {};
    my $add_dirs = {};
    my $delete_files = {};
    my $from_tmpnames = {};
    my $to_tmpnames = {};
    my $curtmp = 0;
    my @parents;
    for my $e (@$mfest) {
        if ($e->{type} eq 'old_revision') {
            push(@parents, $e->{revision_id});
            ++$orcount;
        } 
        next if $orcount > 1;
        if ($e->{type} eq 'add_file' || $e->{type} eq 'patch') {
            my $id = $e->{file_id} || $e->{to_file_id};
            $add_files->{$e->{name}} = $id;
            unless ($marks->{$id}) {
                my $data;
                $m->get_file(\$data, $id);
                print "new file $id\n" if $D;
                print $fi "blob\n";
                my $len = length($data);
                print $fi "mark :$mark\n";
                $marks->{$id} = $mark++;
                print $fi "data $len\n$data\n";
            }
        } elsif ($e->{type} eq 'add_dir') {
            $add_dirs->{$e->{name}} = 1;
        } elsif ($e->{type} eq 'delete') {
            $delete_files->{$e->{name}} = 1;
        } elsif ($e->{type} eq 'rename') {
            $curtmp++;
            $from_tmpnames->{$e->{from_name}} = "__tmp_${tmptag}_$curtmp";
            $to_tmpnames->{$e->{to_name}} = "__tmp_${tmptag}_$curtmp";
        }
    }
    printf("rev $rev (%d/%d, %.2f%)\n",
           ++$c, scalar(@$sorted), 100*$c/scalar(@$sorted));
    print $fi "reset refs/import\n" unless @parents;
    lprint $fi, "commit refs/import\n";
    print $fi "mark :$mark\n";
    $marks->{$rev} = $mark++;
    if ($author =~ m(\s*(.*?\S)\s*<(.*)>\s*)) {
        $author = $1;
        $email = $2;
    }
    $author =~ s/[<>]/_/g;
    $email =~ s/[<>]/_/g;
    $author =~ s/@.*//;
    print $fi "committer $author <$email> $time +0000\n";
    my $len = length($msg);
    print $fi "data $len\n$msg\n";
    my $from = "from";
    for my $p (@parents) {
        lprint $fi, "$from :$marks->{$p}\n";
        $from = "merge";
    }
    for my $f (sort { length($b) <=> length ($a) } keys %$from_tmpnames) {
        lprintf($fi, "R %s %s\n",
                quote_file($f), quote_file($from_tmpnames->{$f}));
    }
    for my $f (sort { length($b) <=> length ($a) } keys %$delete_files) {
        lprintf($fi, "D %s\n", quote_file($f));
    }
    for my $f (sort { length($a) <=> length ($b) } keys %$to_tmpnames) {
        lprintf($fi, "R %s %s\n",
                quote_file($to_tmpnames->{$f}), quote_file($f));
    }
    for my $f (keys %$add_files) {
        lprintf($fi, "M 0644 :%s %s\n",
                $marks->{$add_files->{$f}}, quote_file($f));
    }
    for my $f (keys %$add_dirs) {
        $f .= "/" if $f;
        lprintf($fi, "M 0644 inline %s\n", quote_file("$f.gitignore"));
        lprint($fi, "data 0\n\n");
    }
    print $fi "\n";
}

my $branches = {};
for my $rev (@$leaves) {
    my $branch;
    my @certs;
    $m->certs(\@certs, $rev);
    for my $cert (@certs) {
        my ($n, $v) = ($cert->{name}, $cert->{value});
        $branch = $v if ($n eq 'branch');
    }
    my $r = $branches->{$branch};
    $branches->{$branch}--;
    if ($marks->{$rev}) {
        print $fi "reset refs/heads/$branch$r\n";
        print $fi "from :$marks->{$rev}\n\n";
    }
}

close $fi;

--r5Pyd7+fXNt84Ff3--
