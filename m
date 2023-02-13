Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80CAC636D4
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 20:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjBMUmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 15:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBMUmv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 15:42:51 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B7919F2B
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 12:42:41 -0800 (PST)
Received: (qmail 22052 invoked by uid 109); 13 Feb 2023 20:42:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 13 Feb 2023 20:42:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25363 invoked by uid 111); 13 Feb 2023 20:42:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 13 Feb 2023 15:42:40 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 13 Feb 2023 15:42:40 -0500
From:   Jeff King <peff@peff.net>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>
Subject: Re: [RFC PATCH 6/6] add: reject nested repositories
Message-ID: <Y+qgwHx52DSAfsEb@coredump.intra.peff.net>
References: <20230213182134.2173280-1-calvinwan@google.com>
 <20230213182134.2173280-7-calvinwan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230213182134.2173280-7-calvinwan@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2023 at 06:21:34PM +0000, Calvin Wan wrote:

> As noted in 532139940c (add: warn when adding an embedded repository,
> 2017-06-14), adding embedded repositories results in subpar experience
> compared to submodules, due to the lack of a corresponding .gitmodules
> entry, which means later clones of the top-level repository cannot
> locate the embedded repo. We expect that this situation is usually
> unintentional, which is why 532139940c added a warning message and
> advice when users attempt to add an embedded repo.

As the author of 532139940c, this escalation to an error seems like a
reasonable step to me.

The patch looks pretty reasonable to me from a cursory read, but here a
few small comments:

> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index a030d33c6e..b7fb95b061 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -177,10 +177,11 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
>  	tree or not.
>  
>  --no-warn-embedded-repo::
> -	By default, `git add` will warn when adding an embedded
> +	By default, `git add` will error out when adding an embedded

The option name here is rather unfortunate, since it's no longer a
warning. But keeping it as-is for historical compatibility may be the
best option. In retrospect, I wish I'd called it --allow-embedded-repos
or something.

> diff --git a/builtin/add.c b/builtin/add.c
> index 76277df326..795d9251b9 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -421,36 +421,45 @@ static const char embedded_advice[] = N_(
>  "\n"
>  "	git rm --cached %s\n"
>  "\n"
> -"See \"git help submodule\" for more information."
> +"See \"git help submodule\" for more information.\n"
> +"\n"
> +"If you cannot use submodules, you may bypass this check with:\n"
> +"\n"
> +"	git add --no-warn-embedded-repo %s\n"
>  );

I was a little surprised by this hunk, but I guess if we are going to
block the user's operation from completing, we might want to tell them
how to get around it. But it seems odd to me that the instructions to
"git rm --cached" the submodule remain. If this situation is now an
error and not a warning, there is nothing to roll back from the index,
since we will have bailed before writing it.

If we are going to start recommending --no-warn-embedded-repo here,
would we want to promote it from being OPT_HIDDEN_BOOL()? We do document
it in the manpage, but just omit it from the "-h" output, since it
should be rarely used. Maybe it is OK to stay that way; you don't need
it until you run into this situation, at which point the advice
hopefully has guided you in the right direction.

> -static void check_embedded_repo(const char *path)
> +static int check_embedded_repo(const char *path)
>  {
> +	int ret = 0;
>  	struct strbuf name = STRBUF_INIT;
>  	static int adviced_on_embedded_repo = 0;
>  
>  	if (!warn_on_embedded_repo)
> -		return;
> +		goto cleanup;
>  	if (!ends_with(path, "/"))
> -		return;
> +		goto cleanup;
> +
> +	ret = 1;

I wondered about these "goto cleanup" calls here, since there is nothing
to clean up yet. But you are just piggy-backing on the "return ret",
rather than a separate "return 0" here.

And I was surprised by returning at all, since the point is to make this
a hard error. But it looks like the intent is to report an error for
every such case, and then a final die, like:

  $ git add .
  error: cannot add embedded git repository: foo
  advice: ...
  error: cannot add embedded git repository: bar
  fatal: refusing to add embedded git repositories

OK. I doubt anybody cares much either way (it is more convenient if you
have a lot of cases, at the expense of making the error more verbose
when there is only one case), so this is fine.

>  	/* Drop trailing slash for aesthetics */
>  	strbuf_addstr(&name, path);
>  	strbuf_strip_suffix(&name, "/");
>  
> -	warning(_("adding embedded git repository: %s"), name.buf);
> +	error(_("cannot add embedded git repository: %s"), name.buf);
>  	if (!adviced_on_embedded_repo &&
>  	    advice_enabled(ADVICE_ADD_EMBEDDED_REPO)) {
> -		advise(embedded_advice, name.buf, name.buf);
> +		advise(embedded_advice, name.buf, name.buf, name.buf);

This triple name.buf that must match the earlier string is horrible, of
course, but nothing new in your patch. If you drop the "rm --cached"
part from the advice, it can remain as a horrible double-mention of
name.buf. :)

> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index eae6a46ef3..e0bcecba6e 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -118,7 +118,7 @@ test_expect_success 'setup - repository in init subdirectory' '
>  test_expect_success 'setup - commit with gitlink' '
>  	echo a >a &&
>  	echo z >z &&
> -	git add a init z &&
> +	git add --no-warn-embedded-repo a init z &&
>  	git commit -m "super commit 1"
>  '
>  
> @@ -771,7 +771,7 @@ test_expect_success 'set up for relative path tests' '
>  			git init &&
>  			test_commit foo
>  		) &&
> -		git add sub &&
> +		git add --no-warn-embedded-repo sub &&
>  		git config -f .gitmodules submodule.sub.path sub &&
>  		git config -f .gitmodules submodule.sub.url ../subrepo &&
>  		cp .git/config pristine-.git-config &&

OK, these are cases that are warning now (because they are trying to do
something clever with the setup), but which will be blocked. Arguably
they should have --no-warn-embedded-repo already, but nobody cared
so far that their stderr was a little noisy.

I do wonder if there are any users who might do clever things like this
themselves, but they'd already have been nagged by the warning (and
hopefully discovered --no-warn-embedded-repo on their own).

-Peff
