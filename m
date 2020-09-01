Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147F4C433E6
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 14:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF26421D7D
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 14:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgIAOn2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:43:28 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38600 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728310AbgIAOnY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 10:43:24 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id EC6581F66E;
        Tue,  1 Sep 2020 14:43:23 +0000 (UTC)
Date:   Tue, 1 Sep 2020 14:43:23 +0000
From:   Eric Wong <e@80x24.org>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] core.abbrev <off|false|no> disables abbreviations
Message-ID: <20200901144323.GA14554@dcvr>
References: <20200901074355.GA4498@dcvr>
 <9c00f29b-45e4-ccdf-6d81-5eabd58c875b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9c00f29b-45e4-ccdf-6d81-5eabd58c875b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> wrote:
> On 9/1/2020 3:43 AM, Eric Wong wrote:
> > index 2bdff4457b..f2e09c72ca 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -1217,6 +1217,10 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
> >  			return config_error_nonbool(var);
> >  		if (!strcasecmp(value, "auto"))
> >  			default_abbrev = -1;
> > +		else if (!strcasecmp(value, "false") ||
> > +			 !strcasecmp(value, "no") ||
> > +			 !strcasecmp(value, "off"))
> > +			default_abbrev = the_hash_algo->hexsz;
> 
> I'm not sure we need three synonyms for "no-abbrev" here.

I just used the accepted synonyms since I figured users
would be used to them, already.

> "false" would be natural, except I think in a few places
> the config value "0" is also interpreted as "false", but
> as seen below a value of "0" snaps up to the minimum
> allowed abbreviation.
> 
> >  		else {
> >  			int abbrev = git_config_int(var, value);
> >  			if (abbrev < minimum_abbrev || abbrev > the_hash_algo->hexsz)

It actually errors out on the next line, here.

Perhaps adopting parse_opt_abbrev_cb behavior of clamping to
the minimum and maximum supported values is more consistent?

> Perhaps "core.abbrev = never" would be a good option?

*shrug*

> After we decide on the word, this patch needs:
> 
> * Updates to Documentation/config/core.txt

Will do.

> * A test that works with both hash versions.

Will do, though not too sure where the tests for this should be.

Thanks for the comments, will wait a few days for comments
before sending out v2.
