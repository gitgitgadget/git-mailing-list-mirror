From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 3/3] git-p4: reduce number of server queries for fetches
Date: Sat, 19 Dec 2015 09:39:40 +0000
Message-ID: <1450517980-1744-4-git-send-email-luke@diamand.org>
References: <1450517980-1744-1-git-send-email-luke@diamand.org>
Cc: James Farwell <jfarwell@vmware.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sam Hocevar <sam@hocevar.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 19 10:40:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAE0E-0001Gi-90
	for gcvg-git-2@plane.gmane.org; Sat, 19 Dec 2015 10:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbbLSJjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2015 04:39:51 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38102 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932495AbbLSJjl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2015 04:39:41 -0500
Received: by mail-wm0-f48.google.com with SMTP id l126so13400593wml.1
        for <git@vger.kernel.org>; Sat, 19 Dec 2015 01:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tDeLp7PTEGcAxJev6sDDGzeqdsbHUwgIZi9HuBbNqoI=;
        b=YrE3Ffe+uFEbeOtDDoI5czFt3miksvsOqlIfFoNFUt7F1Mxrte+YM0H2CVszxZGlKK
         XfAYt20KJ4mVjua/AK1Hz1a4TywY+LNJ9yxVLUp1JYiQDL1IvrPxirI9Ptkl9oJbREau
         a9bV5Mzr5jdzI94hl/M6mCCyBQDR+Lg+U24A0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tDeLp7PTEGcAxJev6sDDGzeqdsbHUwgIZi9HuBbNqoI=;
        b=E8186kdB+EKfzGe54bcsftTyC+O64CYgch0s6Tt8H2LGWziLw8wTqBJjH+U+UDSV+I
         MHHmQq2F4VFWeh89wj/wKUvfCbrQAWrhdHSmXR6QtFja14res7FEmzCQPjfUyXrReqvD
         255QyIV77hNuEu524iIo2fbbQ7FRsHZRm4BfKAV6Pn9xqiXZ6X1x3uXefOh7bheooH0r
         mowiJw81oNHvublPW9AfQiaxhmn8Mt4pgEQ0l+CpphKIKN4cvXcrtQVtMS8f2U7+HbFq
         DcSQp3rNMlFACi59rRRTqz9YpM0sVs96fP1YVkQM9FM6mwxQBog5iIEqqh9Elv8ONQCd
         PRWw==
X-Gm-Message-State: ALoCoQlrANW7Xkgzq0V+depqLcXzB+RGeN+OVEm8OW2XV62waEpKlhyHlOuSrXwkszil46MXW2FxcHMQi7XIlOAQl/oVXGM+2A==
X-Received: by 10.194.79.227 with SMTP id m3mr8731140wjx.5.1450517979892;
        Sat, 19 Dec 2015 01:39:39 -0800 (PST)
Received: from ethel.local.diamand.org (cpc92798-cmbg19-2-0-cust327.5-4.cable.virginm.net. [80.1.41.72])
        by smtp.gmail.com with ESMTPSA id b84sm10211547wmh.15.2015.12.19.01.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 19 Dec 2015 01:39:39 -0800 (PST)
X-Mailer: git-send-email 2.6.2.474.g3eb3291
In-Reply-To: <1450517980-1744-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282738>

From: Sam Hocevar <sam@hocevar.net>

When fetching changes from a depot using a full client spec, there
is no need to perform as many queries as there are top-level paths
in the client spec.  Instead we query all changes in chronological
order, also getting rid of the need to sort the results and remove
duplicates.

Signed-off-by: Sam Hocevar <sam@hocevar.net>
Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py               | 44 +++++++++++++++++++++-----------------------
 t/t9818-git-p4-block.sh |  2 +-
 2 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 122aff2..c33dece 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -822,39 +822,37 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
                 die("cannot use --changes-block-size with non-numeric revisions")
             block_size = None
 
-    # Accumulate change numbers in a dictionary to avoid duplicates
-    changes = {}
+    changes = []
 
-    for p in depotPaths:
-        # Retrieve changes a block at a time, to prevent running
-        # into a MaxResults/MaxScanRows error from the server.
+    # Retrieve changes a block at a time, to prevent running
+    # into a MaxResults/MaxScanRows error from the server.
 
-        while True:
-            cmd = ['changes']
+    while True:
+        cmd = ['changes']
 
-            if block_size:
-                end = min(changeEnd, changeStart + block_size)
-                revisionRange = "%d,%d" % (changeStart, end)
-            else:
-                revisionRange = "%s,%s" % (changeStart, changeEnd)
+        if block_size:
+            end = min(changeEnd, changeStart + block_size)
+            revisionRange = "%d,%d" % (changeStart, end)
+        else:
+            revisionRange = "%s,%s" % (changeStart, changeEnd)
 
+        for p in depotPaths:
             cmd += ["%s...@%s" % (p, revisionRange)]
 
-            for line in p4_read_pipe_lines(cmd):
-                changeNum = int(line.split(" ")[1])
-                changes[changeNum] = True
+        # Insert changes in chronological order
+        for line in reversed(p4_read_pipe_lines(cmd)):
+            changes.append(int(line.split(" ")[1]))
 
-            if not block_size:
-                break
+        if not block_size:
+            break
 
-            if end >= changeEnd:
-                break
+        if end >= changeEnd:
+            break
 
-            changeStart = end + 1
+        changeStart = end + 1
 
-    changelist = changes.keys()
-    changelist.sort()
-    return changelist
+    changes = sorted(changes)
+    return changes
 
 def p4PathStartsWith(path, prefix):
     # This method tries to remedy a potential mixed-case issue:
diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
index 64510b7..8840a18 100755
--- a/t/t9818-git-p4-block.sh
+++ b/t/t9818-git-p4-block.sh
@@ -128,7 +128,7 @@ test_expect_success 'Create a repo with multiple depot paths' '
 	done
 '
 
-test_expect_failure 'Clone repo with multiple depot paths' '
+test_expect_success 'Clone repo with multiple depot paths' '
 	(
 		cd "$git" &&
 		git p4 clone --changes-block-size=4 //depot/pathA@all //depot/pathB@all \
-- 
2.6.2.474.g3eb3291
