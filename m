Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC1141F803
	for <e@80x24.org>; Mon,  7 Jan 2019 08:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfAGI1E (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 03:27:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:56286 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726482AbfAGI1E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 03:27:04 -0500
Received: (qmail 497 invoked by uid 109); 7 Jan 2019 08:27:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Jan 2019 08:27:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 624 invoked by uid 111); 7 Jan 2019 08:26:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 Jan 2019 03:26:42 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jan 2019 03:27:02 -0500
Date:   Mon, 7 Jan 2019 03:27:02 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/3] object-store: factor out odb_loose_cache()
Message-ID: <20190107082702.GB21362@sigill.intra.peff.net>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
 <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
 <b87e7e01-baa6-6fb2-7081-0042ecd3b6b7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b87e7e01-baa6-6fb2-7081-0042ecd3b6b7@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 06, 2019 at 05:45:30PM +0100, René Scharfe wrote:

> Add and use a function for loading the entries if a loose object
> subdirectory for a given object ID.  It frees callers from deriving the
> fanout key; they can use the returned oid_array reference for lookups or
> forward range scans.

Much nicer.

> diff --git a/object-store.h b/object-store.h
> index 60758efad8..7236c571c0 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -54,6 +54,13 @@ void add_to_alternates_memory(const char *dir);
>   */
>  void odb_load_loose_cache(struct object_directory *odb, int subdir_nr);
>  
> +/*
> + * Populate and return the loose object cache array corresponding to the
> + * given object ID.
> + */
> +struct oid_array *odb_loose_cache(struct object_directory *odb,
> +				  const struct object_id *oid);
> +

I think the ugly-interfaced odb_load_loose_cache() can become "static"
now, as the only outside caller (from sha1-name.c) has gone away.

> +struct oid_array *odb_loose_cache(struct object_directory *odb,
> +				  const struct object_id *oid)
> +{
> +	int subdir_nr = oid->hash[0];
> +	odb_load_loose_cache(odb, subdir_nr);
> +	return &odb->loose_objects_cache;
> +}
> +
>  void odb_load_loose_cache(struct object_directory *odb, int subdir_nr)

You'd need to re-order these definitions, of course (or alternatively,
just fold the load function inline into odb_loose_cache()).

-Peff
