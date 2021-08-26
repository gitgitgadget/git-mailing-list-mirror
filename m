Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8739EC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 23:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A87B60FD8
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 23:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243789AbhHZXdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 19:33:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:60250 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231251AbhHZXdG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 19:33:06 -0400
Received: (qmail 4922 invoked by uid 109); 26 Aug 2021 23:32:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Aug 2021 23:32:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10212 invoked by uid 111); 26 Aug 2021 23:32:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Aug 2021 19:32:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Aug 2021 19:32:17 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     me@ttaylorr.com, git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Subject: Re: [PATCH 2/2] upload-pack: use stdio in send_ref callbacks
Message-ID: <YSgkgfCr6/kIGzWX@coredump.intra.peff.net>
References: <CADMWQoMpURczcnZne=0cr2vavoLm_VT5eEMg4FCu3VeSg_UJaQ@mail.gmail.com>
 <20210826100648.10333-1-jacob@gitlab.com>
 <20210826100648.10333-2-jacob@gitlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210826100648.10333-2-jacob@gitlab.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 26, 2021 at 12:06:48PM +0200, Jacob Vosmaer wrote:

> @@ -126,6 +127,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
>  	struct string_list uri_protocols = STRING_LIST_INIT_DUP;
>  	struct object_array extra_edge_obj = OBJECT_ARRAY_INIT;
>  	struct string_list allowed_filters = STRING_LIST_INIT_DUP;
> +	struct strbuf send_ref_buf = STRBUF_INIT;
>  
>  	memset(data, 0, sizeof(*data));
>  	data->symref = symref;
> @@ -141,6 +143,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
>  	data->allow_filter_fallback = 1;
>  	data->tree_filter_max_depth = ULONG_MAX;
>  	packet_writer_init(&data->writer, 1);
> +	data->send_ref_buf = send_ref_buf;

This does a struct copy of the strbuf, which is usually a bad thing
(both copies think they own the pointer). It works here because the
original immediately goes out of scope. The usual thing would be to do
this instead:

  strbuf_init(&data->send_ref_buf, 0);

but I notice this whole function is somewhat odd that way (lots of
static initializers followed by struct assignment, rather than using
initialization functions).

I'm not sure if it's worth changing or not. Again, I don't think it's
doing the wrong thing, but just sort of unusual for our code base. A few
of the data structures in use here don't have _init() functions
(object_array and oid_array), but that probably means we ought to add
them.

-Peff
