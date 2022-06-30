Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E80C43334
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 23:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbiF3Xri (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 19:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiF3Xrb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 19:47:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD19B5A2CF
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i25so733447wrc.13
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 16:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ruz+7nzmMVGyR4KB7wSyQmi5y41wZ4bsYIL8rBs0oCE=;
        b=MI82WOHD/dUu+PFFMOn18XDJZFHfbZH/fQpFQ3mE7dIBu7BfajK4w3gCvxAqQDb8ii
         JCDv6gFJbKSGH+6y1vcHaI5D1aLoZ1N3cbNwZUbAudZii0KLxkyMrus0GbzEwp5p9R9C
         pdDXTPH92oOBkIvgBvgjVrgZIoPT73W2LBLnVpDafwK1on4pWQIdI1mgwlDPE+7Y3FQW
         fDdVd8148QZQAUvnzpL9h80KRPYVViVxnisa/sRjLtVS9e2iRhTXQHcIZPnrAHRoQqyQ
         29BB9NvK4jhm14fCMFQTRElYb141c5UeHS61efxcrE8/xXBLExgsZO0+hurq8rIopMWs
         1fvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ruz+7nzmMVGyR4KB7wSyQmi5y41wZ4bsYIL8rBs0oCE=;
        b=vMLhpg2gVGcFL2qprCc+R4Mq3cHQ5We63wqm2DIRjo+27XsRltQm46JwLkfM7rxSgo
         wjK10bpBDJwrvZOWcVt6N/aTRzodtpk3yx6lrY+5kM4dRsLRY3YCoh9iFcvK0woBl0PC
         0OLDnTmZgK3FTC5cVvuJ0dbGOo2rqsyw1LQf6983smdri7kY0YW7Q6JwAmGcRgXDMI6U
         zWbeOtB8wO5JTyOJ1W/WdUbzPB/xNg9x36HfyciiCakVUj5LNN3y5xWFL+lxO6SanfCA
         XcX/1QKcq73qgv9P6iTTyiabjaiDyX2FTVv4F7KzV1I0A40AGstXblVaxnP5NoW2VE0M
         tjsg==
X-Gm-Message-State: AJIora+nZXN/3UtNZUJOP3WtcvDoqDvOakgURM78N0qgFB/8KxZ2I+dX
        lRvN9Y1vJx4IxmYSVWHsvgSvOoyO2FdTQQ==
X-Google-Smtp-Source: AGRyM1sC7Q+lUMwsBfRpedM9zfLCNMD763QKvFZI/f3uvlA0POqbld6GvI5r58VpWOEcz9c5rT7fWg==
X-Received: by 2002:a5d:64e8:0:b0:21d:2fc9:20dd with SMTP id g8-20020a5d64e8000000b0021d2fc920ddmr8644259wri.101.1656632840987;
        Thu, 30 Jun 2022 16:47:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d59c3000000b00210bac248c8sm3011426wry.11.2022.06.30.16.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 16:47:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/9] test-tool regex: call regfree(), fix memory leaks
Date:   Fri,  1 Jul 2022 01:47:05 +0200
Message-Id: <patch-5.9-fe2a8d898f6-20220630T180129Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20220630T180129Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix memory leaks in "test-tool regex" which have been there since
c91841594c2 (test-regex: Add a test to check for a bug in the regex
routines, 2012-09-01), as a result we can mark a test as passing with
SANITIZE=leak using "TEST_PASSES_SANITIZE_LEAK=true".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-regex.c           | 40 ++++++++++++++++++++-------------
 t/t7812-grep-icase-non-ascii.sh |  1 +
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/t/helper/test-regex.c b/t/helper/test-regex.c
index d6f28ca8d14..a37d1f7a546 100644
--- a/t/helper/test-regex.c
+++ b/t/helper/test-regex.c
@@ -24,27 +24,35 @@ static int test_regex_bug(void)
 	char *str = "={}\nfred";
 	regex_t r;
 	regmatch_t m[1];
+	int err = 0;
 
 	if (regcomp(&r, pat, REG_EXTENDED | REG_NEWLINE))
 		die("failed regcomp() for pattern '%s'", pat);
-	if (regexec(&r, str, 1, m, 0))
-		die("no match of pattern '%s' to string '%s'", pat, str);
+	if (regexec(&r, str, 1, m, 0)) {
+		err = error("no match of pattern '%s' to string '%s'", pat, str);
+		goto cleanup;
+	}
 
 	/* http://sourceware.org/bugzilla/show_bug.cgi?id=3957  */
-	if (m[0].rm_so == 3) /* matches '\n' when it should not */
-		die("regex bug confirmed: re-build git with NO_REGEX=1");
+	if (m[0].rm_so == 3) { /* matches '\n' when it should not */
+		err = error("regex bug confirmed: re-build git with NO_REGEX=1");
+		goto cleanup;
+	}
 
-	return 0;
+cleanup:
+	regfree(&r);
+	return err < 0 ? 1 : 0;
 }
 
 int cmd__regex(int argc, const char **argv)
 {
 	const char *pat;
 	const char *str;
-	int ret, silent = 0, flags = 0;
+	int silent = 0, flags = 0;
 	regex_t r;
 	regmatch_t m[1];
 	char errbuf[64];
+	int ret = 0;
 
 	argv++;
 	argc--;
@@ -85,27 +93,29 @@ int cmd__regex(int argc, const char **argv)
 	}
 	git_setup_gettext();
 
-	ret = regcomp(&r, pat, flags);
-	if (ret) {
+	if (regcomp(&r, pat, flags)) {
 		if (silent)
-			return ret;
+			return 1;
 
 		regerror(ret, &r, errbuf, sizeof(errbuf));
 		die("failed regcomp() for pattern '%s' (%s)", pat, errbuf);
 	}
 	if (!str)
-		return 0;
+		goto cleanup;
 
-	ret = regexec(&r, str, 1, m, 0);
-	if (ret) {
+	if (regexec(&r, str, 1, m, 0)) {
+		ret = 1;
 		if (silent || ret == REG_NOMATCH)
-			return ret;
+			goto cleanup;
 
 		regerror(ret, &r, errbuf, sizeof(errbuf));
-		die("failed regexec() for subject '%s' (%s)", str, errbuf);
+		error("failed regexec() for subject '%s' (%s)", str, errbuf);
+		goto cleanup;
 	}
 
-	return 0;
+cleanup:
+	regfree(&r);
+	return ret;
 usage:
 	usage("\ttest-tool regex --bug\n"
 	      "\ttest-tool regex [--silent] <pattern>\n"
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index ac7be547145..31c66b63c2c 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -2,6 +2,7 @@
 
 test_description='grep icase on non-English locales'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 doalarm () {
-- 
2.37.0.874.g7d3439f13c4

