Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7BAC83F12
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 14:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjH1O6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 10:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjH1O6d (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 10:58:33 -0400
X-Greylist: delayed 558 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Aug 2023 07:58:31 PDT
Received: from out-245.mta1.migadu.com (out-245.mta1.migadu.com [IPv6:2001:41d0:203:375::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BB011C
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 07:58:31 -0700 (PDT)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1693234151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rARXmiIZjUvVJyXrKVKTPv5b8eMET3pJGpcszUL2Leo=;
        b=hM5X+8M0wHl1il7kUo5c557WbXHCo0+xze1LYL9LekoEdUSGozofXkWdN5JKZwliRjyxpI
        rjskDp+oktDTVq7ZM0U8pF2/ye9EoA0EF0LWhiHxxY9zq6GaZo9Zz9rGbo/figOeH60v5e
        zpmHMH6oXvfWnAdSerGtptDx+T80a05TdV1Wh2V1FQHuo22pHYO3iTtz0RO8neIPIUAIJX
        57YrE32m9Vro1lj79r1yiDZwCZJfWHROMsjT1kTp9VSA0wW62oDbErkqTguUIE7SDK34Jm
        jyMJet7u+8kcZpPKtl/tteKhWLzGyeB7CtEvKpcv7gVSS9mVUtjNxVMW2d4Jhw==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 28 Aug 2023 16:49:10 +0200
Message-Id: <CV49EUBH6USG.TQMTR5HU2OGD@taiga>
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH] builtin/log.c: prepend "RFC" on --rfc
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Jeff King" <peff@peff.net>
References: <20230828125132.25144-1-sir@cmpwn.com>
 <20230828144215.GA2537587@coredump.intra.peff.net>
In-Reply-To: <20230828144215.GA2537587@coredump.intra.peff.net>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon Aug 28, 2023 at 4:42 PM CEST, Jeff King wrote:
>  static int rfc_callback(const struct option *opt, const char *arg, int u=
nset)
>  {
> +	/*
> +	 * "avoid" leak by holding on to a reference to the memory, since we
> +	 * need the string for the lifetime of the process anyway
> +	 */
> +	static char *prefix;
> +
>  	BUG_ON_OPT_NEG(unset);
>  	BUG_ON_OPT_ARG(arg);
> -	return subject_prefix_callback(opt, "RFC PATCH", unset);
> +
> +	free(prefix);
> +	prefix =3D xstrfmt("RFC %s", ((struct rev_info *)opt->value)->subject_p=
refix);
> +
> +	return subject_prefix_callback(opt, prefix, unset);
>  }

I like this better, thanks!
