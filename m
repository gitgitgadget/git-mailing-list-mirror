Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B9DB1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 10:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeIXQV4 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 24 Sep 2018 12:21:56 -0400
Received: from ao2.it ([92.243.12.208]:58788 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbeIXQV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 12:21:56 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g4NwQ-0008Bb-EG; Mon, 24 Sep 2018 12:18:10 +0200
Date:   Mon, 24 Sep 2018 12:20:31 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v5 9/9] submodule: support reading .gitmodules when it's
 not in the working tree
Message-Id: <20180924122031.9dbec6b4c2e2a8c1bff3365b@ao2.it>
In-Reply-To: <20180918171257.GC27036@localhost>
References: <20180917140940.3839-1-ao2@ao2.it>
        <20180917140940.3839-10-ao2@ao2.it>
        <20180918171257.GC27036@localhost>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 18 Sep 2018 19:12:57 +0200
SZEDER Gábor <szeder.dev@gmail.com> wrote:

[...]
> On Mon, Sep 17, 2018 at 04:09:40PM +0200, Antonio Ospite wrote:
> > When the .gitmodules file is not available in the working tree, try
> > using the content from the index and from the current branch.
> 
> "from the index and from the current branch" of which repository?
>

I took a look, some comments below.

> > diff --git a/submodule-config.c b/submodule-config.c
> > index 61a555e920..bdb1d0e2c9 100644
> > --- a/submodule-config.c
> > +++ b/submodule-config.c
> 
> > @@ -603,8 +604,21 @@ static void submodule_cache_check_init(struct repository *repo)
> >  static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
> >  {
[...]
> > +		file = repo_worktree_path(repo, GITMODULES_FILE);
> > +		if (file_exists(file))
> > +			config_source.file = file;
> > +		else if (get_oid(GITMODULES_INDEX, &oid) >= 0)
> > +			config_source.blob = GITMODULES_INDEX;
> > +		else if (get_oid(GITMODULES_HEAD, &oid) >= 0)
> > +			config_source.blob = GITMODULES_HEAD;
> > +
> 
> The repository used in t7814 contains nested submodules, which means
> that config_from_gitmodules() is invoked three times.
> 
> Now, the first two of those calls look at the superproject and at
> 'submodule', and find the existing files '.../trash
> directory.t7814-grep-recurse-submodules/.gitmodules' and '.../trash
> directory.t7814-grep-recurse-submodules/submodule/.gitmodules',
> respectively.  So far so good.
> 
> The third call, however, looks at the nested submodule at
> 'submodule/sub', which doesn't contain a '.gitmodules' file.  So this
> function goes on with the second condition and calls
> get_oid(GITMODULES_INDEX, &oid), which then appears to find the blob
> in the _superproject's_ index.
>

You are correct.

This is a limitation of the object store in git, there is no equivalent
of get_oid() to get the oid from a specific repository and this affects
config_with_options too when the config source is a blob.

This does not affect commands called via "git -C submodule_dir cmd"
because in that case the chdir happens before the_repository is set up,
for instance "git-submodule $SOMETHING --recursive" commands seem to
change the working directory before the recursion.

> > +		config_with_options(fn, data, &config_source, &opts);
> > +
> >  		free(file);
> >  	}
> >  }
> I'm no expert on submodules, but my gut feeling says that this can't
> be right.  But if it _is_ right, then I would say that the commit
> message should explain in detail, why it is right.
> 

I agree it isn't right, I didn't consider the case of nested
submodules, but even if I did the current git design does not
allow to correctly solve the problem: "read config from blob of an
arbitrary repository".

So what to do for the time being?

The issue is there but in a "normal" scenario it is not causing any real
harm because:

  1. currently it is exposed "only" by git grep and nested submodules.

  2. the new mechanism works fine when reading the submodule config for
     the root repository.

  3. the new mechanism does not "usually" impact non-leaf nested
     submodules, because the .gitmodules file is "normally" there.

  4. git grep never *uses* the GITMODULES_INDEX erroneously read
     from the root project when scanning the _leaf_ nested submodule
     because there are no further submodules down the line, the
     following check fails in builtin/grep.c:

       if (recurse_submodules && S_ISGITLINK(entry.mode) ...
       ...

In fact, because of 4. the test suite passes even if the gitmodule
config is not correct for the leaf submodule.

Actually 4. makes me think that the repo_read_gitmodules() call in
builtin/grep.c might not be strictly necessary, its purpose seems to be
to *anticipate* reading the config of *child* submodules while still
processing the *current* submodule, the config for the *current*
submodule was already read from the superproject by the immediately
preceding repo_submodule_init(), via:

  repo_submodule_init()
    submodule_from_path()
      gitmodules_read_check()
        repo_read_gitmodules()

And this would happen anyway also for child submodules down the
recursion path if we removed repo_read_gitmodules() in builtin/grep.c,
the operation would be not protected by grep_read_lock() tho.

The test suite passes even after removing repo_read_gitmodules()
entirely from builtin/grep.c, but I am still not confident that I get
all the implication of why that call was originally added in commit
f9ee2fcdfa (grep: recurse in-process using 'struct repository',
2017-08-02).

Anyways, even if we removed the call we would prevent the problem from
happening in the test suite, but not in the real world, in case non-leaf
submodules without .gitmodules in their working tree.

To recap:
  - patch 9/9 exposes a problem with the object store but for now it's
    only a potential problem in the future case that someone wanted to
    use *nested* submodules without .gitmodules in the working tree.
  - the new code should not affect current users which
    assume .gitmodules to be in the working tree for nested submodules;
  - even if we removed the call to repo_read_gitmodules() call in
    builtin/grep.c we would not avoid the problem entirely, just avoid
    it for the the _leaf_ submodules in case of nested submodules.

Selfishly, I'd propose to still merge the changes (I can send a v6 with
the locking fix in) and I'll write a test_expect_failure snippet to
document the problem Gábor spotted so we remember about it and fix it
when the object store can be accessed per-repository.

I am afraid I cannot look into the core issue about the object store in
my free time, however if someone wanted to sponsor some time I might
consider taking a stab at it.

Ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
