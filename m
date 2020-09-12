Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC47C43461
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 20:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB892151B
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 20:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgILUvp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 16:51:45 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58468 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725891AbgILUvn (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Sep 2020 16:51:43 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 0DA4260892;
        Sat, 12 Sep 2020 20:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1599943902;
        bh=ffOrMOTqbMSnRIB6DVpqNkv0X12CC7ko+e2Gm55K6es=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=CoYNA/61IPb5RYflH0N9OqyhZeU6RneoscS18EHKtGXSRt5GcWeIolzwU1ArQ1oE1
         vhzzqjc6OvNqSxYm/axwAbmQRP/ki0TADcmi+rbpUwaKrflYq39rK6Wydj72kM9lbb
         wQp11S183OKeowstdk3VAoZi2hsR6k8r1seV/HYV2WJzQjhgfPcmhujxoF68cQ2J9b
         0BkE5sIEw6vfQpfknCCii8pbbyAU3eWM1vhcai0fsxRMFx+a90vXYhLPTskvot2+c4
         6J9fsCMk7+iVb66jvT+01YZSUlopPSGN1akd0ZjbJjJ2yULGN0F33SZiNz/E3r5Xrd
         OU9ZnkqPYC+EF1SJD4D6vW8y9kkAhtM4B/h6a5bZeUieU6rrK2yOu5EPnYdxWuTXrQ
         EKIq5G63rwkpN/U62WPeYF048luUDAmsADiQTbhOtuAMNLXl+ujM5UdUwVHAnAv2YE
         Y2Vm1nIRQONypRPB2wtSnImL8eHhKQ66D/2ajNLyJ7og/bgEW/R
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH 3/3] docs: explain how to deal with files that are always modified
Date:   Sat, 12 Sep 2020 20:48:24 +0000
Message-Id: <20200912204824.2824106-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200912204824.2824106-1-sandals@crustytoothpaste.net>
References: <20200912204824.2824106-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Users frequently have problems where two files differ only in case,
causing one of those files to show up consistently as being modified.
Let's add a FAQ entry that explains how to deal with that.

In addition, let's explain another common case where files are
consistently modified, which is when files using a smudge or clean
filter have not been run through that filter.  Explain the way to fix
this as well.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitfaq.txt | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index 154f0cce54..494ec5dce5 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -362,6 +362,39 @@ information about how to configure files as text or binary.
 You can also control this behavior with the `core.whitespace` setting if you
 don't wish to remove the carriage returns from your line endings.
 
+[[always-modified-files-case]]
+Why do I have a file that's always modified?::
+	Internally, Git always stores file names as sequences of bytes and doesn't
+	perform any encoding or case folding.  However, Windows and macOS by default
+	both perform case folding on file names.  As a result, it's possible to end up
+	with multiple files or directories that differ in case.  Git can handle this
+	just fine, but the file system can store only one of these files, so when Git
+	reads the other file to see its contents, it looks modified.
++
+It's best to remove one of the files such that you only have one file.  You can
+do this with commands like the following (assuming two files `AFile.txt` and
+`afile.txt`) on an otherwise clean working tree:
++
+----
+$ git rm --cached AFile.txt
+$ git commit -m 'Remove files conflicting in case'
+$ git checkout .
+----
++
+This avoids touching the disk, but removes the additional file.  Your project
+may prefer to adopt a naming convention, such as all-lowercase names, to avoid
+this problem from occurring again; such a convention can be checked using a
+`pre-receive` hook or as part of a continuous integration (CI) system.
++
+It is also possible for perpetually modified files to occur on any platform if a
+smudge or clean filter is in use on your system but a file was previously
+committed without running the smudge or clean filter.  To fix this, run the
+following on an otherwise clean working tree:
++
+----
+$ git add --renormalize .
+----
+
 [[recommended-storage-settings]]
 What's the recommended way to store files in Git?::
 	While Git can store and handle any file of any type, there are some
