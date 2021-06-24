Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E9AC49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 17:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4A4613DC
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 17:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFXRNs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 13:13:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:59682 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhFXRNr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 13:13:47 -0400
Received: (qmail 12490 invoked by uid 109); 24 Jun 2021 17:11:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jun 2021 17:11:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14304 invoked by uid 111); 24 Jun 2021 17:11:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Jun 2021 13:11:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Jun 2021 13:11:27 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v2 3/3] bundle: remove "ref_list" in favor of
 string-list.c API
Message-ID: <YNS8vzPc1KyRaSR5@coredump.intra.peff.net>
References: <cover-0.3-0000000000-20210617T111934Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
 <patch-3.3-9d9cb5aaf9e-20210621T151357Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-3.3-9d9cb5aaf9e-20210621T151357Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 05:16:14PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Move away from the "struct ref_list" in bundle.c in favor of the
> almost identical string-list.c API.
> 
> That API fits this use-case perfectly, but did not exist in its
> current form when this code was added in 2e0afafebd (Add git-bundle:
> move objects and references by archive, 2007-02-22), with hindsight we
> could have used the path-list API, which later got renamed to
> string-list. See 8fd2cb4069 (Extract helper bits from
> c-merge-recursive work, 2006-07-25)

I think this is a good direction, and I didn't see any errors in the
code. It's slightly sad that we end up with more lines than we started
with, but I think that's mostly because you're actually freeing the
memory now.

Two small nitpicks:

> @@ -103,19 +94,22 @@ static int parse_bundle_header(int fd, struct bundle_header *header,
>  		 * Prerequisites have object name that is optionally
>  		 * followed by SP and subject line.
>  		 */
> -		if (parse_oid_hex_algop(buf.buf, &oid, &p, header->hash_algo) ||
> +		oid = xmalloc(sizeof(struct object_id));
> +		if (parse_oid_hex_algop(buf.buf, oid, &p, header->hash_algo) ||
>  		    (*p && !isspace(*p)) ||
>  		    (!is_prereq && !*p)) {
>  			if (report_path)
>  				error(_("unrecognized header: %s%s (%d)"),
>  				      (is_prereq ? "-" : ""), buf.buf, (int)buf.len);
>  			status = -1;
> +			free(oid);
>  			break;
>  		} else {

This would be slightly simpler if you kept a local "struct object_id",
and then called:

  string_list_append(list, string)->util = oiddup(&oid);

later when you know you want to save it. And then you don't have to
worry about the extra cleanup here. That does require an extra oidcpy()
under the hood, but I suspect that is lost in the noise.

I'm OK with it either way.

> -			if (is_prereq)
> -				add_to_ref_list(&oid, "", &header->prerequisites);
> -			else
> -				add_to_ref_list(&oid, p + 1, &header->references);
> +			const char *string = is_prereq ? "" : p + 1;
> +			struct string_list *list = is_prereq
> +				? &header->prerequisites
> +				: &header->references;
> +			string_list_append(list, string)->util = oid;

I'm usually a big fan of the ternary operator, and using variable
indirection to make it clear that we always call a function.  But here I
think it makes things more confusing.  The two sides of the if/else are
sufficiently simple that it's easy to see they both make the same
function call. And because there are two variables, we check is_prereq
twice, making it much harder to see the two cases.

I.e., I think:

  if (is_prereq)
          string_list_append(&header->prerequisites, "")->util = oid;
  else
          string_list_append(&header->references, p + 1)->util = oid;

is much more obvious.

-Peff
