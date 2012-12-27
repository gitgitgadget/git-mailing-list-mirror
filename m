From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v3] mergetools/p4merge: Honor $TMPDIR for the /dev/null placeholder
Date: Wed, 26 Dec 2012 16:45:29 -0800
Message-ID: <1356569129-10024-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jeremy Morton <admin@game-point.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 01:45:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To1bd-0005lh-Ke
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 01:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290Ab2L0Ape (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 19:45:34 -0500
Received: from mail-da0-f54.google.com ([209.85.210.54]:44452 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab2L0Apd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 19:45:33 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so4071019dad.27
        for <git@vger.kernel.org>; Wed, 26 Dec 2012 16:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=ACQlG866pfXjpYaWTqS8VUjd64i6VylaV5QBup/pICU=;
        b=DC7hWmcZnjaVt2dcKJGiapQCzA4VZPEhjhBoYPYxbmoywY+8pBB6RtFaz/OIoIlRUd
         aqWI7K6kdhdOXWsypk8u3ebTfs83dvDxG9hZJ3Bq9wHbIqZ0y2cHy/mdKtYpngznwpPx
         PVFO+qqfPTXG/IkGh+bCCyyFvq1NZ2FlWb4Me35DsTqi6JuvqTpzuvEY3jpEcTsqIgy/
         9gsWU7ArGA3CDaBfjR1jifAURyGRqkBHFfNLnq/9DyNY48sGPQe+kCqlFBcnbOnEFWHY
         kytlCpTp3gDaakxt4HAeWsIlPZ40TOBuNotvVp4HXPik/VnMkffEydMD7bxTov5qqY+8
         +KZg==
X-Received: by 10.68.238.165 with SMTP id vl5mr91290484pbc.0.1356569132704;
        Wed, 26 Dec 2012 16:45:32 -0800 (PST)
Received: from horus.socal.rr.com (cpe-76-175-168-235.socal.res.rr.com. [76.175.168.235])
        by mx.google.com with ESMTPS id nf9sm16731933pbc.17.2012.12.26.16.45.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 26 Dec 2012 16:45:31 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.11.g86c3e6e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212168>

Use $TMPDIR when creating the /dev/null placeholder for p4merge.
This prevents users from finding a seemingly random untracked file
in their worktree.

This is different than what mergetool does with $LOCAL and
$REMOTE because those files exist to aid users when resolving
merges.  p4merge's /dev/null placeholder is not helpful in that
situation so it is sensible to keep it out of the worktree.

Reported-by: Jeremy Morton <admin@game-point.net>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
v3 revised the commit message to better justify the change.
This is a replacement for what's current in 'next'.

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
1.8.1.rc3.11.g86c3e6e
