Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B661C2AD
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Greylist: delayed 465 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Nov 2023 08:39:14 PDT
Received: from mrbrklyn.com (www2.mrbrklyn.com [96.57.23.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CB91BD
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 08:39:14 -0700 (PDT)
Received: by mrbrklyn.com (Postfix, from userid 1000)
	id 7E9B31640CD; Fri,  3 Nov 2023 11:31:28 -0400 (EDT)
Date: Fri, 3 Nov 2023 11:31:28 -0400
From: Ruben Safir <ruben@mrbrklyn.com>
To: Joanna Wang <jojwang@google.com>
Cc: gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH 1/1] attr: enable attr pathspec magic for git-add and
 git-stash
Message-ID: <20231103153128.GA8857@www2.mrbrklyn.com>
References: <xmqq34xnlny7.fsf@gitster.g>
 <20231103143508.896745-1-jojwang@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231103143508.896745-1-jojwang@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

Is that really you name or is it a bad joke?


On Fri, Nov 03, 2023 at 02:35:07PM +0000, Joanna Wang wrote:
> This lets users limit files or exclude files based on file
> attributes during git-add and git-stash.
> For example, the chromium project would like to use this like
> "git add --all ':(exclude,attr:submodule)'", as submodules are managed in a
> unique way and often results in submodule changes that users do not want in
> their commits.
> 
> This does not change any attr magic implementation. It is only adding
> attr as an allowed pathspec in git-add and git-stash, which was previously
> blocked by GUARD_PATHSPEC and a pathspec mask in parse_pathspec()).
> However, this does fix a bug in prefix_magic() where attr values were unintentionally removed.
> This was hit whenever parse_pathspec() is called with PATHSPEC_PREFIX_ORIGIN as a flag,
> which was the case for git-stash.
> (But originally filed here:
> https://lore.kernel.org/git/CAMmZTi-0QKtj7Q=sbC5qhipGsQxJFOY-Qkk1jfkRYwfF5FcUVg@mail.gmail.com/)
> 
> Furthermore, while other commands hit this code path it did not result in unexpected
> behavior because this bug only impacts the pathspec->items->original field which is
> NOT used to filter paths. However, git-stash does use pathspec->items->original when
> building args used to call other git commands.
> (See add_pathspecs() usage and implementation in stash.c)
> 
> It is possible that when the attr pathspec feature was first added in
> b0db704652 (pathspec: allow querying for attributes, 2017-03-13),
> "PATHSPEC_ATTR" was just unintentionally left out of a few GUARD_PATHSPEC() invocations.
> 
> Later, to get a more user-friendly error message when attr was used with git-add,
> PATHSPEC_ATTR was added as a mask to git-add's invocation of parse_pathspec()
> 84d938b732 (add: do not accept pathspec magic 'attr', 2018-09-18).
> However, this user-friendly error message was never added for git-stash.
> 
> Signed-off-by: Joanna Wang <jojwang@google.com>
> 
> ---
> 
> > At this point in the code, is it guaranteed that element[0] is ':'
> > and never a NUL?  Also is it guaranteed that element has ')'
> > somewhere later if element[1] is '('?
> No sorry, we can only assume this if there was element magic detected
> by parse_element_magic(). So if element magic is not 0, we know the body
> is in the expected form (either long or short).
> I have added comments and a check for magic to guard against this.
> 
> >  I wonder if this existing bug caused by
> > failing to copy the value of "attr:" is triggerable from a codepath
> > that already allows PATHSPEC_ATTR magic.
> While there are other commands that go through the prefix_magic path (like `git-add -i`),
> AFAICT they are not actually impacted by the bug. The bug only impacts the value of
> pathspec->items->original which is not used during pathspec matching. But git-stash
> uses `original` to pass in as args to other commands it calls. I've included this
> detail in the description above.
> 
> > but as the third parameter strbuf_add() takes is of type size_t, it would not
> > hurt to define "len" as the same type as well.
> Thanks for spotting. fixed.
> 
>  builtin/add.c                  |   7 ++-
>  dir.c                          |   3 +-
>  pathspec.c                     |  36 ++++++++---
>  t/t6135-pathspec-with-attrs.sh | 108 +++++++++++++++++++++++++++++++--
>  4 files changed, 136 insertions(+), 18 deletions(-)
> 
> diff --git a/builtin/add.c b/builtin/add.c
> index 5126d2ede3..d46e4d10e9 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -424,7 +424,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  	 * Check the "pathspec '%s' did not match any files" block
>  	 * below before enabling new magic.
>  	 */
> -	parse_pathspec(&pathspec, PATHSPEC_ATTR,
> +	parse_pathspec(&pathspec, 0,
>  		       PATHSPEC_PREFER_FULL |
>  		       PATHSPEC_SYMLINK_LEADING_PATH,
>  		       prefix, argv);
> @@ -433,7 +433,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		if (pathspec.nr)
>  			die(_("'%s' and pathspec arguments cannot be used together"), "--pathspec-from-file");
>  
> -		parse_pathspec_file(&pathspec, PATHSPEC_ATTR,
> +		parse_pathspec_file(&pathspec, 0,
>  				    PATHSPEC_PREFER_FULL |
>  				    PATHSPEC_SYMLINK_LEADING_PATH,
>  				    prefix, pathspec_from_file, pathspec_file_nul);
> @@ -504,7 +504,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  			       PATHSPEC_LITERAL |
>  			       PATHSPEC_GLOB |
>  			       PATHSPEC_ICASE |
> -			       PATHSPEC_EXCLUDE);
> +			       PATHSPEC_EXCLUDE |
> +			       PATHSPEC_ATTR);
>  
>  		for (i = 0; i < pathspec.nr; i++) {
>  			const char *path = pathspec.items[i].match;
> diff --git a/dir.c b/dir.c
> index 16fdb03f2a..4d1cd039be 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2179,7 +2179,8 @@ static int exclude_matches_pathspec(const char *path, int pathlen,
>  		       PATHSPEC_LITERAL |
>  		       PATHSPEC_GLOB |
>  		       PATHSPEC_ICASE |
> -		       PATHSPEC_EXCLUDE);
> +		       PATHSPEC_EXCLUDE |
> +		       PATHSPEC_ATTR);
>  
>  	for (i = 0; i < pathspec->nr; i++) {
>  		const struct pathspec_item *item = &pathspec->items[i];
> diff --git a/pathspec.c b/pathspec.c
> index bb1efe1f39..2f8721cc15 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -109,16 +109,34 @@ static struct pathspec_magic {
>  	{ PATHSPEC_ATTR,    '\0', "attr" },
>  };
>  
> -static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic)
> +static void prefix_magic(struct strbuf *sb, int prefixlen, unsigned magic, const char *element)
>  {
> -	int i;
> -	strbuf_addstr(sb, ":(");
> -	for (i = 0; i < ARRAY_SIZE(pathspec_magic); i++)
> -		if (magic & pathspec_magic[i].bit) {
> -			if (sb->buf[sb->len - 1] != '(')
> -				strbuf_addch(sb, ',');
> -			strbuf_addstr(sb, pathspec_magic[i].name);
> +	/* No magic was found in element, just add prefix magic */
> +	if (magic == 0) {
> +		strbuf_addf(sb, ":(prefix:%d)", prefixlen);
> +		return;
> +	}
> +
> +	/*
> +	 * At this point we known that parse_element_magic() was able to extract some pathspec
> +	 * magic from element. So we know element is correctly formatted in either shorthand
> +	 * or longhand form
> +	 */
> +	if (element[1] != '(') {
> +		/* Process an element in shorthand form (e.g. ":!/<match>") */
> +		strbuf_addstr(sb, ":(");
> +		for (int i = 0; i < ARRAY_SIZE(pathspec_magic); i++) {
> +			if ((magic & pathspec_magic[i].bit) && (pathspec_magic[i].mnemonic != '\0')) {
> +				if (sb->buf[sb->len - 1] != '(')
> +					strbuf_addch(sb, ',');
> +				strbuf_addstr(sb, pathspec_magic[i].name);
> +			}
>  		}
> +	} else {
> +		/* For the longhand form, we copy everything up to the final ')' */
> +		size_t len = strchr(element, ')') - element;
> +		strbuf_add(sb, element, len);
> +	}
>  	strbuf_addf(sb, ",prefix:%d)", prefixlen);
>  }
>  
> @@ -493,7 +511,7 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
>  		struct strbuf sb = STRBUF_INIT;
>  
>  		/* Preserve the actual prefix length of each pattern */
> -		prefix_magic(&sb, prefixlen, element_magic);
> +		prefix_magic(&sb, prefixlen, element_magic, elt);
>  
>  		strbuf_addstr(&sb, match);
>  		item->original = strbuf_detach(&sb, NULL);
> diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
> index f70c395e75..e46fa176ed 100755
> --- a/t/t6135-pathspec-with-attrs.sh
> +++ b/t/t6135-pathspec-with-attrs.sh
> @@ -64,12 +64,24 @@ test_expect_success 'setup .gitattributes' '
>  	fileSetLabel label
>  	fileValue label=foo
>  	fileWrongLabel label☺
> +	newFileA* labelA
> +	newFileB* labelB
>  	EOF
>  	echo fileSetLabel label1 >sub/.gitattributes &&
>  	git add .gitattributes sub/.gitattributes &&
>  	git commit -m "add attributes"
>  '
>  
> +test_expect_success 'setup .gitignore' '
> +	cat <<-\EOF >.gitignore &&
> +	actual
> +	expect
> +	pathspec_file
> +	EOF
> +	git add .gitignore &&
> +	git commit -m "add gitignore"
> +'
> +
>  test_expect_success 'check specific set attr' '
>  	cat <<-\EOF >expect &&
>  	fileSetLabel
> @@ -150,6 +162,7 @@ test_expect_success 'check specific value attr (2)' '
>  test_expect_success 'check unspecified attr' '
>  	cat <<-\EOF >expect &&
>  	.gitattributes
> +	.gitignore
>  	fileA
>  	fileAB
>  	fileAC
> @@ -175,6 +188,7 @@ test_expect_success 'check unspecified attr' '
>  test_expect_success 'check unspecified attr (2)' '
>  	cat <<-\EOF >expect &&
>  	HEAD:.gitattributes
> +	HEAD:.gitignore
>  	HEAD:fileA
>  	HEAD:fileAB
>  	HEAD:fileAC
> @@ -200,6 +214,7 @@ test_expect_success 'check unspecified attr (2)' '
>  test_expect_success 'check multiple unspecified attr' '
>  	cat <<-\EOF >expect &&
>  	.gitattributes
> +	.gitignore
>  	fileC
>  	fileNoLabel
>  	fileWrongLabel
> @@ -239,16 +254,99 @@ test_expect_success 'fail on multiple attr specifiers in one pathspec item' '
>  	test_i18ngrep "Only one" actual
>  '
>  
> -test_expect_success 'fail if attr magic is used places not implemented' '
> +test_expect_success 'fail if attr magic is used in places not implemented' '
>  	# The main purpose of this test is to check that we actually fail
>  	# when you attempt to use attr magic in commands that do not implement
> -	# attr magic. This test does not advocate git-add to stay that way,
> -	# though, but git-add is convenient as it has its own internal pathspec
> -	# parsing.
> -	test_must_fail git add ":(attr:labelB)" 2>actual &&
> +	# attr magic. This test does not advocate check-ignore to stay that way.
> +	# When you teach the command to grok the pathspec, you need to find
> +	# another command to replace it for the test.
> +	test_must_fail git check-ignore ":(attr:labelB)" 2>actual &&
>  	test_i18ngrep "magic not supported" actual
>  '
>  
> +test_expect_success 'check that attr magic works for git stash push' '
> +	cat <<-\EOF >expect &&
> +	A	sub/newFileA-foo
> +	EOF
> +	>sub/newFileA-foo &&
> +	>sub/newFileB-foo &&
> +	git stash push --include-untracked -- ":(exclude,attr:labelB)" &&
> +	git stash show --include-untracked --name-status >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'check that attr magic works for git add --all' '
> +	cat <<-\EOF >expect &&
> +	sub/newFileA-foo
> +	EOF
> +	>sub/newFileA-foo &&
> +	>sub/newFileB-foo &&
> +	git add --all ":(exclude,attr:labelB)" &&
> +	git diff --name-only --cached >actual &&
> +	git restore -W -S . &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'check that attr magic works for git add -u' '
> +	cat <<-\EOF >expect &&
> +	sub/fileA
> +	EOF
> +	>sub/newFileA-foo &&
> +	>sub/newFileB-foo &&
> +	>sub/fileA &&
> +	>sub/fileB &&
> +	git add -u ":(exclude,attr:labelB)" &&
> +	git diff --name-only --cached  >actual &&
> +	git restore -S -W . && rm sub/new* &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'check that attr magic works for git add <path>' '
> +	cat <<-\EOF >expect &&
> +	fileA
> +	fileB
> +	sub/fileA
> +	EOF
> +	>fileA &&
> +	>fileB &&
> +	>sub/fileA &&
> +	>sub/fileB &&
> +	git add ":(exclude,attr:labelB)sub/*" &&
> +	git diff --name-only --cached >actual &&
> +	git restore -S -W . &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'check that attr magic works for git -add .' '
> +	cat <<-\EOF >expect &&
> +	sub/fileA
> +	EOF
> +	>fileA &&
> +	>fileB &&
> +	>sub/fileA &&
> +	>sub/fileB &&
> +	cd sub &&
> +	git add . ":(exclude,attr:labelB)" &&
> +	cd .. &&
> +	git diff --name-only --cached >actual &&
> +	git restore -S -W . &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'check that attr magic works for git add --pathspec-from-file' '
> +	cat <<-\EOF >pathspec_file &&
> +	:(exclude,attr:labelB)
> +	EOF
> +	cat <<-\EOF >expect &&
> +	sub/newFileA-foo
> +	EOF
> +	>sub/newFileA-foo &&
> +	>sub/newFileB-foo &&
> +	git add --all --pathspec-from-file=pathspec_file &&
> +	git diff --name-only --cached >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'abort on giving invalid label on the command line' '
>  	test_must_fail git ls-files . ":(attr:☺)"
>  '
> -- 
> 2.42.0.869.gea05f2083d-goog
> 

-- 
So many immigrant groups have swept through our town
that Brooklyn, like Atlantis, reaches mythological
proportions in the mind of the world - RI Safir 1998
http://www.mrbrklyn.com 

DRM is THEFT - We are the STAKEHOLDERS - RI Safir 2002
http://www.nylxs.com - Leadership Development in Free Software
http://www2.mrbrklyn.com/resources - Unpublished Archive 
http://www.coinhangout.com - coins!
http://www.brooklyn-living.com 

Being so tracked is for FARM ANIMALS and extermination camps, 
but incompatible with living as a free human being. -RI Safir 2013

