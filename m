Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C504D1F97E
	for <e@80x24.org>; Mon, 20 Aug 2018 21:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeHUAzT (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 20:55:19 -0400
Received: from ao2.it ([92.243.12.208]:52647 "EHLO ao2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbeHUAzS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 20:55:18 -0400
Received: from localhost ([::1] helo=jcn.localdomain)
        by ao2.it with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ao2@ao2.it>)
        id 1frrqQ-0006iE-3A; Mon, 20 Aug 2018 23:36:14 +0200
Date:   Mon, 20 Aug 2018 23:37:55 +0200
From:   Antonio Ospite <ao2@ao2.it>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Daniel =?ISO-8859-1?Q?Gra=F1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 7/7] submodule: support reading .gitmodules even when
 it's not checked out
Message-Id: <20180820233755.dc7b6a6927faccc37b25075f@ao2.it>
In-Reply-To: <xmqqmutoznwe.fsf@gitster-ct.c.googlers.com>
References: <20180814110525.17801-1-ao2@ao2.it>
        <20180814110525.17801-8-ao2@ao2.it>
        <xmqqmutoznwe.fsf@gitster-ct.c.googlers.com>
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

On Tue, 14 Aug 2018 13:36:17 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> Antonio Ospite <ao2@ao2.it> writes:
> 
> >  	/* Equivalent to ACTION_SET in builtin/config.c */
> > -	if (argc == 3)
> > +	if (argc == 3) {
> > +		struct object_id oid;
> > +
> > +		/*
> > +		 * If the .gitmodules file is not in the working tree but it
> > +		 * is in the current branch, stop, as writing new values (and
> > +		 * staging them) would blindly overwrite ALL the old content.
> 
> Hmph, "the file is missing" certainly is a condition we would want
> to notice, but wouldn't we in general want to prevent us from
> overwriting any local modification, where "missing" is merely a very
> special case of local modification?  I am wondering if we would want
> to stop if .gitmodules file exists both in the working tree and in
> the index, and the contents of them differ, or something like that.
>

TTBOMK checking the index status (with something like
is_staging_gitmodules_ok()) when the .gitmodules file *exists* in the
working tree would break calling "git submodule add" multiple times
before committing the changes.

> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index ff258e2e8c..b1cb187227 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -159,6 +159,13 @@ cmd_add()
> >  		shift
> >  	done
> >  
> > +	# For more details about this check, see
> > +	# builtin/submodule--helper.c::module_config()
> > +	if test ! -e .gitmodules && git cat-file -e HEAD:.gitmodules > /dev/null 2>&1
> 
> No SP between redirection '>' and its target '/dev/null'.
>
> More importantly, I think it is better to add a submodule--helper
> subcommand that exposes the check in question, as the code is
> already written ;-) That approach will guarantee that the logic and
> the message stay the same between here and in the C code.  Then you
> do not even need these two line comment.
>

Yeah I anticipated this concern in the patch annotation, but I was
hoping that it would be OK to have this as a followup change.

I guess I can do it for v4 instead.

Does the interface suggested in the patch annotation sound acceptable?

To recap:

  - add an is_gitmodules_safely_writeable() helper;
  - expose a "submodule--helper config --is-safely-writeable"
    subcommand for git-submodule.sh to use.

[...]
> > @@ -603,8 +604,19 @@ static void submodule_cache_check_init(struct repository *repo)
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
> > +		else if (get_oid(GITMODULES_HEAD, &oid) >= 0)
> > +			config_source.blob = GITMODULES_HEAD;
> 
> What is the reason why we fall back directly to HEAD when working
> tree file does not exist?  I thought that our usual fallback was to
> the version in the index for other things like .gitignore/attribute
> and this codepath look like an oddball.  Are you trying to handle
> the case where we are in a bare repository without any file checked
> out (and there is not even the index)?
>

My use case is about *reading* .gitmodules when it's ignored in a sparse
checkout, in this scenario there are usually no staged changes
to .gitmodules, so I basically just didn't care about the index.

Would using ":.gitmodules" instead of "HEAD:.gitmodules" be enough?

By reading man  gitrevisions(7) and after a quick test with "git
cat-file blob :.gitmodules" it looks like this would be more in line
with your suggestion, still covering my use case.

If so, what name should I use instead of GITMODULES_HEAD?
GITMODULES_BLOB is already taken for something different, maybe
GITMODULES_REF or GITMODULES_OBJECT?

> > diff --git a/t/t7416-submodule-sparse-gitmodules.sh b/t/t7416-submodule-sparse-gitmodules.sh
> > new file mode 100755
> > index 0000000000..5341e9b012
> > --- /dev/null
> > +++ b/t/t7416-submodule-sparse-gitmodules.sh
> > @@ -0,0 +1,90 @@
> > +#!/bin/sh
> > +#
> > +# Copyright (C) 2018  Antonio Ospite <ao2@ao2.it>
> > +#
> > +
> > +test_description='Test reading/writing .gitmodules when not in the working tree
> > +
> > +This test verifies that, when .gitmodules is in the current branch but is not
> > +in the working tree reading from it still works but writing to it does not.
> > +
> > +The test setup uses a sparse checkout, however the same scenario can be set up
> > +also by committing .gitmodules and then just removing it from the filesystem.
> > +'
> > +
> > +. ./test-lib.sh
> > +
> > +test_expect_success 'sparse checkout setup which hides .gitmodules' '
> > +	echo file > file &&
> 
> No SP between redirection '>' and its target 'file'.
> 
> > +	git add file &&
> > +	test_tick &&
> > +	git commit -m upstream &&
> > +	git clone . super &&
> > +	git clone super submodule &&
> > +	git clone super new_submodule &&
> > +	(cd super &&
> > +		git submodule add ../submodule &&
> > +		test_tick &&
> > +		git commit -m submodule &&
> > +		cat >.git/info/sparse-checkout <<\EOF &&
> > +/*
> > +!/.gitmodules
> > +EOF
> 
> You can use <<-\EOF and indent the body of the here-doc, which makes
> the result easier to read, i.e.
> 
> 		cat >target <<-\EOF &&
> 		line 1
> 		line 2
> 		EOF
> 
> > +		git config core.sparsecheckout true &&
> > +		git read-tree -m -u HEAD &&
> 
> That's old fashioned---I am curious if this has to be one-way merge
> or can just be a usual "git checkout" (I am merely curious; not
> suggesting to change anything).
>

It was just how I learned to set up a sparse checkout, if there is a
better way I'd be happy to use it.

> > +		test_path_is_missing .gitmodules
> > +	)
> > +'
> > +
> > +test_expect_success 'reading gitmodules config file when it is not checked out' '
> > +	(cd super &&
> > +		echo "../submodule" >expected &&
> > +		git submodule--helper config submodule.submodule.url >actual &&
> > +		test_cmp expected actual
> 
> A minor style thing, but I thought that it was more common in our
> tests to call the expected output 'expect' (which has the same
> number of letters as 'actual') than 'expected'.
> 

Will fix.

> More importantly, do we want a subshell, or is something like this
> sufficient?
> 
> 	echo "../submodule" >expected &&
> 	git -C super submodule--helper config ... >actual &&
> 	test_cmp expect actual
> 
> The same comment applies to many tests I see below (omitted).
> 

I'll keep the subshell when there are multiple git commands ran in the
same sub directory, and remove it in tests which have only one git
command per test (which is most of them), how does that sound?

Thanks,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
