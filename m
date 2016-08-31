Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C84861F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933301AbcHaIzr (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:55:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:60751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933533AbcHaIzm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:55:42 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M7CRe-1aqtCO3swA-00wzCi; Wed, 31 Aug 2016 10:55:39
 +0200
Date:   Wed, 31 Aug 2016 10:55:37 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 18/34] sequencer (rebase -i): refactor setting the reflog
 message
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <375b045469a7c240033eb27d14553e28c81ea9a3.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:T/5v5gABVyEuM0Fh4xiAa9h0XYXxlgNX7Bt1XlcPpQxHtWW39Ir
 cHx+tGDEEYF2nlls2057t0b81BOP0mbvt/l8FC7EXRHoqgufwRi0Dpwcvyw8KFZY1zJSrJi
 Yimld9/mn8x7EHr7HmsiMamg7Ad+zLsMvYzG1ra6up1z9f8LDNUQ+ni+8K0hmbzV/Dyau8F
 c0QesRCY/zOnTUBvG5ZHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bmT8vqZuVg4=:6xA7FxaQsctecLyw9DDjHt
 bY+VS5HjwwnjIcFEFFYI/r/U3jUMiA/hOcbObVdn4oc7kIE3ujZ1asQtR6yJg2fv4kk/Xn1ge
 cYfdqPyA62HbhuqAEQG6UKFYsmEWc6txggzWYaR8GAbGB6qTBsXaagWcrUVcmXSIw2s8mXjkl
 el+ewZnO81jYK/5kqi1uPmx9myuMfU9Bm2tfUDwi2VVIE3EO5fCK9Ym8AmHchi213XCrBdsgp
 QaaKpqBm2RvlCtO3R/JtF7X4OeAPj+qa2Y9yklWk0KhpdGmMGTOuTaNDQjGZkxaDXyJE+Gtif
 dYnbXCmNXVJ8H25ycvz8T6uxPg0nZHPo+XtnWlZbwKlZN4/mYrXnP+HWlsdEfMwHWxXt2kQgG
 SaOj2WpONkc2J2NVydLerT8Z/yuUqhM4kQhDt23fedmEqZzOqv6cTyXWrYLUHCiXTT+sSf0vN
 ynvpFeWGkdGfTJtptE6Dg3XASemAkVoXm3gWfF4wRQsahiOmmXcxV0X+FJ9pBRO6W0DQhAYHE
 lqIg0WF4GF4+LSlAJ7qORJZXjhpZo5bRIVqZJV2JQky6+0Y29ar8/v9Ya8EvMjqmX2LJHk0Zw
 1pDhjPBJvFr/esxAibnsZcXygvzUV7C6md1Fk7boQWu/vMA1dA+MytFJPvz4D54qKhYw9Y+9w
 oO2Hy7v+WXEF4UPcgf3itHEZgs2zMbM7HtY9WM2ge1Pe5ECM8Csw5Da7wqPF/jV1m0mHsrwWg
 dAw+XW8+u8U5c5V6Df9eYvbt8bs4ktI1JuhIN4AKpHOH+PJ6UXSLMP+J/MFO1rN/k6rhyzNf4
 vbs+5nd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the code DRYer, with the obvious benefit that we can enhance
the code further in a single place.

We can also reuse the functionality elsewhere by calling this new
function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 399fc8d..71730e6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1726,6 +1726,26 @@ static int is_final_fixup(struct todo_list *todo_list)
 	return 1;
 }
 
+static const char *reflog_message(struct replay_opts *opts,
+	const char *sub_action, const char *fmt, ...)
+{
+	va_list ap;
+	static struct strbuf buf = STRBUF_INIT;
+
+	va_start(ap, fmt);
+	strbuf_reset(&buf);
+	strbuf_addstr(&buf, action_name(opts));
+	if (sub_action)
+		strbuf_addf(&buf, " (%s)", sub_action);
+	if (fmt) {
+		strbuf_addstr(&buf, ": ");
+		strbuf_vaddf(&buf, fmt, ap);
+	}
+	va_end(ap);
+
+	return buf.buf;
+}
+
 static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 {
 	int res = 0;
@@ -1796,6 +1816,7 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 
 		if (read_oneliner(&head_ref, rebase_path_head_name(), 0) &&
 				starts_with(head_ref.buf, "refs/")) {
+			const char *msg;
 			unsigned char head[20], orig[20];
 
 			if (get_sha1("HEAD", head))
@@ -1803,19 +1824,17 @@ static int pick_commits(struct todo_list *todo_list, struct replay_opts *opts)
 			if (!read_oneliner(&buf, rebase_path_orig_head(), 0) ||
 					get_sha1_hex(buf.buf, orig))
 				return error("Could not read orig-head");
-			strbuf_addf(&buf, "rebase -i (finish): %s onto ",
-				head_ref.buf);
 			if (!read_oneliner(&buf, rebase_path_onto(), 0))
 				return error("Could not read 'onto'");
-			if (update_ref(buf.buf, head_ref.buf, head, orig,
+			msg = reflog_message(opts, "finish", "%s onto %s",
+				head_ref.buf, buf.buf);
+			if (update_ref(msg, head_ref.buf, head, orig,
 					REF_NODEREF, UPDATE_REFS_MSG_ON_ERR))
 				return error("Could not update %s",
 					head_ref.buf);
-			strbuf_reset(&buf);
-			strbuf_addf(&buf,
-				"rebase -i (finish): returning to %s",
+			msg = reflog_message(opts, "finish", "returning to %s",
 				head_ref.buf);
-			if (create_symref("HEAD", head_ref.buf, buf.buf))
+			if (create_symref("HEAD", head_ref.buf, msg))
 				return error("Could not update HEAD to %s",
 					head_ref.buf);
 			strbuf_reset(&buf);
-- 
2.10.0.rc2.102.g5c102ec


