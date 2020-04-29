Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFCBC83003
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 13:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BBAD214D8
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 13:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="QDMv3izn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgD2NCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:02:14 -0400
Received: from mx1.riseup.net ([198.252.153.129]:46010 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgD2NCO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 09:02:14 -0400
Received: from capuchin.riseup.net (unknown [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 49BzF15bDdzFfLf;
        Wed, 29 Apr 2020 06:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1588165333; bh=+I/Q857Zz1P01GJtiWDKaMZhrknaErnCK2YjSEtNvlg=;
        h=From:To:Cc:Subject:Date:From;
        b=QDMv3izn8rMIAC5m/nxg/OmLo3eQ2SONCJrpyq1oNrb0YiBdP4bFzKGBd56HUA4ZI
         Y4RV+STqlwmsoF0WWXGFOFkG9IMOKB8wJgKNeDJfdLNr5AdeNsDwvZ6+9naJt+nK9K
         gdqOWHrkhpRTcfPR4ZqgHanknMX0EMofBTBmJGpQ=
X-Riseup-User-ID: 45DB7319A25AECC9AA9B4ADFA65624A41C53E6B327720DABBAE9A592E567144E
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 49BzF03DQgz8vNS;
        Wed, 29 Apr 2020 06:02:12 -0700 (PDT)
From:   Ivan Tham <pickfire@riseup.net>
To:     git@vger.kernel.org
Cc:     "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] branch: add '-' to delete previous branch
Date:   Wed, 29 Apr 2020 21:01:33 +0800
Message-Id: <20200429130133.520981-1-pickfire@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add support to delete previous branch from git checkout/switch to have
feature parity with git switch -.

Signed-off-by: Ivan Tham <pickfire@riseup.net>
---
 Documentation/git-branch.txt | 10 ++++++++++
 builtin/branch.c             |  6 +++++-
 t/t3200-branch.sh            |  7 +++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 135206ff4a..37e7cbbc52 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -265,6 +265,10 @@ start-point is either a local or remote-tracking branch.
 	The new branch name must pass all checks defined by
 	linkgit:git-check-ref-format[1].  Some of these checks
 	may restrict the characters allowed in a branch name.
++
+You can use the `@{-N}` syntax to refer to the N-th last branch checked out
+using "git checkout" operation. You may also specify `-` which is synonymous to
+`@{-1}`.
 
 <start-point>::
 	The new branch head will point to this commit.  It may be
@@ -334,6 +338,12 @@ $ git branch -D test                                    <2>
 <2> Delete the "test" branch even if the "master" branch (or whichever branch
     is currently checked out) does not have all commits from the test branch.
 
+To delete the previous branch::
++
+------------
+$ git branch -D -
+------------
+
 Listing branches from a specific remote::
 +
 ------------
diff --git a/builtin/branch.c b/builtin/branch.c
index d8297f80ff..5537f819a6 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -227,9 +227,13 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	}
 	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
 		char *target = NULL;
+		const char *arg = argv[i];
 		int flags = 0;
 
-		strbuf_branchname(&bname, argv[i], allowed_interpret);
+		if (!strcmp(arg, "-"))
+			arg = "@{-1}";
+
+		strbuf_branchname(&bname, arg, allowed_interpret);
 		free(name);
 		name = mkpathdup(fmt, bname.buf);
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 411a70b0ce..6819107c1d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1387,4 +1387,11 @@ test_expect_success 'invalid sort parameter in configuration' '
 	)
 '
 
+test_expect_success 'delete previous branch' '
+	git checkout -b a &&
+	git checkout -b b &&
+	git branch -D - &&
+	test_path_is_missing .git/refs/heads/a
+'
+
 test_done
-- 
2.26.2

