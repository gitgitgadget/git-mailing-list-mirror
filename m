From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] import-tars: support symlinks
Date: Wed, 17 Jun 2009 14:49:39 +0200 (CEST)
Message-ID: <c7bf68ab386b2ce16f81d0223a27f0c82671da3b.1245242966u.git.johannes.schindelin@gmx.de>
References: <cover.1245242966u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 17 14:49:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGuaI-0004Tb-K0
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 14:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732AbZFQMtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2009 08:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756650AbZFQMtj
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 08:49:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:43424 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754302AbZFQMti (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2009 08:49:38 -0400
Received: (qmail invoked by alias); 17 Jun 2009 12:49:40 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 17 Jun 2009 14:49:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ESUxck3xEaZGJwotaI+SC2k225RCsR7nUn4Fig4
	ZXeYAhxtOPnucD
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1245242966u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121739>

Without this patch, symbolic links are turned into empty files.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/fast-import/import-tars.perl |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index 6309d14..78e40d2 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -82,10 +82,16 @@ foreach my $tar_file (@ARGV)
 		$mtime = oct $mtime;
 		next if $typeflag == 5; # directory
 
-		print FI "blob\n", "mark :$next_mark\n", "data $size\n";
-		while ($size > 0 && read(I, $_, 512) == 512) {
-			print FI substr($_, 0, $size);
-			$size -= 512;
+		print FI "blob\n", "mark :$next_mark\n";
+		if ($typeflag == 2) { # symbolic link
+			print FI "data ", length($linkname), "\n", $linkname;
+			$mode = 0120000;
+		} else {
+			print FI "data $size\n";
+			while ($size > 0 && read(I, $_, 512) == 512) {
+				print FI substr($_, 0, $size);
+				$size -= 512;
+			}
 		}
 		print FI "\n";
 
@@ -118,7 +124,8 @@ EOF
 	{
 		my ($mark, $mode) = @{$files{$path}};
 		$path =~ s,^([^/]+)/,, if $have_top_dir;
-		printf FI "M %o :%i %s\n", $mode & 0111 ? 0755 : 0644, $mark, $path;
+		$mode = $mode & 0111 ? 0755 : 0644 unless $mode == 0120000;
+		printf FI "M %o :%i %s\n", $mode, $mark, $path;
 	}
 	print FI "\n";
 
-- 
1.6.3.284.g6fecc
