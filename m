From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 2/2] mergetool-lib: add a three-way diff view for vim/gvim
Date: Mon, 27 Sep 2010 10:19:09 -0500
Message-ID: <1285600749-1088-1-git-send-email-dpmcgee@gmail.com>
References: <20100925031745.GB30550@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>, David Aguilar <davvid@gmail.com>,
	Jeff King <peff@peff.net>,
	Jacob Helwig <jacob.helwig@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Charles Bailey <charles@hashpling.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 17:19:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0FUD-0001fc-7d
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 17:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759545Ab0I0PTT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 11:19:19 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:59649 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756157Ab0I0PTS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 11:19:18 -0400
Received: by gwj17 with SMTP id 17so1549022gwj.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wp5tugX+MqWx8ET5ePRRiPXWmWoaTyuGX9pYC+G1aqM=;
        b=ov27KOE1l2whjSxR20i29jwipTrGEy1/iGwcIYHnRAzNSlNhfFOaGb5f7m2bbRYXvv
         g5z9PbYlK90ysWEvOGW22/twD6VI4B71uxZdgYXbGFj/X4r3hSgrJOxAmTpvYEJ6F4QA
         aBP53Q6BxDY2qFWMB6RrViDETCJ1Ss2vhaacg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=L+lkN2ah7Oxe7ByRzVehllKZyUVnBCBNQ0BtP7NJ/u7XaStqyBeQEk/5HGnLWdBWI2
         JmZ7I8xkckst9UuQi2EdAG+ZT4fJYKhy0FbQV3pEdKfaqxCC7SUK0IoywYTvi6WIct7A
         13yvI5uNUZ2fEXohMyNATppvjVcCoCn9gp2PE=
Received: by 10.220.124.139 with SMTP id u11mr854295vcr.13.1285600757916;
        Mon, 27 Sep 2010 08:19:17 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id w31sm3741541vbs.5.2010.09.27.08.19.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Sep 2010 08:19:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <20100925031745.GB30550@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157340>

When the base version is available, use a three-way, four panel view by
default. This shows the (local, base, remote) revisions up top and the
merged result by itself in the lower pane. All revisions will still scroll
together by default, and the cursor still defaults to the merged result edit
pane.

The original vimdiff/gvimdiff configuration is now available by using
'vimdiff2' or 'gvimdiff2' as the preferred merge tool.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---

This should address the comments I got once I pestered people. The new behavior
is the default, but it at least becomes possible to use the previous behavior
without much hassle (just set your mergetool appropriately).

-Dan

 git-mergetool--lib.sh |   23 ++++++++++++++++++++---
 1 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index f9a51ba..77d4aee 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -10,10 +10,10 @@ merge_mode() {
 
 translate_merge_tool_path () {
 	case "$1" in
-	vimdiff)
+	vimdiff|vimdiff2)
 		echo vim
 		;;
-	gvimdiff)
+	gvimdiff|gvimdiff2)
 		echo gvim
 		;;
 	emerge)
@@ -47,7 +47,8 @@ check_unchanged () {
 valid_tool () {
 	case "$1" in
 	kdiff3 | tkdiff | xxdiff | meld | opendiff | \
-	emerge | vimdiff | gvimdiff | ecmerge | diffuse | araxis | p4merge)
+	vimdiff | gvimdiff | vimdiff2 | gvimdiff2 | \
+	emerge | ecmerge | diffuse | araxis | p4merge)
 		;; # happy
 	tortoisemerge)
 		if ! merge_mode; then
@@ -172,6 +173,22 @@ run_merge_tool () {
 	vimdiff|gvimdiff)
 		if merge_mode; then
 			touch "$BACKUP"
+			if $base_present; then
+				"$merge_tool_path" -f -d -c "wincmd J" \
+					"$MERGED" "$LOCAL" "$BASE" "$REMOTE"
+			else
+				"$merge_tool_path" -f -d -c "wincmd l" \
+					"$LOCAL" "$MERGED" "$REMOTE"
+			fi
+			check_unchanged
+		else
+			"$merge_tool_path" -f -d -c "wincmd l" \
+				"$LOCAL" "$REMOTE"
+		fi
+		;;
+	vimdiff2|gvimdiff2)
+		if merge_mode; then
+			touch "$BACKUP"
 			"$merge_tool_path" -f -d -c "wincmd l" \
 				"$LOCAL" "$MERGED" "$REMOTE"
 			check_unchanged
-- 
1.7.3
