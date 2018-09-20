Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FFE11F453
	for <e@80x24.org>; Thu, 20 Sep 2018 15:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732528AbeITVT7 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 20 Sep 2018 17:19:59 -0400
Received: from ao2.it ([92.243.12.208]:54808 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731225AbeITVT7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Sep 2018 17:19:59 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1g30xT-0003Hu-Sa; Thu, 20 Sep 2018 17:33:35 +0200
Date:   Thu, 20 Sep 2018 17:35:52 +0200
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
Message-Id: <20180920173552.6109014827a062dcf3821632@ao2.it>
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

> Hi Antonio,
> 
> it appears that this patch (and its previous versions as well) is
> responsible for triggering occasional test failures in
> 't7814-grep-recurse-submodules.sh', more frequently, about once in
> every ten runs, on macOS on Travis CI, less frequently, about once in
> a couple of hundred runs on Linux on my machine.
>

Thanks a lot for testing Gábor, it's really appreciated.

> The reason for the failure is memory corruption manifesting in various
> ways: segfault, malloc() or use after free() errors from libc, corrupt
> loose object, invalid ref, bogus output, etc.
> 
> Applying the following patch makes t7814 fail almost every time,
> though sometimes that loop has to iterate over 1000 times until that
> 'git grep' finally fails...  so good luck with debugging ;)
[...]

I managed to capture some traces of the segfaults using this variation:

diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 7184113b9b..56e87c3f8a 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -337,6 +337,10 @@ test_expect_success 'grep --recurse-submodules should pass the pattern type alon
        test_must_fail git -c grep.patternType=fixed grep --recurse-submodules -e "(.|.)[\d]" &&

        # Basic
+       for i in $(test_seq 0 2000)
+       do
+               debug --debugger="gdb --silent -ex run -ex quit --return-child-result --args" git grep --recurse-submodules 1 >/dev/null || return 1
+       done &&
        git grep -G --recurse-submodules -e "(.|.)[\d]" >actual &&
        cat >expect <<-\EOF &&
        a:(1|2)d(3|4)


Running t7814 with --run="1,6,22" is enough to observe the issue.

FWICS these corruptions are caused by concurrent accesses to the object
store.

The issue is caused by these facts:
  1. git grep uses threads;
  2. git grep reads submodules config with repo_read_gitmodules;
  3. repo_read_gitmodules calls config_from_gitmodules
  4. the changes in patch 9 in this series make config_from_gitmodules
     use the object store, which apparently is not mt-safe, while the
     previous use of git_config_from_file() was.

> On first look I didn't notice anything that is obviously wrong in this
> patch and could be responsible for the memory corruption, but there is
> one thing I found strange, though:
> 
> 
> On Mon, Sep 17, 2018 at 04:09:40PM +0200, Antonio Ospite wrote:
> > When the .gitmodules file is not available in the working tree, try
> > using the content from the index and from the current branch.
> 
> "from the index and from the current branch" of which repository?
> 
[...]

> > diff --git a/submodule-config.c b/submodule-config.c
> > index 61a555e920..bdb1d0e2c9 100644
> > --- a/submodule-config.c
> > +++ b/submodule-config.c
> 
> > @@ -603,8 +604,21 @@ static void submodule_cache_check_init(struct repository *repo)
> >  static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
> >  {
> >  	if (repo->worktree) {
> > -		char *file = repo_worktree_path(repo, GITMODULES_FILE);
> > -		git_config_from_file(fn, file, data);
> > +		struct git_config_source config_source = { 0 };
> > +		const struct config_options opts = { 0 };
> > +		struct object_id oid;
> > +		char *file;
> > +
> > +		file = repo_worktree_path(repo, GITMODULES_FILE);
> > +		if (file_exists(file))
> > +			config_source.file = file;
> > +		else if (get_oid(GITMODULES_INDEX, &oid) >= 0)
> > +			config_source.blob = GITMODULES_INDEX;
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
> I'm no expert on submodules, but my gut feeling says that this can't
> be right.  But if it _is_ right, then I would say that the commit
> message should explain in detail, why it is right.
>

I'll think about that too.

> Anyway, even if it is indeed wrong, I'm not sure whether this is the
> root cause of the memory corruption.
> 

I think the immediate cause of the corruptions is multi-threading in
grep, I can prevent the issue from happening by using "git grep
--threads 1 ...".

Protecting the problematic submodules function could work for now, but
I'd like to have more comments, my proposal is:

diff --git a/builtin/grep.c b/builtin/grep.c
index 601f801158..52b45de749 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -427,6 +427,11 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
        if (repo_submodule_init(&submodule, superproject, path))
                return 0;

+       grep_read_lock();
+       /*
+        * NEEDSWORK: repo_read_gitmodules accesses the object store which is
+        * global, thus it needs to be protected.
+        */
        repo_read_gitmodules(&submodule);

        /*
@@ -439,7 +444,6 @@ static int grep_submodule(struct grep_opt *opt, struct repository *superproject,
         * store is no longer global and instead is a member of the repository
         * object.
         */
-       grep_read_lock();
        add_to_alternates_memory(submodule.objects->objectdir);
        grep_read_unlock();


The pre-existing NEEDSWORK comment there also suggests that these
problems with the object store are known. I was not aware of them.

With the change from above I could not reproduce the problem anymore,
this should be the only location where
repo_read_gitmodules/config_from_gitmodules is called in a thread.

Thanks you,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
