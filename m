Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EA5C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 00:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D7BA64DEB
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 00:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhA2A3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 19:29:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:42676 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231184AbhA2A3N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 19:29:13 -0500
Received: (qmail 20379 invoked by uid 109); 29 Jan 2021 00:28:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 00:28:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4084 invoked by uid 111); 29 Jan 2021 00:28:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 19:28:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 19:28:32 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3 03/10] builtin/index-pack.c: allow stripping arbitrary
 extensions
Message-ID: <YBNWsJBDUpNiRXP4@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <8a3e70454b9bc64fc7a5ff07d47f7fde018e6a3d.1611617820.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8a3e70454b9bc64fc7a5ff07d47f7fde018e6a3d.1611617820.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 06:37:22PM -0500, Taylor Blau wrote:

> To derive the filename for a .idx file, 'git index-pack' uses
> derive_filename() to strip the '.pack' suffix and add the new suffix.
> 
> Prepare for stripping off suffixes other than '.pack' by making the
> suffix to strip a parameter of derive_filename(). In order to make this
> consistent with the "suffix" parameter which does not begin with a ".",
> an additional check in derive_filename.

Maybe "add" missing from the final line?

> +static const char *derive_filename(const char *pack_name, const char *strip,
> +				   const char *suffix, struct strbuf *buf)
>  {
>  	size_t len;
> -	if (!strip_suffix(pack_name, ".pack", &len))
> -		die(_("packfile name '%s' does not end with '.pack'"),
> -		    pack_name);
> +	if (!strip_suffix(pack_name, strip, &len) || !len ||
> +	    pack_name[len - 1] != '.')
> +		die(_("packfile name '%s' does not end with '.%s'"),
> +		    pack_name, strip);
>  	strbuf_add(buf, pack_name, len);
> -	strbuf_addch(buf, '.');

Looks good to me.

-Peff
