Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3414C05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 18:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjBNSjq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 13:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjBNSjn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 13:39:43 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB50E2DE65
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 10:39:42 -0800 (PST)
Received: (qmail 619 invoked by uid 109); 14 Feb 2023 18:39:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Feb 2023 18:39:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3686 invoked by uid 111); 14 Feb 2023 18:39:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Feb 2023 13:39:41 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Feb 2023 13:39:41 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH 1/3] shorten_unambiguous_ref(): avoid integer truncation
Message-ID: <Y+vVbdS79fZHRs6H@coredump.intra.peff.net>
References: <Y+vVFFCRem6t4IGM@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+vVFFCRem6t4IGM@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We parse the shortened name "foo" out of the full refname
"refs/heads/foo", and then assign the result of strlen(short_name) to an
int, which may truncate or wrap to negative.

In practice, this should never happen, as it requires a 2GB refname. And
even somebody trying to do something malicious should at worst end up
with a confused answer (we use the size only to feed back as a
placeholder length to strbuf_addf() to see if there are any collisions
in the lookup rules).

And it may even be impossible to trigger this, as we parse the string
with sscanf(), and stdio formatting functions are not known for handling
large strings well. I didn't test, but I wouldn't be surprised if
sscanf() on many platforms simply reports no match here.

But even if it is not a problem in practice so far, it is worth fixing
for two reasons:

  1. We'll shortly be replacing the sscanf() call with a real parser
     which will handle arbitrary-sized strings.

  2. Assigning strlen() to an int is an anti-pattern that requires
     people to look twice when auditing for real overflow problems.

So we'll make this a size_t. Unfortunately we still have to cast to int
eventually for the strbuf_addf() call, but at least we can localize the
cast there, and check that it will be valid. I used our new cast helper
here, which will just bail completely. That should be OK, as anybody
with a 2GB refname is up to no good, but if we really wanted to, we
could detect it manually and just refuse to shorten the refname.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index e31dbcda59..94d938390d 100644
--- a/refs.c
+++ b/refs.c
@@ -1356,7 +1356,7 @@ char *refs_shorten_unambiguous_ref(struct ref_store *refs,
 	for (i = nr_rules - 1; i > 0 ; --i) {
 		int j;
 		int rules_to_fail = i;
-		int short_name_len;
+		size_t short_name_len;
 
 		if (1 != sscanf(refname, scanf_fmts[i], short_name))
 			continue;
@@ -1388,7 +1388,8 @@ char *refs_shorten_unambiguous_ref(struct ref_store *refs,
 			 */
 			strbuf_reset(&resolved_buf);
 			strbuf_addf(&resolved_buf, rule,
-				    short_name_len, short_name);
+				    cast_size_t_to_int(short_name_len),
+				    short_name);
 			if (refs_ref_exists(refs, resolved_buf.buf))
 				break;
 		}
-- 
2.39.1.849.g86e176252e

