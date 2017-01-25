Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288F41F70F
	for <e@80x24.org>; Wed, 25 Jan 2017 09:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbdAYJRc (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 04:17:32 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:39690
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751360AbdAYJRb (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Jan 2017 04:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1485335849;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=5pVF6vWhRabYFxUsf4SoRA0h2ICywbbP20GP+VAcDwA=;
        b=HJxoib7Sntqk0fEGNce94qyj9NhnXRhUmUL9maTueANdsCYiffP/63oOQ2Wfl1p9
        1tCe3HODNahEEU4KjqB/8R9yRVRfKqsJNYu0ctdo7orN1GMtkVLtz3nDedtjnme6fdB
        lX3DWTplafD9YW6lsZdkZ97ZQFqyIgFIYFcjUBmY=
From:   George Vanburgh <george@vanburgh.me>
To:     git@vger.kernel.org
Message-ID: <01020159d4ea6861-fce45d61-8be5-49b0-ab4e-d161b9429795-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020159c0e82598-e373cf0d-2bad-41bb-b455-6896ad183e22-000000@eu-west-1.amazonses.com>
References: <01020159c0e82598-e373cf0d-2bad-41bb-b455-6896ad183e22-000000@eu-west-1.amazonses.com>
Subject: [PATCH v2] git-p4: Fix git-p4.mapUser on Windows
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 Jan 2017 09:17:29 +0000
X-SES-Outgoing: 2017.01.25-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: George Vanburgh <gvanburgh@bloomberg.net>

When running git-p4 on Windows, with multiple git-p4.mapUser entries in
git config - no user mappings are applied to the generated repository.

Reproduction Steps:

1. Add multiple git-p4.mapUser entries to git config on a Windows
   machine
2. Attempt to clone a p4 repository

None of the user mappings will be applied.

This issue is actually caused by gitConfigList, using
split(os.linesep) to convert the output of git config --get-all into
a list. On Windows, os.linesep is equal to '\r\n' - however git.exe
returns configuration with a line seperator of '\n'. This leads to
the list returned by gitConfigList containing only one element - which
contains the full output of git config --get-all in string form, which
causes problems for the code introduced to getUserMapFromPerforceServer
in 10d08a1.

This issue should be caught by the test introduced in 10d08a1, however
would require running on Windows to reproduce.

Using splitlines solves this issue, by splitting config on all
typical delimiters ('\n', '\r\n' etc.)

Signed-off-by: George Vanburgh <gvanburgh@bloomberg.net>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index f427bf6..b66f68b 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -656,7 +656,7 @@ def gitConfigInt(key):
 def gitConfigList(key):
     if not _gitConfig.has_key(key):
         s = read_pipe(["git", "config", "--get-all", key], ignore_error=True)
-        _gitConfig[key] = s.strip().split(os.linesep)
+        _gitConfig[key] = s.strip().splitlines()
         if _gitConfig[key] == ['']:
             _gitConfig[key] = []
     return _gitConfig[key]

--
https://github.com/git/git/pull/319
