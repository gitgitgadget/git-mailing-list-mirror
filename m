Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C4CC433E0
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 04:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086B422B48
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 04:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sAqoG8qy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgG3ER0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 00:17:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55023 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3ER0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 00:17:26 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CFE4C836C1;
        Thu, 30 Jul 2020 00:17:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jRrPsrok4INf9j5+P3KR40Sr//I=; b=sAqoG8
        qyqqKSjl7FshPQGI1+L2TBk20hfrtg5Ww2ZR9YT0pufDtmhL8YS1KHhZ525XQ2EZ
        php1GR8qnNhpjyNVHIf6xc7RofClcaMOeNW8zwTkI6ijuQ0la0YZQFHwUNKmXDl/
        nPJ78QS5gwscMWjzOFosfQjen4vZPDRWJnsjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kc/Gy1QtMdmGw5OvkjmYwqUk0lksMCpE
        ghuOMg0yotT82wN+gn6Ri5XFAF4nW+MLsu8vVnjk/PBLHp5VGKxHKLoLhmX8/N3T
        J2cOofsboKjJGAe4y+sLXiUowbqqHsWyBsCbyoBkQf+wN7n0gdAVPY2QHu6ufR6s
        nAW/knJofao=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B825E836C0;
        Thu, 30 Jul 2020 00:17:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3547B836BF;
        Thu, 30 Jul 2020 00:17:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] bisect: introduce first-parent flag
References: <pull.686.git.1595951056.gitgitgadget@gmail.com>
        <20200730002735.87655-1-alipman88@gmail.com>
        <20200730002735.87655-3-alipman88@gmail.com>
Date:   Wed, 29 Jul 2020 21:17:21 -0700
In-Reply-To: <20200730002735.87655-3-alipman88@gmail.com> (Aaron Lipman's
        message of "Wed, 29 Jul 2020 20:27:34 -0400")
Message-ID: <xmqqv9i57i26.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90BA9E3C-D21B-11EA-9A87-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Lipman <alipman88@gmail.com> writes:

> diff --git a/bisect.c b/bisect.c
> index a11fdb1473..b495a19192 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -460,6 +460,7 @@ static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
>  static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
>  static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
>  static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
> +static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
>  static GIT_PATH_FUNC(git_path_head_name, "head-name")

This is not a new issue, but duplication of the above and the same
set of PATH_FUNC in builtin/bisect-helper.c looks ugly.  We may want
to do something about it after this topic is done.

> @@ -981,6 +982,12 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
>  	fclose(fp);
>  }
>  
> +int read_first_parent_option(void)

"static int", no?  I do not think we need to be able to call this
from anywhere outside this file.

> +{
> +	const char *filename = git_path_bisect_first_parent();
> +	return !access(filename, F_OK);
> +}
> +
>  /*
>   * We use the convention that return BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND (-10) means
>   * the bisection process finished successfully.
> @@ -997,7 +1004,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
>  	enum bisect_error res = BISECT_OK;
>  	struct object_id *bisect_rev;
>  	char *steps_msg;
> -	int first_parent_only = 0; /* TODO: pass --first-parent flag from git bisect start */
> +	int first_parent_only = read_first_parent_option();
>  
>  	read_bisect_terms(&term_bad, &term_good);
>  	if (read_bisect_refs())
> @@ -1141,6 +1148,7 @@ int bisect_clean_state(void)
>  	unlink_or_warn(git_path_bisect_names());
>  	unlink_or_warn(git_path_bisect_run());
>  	unlink_or_warn(git_path_bisect_terms());
> +	unlink_or_warn(git_path_bisect_first_parent());
>  	/* Cleanup head-name if it got left by an old version of git-bisect */
>  	unlink_or_warn(git_path_head_name());
>  	/*
> diff --git a/bisect.h b/bisect.h
> index a63af0505f..8ee80f5b48 100644
> --- a/bisect.h
> +++ b/bisect.h
> @@ -66,6 +66,8 @@ int estimate_bisect_steps(int all);
>  
>  void read_bisect_terms(const char **bad, const char **good);
>  
> +int read_first_parent_option(void);
> +

So this won't be needed, right?

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index ec4996282e..1236f5df1d 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -422,7 +423,7 @@ static int bisect_append_log_quoted(const char **argv)
>  }
>  
>  static int bisect_start(struct bisect_terms *terms, int no_checkout,
> -			const char **argv, int argc)
> +			int first_parent_only, const char **argv, int argc)

Why do we need to pass this new parameter from cmd_bisect__helper(),
when we are going to parse it out of argv/argc outselves anyway?

I suspect that you would ask the same question to whoever added
no_checkout to this thing, and I wouldn't be surprised if we end up
removing both of these parameters (and parsing of the options inside
cmd_bisect__helper()) after thinking about them, but anyway, let's
read on.

> +# We want to automatically find the merge that
> +# introduced "line" into hello.

'introduced'?  

> +test_expect_success \
> +    '"git bisect run --first-parent" simple case' \

Let's not revert back to ancient line-folding style.  The next test
you can see in the postimage, i.e.

	test_expect_success 'title in single quote' '
		the first command &&
		the second command &&
		...
		the last command
	'

is what we want to mimic.

> +    'echo "#"\!"/bin/sh" > test_script.sh &&
> +     echo "grep line hello > /dev/null" >> test_script.sh &&
> +     echo "test \$? -ne 0" >> test_script.sh &&
> +     chmod +x test_script.sh &&

So, we want to say "bad" if $? is 0, i.e. the file 'hello' has a
string "line" in it and "good" if $? is not 0, i.e. the file 'hello'
does not have such a line?

A few things:

 - Use "write_script" to abstract away platform-specific details
   such as which $SHELL_PATH to use on "#!" line, and "chmod +x".

 - There is no SP between a redirection operator and its target
   file.

i.e. Ssomething like this instead of the above four lines:

	write_script test_script.sh <<-\EOF
	! grep line hello >/dev/null
	EOF

> +     git bisect start --first-parent &&
> +     test_path_is_file ".git/BISECT_FIRST_PARENT" &&
> +     git bisect good $HASH4 &&
> +     git bisect bad $B_HASH &&
> +     git bisect run ./test_script.sh > my_bisect_log.txt &&

Style: no SP between '>' and its target file.

> +     grep "$B_HASH is the first bad commit" my_bisect_log.txt &&
> +     git bisect reset &&
> +     test_path_is_missing ".git/BISECT_FIRST_PARENT"'

The final blame must lie on a commit on the first-parent chain,
which this test tries to ensure, but I wonder if it is also required
that all commits offered to be tested by "git bisect" are on the
first-parent chain, and if so, shouldn't we be make sure each and
every time "test_script" is run, the commit that is at HEAD is on
the first parent chain between the initial good..bad range?

>  test_expect_success 'good merge bases when good and bad are siblings' '
>  	git bisect start "$B_HASH" "$A_HASH" > my_bisect_log.txt &&
>  	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&

Other than that, overall this seems to be going in the right
direction.

Thanks.
