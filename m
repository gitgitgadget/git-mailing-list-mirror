Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6BBC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 16:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 580F623B98
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 16:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729749AbgLIQfi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 11:35:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:55678 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgLIQfi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 11:35:38 -0500
Received: (qmail 18437 invoked by uid 109); 9 Dec 2020 16:34:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Dec 2020 16:34:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16669 invoked by uid 111); 9 Dec 2020 16:34:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Dec 2020 11:34:57 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Dec 2020 11:34:57 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 3/3] config: store "git -c" variables using more robust
 format
Message-ID: <X9D8sTX3envTCi75@coredump.intra.peff.net>
References: <X9D23LQv34A5Q5DC@coredump.intra.peff.net>
 <X9D5SnXca2rGnJFl@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X9D5SnXca2rGnJFl@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 09, 2020 at 11:20:26AM -0500, Jeff King wrote:

> One other side effect I just noticed is that we're very aggressive about
> trimming leading and trailing whitespace in the old-style format, but
> the new one will store values verbatim. IMHO that's better overall, but
> we might consider a preparatory patch to remove that trimming
> explicitly.

Actually, it looks like we just trim either side of the key. Which
is...weird. We've never generated any, and I wouldn't expect people to
write:

  git -c '  some.key = value'

And even if they did, then "value" would have extra whitespace. So I
don't think this is really changing anything important, though I'm still
tempted to do something like the patch below to clean up the reading
side (and as a bonus, it gets rid of a strbuf_split call, which is a
terrible and awkward interface).

diff --git a/config.c b/config.c
index 04029e45dc..ede33cf3d0 100644
--- a/config.c
+++ b/config.c
@@ -516,29 +516,21 @@ static int config_parse_pair(const char *key, const char *value,
 int git_config_parse_parameter(const char *text,
 			       config_fn_t fn, void *data)
 {
-	const char *value;
-	struct strbuf **pair;
+	char *to_free = NULL;
+	const char *key, *value;
 	int ret;
 
-	pair = strbuf_split_str(text, '=', 2);
-	if (!pair[0])
-		return error(_("bogus config parameter: %s"), text);
-
-	if (pair[0]->len && pair[0]->buf[pair[0]->len - 1] == '=') {
-		strbuf_setlen(pair[0], pair[0]->len - 1);
-		value = pair[1] ? pair[1]->buf : "";
+	value = strchr(text, '=');
+	if (value) {
+		key = to_free = xmemdupz(text, value - text);
+		value++;
 	} else {
-		value = NULL;
+		key = text;
 	}
 
-	strbuf_trim(pair[0]);
-	if (!pair[0]->len) {
-		strbuf_list_free(pair);
-		return error(_("bogus config parameter: %s"), text);
-	}
+	ret = config_parse_pair(key, value, fn, data);
 
-	ret = config_parse_pair(pair[0]->buf, value, fn, data);
-	strbuf_list_free(pair);
+	free(to_free);
 	return ret;
 }
 
