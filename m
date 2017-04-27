Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D44D1FC3E
	for <e@80x24.org>; Thu, 27 Apr 2017 03:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbdD0D1U (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 23:27:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:40972 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751410AbdD0D1T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 23:27:19 -0400
Received: (qmail 13884 invoked by uid 109); 27 Apr 2017 03:27:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Apr 2017 03:27:19 +0000
Received: (qmail 716 invoked by uid 111); 27 Apr 2017 03:27:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Apr 2017 23:27:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Apr 2017 23:27:17 -0400
Date:   Wed, 26 Apr 2017 23:27:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] am: simplify allocations in get_commit_info()
Message-ID: <20170427032717.hzs3og4ql5vceqlf@sigill.intra.peff.net>
References: <20170427032503.rgz3bnctnxdn3hin@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170427032503.rgz3bnctnxdn3hin@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After we call split_ident_line(), we have several begin/end
pairs for various parts of the ident. We then copy each into
a strbuf to create a single string, and then detach that
string.  We can instead skip the strbuf entirely and just
duplicate the strings directly.

This is shorter, and it makes it more obvious that we are
not leaking the strbuf (we were not before, because every
code path either died or hit a strbuf_detach).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/am.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index baab951ed..e08f03326 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1380,40 +1380,35 @@ static int get_mail_commit_oid(struct object_id *commit_id, const char *mail)
  */
 static void get_commit_info(struct am_state *state, struct commit *commit)
 {
-	const char *buffer, *ident_line, *author_date, *msg;
+	const char *buffer, *ident_line, *msg;
 	size_t ident_len;
 	struct ident_split ident_split;
-	struct strbuf sb = STRBUF_INIT;
 
 	buffer = logmsg_reencode(commit, NULL, get_commit_output_encoding());
 
 	ident_line = find_commit_header(buffer, "author", &ident_len);
 
-	if (split_ident_line(&ident_split, ident_line, ident_len) < 0) {
-		strbuf_add(&sb, ident_line, ident_len);
-		die(_("invalid ident line: %s"), sb.buf);
-	}
+	if (split_ident_line(&ident_split, ident_line, ident_len) < 0)
+		die(_("invalid ident line: %.*s"), (int)ident_len, ident_line);
 
 	assert(!state->author_name);
 	if (ident_split.name_begin) {
-		strbuf_add(&sb, ident_split.name_begin,
-			ident_split.name_end - ident_split.name_begin);
-		state->author_name = strbuf_detach(&sb, NULL);
+		state->author_name =
+			xmemdupz(ident_split.name_begin,
+				 ident_split.name_end - ident_split.name_begin);
 	} else
 		state->author_name = xstrdup("");
 
 	assert(!state->author_email);
 	if (ident_split.mail_begin) {
-		strbuf_add(&sb, ident_split.mail_begin,
-			ident_split.mail_end - ident_split.mail_begin);
-		state->author_email = strbuf_detach(&sb, NULL);
+		state->author_email =
+			xmemdupz(ident_split.mail_begin,
+				 ident_split.mail_end - ident_split.mail_begin);
 	} else
 		state->author_email = xstrdup("");
 
-	author_date = show_ident_date(&ident_split, DATE_MODE(NORMAL));
-	strbuf_addstr(&sb, author_date);
 	assert(!state->author_date);
-	state->author_date = strbuf_detach(&sb, NULL);
+	state->author_date = xstrdup(show_ident_date(&ident_split, DATE_MODE(NORMAL)));
 
 	assert(!state->msg);
 	msg = strstr(buffer, "\n\n");
-- 
2.13.0.rc0.465.ga1e654229

