From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetool: Suppress stderr and fix the "both added" test
Date: Sat, 21 Jan 2012 02:26:18 -0800
Message-ID: <1327141578-54796-1-git-send-email-davvid@gmail.com>
Cc: jcwenger@gmail.com, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 21 11:26:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoY9Y-0002Ah-1G
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 11:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708Ab2AUK01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jan 2012 05:26:27 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47257 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294Ab2AUK0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2012 05:26:25 -0500
Received: by iacb35 with SMTP id b35so890488iac.19
        for <git@vger.kernel.org>; Sat, 21 Jan 2012 02:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=y4eTGsVm93ymABsoy1qYa6mq3dW6SvnUwvHhUJV3MZ0=;
        b=eEdjGmy/CEP1YMsJ8QfDz6dn91nX/vd7ujNUrr8OZT2qc456rqU8g3BIerWcovckMr
         uEb5aDNVDFnGcVOLPYao9zFJgooITr4SJob+1CIVgkf4VHZPRBWwaatEN/oAQBYIKZlU
         m/gM5T2icRVSD71BmYOvKgn3OvRJDFTnC9FZE=
Received: by 10.50.189.134 with SMTP id gi6mr22598igc.18.1327141585478;
        Sat, 21 Jan 2012 02:26:25 -0800 (PST)
Received: from localhost.localdomain (208-106-56-2.static.dsltransport.net. [208.106.56.2])
        by mx.google.com with ESMTPS id l35sm20612792ibj.0.2012.01.21.02.26.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 Jan 2012 02:26:24 -0800 (PST)
X-Mailer: git-send-email 1.7.7.166.g1cd0c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188920>

Silence error messages when "git checkout-index" is used to
checkout a stage that does not exist.  This can happen now that
mergetool calls checkout_staged_file() unconditionally when
creating the temporary $BASE, $LOCAL, and $REMOTE files.

Fix the test so that it checks the contents of the "both added"
file.  The test was passing as a consequence of accidentally
handing a bad path to "cat".

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This applies on top of da/maint-mergetool-twoway in pu.

 git-mergetool.sh     |    4 +++-
 t/t7610-mergetool.sh |    5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 24bedc5..a9f23f7 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -181,7 +181,9 @@ stage_submodule () {
 }
 
 checkout_staged_file () {
-    tmpfile=$(expr "$(git checkout-index --temp --stage="$1" "$2")" : '\([^	]*\)	')
+    tmpfile=$(expr \
+	    "$(git checkout-index --temp --stage="$1" "$2" 2>/dev/null)" \
+	    : '\([^	]*\)	')
 
     if test $? -eq 0 -a -n "$tmpfile" ; then
 	mv -- "$(git rev-parse --show-cdup)$tmpfile" "$3"
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 2272743..3f261a3 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -465,8 +465,9 @@ test_expect_success 'directory vs modified submodule' '
 test_expect_success 'file with no base' '
     git checkout -b test13 branch1 &&
     test_must_fail git merge master &&
-    git mergetool --no-prompt --tool mybase -- base &&
-    test "$(cat "$MERGED")" = "" &&
+    git mergetool --no-prompt --tool mybase -- both &&
+    >expected &&
+    test_cmp both expected &&
     git reset --hard master >/dev/null 2>&1
 '
 
-- 
1.7.7.166.g1cd0c
