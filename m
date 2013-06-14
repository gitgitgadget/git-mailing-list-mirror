From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [[PATCH v3] 2/2] [submodule] Replace perl-code with sh
Date: Fri, 14 Jun 2013 17:56:05 +0200
Message-ID: <1371225365-4219-3-git-send-email-iveqy@iveqy.com>
References: <1371225365-4219-1-git-send-email-iveqy@iveqy.com>
Cc: git@vger.kernel.org, iveqy@iveqy.com, jens.lehmann@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 14 17:53:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnWJM-0004nV-Qo
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 17:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806Ab3FNPxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 11:53:08 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:35660 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab3FNPxG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 11:53:06 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so685167lab.4
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=fgK/0wj7VCOUOT7QZIlUcPnRLNQbcDFD0NcieVLfDZ4=;
        b=dEnEehF7MeQq+BEH6pVPcSWYQxEQxSIO3dTWyeeeYHFbLncy8I/VETjOZrbUM645jf
         +F0PRvh6wmJs/StqSVtO+qpAY6bDzrGvty46lvgFboJJbp2CZ7qH0rJ3iCEZaL8whiDg
         E8kOO3kMMKgUggF2lKbdWU0e3BI7Br6zP89F9PAZmGykZAgPN1Vm0mXvIWnJH5ZIa98O
         1oA+TlUYPkiN4lYWc847H6mPVa0LWHOPGG9p/Mb3VTH9HeTogV6hjGlBVOQ5hp7AvXDz
         gNrL+SWTNuQOz4FLWaz2Apm74Rq/k5lmWlpuJ5GMH/tmKFtg47JoDutvkKGmhvFWYhFT
         qk1w==
X-Received: by 10.152.28.199 with SMTP id d7mr1462480lah.67.1371225184734;
        Fri, 14 Jun 2013 08:53:04 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id p20sm1067877lbb.17.2013.06.14.08.53.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 08:53:03 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UnWMH-00016h-KH; Fri, 14 Jun 2013 17:56:13 +0200
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1371225365-4219-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227889>

This will prevent a fork and makes the code similair to the rest of the
file.

In the long term git-submodule.sh needs to use something else than sh to
handle newline in filenames (and therefore needs to use a language that
accepts \0 in strings). However I don't think that keeping that small
perl-part will ease any rewrite.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 git-submodule.sh | 51 ++++++++++++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 29 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index bad051e..be96934 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -112,38 +112,31 @@ resolve_relative_url ()
 #
 module_list()
 {
+	null_sha1=0000000000000000000000000000000000000000
+	unmerged=
 	(
 		git -c core.quotepath=false ls-files --error-unmatch --stage -- "$@" ||
-		echo "unmatched pathspec exists"
+		echo "#unmatched"
 	) |
-	perl -e '
-	my %unmerged = ();
-	my ($null_sha1) = ("0" x 40);
-	my @out = ();
-	my $unmatched = 0;
-	while (<STDIN>) {
-		if (/^unmatched pathspec/) {
-			$unmatched = 1;
-			next;
-		}
-		chomp;
-		my ($mode, $sha1, $stage, $path) =
-			/^([0-7]+) ([0-9a-f]{40}) ([0-3])\t(.*)$/;
-		next unless $mode eq "160000";
-		if ($stage ne "0") {
-			if (!$unmerged{$path}++) {
-				push @out, "$mode $null_sha1 U\t$path\n";
-			}
-			next;
-		}
-		push @out, "$_\n";
-	}
-	if ($unmatched) {
-		print "#unmatched\n";
-	} else {
-		print for (@out);
-	}
-	'
+	while read mode sha1 stage path
+	do
+		if test $mode = "#unmatched"
+		then
+			echo "#unmatched"
+		elif test $mode = "160000"
+		then
+			if test $stage != "0"
+			then
+				if test "$unmerged" != "$path"
+				then
+					echo "$mode $null_sha1 U $path"
+				fi
+				unmerged="$path"
+			else
+				echo "$mode $sha1 $stage $path"
+			fi
+		fi
+	done
 }
 
 die_if_unmatched ()
-- 
1.8.3.1.381.g2ab719e.dirty
