Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF5BB1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 13:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932259AbeFUNym (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 09:54:42 -0400
Received: from ao2.it ([92.243.12.208]:51835 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751048AbeFUNyl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 09:54:41 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fW02I-0001o1-HA; Thu, 21 Jun 2018 15:54:06 +0200
Date:   Thu, 21 Jun 2018 15:54:38 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [RFC PATCH 01/10] config: make config_from_gitmodules generally
 useful
Message-Id: <20180621155438.31b244a9d5d7b4723f85ba89@ao2.it>
In-Reply-To: <CAGZ79kaMbGdJjooqWLiNOabmujhNKKKJQb_HrZ4YUMVMQ--KbA@mail.gmail.com>
References: <20180514105823.8378-1-ao2@ao2.it>
        <20180514105823.8378-2-ao2@ao2.it>
        <CAGZ79kag=1h506FGg72_F9Rmz4nqPN19kaywfTtD3WnNWnxD9w@mail.gmail.com>
        <20180620200634.13b47725cfd1e2dfb1cd482e@ao2.it>
        <CAGZ79kaMbGdJjooqWLiNOabmujhNKKKJQb_HrZ4YUMVMQ--KbA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Jun 2018 12:10:42 -0700
Stefan Beller <sbeller@google.com> wrote:

> Hi Antonio!
>
> On Wed, Jun 20, 2018 at 11:06 AM Antonio Ospite <ao2@ao2.it> wrote:
> > I get that the _content_ of .gitmodules is not meant to be generic
> > config, but I still see some value in having a single point when its
> > _location_ is decided.
> 
> I agree that a single point for the _location_ as well as the _order_
> (in case there will be multiple files; as of now we have the layering
> of .gitmodules overlayed by .git/config; IIRC I explained having
> an intermediate layer in our conversation to be useful; See one of the latest
> bug reports[1], where an intermediate layer outside a single branch would
> prove to be useful.) parsing are useful.
> 
> [1] https://public-inbox.org/git/DB6PR0101MB2344D682511891E4E9528598D97D0@DB6PR0101MB2344.eurprd01.prod.exchangelabs.com/
> 
> Sorry for not explaining my point of view well enough, let me try again:
> 
> Historically we did not store any config in the repository itself.
> There are some exceptions, but these configurations are content related,
> i.e. .gitmodules or .gitattributes can tell you meta data about the
> content itself.
> 
> However other config was kept out: One could have a .gitconfig that
> pre-populates the .git/config file, right? That was intentionally avoided
> as there are many configurations that are easy to abuse security wise,
> e.g. setting core.pager = "rm -rf /"
> 
> And then submodules entered the big picture. Submodules need quite
> a lot of configuration, and hence the .gitmodules file was born. Initially
> IIRC there was only a very simple config like url store:
> 
>   [submodule.<path>]
>     url = <url>
> 
> and that was it as it was just like the .gitignore and .gitattributes
> related to the content and transporting this configuration with the
> content itself seemed so natural.
> 
> However then a lot of settings were invented for submodules and some
> made it into the .gitmodules file; only recently there was a discussion
> on list how these settings may or may not pose a security issue. It turns out
> we had a CVE (with sumodule names) and that got fixed but we really want
> to keep the .gitmodules file simple and ignore any additional things in there
> as they may pose security issues later.
> 
> With that said, how would you write the code while keeping this in mind?
> If you look at builtin/submodule--helper.c and builtin/fetch.c, you'll see that
> they use
> 
>   config_from_gitmodules(their_parse_function);
>   git_config(their_parse_function);
> 
> and config_from_gitmodules is documented to not be expanded;
> the config_from_gitmodules is singled out to treat those settings
> that snuck in and are kept around as we don't want to break existing
> users. But we'd really not want to expand the use of that function
> again for its implications on security. Right now it is nailed down beautifully
> and it is easy to tell which commands actually look at config from
> the .gitmodules file (not to be confused with the submodule parsing,
> that is in submodule-config.{h, c}. That is actually about finding
> submodule specific name/path/url etc instead of the generic
> "submodule.fetchjobs" or "fetch.recursesubmodules".
> 
> ----
> So far about the background story. I would rather replicate the code in
> repo_read_gitmodules in the submodule-config.c as to mix those
> two lines (reading generic config vs. reading submodule specific config,
> like name/url/path). And to not mix them, I would not reuse that function
> but rather replicate (or have a static helper) in submodule helper,
> as then we cannot pass in an arbitrary config parsing callback to
> that, but are bound to the submodule helper code.
>

OK, the fact I was overlooking was that the "config_fn_t" argument
passed to config_from_gitmodules is what we are actually worried about,
it's the config callback which could allow generic config in .gitmodules
to sneak in. I still have some blind spots on git internals, sorry.

So, from Brandon's message I derive that using the gitmodules_cb from
submodules-config.c as a callback would be safe, as that's what
repo_read_gitmodules already uses anyways, and it only allows submodules
configuration.

However, what about avoiding exposing the dangerous interface altogether
and adding ad-hoc helpers when needed?

I mean:

  0. Move config_from_gitmodules to submodule-config.c as per Bradon's
     suggestion.

  1. Add public helpers in submodule-config.[ch] to handle backwards
     compatibility, like: fetch_config_from_gitmodules() and
     update_clone_config_from_gitmodules() these would be used by fetch
     and update-clone function and would not accept callbacks.

     This would mean moving the callback functions
     gitmodules_fetch_config() and gitmodules_update_clone_config() into
     submodule-config.c and making them private. The helpers will call
     config_from_gitmodules() with them.

  2. Now that config_from_gitmodules it's not used in the open it can be
     made private too, so it can only be used in submodule-config.c

  3. Use config_from_gitmodules in repo_read_gitmodules as the
     gitmodules_cb function should be safe to use as a config callback.

  4. Add a new gitmodules_get_value() helper in submodule-config.c which
     calls config_from_gitmodules with a "print" callback and use that
     helper for "submodule--helper config",

  5. At this point we shouldn't worry too much about the .gitmodules
     content anymore, and we can possibly extend config_from_gitmodules
     to read from other locations like HEAD:.gitmodules.

This way the number of users of config_from_gitmodules remains strictly
controlled and confined in submodule-config.c

I know, we could end up adding more code with the helpers but that could
be justified by the more protective approach: we would be using symbols
scoping rules instead of comments to ensure something.

If you think this may be worth a shot I can send a series which covers
items from 0 to 3.

Ciao,
   Antonio

P.S. Always relevant: https://youtu.be/8fnfeuoh4s8 (I swear it's not
Rick Astley)

> > > I think extending 'repo_read_gitmodules' makes sense, as that is
> > > used everywhere for the loading of submodule configuration.
> >
> > I would follow Brandon's suggestion here and still use
> > 'config_from_gitmodules' from 'repo_read_gitmodules' to avoid code
> > duplication.
> >
> > I will try to be clear in the comments and in commit message when
> > motivating the decision.
> 
> Rereading what Brandon said, I agree with this approach, sorry for writing
> out the story above in such lengthy detail.
> 
> Thanks for picking up this series again!
> Stefan


-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
