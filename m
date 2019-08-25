Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40F81F461
	for <e@80x24.org>; Sun, 25 Aug 2019 08:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfHYIIX (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 04:08:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:54814 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725792AbfHYIIX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 04:08:23 -0400
Received: (qmail 11785 invoked by uid 109); 25 Aug 2019 08:08:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 25 Aug 2019 08:08:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10122 invoked by uid 111); 25 Aug 2019 08:09:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 25 Aug 2019 04:09:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 25 Aug 2019 04:08:21 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: [PATCH 1/2] fast-import: duplicate parsed encoding string
Message-ID: <20190825080821.GA31824@sigill.intra.peff.net>
References: <20190825080640.GA31453@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190825080640.GA31453@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We read each line of the fast-import stream into the command_buf strbuf.
When reading a commit, we parse a line like "encoding foo" by storing a
pointer to "foo", but not making a copy. We may then read an unbounded
number of other lines (e.g., one for each modified file in the commit),
each of which writes into command_buf.

This works out in practice for small cases, because we hand off
ownership of the heap buffer from command_buf to the cmd_hist array, and
read new commands into a fresh heap buffer. And thus the pointer to
"foo" remains valid as long as there aren't so many intermediate lines
that we end up dropping the original "encoding" line from the history.

But as the test modification shows, if we go over our default of 100
lines, we end up with our encoding string pointing into freed heap
memory. This seems to fail reliably by writing garbage into the output,
but running under ASan definitely detects this as a user-after-free.

We can fix it by duplicating the encoding value, just as we do for other
parsed lines (e.g., an author line ends up in parse_ident, which copies
it to a new string).

Signed-off-by: Jeff King <peff@peff.net>
---
 fast-import.c          | 7 +++++--
 t/t9300-fast-import.sh | 5 +++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index b44d6a467e..ee7258037a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2588,7 +2588,7 @@ static void parse_new_commit(const char *arg)
 	struct branch *b;
 	char *author = NULL;
 	char *committer = NULL;
-	const char *encoding = NULL;
+	char *encoding = NULL;
 	struct hash_list *merge_list = NULL;
 	unsigned int merge_count;
 	unsigned char prev_fanout, new_fanout;
@@ -2611,8 +2611,10 @@ static void parse_new_commit(const char *arg)
 	}
 	if (!committer)
 		die("Expected committer but didn't get one");
-	if (skip_prefix(command_buf.buf, "encoding ", &encoding))
+	if (skip_prefix(command_buf.buf, "encoding ", &v)) {
+		encoding = xstrdup(v);
 		read_next_command();
+	}
 	parse_data(&msg, 0, NULL);
 	read_next_command();
 	parse_from(b);
@@ -2686,6 +2688,7 @@ static void parse_new_commit(const char *arg)
 	strbuf_addbuf(&new_data, &msg);
 	free(author);
 	free(committer);
+	free(encoding);
 
 	if (!store_object(OBJ_COMMIT, &new_data, NULL, &b->oid, next_mark))
 		b->pack_id = pack_id;
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 141b7fa35e..cf66b40ebc 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3314,6 +3314,11 @@ test_expect_success 'X: handling encoding' '
 
 	printf "Pi: \360\nCOMMIT\n" >>input &&
 
+	for i in $(test_seq 100)
+	do
+		echo "M 644 $EMPTY_BLOB file-$i"
+	done >>input &&
+
 	git fast-import <input &&
 	git cat-file -p encoding | grep $(printf "\360") &&
 	git log -1 --format=%B encoding | grep $(printf "\317\200")
-- 
2.23.0.478.g23872bed7d

