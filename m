Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E6121F461
	for <e@80x24.org>; Tue, 27 Aug 2019 03:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfH0DoN (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 23:44:13 -0400
Received: from forward102j.mail.yandex.net ([5.45.198.243]:33682 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728345AbfH0DoN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Aug 2019 23:44:13 -0400
Received: from mxback7j.mail.yandex.net (mxback7j.mail.yandex.net [IPv6:2a02:6b8:0:1619::110])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id 039DDF202E9;
        Tue, 27 Aug 2019 06:44:09 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback7j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ohqhSqdR2l-i89SD368;
        Tue, 27 Aug 2019 06:44:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1566877448;
        bh=qSzmGm6bqBhZ6KIkJn3VZ7gBmK5nAvDdla3bf96pJzo=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-Id;
        b=QX+KYrVQAtjj8QjCT5EGS9rGKNel0yYG6rgXJTkKCviMPaprx7drDH0SZDJD4xEoP
         tPr4C20aTKbIeHjOY8Jes5kgRCgaVLKkrhYPwLs/XM4sbKtLBh0EjfvdJLwtVapgLB
         S+ut58Y3nRV43TTf8TNoDhXEkelT2FdLQMRn0JjY=
Authentication-Results: mxback7j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id fy1vKFTOGf-i5YKcWf7;
        Tue, 27 Aug 2019 06:44:06 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Andrey Mazo <ahippo@yandex.ru>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Philip.McGraw" <Philip.McGraw@bentley.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Andrey Mazo <ahippo@yandex.com>, git@vger.kernel.org,
        gitgitgadget@gmail.com
Subject: [PATCH v2 1/1] git-p4: auto-delete named temporary file
Date:   Tue, 27 Aug 2019 06:43:58 +0300
Message-Id: <7e59b5cec2f267820feeeeb63a20814fe67d61e3.1566876175.git.ahippo@yandex.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <pull.303.v2.git.gitgitgadget@gmail.com>
References: <pull.303.v2.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Philip.McGraw" <Philip.McGraw@bentley.com>

Avoid double-open exceptions on Windows platform when
calculating for lfs compressed size threshold
(git-p4.largeFileCompressedThreshold) comparisons.

Take new approach using the NamedTemporaryFile()
file-like object as input to the ZipFile() which
auto-deletes after implicit close leaving with scope.

Original code had double-open exception on Windows
platform because file still open from NamedTemporaryFile()
using generated filename instead of object.

Thanks to Andrey for patiently suggesting several
iterations on this change for avoiding exceptions!

Also print error details after resulting IOError to make
debugging cause of exception less mysterious when it has
nothing to do with "git version recent enough."

Signed-off-by: Philip.McGraw <Philip.McGraw@bentley.com>
Reviewed-by: Andrey Mazo <ahippo@yandex.com>
---
 git-p4.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index c71a6832e2..33bdb14fd1 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1158,17 +1158,15 @@ def exceedsLargeFileThreshold(self, relPath, contents):
         if gitConfigInt('git-p4.largeFileCompressedThreshold'):
             contentsSize = sum(len(d) for d in contents)
             if contentsSize <= gitConfigInt('git-p4.largeFileCompressedThreshold'):
                 return False
             contentTempFile = self.generateTempFile(contents)
-            compressedContentFile = tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=False)
-            zf = zipfile.ZipFile(compressedContentFile.name, mode='w')
-            zf.write(contentTempFile, compress_type=zipfile.ZIP_DEFLATED)
-            zf.close()
-            compressedContentsSize = zf.infolist()[0].compress_size
+            compressedContentFile = tempfile.NamedTemporaryFile(prefix='git-p4-large-file', delete=True)
+            with zipfile.ZipFile(compressedContentFile, mode='w') as zf:
+                zf.write(contentTempFile, compress_type=zipfile.ZIP_DEFLATED)
+                compressedContentsSize = zf.infolist()[0].compress_size
             os.remove(contentTempFile)
-            os.remove(compressedContentFile.name)
             if compressedContentsSize > gitConfigInt('git-p4.largeFileCompressedThreshold'):
                 return True
         return False
 
     def addLargeFile(self, relPath):
@@ -3512,12 +3510,13 @@ def importHeadRevision(self, revision):
         details["time"] = res["time"]
 
         self.updateOptionDict(details)
         try:
             self.commit(details, self.extractFilesFromCommit(details), self.branch)
-        except IOError:
+        except IOError as err:
             print("IO error with git fast-import. Is your git version recent enough?")
+            print("IO error details: {}".format(err))
             print(self.gitError.read())
 
     def openStreams(self):
         self.importProcess = subprocess.Popen(["git", "fast-import"],
                                               stdin=subprocess.PIPE,

base-commit: 1feeaaf26bff51996f9f96c6dc41ca0f95ab5fc4
Pull-Request: https://github.com/gitgitgadget/git/pull/303
-- 
2.21.0

