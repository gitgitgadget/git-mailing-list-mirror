From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 2/2] tar archive frontend for fast-import.
Date: Thu, 8 Feb 2007 15:38:45 -0500
Message-ID: <20070208203845.GB956@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 08 21:38:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFG2f-0008Gm-1E
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 21:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423319AbXBHUit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 15:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423321AbXBHUit
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 15:38:49 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:32985 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423319AbXBHUis (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 15:38:48 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HFG2R-00011i-8a; Thu, 08 Feb 2007 15:38:39 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9137320FBAE; Thu,  8 Feb 2007 15:38:45 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39088>

This is an example fast-import frontend, in less than 100 lines
of Perl.  It accepts one or more tar archives on the command line,
passes them through gzcat/bzcat/zcat if necessary, parses out the
individual file headers and feeds all contained data to fast-import.
No temporary files are involved.

Each tar is treated as one commit, with the commit timestamp coming
from the oldest file modification date found within the tar.

Each tar is also tagged with an annotated tag, using the basename
of the tar file as the name of the tag.

Currently symbolic links and hard links are not handled by the
importer.  The file checksums are also not verified.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 Nifty, eh?  :-)

 contrib/fast-import/import-tars.perl |  105 ++++++++++++++++++++++++++++++++++
 1 files changed, 105 insertions(+), 0 deletions(-)
 create mode 100755 contrib/fast-import/import-tars.perl

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
new file mode 100755
index 0000000..26c42c9
--- /dev/null
+++ b/contrib/fast-import/import-tars.perl
@@ -0,0 +1,105 @@
+#!/usr/bin/perl
+
+## tar archive frontend for git-fast-import
+##
+## For example:
+##
+##  mkdir project; cd project; git init
+##  perl import-tars.perl *.tar.bz2
+##  git whatchanged import-tars
+##
+
+use strict;
+die "usage: import-tars *.tar.{gz,bz2,Z}\n" unless @ARGV;
+
+my $branch_name = 'import-tars';
+my $branch_ref = "refs/heads/$branch_name";
+my $committer_name = 'T Ar Creator';
+my $committer_email = 'tar@example.com';
+
+open(FI, '|-', 'git', 'fast-import', '--quiet')
+	or die "Unable to start git fast-import: $!\n";
+foreach my $tar_file (@ARGV)
+{
+	$tar_file =~ m,([^/]+)$,;
+	my $tar_name = $1;
+
+	if ($tar_name =~ s/\.(tar\.gz|tgz)$//) {
+		open(I, '-|', 'gzcat', $tar_file) or die "Unable to gzcat $tar_file: $!\n";
+	} elsif ($tar_name =~ s/\.(tar\.bz2|tbz2)$//) {
+		open(I, '-|', 'bzcat', $tar_file) or die "Unable to bzcat $tar_file: $!\n";
+	} elsif ($tar_name =~ s/\.tar\.Z$//) {
+		open(I, '-|', 'zcat', $tar_file) or die "Unable to zcat $tar_file: $!\n";
+	} elsif ($tar_name =~ s/\.tar$//) {
+		open(I, $tar_file) or die "Unable to open $tar_file: $!\n";
+	} else {
+		die "Unrecognized compression format: $tar_file\n";
+	}
+
+	my $commit_time = 0;
+	my $next_mark = 1;
+	my $have_top_dir = 1;
+	my ($top_dir, %files);
+
+	while (read(I, $_, 512) == 512) {
+		my ($name, $mode, $uid, $gid, $size, $mtime,
+			$chksum, $typeflag, $linkname, $magic,
+			$version, $uname, $gname, $devmajor, $devminor,
+			$prefix) = unpack 'Z100 Z8 Z8 Z8 Z12 Z12
+			Z8 Z1 Z100 Z6
+			Z2 Z32 Z32 Z8 Z8 Z*', $_;
+		last unless $name;
+		$mode = oct $mode;
+		$size = oct $size;
+		$mtime = oct $mtime;
+		next if $mode & 0040000;
+
+		print FI "blob\n", "mark :$next_mark\n", "data $size\n";
+		while ($size > 0 && read(I, $_, 512) == 512) {
+			print FI substr($_, 0, $size);
+			$size -= 512;
+		}
+		print FI "\n";
+
+		my $path = "$prefix$name";
+		$files{$path} = [$next_mark++, $mode];
+
+		$commit_time = $mtime if $mtime > $commit_time;
+		$path =~ m,^([^/]+)/,;
+		$top_dir = $1 unless $top_dir;
+		$have_top_dir = 0 if $top_dir ne $1;
+	}
+
+	print FI <<EOF;
+commit $branch_ref
+committer $committer_name <$committer_email> $commit_time +0000
+data <<END_OF_COMMIT_MESSAGE
+Imported from $tar_file.
+END_OF_COMMIT_MESSAGE
+
+deleteall
+EOF
+
+	foreach my $path (keys %files)
+	{
+		my ($mark, $mode) = @{$files{$path}};
+		my $git_mode = 0644;
+		$git_mode |= 0700 if $mode & 0111;
+		$path =~ s,^([^/]+)/,, if $have_top_dir;
+		printf FI "M %o :%i %s\n", $git_mode, $mark, $path;
+	}
+	print FI "\n";
+
+	print FI <<EOF;
+tag $tar_name
+from $branch_ref
+tagger $committer_name <$committer_email> $commit_time +0000
+data <<END_OF_TAG_MESSAGE
+Package $tar_name
+END_OF_TAG_MESSAGE
+
+EOF
+
+	close I;
+}
+close FI;
-- 
1.5.0.rc4
