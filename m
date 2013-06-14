From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH v2 2/2] [submodule] Replace perl-code with sh
Date: Fri, 14 Jun 2013 02:26:03 +0200
Message-ID: <1371169563-10267-3-git-send-email-iveqy@iveqy.com>
References: <1371169563-10267-1-git-send-email-iveqy@iveqy.com>
Cc: git@vger.kernel.org
To: iveqy@iveqy.com
X-From: git-owner@vger.kernel.org Fri Jun 14 02:23:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnHnO-0001EQ-LS
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 02:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759534Ab3FNAXD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 20:23:03 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:62459 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759478Ab3FNAXA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 20:23:00 -0400
Received: by mail-la0-f44.google.com with SMTP id er20so9558975lab.3
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 17:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=fgK/0wj7VCOUOT7QZIlUcPnRLNQbcDFD0NcieVLfDZ4=;
        b=hK3iMvPKZGGT6NfE2vkNjuCMnRILYIcRg3RxLCSiLQLKQMX8cQC4a7fITiKuaJ29Ej
         UOyacW9EAlw9p2yTZ6gBnrOXVighy3SIfd3E+tck5Z1f6dbDK2dIMXa0jhhvsZNNLMz+
         oar959fwYxTmLSV7JAjZJi5F0wh3/CS14wtlLoIqTD4fjUIivEhc6shoFwyLhEHTpD/L
         ARvZVaSHtfklWh3XUsIsIVpHLd0pUNITebST/qNlV7flDi/imfXm4ooJdX5UAZp/bGoB
         CNlc7SidNYhDQnPuUXdqmWDVvJZ5h/SmP3asRSl9wisdchDrAlppgGJsQ2Gb/AUSVY29
         cADw==
X-Received: by 10.112.19.162 with SMTP id g2mr2422024lbe.9.1371169379081;
        Thu, 13 Jun 2013 17:22:59 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id m1sm6767810lag.3.2013.06.13.17.22.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 17:22:58 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UnHq9-0002gG-22; Fri, 14 Jun 2013 02:26:05 +0200
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1371169563-10267-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227787>

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
