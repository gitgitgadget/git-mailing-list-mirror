Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C4591F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 12:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751164AbdAUMCy (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 07:02:54 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:45766
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750912AbdAUMCx (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Jan 2017 07:02:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1485000156;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=UztOy8aHqC0rzYKY6ZVzulSltqUCrf3ahj777VBgs4A=;
        b=PL30oFR5KJXOBojTRKhcvcBsi8+bKxLQou0rZ0yhTfypZ/ppaMpyNKd5DAv6DRRB
        yi9pks03X8XDhQG5vzIVjCklG9yu8O7CxzszTYLaiaHPcm0Uj9vmDSgj7Miq4Bpl7iP
        IEj+oOtyCTjxKdazwNCnuCUk+pnxoX0aPeU//9LY=
From:   George Vanburgh <george@vanburgh.me>
To:     git@vger.kernel.org
Message-ID: <01020159c0e82598-e373cf0d-2bad-41bb-b455-6896ad183e22-000000@eu-west-1.amazonses.com>
Subject: [PATCH] git-p4: Fix git-p4.mapUser on Windows
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sat, 21 Jan 2017 12:02:36 +0000
X-SES-Outgoing: 2017.01.21-54.240.7.17
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

This issue is caused by the fact that gitConfigList,
uses split(os.linesep) to convert the output of
git config --get-all into a list.

On Windows, os.linesep is equal to '\r\n' - however git.exe
returns configuration with a line seperator of '\n'. This leads to
the list returned by gitConfigList containing only one element - which
contains the full output of git config --get-all in string form. This
causes problems for the code introduced to getUserMapFromPerforceServer
in 10d08a1.

This issue should be caught by the test introduced in 10d08a1, and
would require running on Windows to reproduce. When running inside
MinGW/Cygwin, however, os.linesep correctly returns '\n', and everything
works as expected.

The simplest fix for this issue would be to convert the line split logic
inside gitConfigList to use splitlines(), which splits on any standard
line delimiter. However, this function was only introduced in Python
2.7, and would mean a bump in the minimum required version of Python
required to run git-p4. The alternative fix, implemented here, is to use
'\n' as a delimiter, which git.exe appears to output consistently on
Windows anyway.

Signed-off-by: George Vanburgh <gvanburgh@bloomberg.net>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index f427bf6..c134a58 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -656,7 +656,7 @@ def gitConfigInt(key):
 def gitConfigList(key):
     if not _gitConfig.has_key(key):
         s = read_pipe(["git", "config", "--get-all", key], ignore_error=True)
-        _gitConfig[key] = s.strip().split(os.linesep)
+        _gitConfig[key] = s.strip().split("\n")
         if _gitConfig[key] == ['']:
             _gitConfig[key] = []
     return _gitConfig[key]

--
https://github.com/git/git/pull/319
