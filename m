Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBAAC433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 06:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E5E6208D5
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 06:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389528AbgJMGiI convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 13 Oct 2020 02:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389470AbgJMGiH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 02:38:07 -0400
Received: from mx.pao1.isc.org (mx.pao1.isc.org [IPv6:2001:4f8:0:2::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2473C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 23:38:07 -0700 (PDT)
Received: from zmx1.isc.org (zmx1.isc.org [149.20.0.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.pao1.isc.org (Postfix) with ESMTPS id E6D333AB19E;
        Tue, 13 Oct 2020 06:38:07 +0000 (UTC)
Received: from zmx1.isc.org (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTPS id DE08016003E;
        Tue, 13 Oct 2020 06:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTP id CE32E160053;
        Tue, 13 Oct 2020 06:38:07 +0000 (UTC)
Received: from zmx1.isc.org ([127.0.0.1])
        by localhost (zmx1.isc.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1ZScxn6oLtnw; Tue, 13 Oct 2020 06:38:07 +0000 (UTC)
Received: from larwa.hq.kempniu.pl (unknown [212.180.223.213])
        by zmx1.isc.org (Postfix) with ESMTPSA id E32E216003E;
        Tue, 13 Oct 2020 06:38:06 +0000 (UTC)
Date:   Tue, 13 Oct 2020 08:38:03 +0200
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] diff: add -I<regex> that ignores matching changes
Message-ID: <20201013063803.GD3278@larwa.hq.kempniu.pl>
References: <20201001120606.25773-1-michal@isc.org>
 <20201012091751.19594-1-michal@isc.org>
 <20201012091751.19594-3-michal@isc.org>
 <xmqqk0vvpbmp.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0vvpbmp.fsf@gitster.c.googlers.com>
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +-I<regex>::
> 
> Since we are mimicking other folks' feature, giving also the
> 
> --ignore-matching-lines=<regex>
> 
> synonym to that their users are familiar with would be a good idea,
> no?

Some diff implementations (e.g. the OpenBSD one) lack the long option
and I was aiming for the "greatest common divisor" for all diff
implementations, but sure, I do not see how adding the synonym could
hurt.  I will do that in v3.

> > @@ -5203,6 +5207,22 @@ static int diff_opt_patience(const struct option *opt,
> >  	return 0;
> >  }
> >  
> > +static int diff_opt_ignore_regex(const struct option *opt,
> > +				 const char *arg, int unset)
> > +{
> > +	struct diff_options *options = opt->value;
> > +	regex_t *regex;
> > +
> > +	BUG_ON_OPT_NEG(unset);
> > +	regex = xcalloc(1, sizeof(*regex));
> > +	if (regcomp(regex, arg, REG_EXTENDED | REG_NEWLINE))
> > +		die("invalid regex: %s", arg);
> > +	ALLOC_GROW(options->ignore_regex, options->ignore_regex_nr + 1,
> > +		   options->ignore_regex_alloc);
> > +	options->ignore_regex[options->ignore_regex_nr++] = regex;
> > +	return 0;
> > +}
> 
> Don't these parse-options callback functions have a way to tell the
> caller die instead of them themselves dying like this?  Would it
> work better to "return error(... message ...)", or would that give
> two error messages?

Yes, that would indeed look better, thanks - just one error message is
generated when "return error(...)" is used.  I just failed to notice
that it is a thing.  I will use it in v3.

> In anycase, this is end-user facing, so we'd
> want it to be localizable, e.g.
> 
> 	die(_("invalid regexp given to -I: '%s'", arg));
> 
> probably.

Absolutely, I will fix that in v3.  I tried to mimic what other similar
code in the tree does and a quick `git grep 'die.*regex'` yielded mostly
non-localized strings, so I settled for one as well.

-- 
Best regards,
Michał Kępień
