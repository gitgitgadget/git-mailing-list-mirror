Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50A261F404
	for <e@80x24.org>; Wed, 25 Apr 2018 07:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751261AbeDYHNQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 03:13:16 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:47982 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750969AbeDYHNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 03:13:16 -0400
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id DE3D0335C0A;
        Wed, 25 Apr 2018 07:13:14 +0000 (UTC)
Message-ID: <1524640391.1104.26.camel@gentoo.org>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     "Robin H. Johnson" <robbat2@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
Date:   Wed, 25 Apr 2018 09:13:11 +0200
In-Reply-To: <robbat2-20180425T065446-231760424Z@orbis-terrarum.net>
References: <20180413170129.15310-1-mgorny@gentoo.org>
         <robbat2-20180425T065446-231760424Z@orbis-terrarum.net>
Organization: Gentoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu śro, 25.04.2018 o godzinie 06∶58 +0000, użytkownik Robin H.
Johnson napisał:
> On Fri, Apr 13, 2018 at 07:01:29PM +0200, Michał Górny wrote:
> > --- a/entry.c
> > +++ b/entry.c
> > @@ -411,6 +411,7 @@ int checkout_entry(struct cache_entry *ce,
> >  {
> >  	static struct strbuf path = STRBUF_INIT;
> >  	struct stat st;
> > +	int ret;
> >  
> >  	if (topath)
> >  		return write_entry(ce, topath, state, 1);
> 
> mgorny: Should the topath case trigger utime as well?

I don't think so.  AFAIU topath case is only used by 'git checkout-index 
--all', and it implies that data is written to temporary files rather
than actual working copy files, so mtimes do not really matter there.

> 
> Other questions:
> - Would there be be any value in hoisting the utime change into
>   write_entry's finish block rather than having it in checkout_entry?

I've attempted to reduce the scope of my changes to minimum, therefore
checkout_entry() seemed like the 'closest' thing to where it is set
and where it could be implemented.  I see no problem in doing that
in write_entry(), though.  In fact, it might be useful to do that before
filling the stat cache.

> - Should mtimes on directories be set if the directory is explicitly
>   created?

I don't think there's really a purpose in that.  I can't think of any
reason why anybody would be able to use directory mtimes reliably, so
maybe keeping their standard behavior is better here.

> - Maybe using futimens on supported platforms?

I'm all for that.  However, this is something the git maintainers should
decide as it probably implies some maintenance burden.

-- 
Best regards,
Michał Górny

