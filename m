Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 145901F404
	for <e@80x24.org>; Tue, 27 Feb 2018 04:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeB0EQz (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 23:16:55 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:50158
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751663AbeB0EQy (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Feb 2018 23:16:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1519705013;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=FhKCiwRfyl2d8tbY8PBbDgLHNr6BJdiocCvYmACH3YM=;
        b=jXUbEmLQVAOIP7T2tnVxFuiC2O9QiEgdYTzJpFKc6yYkrcYzEXql0cZcd0SvxOMY
        8r7gV/IQA6FrbaOk7KWp8zte3kfJn8CIekO3TeKKqXRkSdBDuLJ6NVOi1ILQ8PIxnhz
        y+nNtr2zWzeIojuI98nvNWKeEPyCHc3oZIpw+GE0=
From:   Nuno Subtil <subtil@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020161d57a3c14-1177a79b-cc21-4d78-8bbd-b6650f7a6169-000000@eu-west-1.amazonses.com>
Subject: [PATCH] git-p4: Fix depot path stripping
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Feb 2018 04:16:53 +0000
X-SES-Outgoing: 2018.02.27-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When useClientSpec=true, stripping of P4 depot paths doesn't happen
correctly on sync. Modifies stripRepoPath to handle this case better.

Signed-off-by: Nuno Subtil <subtil@gmail.com>
---
 git-p4.py | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 7bb9cadc69738..3df95d0fd1d83 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2480,7 +2480,7 @@ def stripRepoPath(self, path, prefixes):
                     if path.startswith(b + "/"):
                         path = path[len(b)+1:]
 
-        elif self.keepRepoPath:
+        if self.keepRepoPath:
             # Preserve everything in relative path name except leading
             # //depot/; just look at first prefix as they all should
             # be in the same depot.
@@ -2490,6 +2490,12 @@ def stripRepoPath(self, path, prefixes):
 
         else:
             for p in prefixes:
+		if self.useClientSpec and not self.keepRepoPath:
+                    # when useClientSpec is false, the prefix will contain the depot name but the path will not
+                    # extract the depot name and add it to the path so the match below will do the right thing
+                    depot = re.sub("^(//[^/]+/).*", r'\1', p)
+                    path = depot + path
+
                 if p4PathStartsWith(path, p):
                     path = path[len(p):]
                     break
@@ -2526,8 +2532,8 @@ def splitFilesIntoBranches(self, commit):
             # go in a p4 client
             if self.useClientSpec:
                 relPath = self.clientSpecDirs.map_in_client(path)
-            else:
-                relPath = self.stripRepoPath(path, self.depotPaths)
+
+            relPath = self.stripRepoPath(path, self.depotPaths)
 
             for branch in self.knownBranches.keys():
                 # add a trailing slash so that a commit into qt/4.2foo

--
https://github.com/git/git/pull/463
