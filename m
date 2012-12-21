From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] mergetools/p4merge: Honor $TMPDIR for the /dev/null placeholder
Date: Thu, 20 Dec 2012 22:57:03 -0800
Message-ID: <1356073023-15376-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Fri Dec 21 07:57:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlwXv-0003km-QI
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 07:57:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008Ab2LUG5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 01:57:09 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:52242 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab2LUG5I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 01:57:08 -0500
Received: by mail-pb0-f44.google.com with SMTP id uo1so2523971pbc.17
        for <git@vger.kernel.org>; Thu, 20 Dec 2012 22:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=RYn2PNHJU4f3gnZm50yUDNjqQbZULDooey0xSILf0NU=;
        b=wBEFB7cFyC5JtgXUTFN1OQWB5lqPBOJ2Ojl2r0DwYQOP5/6fbZZ9ZVv5KWoB1WZ5Kb
         rQxfol88y+YxsxrGtnncAK5NxsQs7v0KP8SU2PeE1prQu+Mj/3/dTjey9XHJdRRXgb+8
         X/2kt7fOa02oKXMc8sfm+BUHAUj3XwxFN0hMqi5IgxdQMfmlUyiQWC0aqloTuSgyukQR
         Wdt5YlA/XNfxy9v/i3xxUODpBIjJcmBPr7DZ0Zr3zW+qJ+F8OG8hFuAAOCENZUsgpLwM
         QMeWee6K9ItNd+JUvmY/uI5y6Er9TEQEeryhoS0085jQ5Z5dVfxOQpsJjmigJKPuvDrH
         w2hA==
X-Received: by 10.68.212.200 with SMTP id nm8mr37867144pbc.4.1356073027462;
        Thu, 20 Dec 2012 22:57:07 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id bh9sm6854254pab.12.2012.12.20.22.57.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Dec 2012 22:57:06 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc2.6.g18499ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211953>

Use $TMPDIR when creating the /dev/null placeholder for p4merge.
This keeps it out of the current directory.

Reported-by: Jeremy Morton <admin@game-point.net>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
No mktemp usage in this round.

 mergetools/p4merge | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/mergetools/p4merge b/mergetools/p4merge
index 295361a..52f7c8f 100644
--- a/mergetools/p4merge
+++ b/mergetools/p4merge
@@ -1,29 +1,21 @@
 diff_cmd () {
+	empty_file=
+
 	# p4merge does not like /dev/null
-	rm_local=
-	rm_remote=
 	if test "/dev/null" = "$LOCAL"
 	then
-		LOCAL="./p4merge-dev-null.LOCAL.$$"
-		>"$LOCAL"
-		rm_local=true
+		LOCAL="$(create_empty_file)"
 	fi
 	if test "/dev/null" = "$REMOTE"
 	then
-		REMOTE="./p4merge-dev-null.REMOTE.$$"
-		>"$REMOTE"
-		rm_remote=true
+		REMOTE="$(create_empty_file)"
 	fi
 
 	"$merge_tool_path" "$LOCAL" "$REMOTE"
 
-	if test -n "$rm_local"
-	then
-		rm -f "$LOCAL"
-	fi
-	if test -n "$rm_remote"
+	if test -n "$empty_file"
 	then
-		rm -f "$REMOTE"
+		rm -f "$empty_file"
 	fi
 }
 
@@ -33,3 +25,10 @@ merge_cmd () {
 	"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" "$MERGED"
 	check_unchanged
 }
+
+create_empty_file () {
+	empty_file="${TMPDIR:-/tmp}/git-difftool-p4merge-empty-file.$$"
+	>"$empty_file"
+
+	printf "$empty_file"
+}
-- 
1.8.1.rc2.6.g18499ba
