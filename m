Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD196C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 20:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973DB60F6E
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 20:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhGZTVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 15:21:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65435 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhGZTVq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 15:21:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D1C9D0D99;
        Mon, 26 Jul 2021 16:02:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E8wb2DjQUPUXvD8Od4jw/IZX+6vISOJL6oFKac
        icrZw=; b=rmDadQK/ITMq+2XwjKK1fjh5EHSj0ExXEQrhgNl0X60vOIFgB4CHk4
        qWw+M6ZJnGg9Wytogbp3OJb+4ehNRT5xso8heejwpATW86YzMffg9cWDWOZoyXMM
        EOALkBIOINKe+DF4xK90TnfXdEo/WGa9+d9mEw4KH/rhIPCaYy2rc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85536D0D98;
        Mon, 26 Jul 2021 16:02:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6E00D0D97;
        Mon, 26 Jul 2021 16:02:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     andrzej@ahunt.org
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, newren@gmail.com
Subject: Re: [PATCH v2 04/12] builtin/for-each-repo: remove unnecessary argv
 copy to plug leak
References: <20210620151204.19260-1-andrzej@ahunt.org>
        <20210725130830.5145-1-andrzej@ahunt.org>
        <20210725130830.5145-5-andrzej@ahunt.org>
Date:   Mon, 26 Jul 2021 13:02:13 -0700
In-Reply-To: <20210725130830.5145-5-andrzej@ahunt.org> (andrzej@ahunt.org's
        message of "Sun, 25 Jul 2021 15:08:22 +0200")
Message-ID: <xmqqmtq8j12y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EB84EB8-EE4C-11EB-B774-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

andrzej@ahunt.org writes:

> From: Andrzej Hunt <ajrhunt@google.com>
>
> cmd_for_each_repo() copies argv into args (a strvec), which is later
> passed into run_command_on_repo(), which in turn copies that strvec onto
> the end of child.args. The initial copy is unnecessary (we never modify
> args). We therefore choose to just pass argv directly into
> run_command_on_repo(), which lets us avoid the copy and fixes the leak.

Makes sense.  There is no reason to make these copies.

>
> LSAN output from t0068:
>
> Direct leak of 192 byte(s) in 1 object(s) allocated from:
>     #0 0x7f63bd4ab8b0 in realloc (/usr/lib64/libasan.so.4+0xdc8b0)
>     #1 0x98d7e6 in xrealloc wrapper.c:126
>     #2 0x916914 in strvec_push_nodup strvec.c:19
>     #3 0x916a6e in strvec_push strvec.c:26
>     #4 0x4be4eb in cmd_for_each_repo builtin/for-each-repo.c:49
>     #5 0x410dcd in run_builtin git.c:475
>     #6 0x410dcd in handle_builtin git.c:729
>     #7 0x414087 in run_argv git.c:818
>     #8 0x414087 in cmd_main git.c:949
>     #9 0x40e9ec in main common-main.c:52
>     #10 0x7f63bc9fa349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> Indirect leak of 22 byte(s) in 2 object(s) allocated from:
>     #0 0x7f63bd445e30 in __interceptor_strdup (/usr/lib64/libasan.so.4+0x76e30)
>     #1 0x98d698 in xstrdup wrapper.c:29
>     #2 0x916a63 in strvec_push strvec.c:26
>     #3 0x4be4eb in cmd_for_each_repo builtin/for-each-repo.c:49
>     #4 0x410dcd in run_builtin git.c:475
>     #5 0x410dcd in handle_builtin git.c:729
>     #6 0x414087 in run_argv git.c:818
>     #7 0x414087 in cmd_main git.c:949
>     #8 0x40e9ec in main common-main.c:52
>     #9 0x7f63bc9fa349 in __libc_start_main (/lib64/libc.so.6+0x24349)
>
> See also discussion about the original implementation below - this code
> appears to have evolved from a callback explaining the double-strvec-copy
> pattern, but there's no strong reason to keep that now:
>   https://lore.kernel.org/git/68bbeca5-314b-08ee-ef36-040e3f3814e9@gmail.com/
>
> Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
> ---
>  builtin/for-each-repo.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
> index 52be64a437..fd86e5a861 100644
> --- a/builtin/for-each-repo.c
> +++ b/builtin/for-each-repo.c
> @@ -10,18 +10,16 @@ static const char * const for_each_repo_usage[] = {
>  	NULL
>  };
>  
> -static int run_command_on_repo(const char *path,
> -			       void *cbdata)
> +static int run_command_on_repo(const char *path, int argc, const char ** argv)
>  {
>  	int i;
>  	struct child_process child = CHILD_PROCESS_INIT;
> -	struct strvec *args = (struct strvec *)cbdata;
>  
>  	child.git_cmd = 1;
>  	strvec_pushl(&child.args, "-C", path, NULL);
>  
> -	for (i = 0; i < args->nr; i++)
> -		strvec_push(&child.args, args->v[i]);
> +	for (i = 0; i < argc; i++)
> +		strvec_push(&child.args, argv[i]);
>  
>  	return run_command(&child);
>  }
> @@ -31,7 +29,6 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
>  	static const char *config_key = NULL;
>  	int i, result = 0;
>  	const struct string_list *values;
> -	struct strvec args = STRVEC_INIT;
>  
>  	const struct option options[] = {
>  		OPT_STRING(0, "config", &config_key, N_("config"),
> @@ -45,9 +42,6 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
>  	if (!config_key)
>  		die(_("missing --config=<config>"));
>  
> -	for (i = 0; i < argc; i++)
> -		strvec_push(&args, argv[i]);
> -
>  	values = repo_config_get_value_multi(the_repository,
>  					     config_key);
>  
> @@ -59,7 +53,7 @@ int cmd_for_each_repo(int argc, const char **argv, const char *prefix)
>  		return 0;
>  
>  	for (i = 0; !result && i < values->nr; i++)
> -		result = run_command_on_repo(values->items[i].string, &args);
> +		result = run_command_on_repo(values->items[i].string, argc, argv);
>  
>  	return result;
>  }
