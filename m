Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A584AE95A60
	for <git@archiver.kernel.org>; Sat,  7 Oct 2023 10:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbjJGKKM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Oct 2023 06:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjJGKKK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2023 06:10:10 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFF792
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 03:10:08 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A67D1B4B97;
        Sat,  7 Oct 2023 06:10:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=TowwohQyywivJFgs65cmHLDTuoA144WAuX5U06
        qd6gc=; b=yB/q/GLQCured4FaC9Pgtdwy5+PHS6YkS2VKn3fW8vxjLsPL4i+qzT
        ZxYFMKNUWr+EpX27IXT4TmLUr17SVDkCU0UcBqvJWxMgR5vkWjD0jzQ3oXJBs+g/
        2OXFkpO5IqR2S/NJ/BpmUJdVE1ij6dccQEbltWa8wEVMOZKFFi62E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DEE51B4B96;
        Sat,  7 Oct 2023 06:10:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 753001B4B95;
        Sat,  7 Oct 2023 06:10:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joanna Wang <jojwang@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] add: Enable attr pathspec magic for git-add.
In-Reply-To: <20231007002811.2337315-1-jojwang@google.com> (Joanna Wang's
        message of "Sat, 7 Oct 2023 00:28:10 +0000")
References: <xmqqttr3adgg.fsf@gitster.g>
        <20231007002811.2337315-1-jojwang@google.com>
Date:   Sat, 07 Oct 2023 03:10:02 -0700
Message-ID: <xmqqbkda4ubp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AFDCD996-64F9-11EE-9702-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joanna Wang <jojwang@google.com> writes:

> Added 'add:' and specified it is 'patchpsec' magic, but lmk if i'm still missing something.

If you run

    $ git shortlog --no-merges v2.42.0..

or something on your branch to see how well its subject blends with
others, you'd start wanting to (1) downcase "Enable", and (2) omit
the full-stop after the title, to make it look similar to others.

> diff --git a/builtin/stash.c b/builtin/stash.c
> index 1ad496985a..9c77d3e4e4 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1760,7 +1760,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
>  		}
>  	}
>  
> -	parse_pathspec(&ps, 0, PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
> +	parse_pathspec(&ps, PATHSPEC_ATTR, PATHSPEC_PREFER_FULL | PATHSPEC_PREFIX_ORIGIN,
>  		       prefix, argv);

This becomes necessary because "stash" later goes through other
places this patch touches (e.g., dir.c::exclude_matches_pathspec()?)
that happened to be serving as a guard for another code "stash" has
that is not prepared to handle attribute magic?  Do you know what
exactly is not ready, so that perhaps others can help figuring out
how to make it ready for the attr magic?

> diff --git a/dir.c b/dir.c
> index 8486e4d56f..9bf9b53ca5 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2174,12 +2174,13 @@ static int exclude_matches_pathspec(const char *path, int pathlen,
>  		return 0;
>  
>  	GUARD_PATHSPEC(pathspec,
> -		       PATHSPEC_FROMTOP |
> -		       PATHSPEC_MAXDEPTH |
> -		       PATHSPEC_LITERAL |
> -		       PATHSPEC_GLOB |
> -		       PATHSPEC_ICASE |
> -		       PATHSPEC_EXCLUDE);
> +                       PATHSPEC_FROMTOP |
> +                       PATHSPEC_MAXDEPTH |
> +                       PATHSPEC_LITERAL |
> +                       PATHSPEC_GLOB |
> +                       PATHSPEC_ICASE |
> +                       PATHSPEC_EXCLUDE |
> +                       PATHSPEC_ATTR);

Why this reindent?

> @@ -239,16 +254,100 @@ test_expect_success 'fail on multiple attr specifie
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
> +	# attr magic. This test does not advocate stash push to stay that way.
> +	# When you teach the command to grok the pathspec, you need to find
> +	# another commnad to replace it for the test.

There is a typo here.  Please do not expect your reviewers to always
offer a perfect solution to your problem and blindly copy what they
fed you.  Instead, just like other project participants try to find
bugs and improvement opportunities in your patch, please lend them
sanity-checking eyeballs in return ;-)
