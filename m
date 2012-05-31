From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH] Remove perl dependency from git-submodule.sh
Date: Thu, 31 May 2012 10:48:46 +0200
Message-ID: <1338454126-30441-1-git-send-email-iveqy@iveqy.com>
Cc: jens.lehmann@web.de, gitster@pobox.com, iveqy@iveqy.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 10:49:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa14a-0003p5-02
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 10:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471Ab2EaIt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 04:49:28 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:37784 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751217Ab2EaIt0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 04:49:26 -0400
Received: by lahd3 with SMTP id d3so529034lah.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 01:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=XYD7gTh6pjtz82XM/GY/cFpoNX1hrZlRxnEi2v3fhfI=;
        b=yI9DZs7UsSHe2For4E6IusSbXZV/GaM6zFX7SOVc/kAxGOr/QcRFKCO0+8h0S/VDek
         8RvtD8zSWTfl16B4sLIuVjxHn3TxCezhLwnFosQxrCeee99+B5PzhUdp9LA8iHOYcvKz
         LAri8LWsxg8MnayNrfP4r0PB6lauZnBY1WVwz/ibLSOVSW/K2wHAWl+oohd15/pC0k2M
         m/nd4akB+ZR3JguFIr3P2Hz2shFTqY794+GzZhZjT+wEboBt1yhm7HW0h2ICSOyF+NI2
         Cw8LuZwEu8pC8KHnO3WIb1Dk/Ue4GuYCDQzq2iv3INgcsdF9Jr2gchSjIfouUjjYCejN
         llKg==
Received: by 10.112.40.36 with SMTP id u4mr8224097lbk.70.1338454165444;
        Thu, 31 May 2012 01:49:25 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-184-249.a189.priv.bahnhof.se. [85.24.184.249])
        by mx.google.com with ESMTPS id fy10sm3524175lab.0.2012.05.31.01.49.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 31 May 2012 01:49:24 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Sa13w-0007vX-Kd; Thu, 31 May 2012 10:48:56 +0200
X-Mailer: git-send-email 1.7.5.1180.g4bfe7.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198873>

Rewrote a perl section in sh.

The code may be a bit slower (doing grep on strings instead of using
perl-lists).

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 git-submodule.sh |   35 ++++++++++++++++++-----------------
 1 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index f46862f..d3dfb24 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -73,24 +73,25 @@ resolve_relative_url ()
 #
 module_list()
 {
+	unmerged=
+	null_sha1=0000000000000000000000000000000000000000
 	git ls-files --error-unmatch --stage -- "$@" |
-	perl -e '
-	my %unmerged = ();
-	my ($null_sha1) = ("0" x 40);
-	while (<STDIN>) {
-		chomp;
-		my ($mode, $sha1, $stage, $path) =
-			/^([0-7]+) ([0-9a-f]{40}) ([0-3])\t(.*)$/;
-		next unless $mode eq "160000";
-		if ($stage ne "0") {
-			if (!$unmerged{$path}++) {
-				print "$mode $null_sha1 U\t$path\n";
-			}
-			next;
-		}
-		print "$_\n";
-	}
-	'
+	while read mode sha1 stage path
+	do
+		if test $mode -eq 160000
+		then
+			if test $stage -ne 0
+			then
+				if test -z "$(echo $unmerged | grep "|$path|")"
+					then
+					echo "$mode $null_sha1 U\t$path"
+				fi
+				unmerged="$unmerged|$path|"
+			else
+				echo "$mode $sha1 $stage\t$path"
+			fi
+		fi
+	done
 }
 
 #
-- 
1.7.5.1180.g4bfe7.dirty
