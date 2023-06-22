Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C0CEB64DC
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 21:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjFVVR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 17:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjFVVR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 17:17:26 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787F1F1
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 14:17:25 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EE2FE30B7D;
        Thu, 22 Jun 2023 17:17:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=we+ETGGErCXg5BeUfcwBV/l9rkGvnyRsbBG0vP
        0fhNw=; b=QirAsAijVBGx73I6Zr2jrFDk1/zagsquvy6J6BksPZtZ6gnd+DG7wj
        9ttClBkxbheRtMGPCovPlKhZA48xLPgOc5Wsya9oUgmd/tcYKmEQFZgJMMBgc9SO
        LdeN/2jjQ5l81+qHqWlMXR0f4RGA2EuWcsOIq0CuaDZIcUBNa/5CA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E67A930B7C;
        Thu, 22 Jun 2023 17:17:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0C00530B7B;
        Thu, 22 Jun 2023 17:17:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 2/3] var: add attributes files locations
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
        <20230622195059.320593-3-sandals@crustytoothpaste.net>
Date:   Thu, 22 Jun 2023 14:17:20 -0700
In-Reply-To: <20230622195059.320593-3-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 22 Jun 2023 19:50:58 +0000")
Message-ID: <xmqqcz1ndwnz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D4DF0E2-1142-11EE-998C-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> -static const char *git_etc_gitattributes(void)
> +const char *git_etc_gitattributes(void)
>  {
>  	static const char *system_wide;
>  	if (!system_wide)
> @@ -878,7 +878,7 @@ static const char *git_etc_gitattributes(void)
>  	return system_wide;
>  }
>  
> -static const char *get_home_gitattributes(void)
> +const char *get_home_gitattributes(void)
>  {
>  	if (!git_attributes_file)
>  		git_attributes_file = xdg_config_home("attributes");
> @@ -886,7 +886,7 @@ static const char *get_home_gitattributes(void)
>  	return git_attributes_file;
>  }

These are sensible, but ...

> -static int git_attr_system(void)
> +int git_attr_system(void)
>  {
>  	return !git_env_bool("GIT_ATTR_NOSYSTEM", 0);
>  }

... even though this is not exactly a new problem, but this function
is misnamed and exposing it outside the file is not exactly nice.
We would want to rename it to perhaps git_attr_use_system() or
something?  "allow" would also work as a verb there, but the point
is without any verb, it is easily confused with what the function
git_etc_git_attributes() wants to do.

side note: arguably the "etc-gitattributes" and "home-gitattributes"
are also suboptimal public names to give these functions, even
though they are fine as long as they are confined in a subsystem.
For global functions, it would be better to give name that match
what the end-users think of them, when possible.  The former would
be "git_attr_system()" and the latter would be "git_attr_global()".

>  struct git_var {
>  	const char *name;
>  	const char *(*read)(int);
> +	int free;
>  };
>  static struct git_var git_vars[] = {
> -	{ "GIT_COMMITTER_IDENT", git_committer_info },
> -	{ "GIT_AUTHOR_IDENT",   git_author_info },
> -	{ "GIT_EDITOR", editor },
> -	{ "GIT_SEQUENCE_EDITOR", sequence_editor },
> -	{ "GIT_PAGER", pager },
> -	{ "GIT_DEFAULT_BRANCH", default_branch },
> -	{ "GIT_SHELL_PATH", shell_path },
> +	{ "GIT_COMMITTER_IDENT", git_committer_info, 0 },
> +	{ "GIT_AUTHOR_IDENT",   git_author_info, 0 },
> +	{ "GIT_EDITOR", editor, 0 },
> +	{ "GIT_SEQUENCE_EDITOR", sequence_editor, 0 },
> +	{ "GIT_PAGER", pager, 0 },
> +	{ "GIT_DEFAULT_BRANCH", default_branch, 0 },
> +	{ "GIT_SHELL_PATH", shell_path, 0 },
> +	{ "GIT_ATTR_SYSTEM", git_attr_val_system, 1 },
> +	{ "GIT_ATTR_GLOBAL", git_attr_val_global, 1 },
>  	{ "", NULL },
>  };

I am not sure if the "free" (which stands for "allocated") is worth
adding here for such a single-use-and-then-exit command.  It is a
maintenance burden for anybody who adds new variables.

Either mark these values with UNLEAK(), or make the ones that do
not allocate xstrdup() so that they can be free'd blindly, would be
less unwieldy option, I guess.

> diff --git a/t/t0007-git-var.sh b/t/t0007-git-var.sh
> index 270bd4e512..6a2cc94abb 100755
> --- a/t/t0007-git-var.sh
> +++ b/t/t0007-git-var.sh
> @@ -159,6 +159,26 @@ test_expect_success MINGW 'GIT_SHELL_PATH points to a suitable shell' '
>  	grep "sh\$" shell
>  '
>  
> +test_expect_success 'GIT_ATTR_SYSTEM points to the correct location' '

I found it somewhat funny to claim we are checking that the variable
points to the "correct" location, while the test is happy as long as
it points at any path.

> +	test_must_fail env GIT_ATTR_NOSYSTEM=1 git var GIT_ATTR_SYSTEM &&
> +	(
> +		sane_unset GIT_ATTR_NOSYSTEM &&
> +		git var GIT_ATTR_SYSTEM >path &&
> +		test "$(cat path)" != ""
> +	)
> +'
> +
> +test_expect_success 'GIT_ATTR_GLOBAL points to the correct location' '
> +	TRASHDIR="$(test-tool path-utils normalize_path_copy "$(pwd)")" &&
> +	XDG_CONFIG_HOME="$TRASHDIR/.config" git var GIT_ATTR_GLOBAL >path &&
> +	test "$(cat path)" = "$TRASHDIR/.config/git/attributes" &&
> +	(
> +		sane_unset XDG_CONFIG_HOME &&
> +		HOME="$TRASHDIR" git var GIT_ATTR_GLOBAL >path &&
> +		test "$(cat path)" = "$TRASHDIR/.config/git/attributes"
> +	)
> +'

This one is much less funny ;-)  Very nice.
