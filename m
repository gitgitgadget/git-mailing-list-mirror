From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: gitweb wishlist
Date: Sat, 21 May 2005 00:04:12 +0200
Message-ID: <1116626652.12975.118.camel@dhcp-188>
References: <20050511012626.GL26384@pasky.ji.cz>
	 <1116384951.5094.83.camel@dhcp-188.off.vrfy.org>
	 <Pine.LNX.4.58.0505200948150.2206@ppc970.osdl.org>
	 <1116611932.12975.22.camel@dhcp-188>
	 <Pine.LNX.4.58.0505201111090.2206@ppc970.osdl.org>
	 <Pine.LNX.4.58.0505201123550.2206@ppc970.osdl.org>
	 <1116615600.12975.33.camel@dhcp-188>
	 <Pine.LNX.4.58.0505201219420.2206@ppc970.osdl.org> <428E49DD.406@zytor.com>
	 <Pine.LNX.4.58.0505201346330.2206@ppc970.osdl.org>
	 <428E4D8C.3020606@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-882KtFzdh89xAZ42bgVn"
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 21 00:07:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZFbA-0004zj-8o
	for gcvg-git@gmane.org; Sat, 21 May 2005 00:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbVETWFA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 18:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVETWFA
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 18:05:00 -0400
Received: from soundwarez.org ([217.160.171.123]:50403 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261427AbVETWEa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 18:04:30 -0400
Received: from dhcp-188.off.vrfy.org (d027239.adsl.hansenet.de [80.171.27.239])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 6E1892F0CC;
	Sat, 21 May 2005 00:04:27 +0200 (CEST)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <428E4D8C.3020606@zytor.com>
X-Mailer: Evolution 2.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-882KtFzdh89xAZ42bgVn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-05-20 at 13:50 -0700, H. Peter Anvin wrote:
> Linus Torvalds wrote:
> > 
> > Oh, btw, I notice that you moved klibc over to git - care to share your
> > cvs->git script (I assume you scripted it ;)? That would seem to be an 
> > obvious addition to the core stuff..
> > 
> 
> Actually, Kay did the conversion... the scripts are clearly very 
> cantankerous, because if *I* run them -- I tried -- they don't work! 
> Since it's Kay's work, I'll leave them to him, but I would definitely 
> love to move more of my CVS repos over to git, especially syslinux.

Here we go;

These scripts are just a quick hack, I just wanted to know how nice the
stupid cvs file history can be converted to git-committs.

It exports the CVS repo with the help of the nice cvsps to individual
patches. (Every patch contains something like a "ChangeSet" by searching
for file revisions with the same checkin-date)

Then the patches with the header are split into individual files for
committing it into git (similar to Linus' git-mbox-tools).

If we reach a CVS tag with a patch during sequential patching, the
script throws away the whole current working tree and checks the
revision out of CVS. This way we make sure, that the git-tag matches
tree CVS has tagged. (I've encountered two mismatches in the
"patch-chain" with the CVS revision-tag. These corrections are hardcoded
into the script. :)

For every CVS revision-tag a git-tag without any content except the name
is created.

And the klibc-repo was created with a patched git-commit to fake the
commit date with the author date. :)

Good luck with it,
Kay

--=-882KtFzdh89xAZ42bgVn
Content-Disposition: inline; filename=export-to-git.sh
Content-Type: application/x-shellscript; name=export-to-git.sh
Content-Transfer-Encoding: 7bit

#/bin/sh

base=$(pwd);
project=klibc;
export COMMIT_AUTHOR_NAME="H. Peter Anvin"
export COMMIT_AUTHOR_EMAIL="hpa@zytor.com"
export TZ=UTC

# clean
rm -rf $base/checkout/ || exit 1
mkdir $base/checkout/ || exit 1
rm  -rf $base/patches/ || exit 1
mkdir $base/patches/ || exit 1
rm  -rf $base/git/ || exit 1
mkdir -p $base/git/$project || exit 1
cd $base/git/$project || exit 1
git-init-db || exit 1
mkdir -p .git/refs/tags/

# checkout sources
cd $base/checkout/ || exit 1
cvs co $project || exit 1
cd $base/checkout/$project || exit 1

# export patchset patches
cd $base/checkout/$project || exit 1
cvsps -x -g -p $base/patches/ || exit 1

# extract metadata into individual files
cd $base/patches/ || exit 1

# fix CVS patchset order
mv 204.patch old204.patch
mv 205.patch 204.patch
mv old204.patch 205.patch

count=$(ls -1 *.patch| wc -l)
for i in $(seq 1 $count); do
	$base/split-cvsps-patch.pl $i.patch;
done

# suppress ash-branch
rm 205.patch.tag

commit_patch() {
	. $base/patches/$1.patch.author

	cd $base/git/$project || exit 1
	patch -u --no-backup-if-mismatch -f -p1 --fuzz=0 --input=$base/patches/$1.patch || exit 1
	cat $base/patches/$1.patch.files | xargs git-update-cache --add --remove
	tree=$(git-write-tree) || exit 1

	# create initial commit
	if [ -e .git/HEAD ]; then
		commit=$(git-commit-tree $tree -p HEAD < $base/patches/$1.patch.log) || exit 1
	else
		commit=$(git-commit-tree $tree < $base/patches/$1.patch.log) || exit 1
	fi

	echo Committed: $commit[$i]
	echo $commit > .git/HEAD
}

commit_tag() {
	tag=$(cat $base/patches/$1.patch.tag) || exit 1
	rm -rf $base/git/$project/* || exit 1
	cd $base/checkout/ || exit 1
	cvs export -r$tag -d$base/git/$project $project
	cd $base/git/$project || exit 1
	rm $base/git/$project/.git/index || exit 1
	find * \( -type f -o -type l \) | xargs git-update-cache --add
	tree=$(git-write-tree) || exit 1
	commit=$(git-commit-tree $tree -p HEAD < $base/patches/$1.patch.log) || exit 1
	echo Committed: $commit[$i] $tag
	echo $commit > .git/HEAD
	echo "object $commit" > .git/refs/tags/$tag.tmp
	echo "type commit" >> .git/refs/tags/$tag.tmp
	echo "tag $tag" >> .git/refs/tags/$tag.tmp
	tagid=$(git-mktag < .git/refs/tags/$tag.tmp)
	rm .git/refs/tags/$tag.tmp
	echo $tagid > .git/refs/tags/$tag
}

# commit patches to git repository
for i in $(seq 1 $count); do \
	echo commit $i; \
	if [ $i -eq "688" ]; then
		cat $base/patches/205.patch | patch -p1 -R
	fi
	if [ -e $base/patches/$i.patch.tag ]; then
		echo patch $i is a tag; \
		commit_tag $i;
	elif [ -e $base/patches/$i.patch ]; then
		commit_patch $i;
	fi
done

--=-882KtFzdh89xAZ42bgVn
Content-Disposition: inline; filename=split-cvsps-patch.pl
Content-Type: application/x-perl; name=split-cvsps-patch.pl
Content-Transfer-Encoding: 7bit

#!/usr/bin/perl

use strict;
use warnings;

# ---------------------
# PatchSet 1 
# Date: 2002/07/23 07:41:30
# Author: hpa
# Branch: HEAD
# Tag: (none) 
# Log:
# Initial revision
# 
# Members: 
# 	klibc.cvsroot/snprintf.c:INITIAL->1.1 
# 	klibc.cvsroot/vsnprintf.c:INITIAL->1.1 
# 	klibc.cvsroot/klibc/Makefile:INITIAL->1.1 
# 	klibc.cvsroot/klibc/snprintf.c:INITIAL->1.1 
# 	klibc.cvsroot/klibc/vsnprintf.c:INITIAL->1.1 
# 
# --- /dev/null	2005-04-30 18:00:24.840397008 +0200
# +++ klibc/klibc.cvsroot/snprintf.c	2005-05-02 19:57:42.879913000 +0200
# @@ -0,0 +1,19 @@
# +/*


my $patch = $ARGV[0];

my $author_name = "";
my $author_mail = "";
my $author_date = "";
my $tag = "";
my @log = ();
my %files = ();

open (my $fd, $patch);
while (my $line = <$fd>) {
	if ($line =~ m/^Date: (.*)/) {
		$author_date = $1;
	} elsif ($line =~ m/^Author: (.*)/) {
		$author_name = $1;
	} elsif ($line =~ m/^Tag: (.*) /) {
		$tag = $1;
	} elsif ($line =~ m/^Log:/) {
		while (my $line = <$fd>) {
			if ($line =~ m/^Members: /) {
				last;
			}
			push @log, $line;
		}
	} elsif ($line =~ m/^(---|\+\+\+) ([^\t]*)/) {
		chomp($line);
		my $file = $2;
		$file =~ s/^klibc\///;
		if ($file ne "/dev/null") {
			$files{$file} = $file;
		}
	}
}
close $fd;

open $fd, "> $patch.files";
foreach my $file (sort keys %files) {
	print $fd "$file\n";
};
close $fd;

if ($tag ne "(none)") {
	open $fd, "> $patch.tag";
	print $fd $tag;
	close $fd;
}

open $fd, "> $patch.log";
print $fd (@log);
close $fd;

if ($author_name eq 'hpa') {
    $author_name = 'H. Peter Anvin';
    $author_mail = 'hpa@zytor.com';
} elsif ($author_name eq 'olh') {
    $author_name = 'Olaf Hering';
    $author_mail = 'olh@suse.de';
} elsif ($author_name eq 'rmk') {
    $author_name = 'Russell King';
    $author_mail = 'rmk@arm.linux.org.uk';
} elsif ($author_name eq 'bos') {
    $author_name = "Bryan O\'Sullivan";
    $author_mail = 'bos@serpentine.com';
} elsif ($author_name eq 'gregkh') {
    $author_name = 'Greg Kroah-Hartman';
    $author_mail = 'greg@kroah.com';
} else {
    die "$0: don\'t know who $author_name is\n";
}

if ($author_mail eq "") {
	$author_mail = "none";
}

open $fd, "> $patch.author";
print $fd "export AUTHOR_NAME=\"$author_name\"\n";
print $fd "export AUTHOR_EMAIL=\"$author_mail\"\n";
print $fd "export AUTHOR_DATE=\"$author_date\"\n";
close $fd;

print "$patch $author_name \[$author_date\]\n";

--=-882KtFzdh89xAZ42bgVn--

