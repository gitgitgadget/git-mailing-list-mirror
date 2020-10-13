Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A783C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 06:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03359208D5
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 06:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389534AbgJMGgv convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 13 Oct 2020 02:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389353AbgJMGgv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 02:36:51 -0400
Received: from mx.pao1.isc.org (mx.pao1.isc.org [IPv6:2001:4f8:0:2::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C4CC0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 23:36:51 -0700 (PDT)
Received: from zmx1.isc.org (zmx1.isc.org [149.20.0.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.pao1.isc.org (Postfix) with ESMTPS id 00A603AB009;
        Tue, 13 Oct 2020 06:36:50 +0000 (UTC)
Received: from zmx1.isc.org (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTPS id EB81616008A;
        Tue, 13 Oct 2020 06:36:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zmx1.isc.org (Postfix) with ESMTP id DF515160053;
        Tue, 13 Oct 2020 06:36:50 +0000 (UTC)
Received: from zmx1.isc.org ([127.0.0.1])
        by localhost (zmx1.isc.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VFpw6waIexi6; Tue, 13 Oct 2020 06:36:50 +0000 (UTC)
Received: from larwa.hq.kempniu.pl (unknown [212.180.223.213])
        by zmx1.isc.org (Postfix) with ESMTPSA id 061F216003E;
        Tue, 13 Oct 2020 06:36:49 +0000 (UTC)
Date:   Tue, 13 Oct 2020 08:36:46 +0200
From:   =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] diff: add -I<regex> that ignores matching changes
Message-ID: <20201013063646.GB3278@larwa.hq.kempniu.pl>
References: <20201001120606.25773-1-michal@isc.org>
 <20201012091751.19594-1-michal@isc.org>
 <20201012091751.19594-3-michal@isc.org>
 <nycvar.QRO.7.76.6.2010121315170.50@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2010121315170.50@tvgsbejvaqbjf.bet>
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

> > @@ -5491,6 +5511,9 @@ static void prep_parse_options(struct diff_options *options)
> >  		OPT_BIT_F(0, "ignore-blank-lines", &options->xdl_opts,
> >  			  N_("ignore changes whose lines are all blank"),
> >  			  XDF_IGNORE_BLANK_LINES, PARSE_OPT_NONEG),
> > +		OPT_CALLBACK_F('I', NULL, options, N_("<regex>"),
> > +			       N_("ignore changes whose all lines match <regex>"),
> > +			       0, diff_opt_ignore_regex),
> >  		OPT_BIT(0, "indent-heuristic", &options->xdl_opts,
> >  			N_("heuristic to shift diff hunk boundaries for easy reading"),
> >  			XDF_INDENT_HEURISTIC),
> 
> Are we releasing the `ignore_regex` anywhere?

Oops, I tried to mimic what is done for 'anchors', and I failed to
notice that apparently the elements of the options->anchors array are
only free()'d when --patience is also used and the array pointer itself
is never free()'d at all.  Given this, I believe I need to fix
diff_opt_ignore_regex() in patch 2 and also make sure that the memory
allocated in diff_opt_anchored() gets properly released - in another
preliminary clean-up patch?

At first glance, diff_flush() - specifically the part below the
'free_queue' label - looks like a sane place to free() things.  Am I
mistaken?

-- 
Best regards,
Michał Kępień
