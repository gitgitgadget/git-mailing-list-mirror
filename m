Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2077C1FF6D
	for <e@80x24.org>; Sun, 18 Dec 2016 17:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753253AbcLRRvX (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Dec 2016 12:51:23 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33877 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbcLRRvW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Dec 2016 12:51:22 -0500
Received: by mail-wm0-f66.google.com with SMTP id g23so14746323wme.1
        for <git@vger.kernel.org>; Sun, 18 Dec 2016 09:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xugvRBPYS3EhKmlkYKHbtq5YhCL1xZZQz5FO7kKvDh8=;
        b=P9CNDamLAtqp+QOZSup6zg7LnYCeizpi61aK/kKj2WOtA9CRgmTedXDMIYloEdF7C/
         8B/K4+cRUNDEbkkNLOLHAGfo3sGBx9bgcg6ys1aLohuJDJNKEOUv1IILGpNuDpIKSWJ7
         m06LG1RFrG7/3t5KlFsRJunr2GbCr9IR3ddchZhRQfM5MKdm68NyJ9G5UA1tSCKbpOjU
         Vfg73l9ZU46AOYZI7gimWokZD00dnaSdA2qVbwci7ePJVBypGdC0JXHnzaTCRfPmfLZ2
         KNXhr4+qBNuplY0dYTcfHKmKZrNBxb8bzleuRLT4+PoO2fzHg5ETocX7u28qBRk4SVAD
         ZlJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xugvRBPYS3EhKmlkYKHbtq5YhCL1xZZQz5FO7kKvDh8=;
        b=bkgOzvWCvPY4/dVQwzuCucL1ZPBLxpi2qtoyjPAi/ytJVBDwGTWcknhMIpt8PT3vr1
         dEv/Zo7dadh3WK3i5Rur9k7xo4JyR8Yy4iC6l43WTMwcy4DMhDRSOuXeu72mleZ2JbNn
         wU0p1of6UUrf2KPReW7O3CCgk0PWHEGdJpC6YSLKyNdtdmbGhOkSR/Xch/elrxIFzXem
         7fo3hwi7EjlCO3cTQxOPkYEX9Xov45BPysm3jEiAAGO78Ly/C0ABLu5LS2fqazV1MmwB
         /08MYdur5B1CPhYTZho9V1l0Jus323toPYjR8gpxvaLtdO+1NXhBBgzxJuecmy/UjYpk
         PBvg==
X-Gm-Message-State: AIkVDXL8r8Y325OQpNDwvs9hFAt/eme6lE8DRQ8HaSoeX8091mKfwER8ULwvaeL3iY5RTw==
X-Received: by 10.28.4.199 with SMTP id 190mr10319408wme.11.1482083481186;
        Sun, 18 Dec 2016 09:51:21 -0800 (PST)
Received: from slxBook4.fritz.box.fritz.box (p5DDB6496.dip0.t-ipconnect.de. [93.219.100.150])
        by smtp.gmail.com with ESMTPSA id yj10sm16961250wjb.3.2016.12.18.09.51.19
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 18 Dec 2016 09:51:20 -0800 (PST)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     luke@diamand.org, gitster@pobox.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1] git-p4: fix git-p4.pathEncoding for removed files
Date:   Sun, 18 Dec 2016 18:51:53 +0100
Message-Id: <20161218175153.92336-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

In a9e38359e3 we taught git-p4 a way to re-encode path names from what
was used in Perforce to UTF-8. This path re-encoding worked properly for
"added" paths. "Removed" paths were not re-encoded and therefore
different from the "added" paths. Consequently, these files were not
removed in a git-p4 cloned Git repository because the path names did not
match.

Fix this by moving the re-encoding to a place that affects "added" and
"removed" paths. Add a test to demonstrate the issue.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Notes:
    Base Commit: d1271bddd4 (v2.11.0)
    Diff on Web: https://github.com/git/git/compare/d1271bddd4...larsxschneider:05a82caa69
    Checkout:    git fetch https://github.com/larsxschneider/git git-p4/fix-path-encoding-v1 && git checkout 05a82caa69

 git-p4.py                       | 19 +++++++++----------
 t/t9822-git-p4-path-encoding.sh | 16 ++++++++++++++++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index fd5ca52462..8f311cb4e8 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2366,6 +2366,15 @@ class P4Sync(Command, P4UserMap):
                     break
 
         path = wildcard_decode(path)
+        try:
+            path.decode('ascii')
+        except:
+            encoding = 'utf8'
+            if gitConfig('git-p4.pathEncoding'):
+                encoding = gitConfig('git-p4.pathEncoding')
+            path = path.decode(encoding, 'replace').encode('utf8', 'replace')
+            if self.verbose:
+                print 'Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, path)
         return path
 
     def splitFilesIntoBranches(self, commit):
@@ -2495,16 +2504,6 @@ class P4Sync(Command, P4UserMap):
             text = regexp.sub(r'$\1$', text)
             contents = [ text ]
 
-        try:
-            relPath.decode('ascii')
-        except:
-            encoding = 'utf8'
-            if gitConfig('git-p4.pathEncoding'):
-                encoding = gitConfig('git-p4.pathEncoding')
-            relPath = relPath.decode(encoding, 'replace').encode('utf8', 'replace')
-            if self.verbose:
-                print 'Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, relPath)
-
         if self.largeFileSystem:
             (git_mode, contents) = self.largeFileSystem.processContent(git_mode, relPath, contents)
 
diff --git a/t/t9822-git-p4-path-encoding.sh b/t/t9822-git-p4-path-encoding.sh
index 7b83e696a9..c78477c19b 100755
--- a/t/t9822-git-p4-path-encoding.sh
+++ b/t/t9822-git-p4-path-encoding.sh
@@ -51,6 +51,22 @@ test_expect_success 'Clone repo containing iso8859-1 encoded paths with git-p4.p
 	)
 '
 
+test_expect_success 'Delete iso8859-1 encoded paths and clone' '
+	(
+		cd "$cli" &&
+		ISO8859="$(printf "$ISO8859_ESCAPED")" &&
+		p4 delete "$ISO8859" &&
+		p4 submit -d "remove file"
+	) &&
+	git p4 clone --destination="$git" //depot@all &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git -c core.quotepath=false ls-files >actual &&
+		test_must_be_empty actual
+	)
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
2.11.0

