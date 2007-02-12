From: Michael Loeffler <zvpunry@zvpunry.de>
Subject: [PATCH] import-tars: use Archive::Tar instead of unpack()
Date: Mon, 12 Feb 2007 15:17:11 +0100
Message-ID: <1171289831.629.6.camel@ibook.zvpunry.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 12 15:17:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGbzp-0000aB-MO
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 15:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbXBLOR2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 09:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbXBLOR2
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 09:17:28 -0500
Received: from mx01.ap-wdsl.de ([88.198.184.82]:60370 "EHLO mx01.ap-wdsl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964940AbXBLOR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 09:17:26 -0500
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39403>

this is less obscure, does not use gzcat (which is often installed as zcat)
and it is shorter.

Signed-off-by: Michael Loeffler <zvpunry@zvpunry.de>
---

This version does no longer support bzip2 or compress which will be fixed in
an amend. I did this patch to solve 2 problems. Maybe I do another patch with
GetoptLong and bzip2/compress support.

The first is a bug with this $git_mode variable which should be 0644 of
0755, but nothing else I think.

The second problem was the usage of gzcat, I don't have this link
(Debian sid).

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index 26c42c9..c084573 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -10,6 +10,10 @@
 ##
 
 use strict;
+use Archive::Tar;
+use Archive::Tar::File;
+use Archive::Tar::Constant;
+
 die "usage: import-tars *.tar.{gz,bz2,Z}\n" unless @ARGV;
 
 my $branch_name = 'import-tars';
@@ -23,48 +27,25 @@ foreach my $tar_file (@ARGV)
 {
 	$tar_file =~ m,([^/]+)$,;
 	my $tar_name = $1;
-
-	if ($tar_name =~ s/\.(tar\.gz|tgz)$//) {
-		open(I, '-|', 'gzcat', $tar_file) or die "Unable to gzcat $tar_file: $!\n";
-	} elsif ($tar_name =~ s/\.(tar\.bz2|tbz2)$//) {
-		open(I, '-|', 'bzcat', $tar_file) or die "Unable to bzcat $tar_file: $!\n";
-	} elsif ($tar_name =~ s/\.tar\.Z$//) {
-		open(I, '-|', 'zcat', $tar_file) or die "Unable to zcat $tar_file: $!\n";
-	} elsif ($tar_name =~ s/\.tar$//) {
-		open(I, $tar_file) or die "Unable to open $tar_file: $!\n";
-	} else {
-		die "Unrecognized compression format: $tar_file\n";
-	}
+	$tar_name =~ s/\.(tar|tgz|tar\.gz)$//;
+	my $tar = new Archive::Tar($tar_file) or die "Unable to open $tar_file: $!\n";
 
 	my $commit_time = 0;
 	my $next_mark = 1;
 	my $have_top_dir = 1;
 	my ($top_dir, %files);
 
-	while (read(I, $_, 512) == 512) {
-		my ($name, $mode, $uid, $gid, $size, $mtime,
-			$chksum, $typeflag, $linkname, $magic,
-			$version, $uname, $gname, $devmajor, $devminor,
-			$prefix) = unpack 'Z100 Z8 Z8 Z8 Z12 Z12
-			Z8 Z1 Z100 Z6
-			Z2 Z32 Z32 Z8 Z8 Z*', $_;
-		last unless $name;
-		$mode = oct $mode;
-		$size = oct $size;
-		$mtime = oct $mtime;
-		next if $mode & 0040000;
-
-		print FI "blob\n", "mark :$next_mark\n", "data $size\n";
-		while ($size > 0 && read(I, $_, 512) == 512) {
-			print FI substr($_, 0, $size);
-			$size -= 512;
-		}
-		print FI "\n";
-
-		my $path = "$prefix$name";
-		$files{$path} = [$next_mark++, $mode];
-
-		$commit_time = $mtime if $mtime > $commit_time;
+	foreach my $entry ($tar->get_files()) {
+		next if $entry->type != FILE;
+
+		printf FI "blob\nmark :%s\ndata %s\n%s\n", $next_mark,
+			$entry->size, $entry->get_content();
+
+		my $path = $entry->prefix . $entry->name;
+		$files{$path} = [$next_mark++, $entry->mode];
+
+		$commit_time = $entry->mtime if $entry->mtime > $commit_time;
+
 		$path =~ m,^([^/]+)/,;
 		$top_dir = $1 unless $top_dir;
 		$have_top_dir = 0 if $top_dir ne $1;
@@ -83,10 +64,8 @@ EOF
 	foreach my $path (keys %files)
 	{
 		my ($mark, $mode) = @{$files{$path}};
-		my $git_mode = 0644;
-		$git_mode |= 0700 if $mode & 0111;
 		$path =~ s,^([^/]+)/,, if $have_top_dir;
-		printf FI "M %o :%i %s\n", $git_mode, $mark, $path;
+		printf FI "M %o :%i %s\n", $mode & 0111 ? 0755 : 0644, $mark, $path;
 	}
 	print FI "\n";
 
-- 
1.5.0.rc4
