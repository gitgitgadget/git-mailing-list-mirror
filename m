Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 079321F424
	for <e@80x24.org>; Mon, 16 Apr 2018 11:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeDPLdP (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 07:33:15 -0400
Received: from ao2.it ([92.243.12.208]:39796 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750946AbeDPLdO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 07:33:14 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1f82Me-0002gI-Pp; Mon, 16 Apr 2018 13:32:04 +0200
Date:   Mon, 16 Apr 2018 13:33:12 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>, git <git@vger.kernel.org>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [RFC 00/10] Make .the gitmodules file path configurable
Message-Id: <20180416133312.241ada0390d6fec18856b027@ao2.it>
In-Reply-To: <CAGZ79kZbZ03D7ysaVXYkV3v0jO6K7kEOc9sT2zA+Xc6mqLNL9Q@mail.gmail.com>
References: <20180412222047.5716-1-ao2@ao2.it>
        <CAGZ79kZbZ03D7ysaVXYkV3v0jO6K7kEOc9sT2zA+Xc6mqLNL9Q@mail.gmail.com>
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

On Thu, 12 Apr 2018 16:36:32 -0700
Stefan Beller <sbeller@google.com> wrote:

> Hi Antonio,
>

Hi Stefan,

> On Thu, Apr 12, 2018 at 3:20 PM, Antonio Ospite <ao2@ao2.it> wrote:
> > Hi,
> >
> > vcsh[1] uses bare git repositories and detached work-trees to manage
> > *distinct* sets of configuration files directly into $HOME.
> >
> > In general, submodules have worked perfectly fine with detached
> > work-trees for some time[2,3,4].
> >
> > However when multiple repositories take turns using the same directory
> > as their work-tree, and more than one of them want to use submodules,
> > there could still be conflicts about the '.gitmodules' file because git
> > hardcodes this path.
> >
[...]
> 
> > So this series proposes a mechanism to set an alternative path for the
> > submodules configuration file (from now on "gitmodules file").
> 
[...]
> > Expanding on that change the first patch in the series makes the path
> > customizable exposing a 'core.submodulesFile' configuration setting.
> 
> I guess the similarity to core.ignoreFile is desired here. Although these
> mechanisms are very different.
>

The option name is similar to 'core.excludesFile' also because, when I
started, I first looked at how multiple ignore files were used, so I
may have been influenced by that.

I acknowledge that the two mechanisms are different, in particular
because git *writes* the gitmodules file itself.

I am not opposed to change the name, something like
'core.submodulesConfigFile' might highlight that the syntax of the file
is the one of git config, but I think it's too long.

> > The new configuration setting can be used to set an *alternative*
> > location for the gitmodules file; IMHO there is no need to provide
> > *additional* locations like in the case of exclude files.
> 
> I think there *may* be a need for additional files.
> Currently there is only the .gitmodules file and the configuration
> in .git/config overriding settings from .gitmodules.
> 
> There was some discussion on the mailing list in the past, which
> presented a intermediate layer in between these two places, in
> a special ref, such that:
>     base is in .gitmodules
>     overwritten via refs/meta/submodules:.gitmodules
>     overwritten via the .git/config
> 
> The intermediate would be a config file that is tracked on another
> ref. This (a) decouples main project history from submodule history
> and (b) makes it easier to distribute as it is part of the repository.
> 
> For example (a) is desired if you dig up an old project and the
> submodules have all moved from one git hosting provider to another.
> Another example would be when you fork a project with submodules
> and don't want to mess with the main history but you just want to
> adjust the submodule URLs. That is possible with such an intermediate
> additional place.
> 
> For (b) you can imagine the fork that you want to distribute in your
> community and you don't want to tell everyone to change the
> submodule URLs, but instead you can provide them with a prepared
> .gitmodules file, that they have to place into that special ref (which
> can be done via fetching).
> 
> I digress as these ideas seem to be orthogonal to your patch series,
> just FYI. prior discussion starting at:
> https://public-inbox.org/git/1462317985-640-1-git-send-email-sbeller@google.com/
> I recall there was a better discussion even prior to that, but have no
> link handy.
>

Just to understand, is that 'refs/meta/submodules:.gitmodules' file
meant to be managed manually? Or do you imagine some options to
instruct "git submodule" to *write* to that file instead of .gitmodules?

In the latter case your idea could cover my use case too, couldn't it?

But most importantly, is this realistically going to be added?
Currently I am not that familiar with the git code base to do it
myself, and I've never explicitly dealt with special refs in git.

The approach of this patch series is a lot simpler, and something I can
work on in my spare time.

Presumably (b) could even be partially supported with my changes, by
having both '.gitmodules' and some custom '.gitmodules-alternative'
files in the repository and tell users to clone with:

  git clone --config core.submodulesFile=.gitmodules-alternative URL

Not as clean as your idea but doable.

[...]
> > Since the gitmodules file is meant to be checked in into the repository,
> > the overridden file path should be relative to the work-tree; is there
> > a way to enforce this constraint at run time (i.e. validate the config
> > value), or is it enough to have it documented?
> 
> I think we'd want to check at run time, if we need this constraint.
> 

I'll look into it once we decide which the way to go.

Thank you.

Ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
