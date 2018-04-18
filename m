Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAC4F1F424
	for <e@80x24.org>; Wed, 18 Apr 2018 11:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754050AbeDRLoA (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Apr 2018 07:44:00 -0400
Received: from ao2.it ([92.243.12.208]:44334 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754045AbeDRLn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Apr 2018 07:43:59 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1f8lU6-0006bE-A0; Wed, 18 Apr 2018 13:42:46 +0200
Date:   Wed, 18 Apr 2018 13:43:57 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [RFC 01/10] submodule: add 'core.submodulesFile' to override
 the '.gitmodules' path
Message-Id: <20180418134357.1e417fb22201b6a6b67c02c0@ao2.it>
In-Reply-To: <CAGZ79kajTdkPKpcjH3NXBE75qWnNCCq_OefAjQsw17hK_VEyCw@mail.gmail.com>
References: <20180412222047.5716-1-ao2@ao2.it>
        <20180412222047.5716-2-ao2@ao2.it>
        <CAGZ79kZV+MLaVp4AM77bJkT=MeBvDSHTxZCni8dkqq4VLWZ0AA@mail.gmail.com>
        <20180416183742.032530a4d44faccd44189ea6@ao2.it>
        <CAGZ79kajTdkPKpcjH3NXBE75qWnNCCq_OefAjQsw17hK_VEyCw@mail.gmail.com>
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

On Mon, 16 Apr 2018 14:22:35 -0700
Stefan Beller <sbeller@google.com> wrote:

> On Mon, Apr 16, 2018 at 9:37 AM, Antonio Ospite <ao2@ao2.it> wrote:
> > On Thu, 12 Apr 2018 16:50:03 -0700
> > Stefan Beller <sbeller@google.com> wrote:
> >
> >> Hi Antonio,
> >>
> >> On Thu, Apr 12, 2018 at 3:20 PM, Antonio Ospite <ao2@ao2.it> wrote:
> >> > When multiple repositories with detached work-trees take turns using the
> >> > same directory as their work-tree, and more than one of them want to use
> >> > submodules, there will be conflicts about the '.gitmodules' file.
> >>
> >> unlike other files which would not conflict?
> >> There might be file names such as LICENSE, Readme.md etc,
> >> which are common enough that they would produce conflicts as well?
> >> I find this argument on its own rather weak. ("Just delete everything in
> >> the working dir before using it with another repository"). I might be
> >> missing a crucial bit here?
> >>
> >
> > All the vcsh repositories _share_ the same work-tree; they may control
> > it taking turns but, in general, all files are meant to be checked out
> > at all times as the basic use case is: *distinct* sets of config files.
> >
> > Maybe saying that the repositories "take turns" is confusing.
> > It's an unnecessary information, so I will omit that part form the
> > commit message.
> 
> So they all have the same workdir, do they track the same set of files
> or do they track a disjoint set of files, and ignoring the other repositories
> files via the ignore mechanism?
>

To recap,

vcsh[1] sets $HOME as the work-tree of multiple repositories to track
different sets of dotfiles in distinct repositories, while still having
the files directly available in $HOME. Each repository can ignore
untracked files via the ignore mechanism (namely core.excludesFile).

[1] https://github.com/RichiH/vcsh

For all this to work well, the sets of the tracked files would also need
to be disjoint, and usually they "practically" are, once a few
exceptions are taken care of.

Common intersecting items like LICENSE and README can be handled via
sparse-checkout to have "disjoint checkouts" and this solves most of
the problems, but the same mechanism cannot be used for .gitmodules as
it needs to be checked out.

And the problem cannot be worked around like done with .gitignore
(using core.excludesFile instead) because .gitmodules is unique and
hardcoded.

> This sounds like an interesting setup. I never though of that as something
> useful (in either configuration).
>

Give vcsh a try maybe.

[...]
> > However I guess that my point here is that the gitmodules file is
> > something that influences git behavior so it should not be on the user's
> > shoulder to manage conflicts for it, and most importantly it needs to
> > be checked out for git to access it, doesn't it?
> 
> Good point! I wonder if the cleaner solution would be to just
> tell git to use HEAD:.gitmodules and not check out the file?
> then you would not need to come up with a namespace for names
> of the .gitmodules files and scatter them into the worktree as well?
>

Any solution which:

  1. prevents the gitmodules file to be checked out
  2. but still tracks it in the git repository

OR
  
  1. allows to set the gitmoudles file under some namespace

would work for vcsh I guess.

> 
> >> > -               value=$(git config -f .gitmodules submodule."$name"."$option")
> >> > +               gitmodules_file=$(git config core.submodulesfile)
> >> > +               : ${gitmodules_file:=.gitmodules}
> >> > +               value=$(git config -f "$gitmodules_file" submodule."$name"."$option")
> >>
> >> I wonder if it would be cheaper to write a special config lookup now, e.g.
> >> in builtin/submodule--helper.c we could have a "config-from-gitmodules"
> >> subcommand that is looking up the modules file and then running the config
> >> on that file.
> >>
> >
> > Can you give an example from the user point of view of such a
> > "config-from-gitmodules" command?
> >
> 
>     git submodule config <name> <option>
> 
> as an 'alias' for
> 
>                gitmodules_file=$(git config core.submodulesfile)
>                : ${gitmodules_file:=.gitmodules}
>                value=$(git config -f "$gitmodules_file"
> submodule."$name"."$option")
> 
> The helper would figure out which config file to load form
> (.gitmodules in tree, HEAD:.gitmodules, your new proposed gitmodules file,
> .git/config... or the special ref) and then return the <option> for <name>
> 
> So maybe:
> 
>     $ git clone https://gerrit.googlesource.com/gerrit && cd gerrit
>     # ^ My goto-repo with submodules
> 
>     $ git submodule config "plugins/hooks" URL
>     ../plugins/hooks
> 
>

I may look into such supporting changes once you decide the approach to
take for the bigger problem.

Thank you,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
