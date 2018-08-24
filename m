Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42B761F404
	for <e@80x24.org>; Fri, 24 Aug 2018 16:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeHXU2X convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 24 Aug 2018 16:28:23 -0400
Received: from ao2.it ([92.243.12.208]:59916 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbeHXU2X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 16:28:23 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1ftFIf-00078G-FQ; Fri, 24 Aug 2018 18:51:05 +0200
Date:   Fri, 24 Aug 2018 18:52:51 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 1/9] submodule: add a print_config_from_gitmodules()
 helper
Message-Id: <20180824185251.be9374239a7a9ec0a796afe7@ao2.it>
In-Reply-To: <87wosfesxl.fsf@evledraar.gmail.com>
References: <20180824132951.8000-1-ao2@ao2.it>
        <20180824132951.8000-2-ao2@ao2.it>
        <87wosfesxl.fsf@evledraar.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Aug 2018 16:32:38 +0200
Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:

> 
> On Fri, Aug 24 2018, Antonio Ospite wrote:
[...]
> > +static int config_print_callback(const char *key_, const char *value_, void *cb_data)
> > +{
> > +	char *key = cb_data;
> > +
> > +	if (!strcmp(key, key_))
> > +		printf("%s\n", value_);
> > +
> > +	return 0;
> > +}
> 
> No problem with the code itself, but I'd find this a lot easier to read
> in context if it was:
> 
>     key_ -> var
>     value_ -> value
>     key -> wanted_key, perhaps?
> 
> I.e. the rest of the file uses the convention of the
> config_from_gitmodules callbacks getting "var" and "value",
> respectively.
> 
> We don't use this convention of suffixing variables with "_" if they're
> arguments to the function anywhere else.
>

I was new to git when I firstly wrote the code, I picked up the style
by copying from builtin/config.c (collect_config() and
show_all_config()) because I was focusing more on the functionality and
didn't bother to harmonize the style with the destination file.

> > +int print_config_from_gitmodules(const char *key)
> > +{
> > +	int ret;
> > +	char *store_key;
> > +
> > +	ret = git_config_parse_key(key, &store_key, NULL);
> > +	if (ret < 0)
> > +		return CONFIG_INVALID_KEY;
> 
> Isn't this a memory leak? I.e. we should free() and return here, no?
>

It is true that git_config_parse_key_1() allocates some storage even
for an invalid key, and uses the space to lowercase the key as the
parsing progresses, however it also frees the memory in the *error*
path.

So unless I am missing something I don't think there is a leak here.

[...]
> > diff --git a/submodule-config.h b/submodule-config.h
> > index dc7278eea4..ed40e9a478 100644
> > --- a/submodule-config.h
> > +++ b/submodule-config.h
> > @@ -56,6 +56,8 @@ void submodule_free(struct repository *r);
> >   */
> >  int check_submodule_name(const char *name);
> >
> > +int print_config_from_gitmodules(const char *key);
> > +
> >  /*
> >   * Note: these helper functions exist solely to maintain backward
> >   * compatibility with 'fetch' and 'update_clone' storing configuration in
> 
> Another style nit: Makes more sense to put this new function right
> underneath "submodule_free" above, instead of under 1/2 of the functions
> that have a big comment describing how they work, since that comment
> doesn't apply to this new function.

You are probably right, IIRC the function was firstly written before
check_submodule_name() was there. And I didn't think of moving it up
when I rebased after check_submodule_name() was added.

Your same remark may apply to the new function added in patch 02.

I'll wait for other comments to see if a v5 is really needed.

Thanks for the review Ævar.

Ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
