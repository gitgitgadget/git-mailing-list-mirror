Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1225C4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 19:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbiLETpI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 14:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbiLETop (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 14:44:45 -0500
X-Greylist: delayed 319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Dec 2022 11:41:48 PST
Received: from smtp127.iad3a.emailsrvr.com (smtp127.iad3a.emailsrvr.com [173.203.187.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B41B2CC80
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 11:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
        s=20180920-g2b7aziw; t=1670268988;
        bh=i9uFfpZDHwe9ZT4ygZyyVJGdOC2jS7SMiavLbEK7uxc=;
        h=From:To:Subject:Date:From;
        b=cNk5BcIvI7X2E86NVYB1c7bwUGVKdTbY2ek/bs5OvE+2jdA4sRnZQmCSwXoQTGPGA
         MRNFIe9JFqgDmX+dPWhmNh5M9dM1BOjTycVIZWmnJ6hi8XXU5ARzWXaH1ezal6A1Nk
         bPoeYbajSp9nThK59vTBDyKJuzSclUgvuwqIfa9Q=
X-Auth-ID: lars@oddbit.com
Received: by smtp16.relay.iad3a.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id A77B9596A;
        Mon,  5 Dec 2022 14:36:28 -0500 (EST)
From:   Lars Kellogg-Stedman <lars@oddbit.com>
To:     git@vger.kernel.org
Cc:     Lars Kellogg-Stedman <lars@oddbit.com>
Subject: [PATCH v2] line-range: Fix infinite loop bug with degenerate regex
Date:   Mon,  5 Dec 2022 14:36:25 -0500
Message-Id: <20221205193625.2424202-1-lars@oddbit.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 52272067-2e9d-4e68-8a3e-9b80aca7229e-1-1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the -L argument to "git log" is passed the degenerate regular
expression "$" (as in "-L :$:line-range.c"), this results in an
infinite loop in find_funcname_matching_regexp() (the function
iterates through the file correctly, but when it reaches the end of
the file it matches $ against the empty string, "", and at that points
loops forever).

Modify the loop condition from while (1) to while (*start) so that the
loop exits when start is the empty string. In this case, "git log" exits
with the error:

    fatal: -L parameter '$' starting at line 1: no match

Originally reported in <https://stackoverflow.com/q/74690545/147356>.

Signed-off-by: Lars Kellogg-Stedman <lars@oddbit.com>
---
 line-range.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/line-range.c b/line-range.c
index 955a8a9535..bdcb810485 100644
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
@@ -161,6 +161,8 @@ static const char *find_funcname_matching_regexp(xdemitconf_t *xecfg, const char
 			return bol;
 		start = eol;
 	}
+
+    return NULL;
 }
 
 static const char *parse_range_funcname(
-- 
2.38.1

