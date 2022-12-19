Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17493C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 22:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiLSWtA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 17:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLSWs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 17:48:57 -0500
Received: from smtp73.ord1d.emailsrvr.com (smtp73.ord1d.emailsrvr.com [184.106.54.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273152719
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 14:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
        s=20180920-g2b7aziw; t=1671490134;
        bh=ax9b+nYMzpaqs8NKCu9mvYwmC+1H7qjdTqEtgDY4nrs=;
        h=From:To:Subject:Date:From;
        b=MO7gpeqQAGbn/xv9BgKbsURuTYHwh6iGREwdGRy/ee9W7Ns6GIpptucJYx82y3WcF
         v8/RcoXnnywPZ6Hfo3pmM+EEw2S97ncMlpZyxQRIH5yBkplM2xyIYE82h98jvF1BK6
         cv1fAUIgaQGlYZhhRu6geqKMkGapL2YdSvIvVki8=
X-Auth-ID: lars@oddbit.com
Received: by smtp2.relay.ord1d.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id A5D2C200A6;
        Mon, 19 Dec 2022 17:48:54 -0500 (EST)
From:   Lars Kellogg-Stedman <lars@oddbit.com>
To:     git@vger.kernel.org
Cc:     Lars Kellogg-Stedman <lars@oddbit.com>
Subject: [PATCH v4] line-range: fix infinite loop bug with '$' regex
Date:   Mon, 19 Dec 2022 17:48:50 -0500
Message-Id: <20221219224850.2703967-1-lars@oddbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221205193625.2424202-1-lars@oddbit.com>
References: <20221205193625.2424202-1-lars@oddbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: b758d8b4-3e12-42e1-9105-167a531a76bb-1-1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the -L argument to "git log" is passed the zero-width regular
expression "$" (as in "-L :$:line-range.c"), this results in an
infinite loop in find_funcname_matching_regexp().

Modify find_funcname_matching_regexp to correctly match the entire line
instead of the zero-width match at eol and update the loop condition to
prevent an infinite loop in the event of other undiscovered corner cases.

The primary change is that we pre-decrement the beginning-of-line marker
('bol') before comparing it to '\n'. In the case of '$', where we match the
'\n' at the end of the line and start the loop with bol == eol, this
ensures that bol will find the beginning of the line on which the match
occurred.

Originally reported in <https://stackoverflow.com/q/74690545/147356>.

Signed-off-by: Lars Kellogg-Stedman <lars@oddbit.com>
---
 line-range.c        |  7 ++++---
 t/t4211-line-log.sh | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/line-range.c b/line-range.c
index 955a8a9535..47bf0d6f1a 100644
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
@@ -148,8 +148,8 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
 		/* determine extent of line matched */
 		bol = start+match[0].rm_so;
 		eol = start+match[0].rm_eo;
-		while (bol > start && *bol != '\n')
-			bol--;
+		while (bol > start && *--bol != '\n')
+			; /* nothing */
 		if (*bol == '\n')
 			bol++;
 		while (*eol && *eol != '\n')
@@ -161,6 +161,7 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
 			return bol;
 		start = eol;
 	}
+	return NULL;
 }
 
 static const char *parse_range_funcname(
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index ac9e4d0928..c6540e822f 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -315,4 +315,26 @@ test_expect_success 'line-log with --before' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup tests for zero-width regular expressions' '
+	cat >expect <<-EOF
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
+test_expect_success 'zero-width regex .* matches any function name' '
+	git log --format="%s" --no-patch "-L:.*:file.c" >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.38.1

