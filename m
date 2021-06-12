Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F395FC48BCF
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 07:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE6FD61108
	for <git@archiver.kernel.org>; Sat, 12 Jun 2021 07:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhFLHmA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 12 Jun 2021 03:42:00 -0400
Received: from outgoing-exchange-7.mit.edu ([18.9.28.58]:40830 "EHLO
        outgoing-exchange-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229942AbhFLHl7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Jun 2021 03:41:59 -0400
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Jun 2021 03:41:59 EDT
Received: from oc11exedge1.exchange.mit.edu (OC11EXEDGE1.EXCHANGE.MIT.EDU [18.9.3.17])
        by outgoing-exchange-7.mit.edu (8.14.7/8.12.4) with ESMTP id 15C7Yj9k000632;
        Sat, 12 Jun 2021 03:34:47 -0400
Received: from w92expo7.exchange.mit.edu (18.7.74.61) by
 oc11exedge1.exchange.mit.edu (18.9.3.17) with Microsoft SMTP Server (TLS) id
 15.0.1497.18; Sat, 12 Jun 2021 03:34:48 -0400
Received: from oc11expo7.exchange.mit.edu (18.9.4.12) by
 w92expo7.exchange.mit.edu (18.7.74.61) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 12 Jun 2021 03:34:46 -0400
Received: from oc11expo7.exchange.mit.edu ([18.9.4.12]) by
 oc11expo7.exchange.mit.edu ([18.9.4.12]) with mapi id 15.00.1497.015; Sat, 12
 Jun 2021 03:34:46 -0400
From:   Anders Kaseorg <andersk@mit.edu>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Elijah Newren <newren@gmail.com>
Subject: v2.25 regression: cherry-pick alters patch and leaves working tree
 dirty
Thread-Topic: v2.25 regression: cherry-pick alters patch and leaves working
 tree dirty
Thread-Index: AQHXX11rnNeW6S6HRUqBaUqHX35FMA==
Date:   Sat, 12 Jun 2021 07:34:46 +0000
Message-ID: <148044c89c194a82aa15ab0ca016669d@oc11expo7.exchange.mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [157.131.169.219]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I ran into a problem where git cherry-pick incorrectly alters a patch that should apply cleanly, and leaves the working tree dirty despite claiming to finish successfully. I minimized the problem to the reproduction recipe below. Bisecting git.git shows the problem was introduced by 49b8133a9ece199a17db8bb2545202c6eac67485 (v2.25.0-rc0~144^2~1) “merge-recursive: fix merging a subdirectory into the root directory”, and it remains a problem in v2.32.0.

To reproduce:

git init
echo foo >foo
echo bar >bar
echo baz >baz
git add foo bar baz
git commit -m 'Initial commit'
mkdir dir
git mv foo dir/foo
git commit -am 'Move foo'
git mv bar dir/bar
echo baz >>baz
git commit -am 'Move bar'
git tag move-bar
git reset --hard move-bar~2
git cherry-pick move-bar

The rename part of the patch has been unexpectedly lost, and ‘bar’ has been unexpectedly deleted from the working tree:

$ git show
commit f06592b45db70540983a6c3e8bcf62712c694257
Author: Anders Kaseorg <andersk@mit.edu>
Date:   Sat Jun 12 00:20:13 2021 -0700

    Move bar

diff --git a/baz b/baz
index 7601807..1f55335 100644
--- a/baz
+++ b/baz
@@ -1 +1,2 @@
 baz
+baz

$ git status
On branch master
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	deleted:    bar

no changes added to commit (use "git add" and/or "git commit -a")

Before 49b8133a9e, the results are as expected:

$ git show
commit b7a2a3505dae3589203ca4469cb49e8a8e2727c3
Author: Anders Kaseorg <andersk@mit.edu>
Date:   Sat Jun 12 00:23:07 2021 -0700

    Move bar

diff --git a/baz b/baz
index 7601807..1f55335 100644
--- a/baz
+++ b/baz
@@ -1 +1,2 @@
 baz
+baz
diff --git a/bar b/dir/bar
similarity index 100%
rename from bar
rename to dir/bar

$ git status
On branch master
nothing to commit, working tree clean

Anders
