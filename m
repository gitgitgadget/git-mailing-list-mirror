From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Anyone working on a CVS->git converter?
Date: Tue, 03 May 2005 02:28:59 +0200
Message-ID: <1115080139.21105.18.camel@localhost.localdomain>
References: <4275857A.1050106@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-V2122xenL7tX0s3kE1tr"
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 02:23:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSlC2-0003WG-K4
	for gcvg-git@gmane.org; Tue, 03 May 2005 02:23:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVECA3Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 May 2005 20:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVECA3Z
	(ORCPT <rfc822;git-outgoing>); Mon, 2 May 2005 20:29:25 -0400
Received: from soundwarez.org ([217.160.171.123]:33680 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261251AbVECA3A (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2005 20:29:00 -0400
Received: from dhcp-113.off.vrfy.org (c169067.adsl.hansenet.de [213.39.169.67])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 3D5762BD30;
	Tue,  3 May 2005 02:28:58 +0200 (CEST)
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4275857A.1050106@zytor.com>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-V2122xenL7tX0s3kE1tr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2005-05-01 at 18:42 -0700, H. Peter Anvin wrote:
> Anyone working on a CVS->git converter?  I'd like to move klibc 
> development into git.

I tried it with two completely stupid scripts and the nice cvsps.

Here is the tree to browse:
  http://ehlo.org/~kay/git/gitweb.cgi?p=klibc.git;a=log


In the CVS repo directory export patchsets as individual patches with a
header containing metadata:
  cvsps -x -b HEAD -g -p ../../patches/

split exported patches into individial files like author data, log, file list:
  for i in `seq 1 546`; do ../parse-cvsps-patch.pl ../patches/$i.patch ;done

apply it to an completely empty git-repo:
  for i in `seq 1 546`; do ../apply.sh ../patches/$i.patch ;done

Stupid scripts are attached. cvsps is here:
  http://www.cobite.com/cvsps/

Kay

--=-V2122xenL7tX0s3kE1tr
Content-Disposition: inline; filename=apply.sh
Content-Type: application/x-shellscript; name=apply.sh
Content-Transfer-Encoding: 7bit

#!/bin/sh

FILES=$1.files
PATCHFILE=$1
LOG=$1.log
. $1.author

if [ -e .git/HEAD ]; then
	git-check-files $(cat $FILES) || exit 1
	git-checkout-cache -q $(cat $FILES) || exit 1
fi

patch -u --no-backup-if-mismatch -f -p0 --fuzz=0 --input=$PATCHFILE || exit 1
git-update-cache --add --remove $(cat $FILES) || exit 1
tree=$(git-write-tree) || exit 1
echo Wrote tree $tree

if [ -e .git/HEAD ]; then
	commit=$(git-commit-tree $tree -p HEAD < $LOG) || exit 1
else
	commit=$(git-commit-tree $tree < $LOG) || exit 1
fi

echo Committed: $commit
echo $commit > .git/HEAD


--=-V2122xenL7tX0s3kE1tr
Content-Disposition: inline; filename=parse-cvsps-patch.pl
Content-Type: application/x-perl; name=parse-cvsps-patch.pl
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
my @log = ();
my %files = ();

open (my $fd, $patch);
while (my $line = <$fd>) {
	if ($line =~ m/^Date: (.*)/) {
		$author_date = $1;
	} elsif ($line =~ m/^Author: (.*)/) {
		$author_name = $1;
	} elsif ($line =~ m/^Log:/) {
		while (my $line = <$fd>) {
			if ($line =~ m/^Members: /) {
				last;
			}
			push @log, $line;
		}
	} elsif ($line =~ m/^(---|\+\+\+) ([^\t]*)/) {
		chomp($line);
		if ($2 ne "/dev/null") {
			$files{$2} = $2;
		}
	}
}
close $fd;

open $fd, "> $patch.files";
foreach my $file (sort keys %files) {
	print $fd "$file\n";
};
close $fd;

open $fd, "> $patch.log";
print $fd (@log);
close $fd;

open $fd, "> $patch.author";
print $fd "export AUTHOR_NAME=\"$author_name\"\n";
print $fd "export AUTHOR_EMAIL=\"$author_mail\"\n";
print $fd "export AUTHOR_DATE=\"$author_date\"\n";
close $fd;

print "$patch $author_name \[$author_date\]\n";

--=-V2122xenL7tX0s3kE1tr--

