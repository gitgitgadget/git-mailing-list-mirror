Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CFFC4332F
	for <git@archiver.kernel.org>; Sun, 11 Dec 2022 01:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiLKBxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Dec 2022 20:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLKBxw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2022 20:53:52 -0500
Received: from smtp79.iad3b.emailsrvr.com (smtp79.iad3b.emailsrvr.com [146.20.161.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B57E11836
        for <git@vger.kernel.org>; Sat, 10 Dec 2022 17:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
        s=20180920-g2b7aziw; t=1670723629;
        bh=0FfH8TVoQliryrdsoZn7AWcGm1q3CzcBElRll9zASX8=;
        h=From:To:Subject:Date:From;
        b=L1VQOa5FDdCnx/XNW3nsX1rBy/kopPjsNF2UDOm/pVLllvxqv7trNtkl37R/hIYM9
         kIawCFNp8RHO01gWTXf5iugBlgSMc4VJOTPdK7mIbL4ywj2AuvhI8qQpaZxs/yNT8v
         KJiNULAJg185vrexjeC8MluSE/Nv+Rk8UhkgIm88=
X-Auth-ID: lars@oddbit.com
Received: by smtp10.relay.iad3b.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id 87D8DE006D;
        Sat, 10 Dec 2022 20:53:49 -0500 (EST)
From:   Lars Kellogg-Stedman <lars@oddbit.com>
To:     git@vger.kernel.org
Cc:     Lars Kellogg-Stedman <lars@oddbit.com>
Subject: [PATCH v3] line-range: Fix infinite loop bug with degenerate '$' regex
Date:   Sat, 10 Dec 2022 20:53:40 -0500
Message-Id: <20221211015340.2181837-1-lars@oddbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221205193625.2424202-1-lars@oddbit.com>
References: <20221205193625.2424202-1-lars@oddbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: a8918a6f-f8e6-4503-b73c-ec376923ce3f-1-1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the -L argument to "git log" is passed the degenerate regular
expression "$" (as in "-L :$:line-range.c"), this results in an
infinite loop in find_funcname_matching_regexp().

Modify find_funcname_matching_regexp to correctly match the entire line
instead of the zero-width match at eol and update the loop condition to
prevent an infinite loop in the event of other undiscovered corner cases.

Originally reported in <https://stackoverflow.com/q/74690545/147356>.

Signed-off-by: Lars Kellogg-Stedman <lars@oddbit.com>
---
This modifies my earlier patch so that instead of failing, the
regular expression '$' correctly matches any function name (and so
always returns the first function in the named file). This makes '$'
behave the same as '.' and '^'.

The primary change is that we pre-decrement the beginning-of-line
marker ('bol') before comparing it to '\n'. In the case of '$', where
we start with bol == eol, this ensures that bol will find the
beginning of the line on which the match occurred.

 line-range.c        |  6 +++---
 t/t4211-line-log.sh | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/line-range.c b/line-range.c
index 955a8a9535..b0e26e7f9d 100644
--- a/line-range.c
+++ b/line-range.c
@@ -135,7 +135,7 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
 {
 	int reg_error;
 	regmatch_t match[1];
-	while (1) {
+	while (*start) {
 		const char *bol, *eol;
 		reg_error = regexec(regexp, start, 1, match, 0);
 		if (reg_error == REG_NOMATCH)
@@ -148,8 +148,7 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
 		/* determine extent of line matched */
 		bol = start+match[0].rm_so;
 		eol = start+match[0].rm_eo;
-		while (bol > start && *bol != '\n')
-			bol--;
+		while (bol > start && *--bol != '\n');
 		if (*bol == '\n')
 			bol++;
 		while (*eol && *eol != '\n')
@@ -161,6 +160,7 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
 			return bol;
 		start = eol;
 	}
+	return NULL;
 }
 
 static const char *parse_range_funcname(
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index ac9e4d0928..19db07a8df 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -315,4 +315,26 @@ test_expect_success 'line-log with --before' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup tests for zero-width regular expressions' '
+	cat > expect <<-EOF
+	Modify func1() in file.c
+	Add func1() and func2() in file.c
+	EOF
+'
+
+test_expect_success 'zero-width regex $ matches any function name' '
+	git log --format="%s" --no-patch "-L:$:file.c" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'zero-width regex ^ matches any function name' '
+	git log --format="%s" --no-patch "-L:^:file.c" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'zero-width regex . matches any function name' '
+	git log --format="%s" --no-patch "-L:.:file.c" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.38.1

