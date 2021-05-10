Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A424C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 22:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E4D61581
	for <git@archiver.kernel.org>; Mon, 10 May 2021 22:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbhEJWea (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 18:34:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:49826 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231277AbhEJWe1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 18:34:27 -0400
Received: (qmail 20155 invoked by uid 109); 10 May 2021 22:33:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 10 May 2021 22:33:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16311 invoked by uid 111); 10 May 2021 22:33:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 May 2021 18:33:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 May 2021 18:33:19 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com
Subject: Re: [PATCH] merge-ort: split "distinct types" message into two
 translatable messages
Message-ID: <YJm0r15gK3DjKbbl@coredump.intra.peff.net>
References: <20210509215250.33215-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210509215250.33215-1-alexhenrie24@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 09, 2021 at 03:52:50PM -0600, Alex Henrie wrote:

> The word "renamed" has two possible translations in many European
> languages depending on whether one thing was renamed or two things were
> renamed. Give translators freedom to alter any part of the message to
> make it sound right in their language.

Makes sense. And in general, I think the advice (e.g., given in
gettext's "Preparing Strings" doc) is to avoid the kind of "lego"
translation structure we saw in the original (where words like "both" or
"none" might need more context than a single %s provides).

> -			path_msg(opt, path, 0,
> -				 _("CONFLICT (distinct types): %s had different "
> -				   "types on each side; renamed %s of them so "
> -				   "each can be recorded somewhere."),
> -				 path,
> -				 (rename_a && rename_b) ? _("both") : _("one"));
> +			if (rename_a && rename_b) {
> +				path_msg(opt, path, 0,
> +					 _("CONFLICT (distinct types): %s had "
> +					   "different types on each side; "
> +					   "renamed both of them so each can "
> +					   "be recorded somewhere."),
> +					 path);
> +			} else {
> +				path_msg(opt, path, 0,
> +					 _("CONFLICT (distinct types): %s had "
> +					   "different types on each side; "
> +					   "renamed one of them so each can be "
> +					   "recorded somewhere."),
> +					 path);
> +			}

I wondered if we could be using the Q_() helper here, which
distinguishes cases based on quantity. But I don't think this is
semantically quite the same thing (it's not "rename" versus "renames",
but rather two distinctly interesting cases).

-Peff
