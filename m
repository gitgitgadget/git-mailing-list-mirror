Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468DAE92FD4
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 02:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjJFCmn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 22:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjJFCmm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 22:42:42 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21516D6
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 19:42:41 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7688020751;
        Thu,  5 Oct 2023 22:42:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=r0AUsoTlarxLkTv4rQ3xc4o8robLvjwHKLziw9
        8vgH8=; b=FPVwK2dSu2XgyS+CG6B0ZVYSn7wWsELkYuQ2FwF+o9tJWJiBjP0Lq6
        8mDu1fcrARvqH5iqxjwh8PhQOIYjn1r3AlIXu0jmTw8hL9p9Og6mKo1URqb6EOOg
        aVmc/hTZLPxlz7l9XQ005a9ReLkc7nVk7o5zQfFe0itpDa7T8+0qg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6DB3220750;
        Thu,  5 Oct 2023 22:42:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0648F2074E;
        Thu,  5 Oct 2023 22:42:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joanna Wang <jojwang@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] Allow attr magic for git-add, git-stash.
In-Reply-To: <20231005232423.1834298-1-jojwang@google.com> (Joanna Wang's
        message of "Thu, 5 Oct 2023 23:23:28 +0000")
References: <20231005232423.1834298-1-jojwang@google.com>
Date:   Thu, 05 Oct 2023 19:42:26 -0700
Message-ID: <xmqqedi8bhf1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD252D10-63F1-11EE-A5D7-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joanna Wang <jojwang@google.com> writes:

> This lets users limit added/stashed files or exclude files based on file
> attributes. For example, the chromium project would like to use
> this like "git add --all ':(exclude,attr:submodule)'", as submodules
> are managed in a unique way and often results in submodule changes
> that users do not want in their commits.
> ...

Everything else before the following line was written quite well
(perhaps except for the commit title on the Subject: header).  Very
pleasant to see in the first iteration of a new contributor.

> Any bugs this may trigger will be fixed in follow-up patches.

This is rather a poor statement to make, as it hints that there are
known breakages this change will reveal that you are not telling us,
although I suspect that it is not the case.

But in case there are such existing-but-not-revealed bugs, the above
is not how the world works around here.  Instead, any existing code
whose bug has been hidden behind the GUARD_PATHSPEC() and known to
be revealed with this change should be fixed with N preliminary
clean-up patches, and then finally this patch would become the last
[N+1/N+1] step of such a N+1 patch series.

If no bugs are known to be revealed by applying this code change,
then we should just drop the above comment.  It is common to see a
patch that changes behaviour without intending to break anything has
unintended and unfortunate side effects, and we cannot really avoid
it.  The fallouts from such a change will be fixed after they are
discovered, and that is not something we need or want to repeat at
the end of every commit message ;-)

> I have tested this thoroughly with different flags, non-root directories,
> and other magic pathspecs, but may be unaware of some edge cases.

These are good things to add to the new test this patch adds.  Your
one time testing will not protect the current code that works for
these undocumented cases from future breakages, but when made into
a part of the test suite, it will.

> diff --git a/builtin/add.c b/builtin/add.c
> index c27254a5cd..ef0b8d55fd 100644
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
> @@ -504,7 +504,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  			       PATHSPEC_LITERAL |
>  			       PATHSPEC_GLOB |
>  			       PATHSPEC_ICASE |
> -			       PATHSPEC_EXCLUDE);
> +			       PATHSPEC_EXCLUDE |
> +			       PATHSPEC_ATTR);

Both hunks look quite as expected.  Looking good.

> diff --git a/dir.c b/dir.c
> index 8486e4d56f..55c9607b1a 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2173,13 +2173,7 @@ static int exclude_matches_pathspec(const char *path, int pathlen,
>  	if (!pathspec || !pathspec->nr)
>  		return 0;
>  
> -	GUARD_PATHSPEC(pathspec,
> -		       PATHSPEC_FROMTOP |
> -		       PATHSPEC_MAXDEPTH |
> -		       PATHSPEC_LITERAL |
> -		       PATHSPEC_GLOB |
> -		       PATHSPEC_ICASE |
> -		       PATHSPEC_EXCLUDE);
> +	GUARD_PATHSPEC(pathspec, PATHSPEC_ALL_MAGIC);

Hmph, is it a good idea in general to use ALL_MAGIC in guard?  The
programmer who wrote this not just promises that everything in the
current set of PATHSPEC_FOO bits are supported in this codepath
right now, but also says any *new* PATHSPEC_FOO magic will be
automatically supported.  How does the updated code guarantee it?

> @@ -239,14 +253,18 @@ test_expect_success 'fail on multiple attr specifiers in one pathspec item' '
>  	test_i18ngrep "Only one" actual
>  '
>  
> -test_expect_success 'fail if attr magic is used places not implemented' '
> -	# The main purpose of this test is to check that we actually fail
> -	# when you attempt to use attr magic in commands that do not implement
> -	# attr magic. This test does not advocate git-add to stay that way,
> -	# though, but git-add is convenient as it has its own internal pathspec
> -	# parsing.
> -	test_must_fail git add ":(attr:labelB)" 2>actual &&
> -	test_i18ngrep "magic not supported" actual

As the comment says, this test is primarily about making sure that
parse_pathspec() that limits the allowed pathspec magic and
GUARD_PATHSPEC() that forbids certain magic are working as expected.

It is strongly preferrable, instead of butchering this test that
guards these two mechanisms from being broken, to find a command
that still has some restriction on the magic it allows, and use it
to make sure they still trigger and give "magic not supported" error
message.  IOW, do not remove the above test, but find something
other than "add" that is suitable to still follow the original
intention of the test.

It is, of course, very much welcome to add a new test below to
protect the new feature.  IIRC, "add --all" and "add -u" used
somewhat different codepaths to find and update the changed paths.

Don't we need a test each for both new paths (which "--all" is about
and these two new files created in the test are) and also tracked
paths (which "-u" would try to enumerate and update the index with)?
For that matter, wouldn't "add . ':(exclude)...'" be also something
we need to check?  Or do these three all use pretty-much the same
codepath under the hood?

> +test_expect_success 'check that attr magic works for git-add' '
> +	# attr magic was previously blocked for git-add. With attr magic
> +	# enabled for git-add, add a basic test to make sure it works as
> +	# expected and add more tests if more bugs are discovered.

These three lines are unwanted.

"was X, now Y" and "do Z now" may belong to the log message where
previous state and new state are captured in the commit.  But not in
the tracked contents.  6 months down the road, when reading t6135 in
order to further polish the tests, nobody cares if "add" did not
support the attr magic in the past.  The title of the test already
says the test is about attr magic used in pathspec fed to "git add",
so "add a basic test" is unnecessary to say.

> +	cat <<-\EOF >expect &&
> +	sub/newFileA-foo
> +	EOF
> +	touch sub/newFileA-foo &&
> +	touch sub/newFileB-foo &&

Unless it matters that these files have recent timestamps, do not
use "touch", merely to ensure presence of a file.  We often use a
simple redirection

	>sub/newFileA-foo &&

for such purpose (I thought we had it somewhere in the coding
guidelines document, but if not, we should add it).

> +	git add --all ":(exclude,attr:labelB)" &&
> +	git diff --name-only --cached >actual &&
> +	test_cmp expect actual
>  '

So we have two new paths (I do not offhand know if there are
existing paths that are already tracked), and one is with label and
the other is without.  We tell "add" to grab all paths except for
the paths with the label and see that we do not see the one with the
label.  OK.

Thanks.
