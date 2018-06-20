Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD23E1F403
	for <e@80x24.org>; Wed, 20 Jun 2018 18:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754650AbeFTS1Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 14:27:24 -0400
Received: from ao2.it ([92.243.12.208]:50618 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754638AbeFTS1X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 14:27:23 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1fVhSb-0003F8-1k; Wed, 20 Jun 2018 20:04:01 +0200
Date:   Wed, 20 Jun 2018 20:04:32 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 01/10] config: make config_from_gitmodules generally
 useful
Message-Id: <20180620200432.1d3690d4a4a0f88eb96ded73@ao2.it>
In-Reply-To: <20180514181928.GA235601@google.com>
References: <20180514105823.8378-1-ao2@ao2.it>
        <20180514105823.8378-2-ao2@ao2.it>
        <20180514181928.GA235601@google.com>
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

On Mon, 14 May 2018 11:19:28 -0700
Brandon Williams <bmwill@google.com> wrote:

Hi Brandon,

sorry for the delay, some comments below.

> On 05/14, Antonio Ospite wrote:
> > The config_from_gitmodules() function is a good candidate for
> > a centralized point where to read the gitmodules configuration file.
> > 
> > Add a repo argument to it to make the function more general, and adjust
> > the current callers in cmd_fetch and update-clone.
> > 
> > As a proof of the utility of the change, start using the function also
> > in repo_read_gitmodules which was basically doing the same operations.
> > 
> > Signed-off-by: Antonio Ospite <ao2@ao2.it>
> > ---
> >  builtin/fetch.c             |  2 +-
> >  builtin/submodule--helper.c |  2 +-
> >  config.c                    | 13 +++++++------
> >  config.h                    | 10 +---------
> >  submodule-config.c          | 16 ++++------------
> >  5 files changed, 14 insertions(+), 29 deletions(-)
> > 
> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index 7ee83ac0f..a67ee7c39 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -1445,7 +1445,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
> >  	for (i = 1; i < argc; i++)
> >  		strbuf_addf(&default_rla, " %s", argv[i]);
> >  
> > -	config_from_gitmodules(gitmodules_fetch_config, NULL);
> > +	config_from_gitmodules(gitmodules_fetch_config, the_repository, NULL);
> >  	git_config(git_fetch_config, NULL);
> >  
> >  	argc = parse_options(argc, argv, prefix,
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index c2403a915..9e8f2acd5 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -1602,7 +1602,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
> >  	};
> >  	suc.prefix = prefix;
> >  
> > -	config_from_gitmodules(gitmodules_update_clone_config, &max_jobs);
> > +	config_from_gitmodules(gitmodules_update_clone_config, the_repository, &max_jobs);
> >  	git_config(gitmodules_update_clone_config, &max_jobs);
> >  
> >  	argc = parse_options(argc, argv, prefix, module_update_clone_options,
> > diff --git a/config.c b/config.c
> > index 6f8f1d8c1..8ffe29330 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -2173,17 +2173,18 @@ int git_config_get_pathname(const char *key, const char **dest)
> >  }
> >  
> >  /*
> > - * Note: This function exists solely to maintain backward compatibility with
> > - * 'fetch' and 'update_clone' storing configuration in '.gitmodules' and should
> > - * NOT be used anywhere else.
> > + * Note: Initially this function existed solely to maintain backward
> > + * compatibility with 'fetch' and 'update_clone' storing configuration in
> > + * '.gitmodules' but it turns out it can be useful as a centralized point to
> > + * read the gitmodules config file.
> 
> I'm all for what you're trying to accomplish in this patch series but I
> think a little more care needs to be taken here.  Maybe about a year ago
> I did some refactoring with how the gitmodules file was loaded and it
> was decided that allowing arbitrary configuration in the .gitmodules
> file was a bad thing, so I tried to make sure that it was very difficult
> to sneak in more of that and limiting it to the places where it was
> already done (fetch and update_clone).  Now this patch is explicitly
> changing the comment on this function to loosen the requirements I made
> when it was introduced, which could be problematic in the future.
>

Yes, it was a little inconsiderate of me, sorry.

> So here's what I suggest doing:
>   1. Move this function from config.{c,h} to submodule-config.{c,h} to
>      make it clear who owns this.
>   2. Move the gitmodules_set function you created to live in submodule-config.
>   3. You can still use this function as the main driver for reading the
>      submodule config BUT the comment above the function in both the .c and
>      .h files should be adapted so that it is clearly spells out that the
>      function is to be used only by the submodule config code (reading it
>      in repo_read_gitmodules and reading/writing it in the
>      submodule-helper config function you've added) and that the only
>      exceptions to this are to maintain backwards compatibility with the
>      existing callers and that new callers shouldn't be added.
>

I fully agree, I am going to send a new RFC soon.

> This is just a long way to say that if new callers to this function are
> added in the future that it is made very clear in the code that the
> .gitmodules file exists for a specific purpose and that it shouldn't be
> exploited to ship config with a repository. (If we end up allowing
> config to be shipped with a repository at a later date that will need to
> be handled with great care due to security concerns).
>

Got it.

> Thanks for working on this, the end result is definitely a step in the
> direction I've wanted the submodule config to head to.
>

Thank you for the review.

Ciao,
   Antonio

> >   *
> >   * Runs the provided config function on the '.gitmodules' file found in the
> >   * working directory.
> >   */
> > -void config_from_gitmodules(config_fn_t fn, void *data)
> > +void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
> >  {
> > -	if (the_repository->worktree) {
> > -		char *file = repo_worktree_path(the_repository, GITMODULES_FILE);
> > +	if (repo->worktree) {
> > +		char *file = repo_worktree_path(repo, GITMODULES_FILE);
> >  		git_config_from_file(fn, file, data);
> >  		free(file);
> >  	}
> > diff --git a/config.h b/config.h
> > index cdac2fc73..43ce76c0f 100644
> > --- a/config.h
> > +++ b/config.h
> > @@ -215,15 +215,7 @@ extern int repo_config_get_maybe_bool(struct repository *repo,
> >  extern int repo_config_get_pathname(struct repository *repo,
> >  				    const char *key, const char **dest);
> >  
> > -/*
> > - * Note: This function exists solely to maintain backward compatibility with
> > - * 'fetch' and 'update_clone' storing configuration in '.gitmodules' and should
> > - * NOT be used anywhere else.
> > - *
> > - * Runs the provided config function on the '.gitmodules' file found in the
> > - * working directory.
> > - */
> > -extern void config_from_gitmodules(config_fn_t fn, void *data);
> > +extern void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data);
> >  
> >  extern int git_config_get_value(const char *key, const char **value);
> >  extern const struct string_list *git_config_get_value_multi(const char *key);
> > diff --git a/submodule-config.c b/submodule-config.c
> > index d87c3ff63..f39c71dfb 100644
> > --- a/submodule-config.c
> > +++ b/submodule-config.c
> > @@ -577,19 +577,11 @@ void repo_read_gitmodules(struct repository *repo)
> >  {
> >  	submodule_cache_check_init(repo);
> >  
> > -	if (repo->worktree) {
> > -		char *gitmodules;
> > -
> > -		if (repo_read_index(repo) < 0)
> > -			return;
> > -
> > -		gitmodules = repo_worktree_path(repo, GITMODULES_FILE);
> > -
> > -		if (!is_gitmodules_unmerged(repo->index))
> > -			git_config_from_file(gitmodules_cb, gitmodules, repo);
> > +	if (repo_read_index(repo) < 0)
> > +		return;
> >  
> > -		free(gitmodules);
> > -	}
> > +	if (!is_gitmodules_unmerged(repo->index))
> > +		config_from_gitmodules(gitmodules_cb, repo, repo);
> >  
> >  	repo->submodule_cache->gitmodules_read = 1;
> >  }
> > -- 
> > 2.17.0
> > 
> 
> -- 
> Brandon Williams


-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
