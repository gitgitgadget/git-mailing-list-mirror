From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Towards CVS code-exchange and gateways
Date: Wed, 26 Oct 2005 16:35:41 +1300
Message-ID: <46a038f90510252035yb4167e1w2ee54d82896e5906@mail.gmail.com>
References: <46a038f90510251357l23886747s8024a4326ad4e392@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Oct 26 05:36:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUc4z-0005k7-TT
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 05:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbVJZDfm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 23:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932527AbVJZDfm
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 23:35:42 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:29223 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932526AbVJZDfm convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 23:35:42 -0400
Received: by xproxy.gmail.com with SMTP id i30so122236wxd
        for <git@vger.kernel.org>; Tue, 25 Oct 2005 20:35:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QMQ+zMXEgqzswqC6VVKXjURGOFHYHv1LX/vO3Khm4TuljqmbQeZSc6NhFpQ+CYnRrWPp+pxnPOMrCHkeMaDiusSx0AB/L8snFJ3h8nqhP0mfx67mv2B1NUSjwXe8SnHjDl7+LNh5T1Lr1zc5J2o+w5Bvt1oshRjGy3/WKKO1hmE=
Received: by 10.65.192.13 with SMTP id u13mr312960qbp;
        Tue, 25 Oct 2005 20:35:41 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Tue, 25 Oct 2005 20:35:41 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <46a038f90510251357l23886747s8024a4326ad4e392@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10644>

Update here: Sven sent me a cool 4 line shell script that has the
basics. Next thing I know, and I was dumped into a boring presentation
-- so I turned it into a more complete Perl script. Still incomplete &
extremely untested, but showing the basics.

Give me a couple more boring presentations and we'll be done ;-)

cheers,


martin
---
#!/usr/bin/perl -w

use strict;
use Getopt::Std;

unless ($ENV{GIT_DIR} && -r $ENV{GIT_DIR}){
    die "GIT_DIR is not defined or is unreadable";
}

our ($opt_h, $opt_p);

getopt('hp');

$opt_h && usage();

die "Need at least one commit identifier!" unless @ARGV;

# resolve target commit
my $commit;
$commit = pop @ARGV;
$commit = `git-rev-parse --verify "$commit"^0"`;
chomp $commit;
if ($?) {
    die "The commit reference did not resolve!";
}

# resolve what parent we want
my $parent;
if (@ARGV) {
    $parent = pop @ARGV;
    $parent =  `git-rev-parse --verify "$parent"^0"`;
    chomp $parent;
    if ($?) {
	die "The parent reference did not resolve!";
    }
}

# parents from the commit itself
my @parents = `git-cat-file commmit $commit | grep -E '^parent
\\w{40}\$' | sed -e 's/^parent //'`;
@parents = map { chomp } @parents;

if ($parent) {
    # double check that it's a valid parent
    foreach my $p (@parents) {
	my $found;
	if ($p eq $parent) {
	    $found = 1;
	    last;
	}; # found it
	die "Did not find $parent in the parents for this commit!";
    }
} else { # we don't have a parent from the cmdline...
    if (@parents == 1) { # it's safe to get it from the commit
	$parent = $parents[0];
    } else { # or perhaps not!
	die "This commit has more than one parent -- please name the parent
you want to use explicitly";
    }
}

# grab the commit message
`git-cat-file commit $commit | sed -e '1,/^$/d' > .msg`;
$? && die "Error extraction the commit message";

my @files = `git-diff-tree -r $parent $commit | cut -f 2`;
$? && die "Error in git-diff-tree";
@files = map { chomp } @files;

# check that the files are clean and up to date according to cvs
my $dirty;
foreach my $f (@files) {
    # TODO:we need to handle removed in cvs and/or new (from git)
    my $status = `cvs status $f`;

    unless ($status =~ m/Up to date/) {
	$dirty = 1;
	warn "File $f not up to date!\n";
    }
}
if ($dirty) {
    die "Exiting: your CVS tree is not clean for this merge.";
}

###
### NOTE: if you are planning to die() past this point
###       you MUST call cleanupcvs(@files) before die()
###

## apply changes to binary files
my @bfiles = `git-diff-tree -p $parent $commit | grep '^Binary'`;
@bfiles = map { chomp } @bfiles;
foreach my $f (@bfiles) {
    # check that the file in cvs matches the "old" file

    # replace with the new file

}

## apply non-binary changes
## (git-diff-tree -p $1 | patch -p1) && cvs commit -F .msg


sub usage {
	print STDERR <<END;
Usage: GIT_DIR=/path/to/.gi ${\basename $0}      # fetch/update GIT from CVS
       [-h] [-p] [ parent ] commit
END
	exit(1);
}

# ensure cvs is clean before we die
sub cleanupcvs {
    my @files = @_;
    foreach my $f (@files) {
	`cvs -q update -C "$f"`;
	if ($?) {
	    warn "Warning! Failed to cleanup state of $f\n";
	}
    }
}
