From: Eric Lesh <eclesh@ucla.edu>
Subject: [GUILT PATCH 1/5] get_series: Remove comments from end of series lines
Date: Mon, 30 Jul 2007 20:11:17 -0700
Message-ID: <11858514812742-git-send-email-eclesh@ucla.edu>
References: <1185851481190-git-send-email-eclesh@ucla.edu>
Cc: git@vger.kernel.org, Eric Lesh <eclesh@ucla.edu>
To: jsipek@cs.sunysb.edu
X-From: git-owner@vger.kernel.org Tue Jul 31 05:11:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFi97-0001pK-9L
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 05:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965994AbXGaDLi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 23:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764693AbXGaDLh
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 23:11:37 -0400
Received: from smtp-5.smtp.ucla.edu ([169.232.47.137]:37114 "EHLO
	smtp-5.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759914AbXGaDLg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 23:11:36 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.48.150])
	by smtp-5.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6V3BTJr028578;
	Mon, 30 Jul 2007 20:11:29 -0700
Received: from localhost (adsl-75-26-197-236.dsl.scrm01.sbcglobal.net [75.26.197.236])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6V3BS9N013433
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Jul 2007 20:11:29 -0700
Received: by localhost (Postfix, from userid 1000)
	id 9363B1E80AA; Mon, 30 Jul 2007 20:11:21 -0700 (PDT)
X-Mailer: git-send-email 1.5.2
In-Reply-To: <1185851481190-git-send-email-eclesh@ucla.edu>
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.47.137
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54309>

Also make sure that series_remove_patch and series_rename_patch do the
right thing if there are comments on the line.

Signed-off-by: Eric Lesh <eclesh@ucla.edu>
---
 guilt                    |   15 ++++++++++++---
 regression/050-series.sh |    2 +-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/guilt b/guilt
index 7f2b93c..700c167 100755
--- a/guilt
+++ b/guilt
@@ -178,7 +178,13 @@ get_series()
 	#	- whitespace only
 	#	- optional whitespace followed by '#' followed by more
 	#	  optional whitespace
-	grep -ve '^[[:space:]]*\(#.*\)*$' "$series"
+	# also remove comments from end of lines
+	sed -n -e "/^[[:space:]]*\(#.*\)*\$/ ! {
+		s/[[:space:]]*#.*\$//
+
+		p
+		}
+		" $series
 }
 
 # usage: do_make_header <hash>
@@ -290,14 +296,17 @@ series_insert_patch()
 # usage: series_remove_patch <patchname>
 series_remove_patch()
 {
-	grep -v "^$1\$" < "$series" > "$series.tmp"
+	grep -v "^$1[[:space:]]*#*" < "$series" > "$series.tmp"
 	mv "$series.tmp" "$series"
 }
 
 # usage: series_rename_patch <oldname> <newname>
 series_rename_patch()
 {
-	awk -v old="$1" -v new="$2" \
+	# Rename the patch, but preserve comments on the line
+	old=$(grep -e "^$1[[:space:]]*" $series)
+	new=$(echo "$old" | sed -e "s,^$1,$2,")
+	awk -v old="$old" -v new="$new" \
 		'{ if ($0 == old) print new; else print $0 }' \
 		"$series" > "$series.tmp"
 
diff --git a/regression/050-series.sh b/regression/050-series.sh
index eb23540..4c47e9d 100755
--- a/regression/050-series.sh
+++ b/regression/050-series.sh
@@ -26,7 +26,7 @@ modify
 add
 
 remove
-mode
+mode # and text
 #sure
 DONE
 }
-- 
1.5.2
