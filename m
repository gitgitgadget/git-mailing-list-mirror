Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B2741F404
	for <e@80x24.org>; Tue, 27 Feb 2018 22:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeB0Wjc (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 17:39:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:39684 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751641AbeB0Wjb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 17:39:31 -0500
Received: (qmail 12000 invoked by uid 109); 27 Feb 2018 22:39:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Feb 2018 22:39:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28676 invoked by uid 111); 27 Feb 2018 22:40:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 27 Feb 2018 17:40:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Feb 2018 17:39:29 -0500
Date:   Tue, 27 Feb 2018 17:39:29 -0500
From:   Jeff King <peff@peff.net>
To:     tboegi@web.de
Cc:     j6t@kdbg.org, lars.schneider@autodesk.com, git@vger.kernel.org,
        gitster@pobox.com, patrick@luehne.de, larsxschneider@gmail.com
Subject: Re: [PATCH/RFC 1/1] Auto diff of UTF-16 files in UTF-8
Message-ID: <20180227223929.GA3484@sigill.intra.peff.net>
References: <20171218131249.GB4665@sigill.intra.peff.net>
 <20180226172706.7822-1-tboegi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180226172706.7822-1-tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 06:27:06PM +0100, tboegi@web.de wrote:

> @@ -3611,8 +3615,25 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
>  			s->size = size;
>  			s->should_free = 1;
>  		}
> -	}
> -	else {
> +		if (!s->binary && buffer_is_binary(s->data, s->size) &&
> +		    buffer_has_utf16_bom(s->data, s->size)) {
> +			int outsz = 0;
> +			char *outbuf;
> +			outbuf = reencode_string_len(s->data, (int)s->size,
> +						     "UTF-8", "UTF-16", &outsz);
> +			if (outbuf) {
> +				if (s->should_free)
> +					free(s->data);
> +				if (s->should_munmap)
> +					munmap(s->data, s->size);
> +				s->should_munmap = 0;
> +				s->data = outbuf;
> +				s->size = outsz;
> +				s->reencoded_from_utf16 = 1;
> +				s->should_free = 1;
> +			}
> +		}
> +	} else {

I don't think it makes sense to do the conversion deep inside
diff_populate_filespec(), because it will kick in much more than you'd
want (e.g., "format-patch | am" would stop working with this patch, I
think).

I think you'd want to hook this in at the same level as fill_textconv().
In fact, one way to do it would be to have the get_textconv() stack just
fill in a special driver that does the auto-detection. This is similar
to my earlier patch, but it avoids overriding the user-facing config for
non-textconv things (and naturally any actual configured textconv filter
would override the auto-detection).

-Peff
