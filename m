Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EE411F404
	for <e@80x24.org>; Mon, 16 Apr 2018 16:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbeDPQho (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 12:37:44 -0400
Received: from ao2.it ([92.243.12.208]:40156 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752623AbeDPQho (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 12:37:44 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1f877K-0004cn-4R; Mon, 16 Apr 2018 18:36:34 +0200
Date:   Mon, 16 Apr 2018 18:37:42 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [RFC 01/10] submodule: add 'core.submodulesFile' to override
 the '.gitmodules' path
Message-Id: <20180416183742.032530a4d44faccd44189ea6@ao2.it>
In-Reply-To: <CAGZ79kZV+MLaVp4AM77bJkT=MeBvDSHTxZCni8dkqq4VLWZ0AA@mail.gmail.com>
References: <20180412222047.5716-1-ao2@ao2.it>
        <20180412222047.5716-2-ao2@ao2.it>
        <CAGZ79kZV+MLaVp4AM77bJkT=MeBvDSHTxZCni8dkqq4VLWZ0AA@mail.gmail.com>
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

On Thu, 12 Apr 2018 16:50:03 -0700
Stefan Beller <sbeller@google.com> wrote:

> Hi Antonio,
> 
> On Thu, Apr 12, 2018 at 3:20 PM, Antonio Ospite <ao2@ao2.it> wrote:
> > When multiple repositories with detached work-trees take turns using the
> > same directory as their work-tree, and more than one of them want to use
> > submodules, there will be conflicts about the '.gitmodules' file.
> 
> unlike other files which would not conflict?
> There might be file names such as LICENSE, Readme.md etc,
> which are common enough that they would produce conflicts as well?
> I find this argument on its own rather weak. ("Just delete everything in
> the working dir before using it with another repository"). I might be
> missing a crucial bit here?
>

All the vcsh repositories _share_ the same work-tree; they may control
it taking turns but, in general, all files are meant to be checked out
at all times as the basic use case is: *distinct* sets of config files.

Maybe saying that the repositories "take turns" is confusing.
It's an unnecessary information, so I will omit that part form the
commit message.

After your question I've done some research and I've seen other vcsh
users managing conflicting LICENSE and README files using git
sparse-checkouts, to have these files in the single repositories but
not checked out in the shared work-tree:
https://github.com/RichiH/vcsh/issues/120#issuecomment-42639619
https://github.com/jwhitley/vcsh-root/commit/30b0d495c2cbe47ae9617ace9c2c14720d961d78

However I guess that my point here is that the gitmodules file is
something that influences git behavior so it should not be on the user's
shoulder to manage conflicts for it, and most importantly it needs to
be checked out for git to access it, doesn't it?

> > git hardcodes this path so it's not possible to override its location on
> > a per-repository basis to allow such repositories to coexists
> > peacefully.
> >
> > Make the path of the "gitmodules file" customizable exposing
> > a 'core.submodulesFile' configuration setting.
> >
> > The default value will still be '.gitmodules' when 'core.submodulesFile'
> > is not set.
> 
> ok.
> 
> 
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -1774,6 +1774,7 @@ extern void prepare_pager_args(struct child_process *, const char *pager);
> >  extern const char *editor_program;
> >  extern const char *askpass_program;
> >  extern const char *excludes_file;
> > +extern const char *submodules_file;
> 
> Could you place this variable in repository.h in struct repository?
> (Some developers currently try to move any global state to that place,
> as that makes working with e.g. nested submodules easier in-process
> and you would not need to spawn processes for submodules)
> 
> Once migrated to the repository struct mentioned above, you'd access
> it via the_repository->submodules_file for the main repository.
>

OK, thanks, I didn't like the global variable either, I was just copying
from excludes_file.

> 
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 24914963c..610fd0dc5 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -71,7 +71,9 @@ get_submodule_config () {
> >         value=$(git config submodule."$name"."$option")
> >         if test -z "$value"
> >         then
> > -               value=$(git config -f .gitmodules submodule."$name"."$option")
> > +               gitmodules_file=$(git config core.submodulesfile)
> > +               : ${gitmodules_file:=.gitmodules}
> > +               value=$(git config -f "$gitmodules_file" submodule."$name"."$option")
> 
> I wonder if it would be cheaper to write a special config lookup now, e.g.
> in builtin/submodule--helper.c we could have a "config-from-gitmodules"
> subcommand that is looking up the modules file and then running the config
> on that file.
>

Can you give an example from the user point of view of such a
"config-from-gitmodules" command?

I might look into it, but that can also be a followup change. 

> I am surprised how little access of the .gitmodules is left in git-submodule.sh
> (which is partially ported to the builtin/submodule--helper.c)
> 
> > diff --git a/submodule-config.c b/submodule-config.c
> > index 3f2075764..8a3396ade 100644
> > --- a/submodule-config.c
> > +++ b/submodule-config.c
> > @@ -468,7 +468,7 @@ static int gitmodule_oid_from_commit(const struct object_id *treeish_name,
> >                 return 1;
> >         }
> >
> > -       strbuf_addf(rev, "%s:.gitmodules", oid_to_hex(treeish_name));
> > +       strbuf_addf(rev, "%s:%s", oid_to_hex(treeish_name), submodules_file);
> >         if (get_oid(rev->buf, gitmodules_oid) >= 0)
> >                 ret = 1;
> >
> > @@ -583,7 +583,7 @@ void repo_read_gitmodules(struct repository *repo)
> >                 if (repo_read_index(repo) < 0)
> >                         return;
> >
> > -               gitmodules = repo_worktree_path(repo, GITMODULES_FILE);
> > +               gitmodules = repo_worktree_path(repo, submodules_file);
> >
> >                 if (!is_gitmodules_unmerged(repo->index))
> >                         git_config_from_file(gitmodules_cb, gitmodules, repo);
> > diff --git a/submodule.c b/submodule.c
> > index 9a50168b2..2afbdb644 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -36,13 +36,13 @@ static struct oid_array ref_tips_after_fetch;
> >   */
> >  int is_gitmodules_unmerged(const struct index_state *istate)
> >  {
> > -       int pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
> > +       int pos = index_name_pos(istate, submodules_file, strlen(submodules_file));
> 
> Ah, regarding the coverletter: This clearly assumes the modules
> file is in the tree. So at least here we would make an exception
> for files outside the tree to either not check for un-merged-ness or
> disallow that case entirely.
>

Sorry I am not sure I follow what you are saying here, keep in mind
that I am new to git internals.

Do you mean that, even if we ensure (in
config.c::git_default_core_config) that only paths relative to
the work-tree are allowed, we still have to check here that the
constraint is respected? And is so, why?

> There are quite a few functions in submodule.c which access the new global. :/
> So moving them to the_repository should be fine, but eventually (not
> in this series)
> all these functions would would want to take a repository argument as well
> such that they work on more than the_repository.
> 

I will surely get rid of the global variable, but about changing the
functions signatures I don't feel like promising anything just yet.

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
