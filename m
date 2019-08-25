Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 391871F461
	for <e@80x24.org>; Sun, 25 Aug 2019 06:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfHYG5u (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 02:57:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:54732 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725775AbfHYG5t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 02:57:49 -0400
Received: (qmail 8944 invoked by uid 109); 25 Aug 2019 06:57:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 25 Aug 2019 06:57:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9859 invoked by uid 111); 25 Aug 2019 06:59:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 25 Aug 2019 02:59:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 25 Aug 2019 02:57:48 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] fast-import: Reinitialize command_buf rather than detach
 it.
Message-ID: <20190825065747.GA23806@sigill.intra.peff.net>
References: <20190825041348.31835-1-mh@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190825041348.31835-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 01:13:48PM +0900, Mike Hommey wrote:

> command_buf.buf is also stored in cmd_hist, so instead of
> strbuf_release, the current code uses strbuf_detach in order to
> "leak" the buffer as far as the strbuf is concerned.
> 
> However, strbuf_detach does more than "leak" the strbuf buffer: it
> possibly reallocates it to ensure a terminating nul character. And when
> that happens, what is already stored in cmd_hist may now be a free()d
> buffer.
> 
> In practice, though, command_buf.buf is most of the time a nul
> terminated string, meaning command_buf.len < command_buf.alloc, and
> strbuf_detach is a no-op. BUT, when it's not (e.g. on the first call),
> command_buf.buf is &strbuf_slopbuf. In that case, strbuf_detach does
> allocate a 1 byte buffer to store a nul character in it, which is then
> leaked.

I think this is stronger than just "most of the time". It's an invariant
for strbufs to have a NUL, so the only case where detaching isn't a noop
is the empty slopbuf case you mention.

Splitting hairs, perhaps, but I think with that explanation, we could
probably argue that this case will never come up: strbuf_getline will
either have allocated a buffer or will have returned EOF.

That said, I do think it's quite confusing and is worth fixing, both for
readability and for future-proofing. But...

> diff --git a/fast-import.c b/fast-import.c
> index b44d6a467e..b1d07efe8c 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1763,7 +1763,9 @@ static int read_next_command(void)
>  		} else {
>  			struct recent_command *rc;
>  
> -			strbuf_detach(&command_buf, NULL);
> +			// command_buf is enther empty or also stored in cmd_hist,
> +			// reinitialize it.
> +			strbuf_init(&command_buf, 0);

This whole thing is a sign that the code is Doing It Wrong. Whoever is
taking ownership of the buffer should be calling strbuf_detach() at that
point.

It's a bit tricky, though, because we take ownership and then expect
people still look at command_buf.buf. Which makes me concerned that
there are other operations which might modify the buffer and have the
same issue.

I think it would be much easier to follow if we simply used the same
command_buf over and over, and just copied into the history. The cost is
about the same (we still alloc once per line, though we do an extra
memcpy now). So I thought something like this would work (we don't need
to convert those detaches into a strbuf_reset() calls because
strbuf_getline does so automatically):

diff --git a/fast-import.c b/fast-import.c
index b44d6a467e..31207acd61 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1763,7 +1763,6 @@ static int read_next_command(void)
 		} else {
 			struct recent_command *rc;
 
-			strbuf_detach(&command_buf, NULL);
 			stdin_eof = strbuf_getline_lf(&command_buf, stdin);
 			if (stdin_eof)
 				return EOF;
@@ -1784,7 +1783,7 @@ static int read_next_command(void)
 				free(rc->buf);
 			}
 
-			rc->buf = command_buf.buf;
+			rc->buf = xstrdup(command_buf.buf);
 			rc->prev = cmd_tail;
 			rc->next = cmd_hist.prev;
 			rc->prev->next = rc;
@@ -1833,7 +1832,6 @@ static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 		char *term = xstrdup(data);
 		size_t term_len = command_buf.len - (data - command_buf.buf);
 
-		strbuf_detach(&command_buf, NULL);
 		for (;;) {
 			if (strbuf_getline_lf(&command_buf, stdin) == EOF)
 				die("EOF in data (terminator '%s' not found)", term);

But it doesn't! It turns out that there are other places in the code
which assume they can call read_next_command() while hanging onto the
existing buffer. Which only works in the old code because the history
feature happens to hold on to the old pointer.

If I do this on top, then all tests pass:

diff --git a/fast-import.c b/fast-import.c
index 31207acd61..1f9160b645 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2586,7 +2586,7 @@ static void parse_new_commit(const char *arg)
 	struct branch *b;
 	char *author = NULL;
 	char *committer = NULL;
-	const char *encoding = NULL;
+	char *encoding = NULL;
 	struct hash_list *merge_list = NULL;
 	unsigned int merge_count;
 	unsigned char prev_fanout, new_fanout;
@@ -2609,8 +2609,10 @@ static void parse_new_commit(const char *arg)
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
@@ -2684,6 +2686,7 @@ static void parse_new_commit(const char *arg)
 	strbuf_addbuf(&new_data, &msg);
 	free(author);
 	free(committer);
+	free(encoding);
 
 	if (!store_object(OBJ_COMMIT, &new_data, NULL, &b->oid, next_mark))
 		b->pack_id = pack_id;

And I think this is actually a real bug in the current code! We keep a
pointer to the encoding string, which survives because of the history.
But that history is bounded, and we could have an indefinite number of
changed files in the middle. If I modify t9300 like this:

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 141b7fa35e..d4bbe630d5 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3314,6 +3314,11 @@ test_expect_success 'X: handling encoding' '
 
 	printf "Pi: \360\nCOMMIT\n" >>input &&
 
+	for i in $(test_seq 200)
+	do
+		echo "M 644 $EMPTY_BLOB file-$i"
+	done >>input &&
+
 	git fast-import <input &&
 	git cat-file -p encoding | grep $(printf "\360") &&
 	git log -1 --format=%B encoding | grep $(printf "\317\200")

and run the test suite (using an unmodified git, without the earlier
patches I showed) then the test fails, putting garbage into the encoding
header (and when compiled with ASan, reports a use-after-free).

So I think the way the string handling is currently done papers over
such problems. You only see the problem if you have a hundred or more
modified files, so it works _most_ of the time.

That implies to me it's worth following a fix like the one I showed
above. I am slightly concerned there are other similar cases to the
"encoding" one lurking (and they _might_ not be bugs already, if there's
a fixed number of reads between the pointer being saved and being used),
but it seems worth the risk.

-Peff
