From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Towards CVS code-exchange and gateways
Date: Wed, 26 Oct 2005 22:11:49 +1300
Message-ID: <46a038f90510260211i47c8a4e1oca8be8d0833f4b68@mail.gmail.com>
References: <46a038f90510251357l23886747s8024a4326ad4e392@mail.gmail.com>
	 <46a038f90510252035yb4167e1w2ee54d82896e5906@mail.gmail.com>
	 <20051026085302.GF30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_13701_20032814.1130317909112"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 26 11:13:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUhKQ-0007cU-Ni
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 11:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbVJZJLu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 05:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbVJZJLu
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 05:11:50 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:10780 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932556AbVJZJLu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2005 05:11:50 -0400
Received: by xproxy.gmail.com with SMTP id i30so197122wxd
        for <git@vger.kernel.org>; Wed, 26 Oct 2005 02:11:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=IwOBUKIqLe5j3jgFgBcNZeCz8s+A5tTF9UrSQ5Tmk3/I2JQbpIc4c/6qUN6Y9prZaOfFRIiYLfwCb/41delsW/jmtmRSpX3i2LSinzphZJw8FrfGlNXTEp4i1shCzKk/ymbSxXnXi200/rcMun0qoor8kbG5jLOEPJ7osTMJGGo=
Received: by 10.64.242.15 with SMTP id p15mr483455qbh;
        Wed, 26 Oct 2005 02:11:49 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 26 Oct 2005 02:11:49 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051026085302.GF30889@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10658>

------=_Part_13701_20032814.1130317909112
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 10/26/05, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Wed, Oct 26, 2005 at 05:35:41AM CEST, I got a letter
> where Martin Langhoff <martin.langhoff@gmail.com> told me that...
> > Update here: Sven sent me a cool 4 line shell script that has the
> > basics. Next thing I know, and I was dumped into a boring presentation
> > -- so I turned it into a more complete Perl script. Still incomplete &
> > extremely untested, but showing the basics.
> >
> > Give me a couple more boring presentations and we'll be done ;-)
>
> Can I then import from the CVS incrementally later? I guess from the
> cvsimport code that it just tries to always import everything but the
> already imported commits get the same hashes so it magically imports
> "incrementally"... (The code could use some descriptive comments, it is
> rather spaggetish.)

Yes -- the cvsimport script does incremental imports. If you use
cvsimport to bring in the commits from CVS, you must treat those
branches as "read only". But you can open new heads from them and do
your "local" work there.

That's what we do with Moodle, as you can see here:
http://locke.catalyst.net.nz/gitweb?p=3Dmoodle.git;a=3Dsummary the
branches in uppercase are imported from CVS by a cronjob. The branches
that begin with "mdl" open off those, and we merge the cvs updates
often.

The goal for this script that I'm drafting is to be able to push
commits back into cvs in a format that maximises the chance of
git-cherry identifying them when they are echoed back (and thus
avoiding bogus conflicts).

> If someone really desperately needs this, BTW, you might be able to
> merge two Monotone branches (.git and .cvssync) to get two-way
> incremental GIT and CVS interface, and then do that through Monotone.
> ;-))

I'm really scared by the concept ;-)

The script has moved forward quite a bit -- and I suspect it might
even work. Current (untested) version attached.

cheers,

martin

------=_Part_13701_20032814.1130317909112
Content-Type: application/octet-stream; name=git-cvsapplycommmit.perl
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="git-cvsapplycommmit.perl"

#!/usr/bin/perl -w

use strict;
use Getopt::Std;
use File::Temp qw(tempdir);

unless ($ENV{GIT_DIR} && -r $ENV{GIT_DIR}){
    die "GIT_DIR is not defined or is unreadable";
}

our ($opt_h, $opt_p);

getopt('hp');

$opt_h && usage();

die "Need at least one commit identifier!" unless @ARGV;

# setup a tempdir
our ($tmpdir, $tmpdirname) = tempdir('git-cvsapplycommit-XXXXXX',
				     TMPDIR => 1,
				     CLEANUP => 1);

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

# find parents from the commit itself
my @parents = `git-cat-file commmit $commit | grep -E '^parent \\w{40}\$' | sed -e 's/^parent //'`;
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
	die "This commit has more than one parent -- please name the parent you want to use explicitly";
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
    my $status = `cvs -q status "$f" | grep '^File: '`;

    unless ($status =~ m/Status: Up-to-date$/) {
	$dirty = 1;
	warn "File $f not up to date in your CVS checkout!\n";
    }
}
if ($dirty) {
    die "Exiting: your CVS tree is not clean for this merge.";
}

###
### NOTE: if you are planning to die() past this point
###       you MUST call cleanupcvs(@files) before die()
###


print "'Patching' binary files\n";

my @bfiles = `git-diff-tree -p $parent $commit | grep '^Binary'`;
@bfiles = map { chomp } @bfiles;
foreach my $f (@bfiles) {
    # check that the file in cvs matches the "old" file
    # extract the file to $tmpdir and comparre with cmp
    my $tree = `git-rev-parse $parent^{tree} `;
    chomp $tree;
    my $blob = `git-ls-tree $tree "$f" | cut -f 1 | cut -d ' ' -f 3`;
    chomp $blob;
    `git-cat-file blob $blob > $tmp/blob`;
    `cmp -q $f $tmp/blob`;
    if ($?) {
	warn "Binary file $f in CVS does not match parent.\n";
	$dirty = 1;
	next;
    }

    # replace with the new file
     `git-cat-file blob $blob > $f`;

    # TODO: something smart with file modes

}
if ($dirty) {
    cleanupcvs(@files);
    die "Exiting: Binary files in CVS do not match parent";
}

## apply non-binary changes
my $fuzz = $opt_p ? 0 : 2;

print "Patching non-binary files\n";
print `(git-diff-tree -p $1 | patch -p1 -F $fuzz ) 2>&1`;
if ($?) {
    cleanupcvs(@files);
    die "Exiting: Patch did not succeed -- you will have to apply this patch manually";
}

print "Commit to CVS\n";
my $commitfiles = join(' ', @files);
print `cvs commit -F .msg $commitfiles 2>&1`;
if ($?) {
    cleanupcvs(@files);
    die "Exiting: The commit did not succeed";
}
print "Committed successfully to CVS\n";

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


------=_Part_13701_20032814.1130317909112--
