Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE0AC46467
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 17:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbjAPRr6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 12:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbjAPRrj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 12:47:39 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E977B1CF5B
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 09:27:24 -0800 (PST)
Received: (qmail 15466 invoked by uid 109); 16 Jan 2023 17:27:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Jan 2023 17:27:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31755 invoked by uid 111); 16 Jan 2023 17:27:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Jan 2023 12:27:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Jan 2023 12:27:23 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 3/3] http: support CURLOPT_PROTOCOLS_STR
Message-ID: <Y8WI+/A7a3BvUIWJ@coredump.intra.peff.net>
References: <Y8RddcM9Vr71ljp4@coredump.intra.peff.net>
 <Y8ReHbGWetJHQcI1@coredump.intra.peff.net>
 <230116.86edruzk5m.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <230116.86edruzk5m.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2023 at 02:06:50PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > -static long get_curl_allowed_protocols(int from_user)
> > +static void proto_list_append(struct strbuf *list_str, const char *proto_str,
> > +			      long *list_bits, long proto_bits)
> > +{
> > +	*list_bits |= proto_bits;
> > +	if (list_str) {
> > +		if (list_str->len)
> > +			strbuf_addch(list_str, ',');
> > +		strbuf_addstr(list_str, proto_str);
> > +	}
> > +}
> 
> Nit: It would be nice (especially in this even smaller function) to
> carry forward the name the parent get_curl_allowed_protocols() uses,
> i.e. just "list", not "list_str", ditto "proto" rather than "proto_str".

I think it gets confusing in this function, then, because you have both
types. If anything, the sin is in the caller which uses "list" and
"allowed_protocols". I had originally written that as "list" and "bits",
but I left "bits" as "allowed_protocols" to reduce the size of the diff.
Maybe that was a bad choice.

Likewise, the caller could just do the bitwise-OR inline, like:

  if (is_transported_allowed("http", from_user)) {
	bits |= CURLPROTO_HTTP;
	proto_list_append(list, "http");
  }

but that makes the diff bigger (the whole function body is replaced,
because the "if" lines, which now have a "{", are no longer unchanged
context). But again, maybe optimizing for a small diff is a bad idea if
the resulting code is harder to follow (I didn't think it was, but then
I also wrote it).

-Peff
