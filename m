Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29C0C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiKHOvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbiKHOvW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:51:22 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3843B13F6F
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:51:21 -0800 (PST)
Received: (qmail 7835 invoked by uid 109); 8 Nov 2022 14:51:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Nov 2022 14:51:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5021 invoked by uid 111); 8 Nov 2022 14:51:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Nov 2022 09:51:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Nov 2022 09:51:20 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 1/6] refs: get rid of global list of hidden refs
Message-ID: <Y2ps6Fpf52Ra68v3@coredump.intra.peff.net>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667901510.git.ps@pks.im>
 <34afe30d60e4dbc7e50a590541440c20c27507a6.1667901510.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34afe30d60e4dbc7e50a590541440c20c27507a6.1667901510.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 11:03:39AM +0100, Patrick Steinhardt wrote:

> -static struct string_list *hide_refs;
> -
> -int parse_hide_refs_config(const char *var, const char *value, const char *section)
> +int parse_hide_refs_config(const char *var, const char *value, const char *section,
> +			   struct string_list *hide_refs)
>  {
>  	const char *key;
>  	if (!strcmp("transfer.hiderefs", var) ||
> @@ -1431,21 +1430,16 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
>  		len = strlen(ref);
>  		while (len && ref[len - 1] == '/')
>  			ref[--len] = '\0';
> -		if (!hide_refs) {
> -			CALLOC_ARRAY(hide_refs, 1);
> -			hide_refs->strdup_strings = 1;
> -		}
> -		string_list_append(hide_refs, ref);
> +		string_list_append_nodup(hide_refs, ref);
>  	}
>  	return 0;
>  }

This nodup is definitely the right thing to be doing, but it's kind of
hidden in here. AFAICT it is fixing an existing leak, because the
previous code always set strdup_strings, and we always made our own copy
of "ref".

Probably not worth a re-roll on its own, but I'd probably have pulled
that into its own commit.

The rest of the commit looks OK to me. Like Ævar, I'm confused by the
"free_util" arguments to string_list_clear().

-Peff
