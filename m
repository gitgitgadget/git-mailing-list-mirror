Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DB851F954
	for <e@80x24.org>; Thu, 23 Aug 2018 00:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeHWEYk (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 00:24:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:52596 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726261AbeHWEYk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 00:24:40 -0400
Received: (qmail 12209 invoked by uid 109); 23 Aug 2018 00:50:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Aug 2018 00:50:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6332 invoked by uid 111); 23 Aug 2018 00:50:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 20:50:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 20:50:51 -0400
Date:   Wed, 22 Aug 2018 20:50:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: [PATCH 8/9] append_signoff: use size_t for string offsets
Message-ID: <20180823005051.GH3126@sigill.intra.peff.net>
References: <20180823004300.GA1355@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180823004300.GA1355@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The append_signoff() function takes an "int" to specify the
number of bytes to ignore. Most callers just pass 0, and the
remainder use ignore_non_trailer() to skip over cruft.
That function also returns an int, and uses them internally.

On systems where size_t is larger than an int (i.e., most
64-bit systems), dealing with a ridiculously large commit
message could end up overflowing an int, producing
surprising results (e.g., returning a negative offset, which
would cause us to look outside the original string).

Let's consistently use size_t for these offsets through this
whole stack. As a bonus, this makes the meaning of
"ignore_footer" as an offset (and not a boolean) more clear.
But while we're here, let's also document the interface.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c    | 6 +++---
 commit.h    | 2 +-
 sequencer.c | 4 ++--
 sequencer.h | 9 ++++++++-
 4 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/commit.c b/commit.c
index 30d1af2b20..9fb67d785d 100644
--- a/commit.c
+++ b/commit.c
@@ -1784,10 +1784,10 @@ const char *find_commit_header(const char *msg, const char *key, size_t *out_len
  * Returns the number of bytes from the tail to ignore, to be fed as
  * the second parameter to append_signoff().
  */
-int ignore_non_trailer(const char *buf, size_t len)
+size_t ignore_non_trailer(const char *buf, size_t len)
 {
-	int boc = 0;
-	int bol = 0;
+	size_t boc = 0;
+	size_t bol = 0;
 	int in_old_conflicts_block = 0;
 	size_t cutoff = wt_status_locate_end(buf, len);
 
diff --git a/commit.h b/commit.h
index da0db36eba..43f93b973d 100644
--- a/commit.h
+++ b/commit.h
@@ -322,7 +322,7 @@ extern const char *find_commit_header(const char *msg, const char *key,
 				      size_t *out_len);
 
 /* Find the end of the log message, the right place for a new trailer. */
-extern int ignore_non_trailer(const char *buf, size_t len);
+extern size_t ignore_non_trailer(const char *buf, size_t len);
 
 typedef int (*each_mergetag_fn)(struct commit *commit, struct commit_extra_header *extra,
 				 void *cb_data);
diff --git a/sequencer.c b/sequencer.c
index 25bdbfcce1..c01ff79ab0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -225,7 +225,7 @@ static const char *get_todo_path(const struct replay_opts *opts)
  * Returns 3 when sob exists within conforming footer as last entry
  */
 static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
-	int ignore_footer)
+	size_t ignore_footer)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
 	struct trailer_info info;
@@ -3802,7 +3802,7 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	return res;
 }
 
-void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
+void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
 {
 	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
 	struct strbuf sob = STRBUF_INIT;
diff --git a/sequencer.h b/sequencer.h
index c751c9d6e4..c986bc8251 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -90,7 +90,14 @@ int rearrange_squash(void);
 
 extern const char sign_off_header[];
 
-void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
+/*
+ * Append a signoff to the commit message in "msgbuf". The ignore_footer
+ * parameter specifies the number of bytes at the end of msgbuf that should
+ * not be considered at all. I.e., they are not checked for existing trailers,
+ * and the new signoff will be spliced into the buffer before those bytes.
+ */
+void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
+
 void append_conflicts_hint(struct strbuf *msgbuf);
 int message_is_empty(const struct strbuf *sb,
 		     enum commit_msg_cleanup_mode cleanup_mode);
-- 
2.19.0.rc0.412.g7005db4e88

