Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF3DC4332F
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 19:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbiLETf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 14:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbiLETff (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 14:35:35 -0500
X-Greylist: delayed 475 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 05 Dec 2022 11:31:47 PST
Received: from smtp82.ord1d.emailsrvr.com (smtp82.ord1d.emailsrvr.com [184.106.54.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B3D24BF4
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 11:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
        s=20180920-g2b7aziw; t=1670268232;
        bh=pT8ZoOrAedRtFHOBW44voalrUceEJHcdx3Xm2Yyyc+c=;
        h=From:To:Subject:Date:From;
        b=ns6jOId+t5YaAnFaswnKQ/dB7QgjPkUB9qLva+o7ww0x1uSokLDT7ak7H773hBPCY
         uOhsgopHLfBHHv5PLe/LD+BjD5FT33EwH/vHk8okPMgKUX9MNbjbqMwBDHqsuuOFf4
         yGfKEp/WqdJ6g6lN2FHl4aCaJOT9EjJtuvOq9IA0=
X-Auth-ID: lars@oddbit.com
Received: by smtp3.relay.ord1d.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id 32DCE601AB;
        Mon,  5 Dec 2022 14:23:52 -0500 (EST)
From:   Lars Kellogg-Stedman <lars@oddbit.com>
To:     git@vger.kernel.org
Cc:     Lars Kellogg-Stedman <lars@oddbit.com>
Subject: [PATCH 1/1] line-range: Fix infinite loop bug with degenerate regex
Date:   Mon,  5 Dec 2022 14:23:38 -0500
Message-Id: <20221205192338.2413155-1-lars@oddbit.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: b0e48c3c-1184-4dc7-935c-ceaf3ab784cc-1-1
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
 line-range.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/line-range.c b/line-range.c
index 955a8a9535..9482d93d62 100644
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
-- 
2.38.1

