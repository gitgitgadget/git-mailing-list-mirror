From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCHv2 5/8] fetching submodules: Respect `submodule.jobs`
 config option
Date: Thu, 29 Oct 2015 22:17:12 -0400
Message-ID: <CAPig+cS5yCzcz6xNyaMLTBFUzPqmbbE8x2_toFxAvXELcc786A@mail.gmail.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
	<1446074504-6014-1-git-send-email-sbeller@google.com>
	<1446074504-6014-6-git-send-email-sbeller@google.com>
Reply-To: Eric Sunshine <sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 03:17:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrzFm-0000Gy-47
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 03:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755607AbbJ3CRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 22:17:14 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:34551 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbbJ3CRN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 22:17:13 -0400
Received: by vkgs66 with SMTP id s66so39206644vkg.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 19:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=aFg6hp81vOGhl5VzpclqivvKNpPS9AkNzprZH38Kbxk=;
        b=Unbm6Bl77kMov0j14j2i0nCCZ6r9den1En0+Du4mf27uaMonNSk/1GXaDGfwKB1M8S
         JLLlLIS5R7D4SDV8S2Ju55w9M9Is99PR5Lyh99raa/vGgC3fABUp4llv4HxZiEFoKjMA
         moqFOpFLB+JOFtoSJhLQcFKpt/srFEy7CCtwmFLxF2aAUfIrv44mVTqXMbjRNcAdQOHh
         r/vv2psWnaRUfhydSjcRnvO0w0b4f7nEZt/nCwF0V2yWr27Iiun99qHfvfEM7VIhMKLD
         UOL/uzRDE7zhDwEm5fKLn9XyxNA344OzhdE6DMvIFSSaA7AXBwJivWFNGF9jxD5jass0
         hy7g==
X-Received: by 10.31.131.141 with SMTP id f135mr3792309vkd.37.1446171432301;
 Thu, 29 Oct 2015 19:17:12 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Thu, 29 Oct 2015 19:17:12 -0700 (PDT)
In-Reply-To: <1446074504-6014-6-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280475>

On Wed, Oct 28, 2015 at 7:21 PM, Stefan Beller <sbeller@google.com> wrote:
> This allows to configure fetching and updating in parallel
> without having the command line option.
>
> This moved the responsibility to determine how many parallel processes
> to start from builtin/fetch to submodule.c as we need a way to communicate
> "The user did not specify the number of parallel processes in the command
> line options" in the builtin fetch. The submodule code takes care of
> the precedence (CLI > config > default)
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 391a0c3..785721a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2643,6 +2643,13 @@ submodule.<name>.ignore::
>         "--ignore-submodules" option. The 'git submodule' commands are not
>         affected by this setting.
>
> +submodule.jobs::
> +       This is used to determine how many submodules can be operated on in
> +       parallel. Specifying a positive integer allows up to that number
> +       of submodules being fetched in parallel. This is used in fetch
> +       and clone operations only. A value of 0 will give some reasonable
> +       default. The defaults may change with different versions of Git.

I'm not sure that "default" is the correct word here. When you talk
about a "default", you're normally explaining what happens when the
configuration is not provided. (In fact, the default number of jobs is
1, which you may want to document here).

>  tag.sort::
>         This variable controls the sort ordering of tags when displayed by
>         linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
> diff --git a/submodule-config.c b/submodule-config.c
> index 1cea404..07bdcdf 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -32,6 +32,7 @@ enum lookup_type {
>
>  static struct submodule_cache cache;
>  static int is_cache_init;
> +static int parallel_jobs = -1;
>
>  static int config_path_cmp(const struct submodule_entry *a,
>                            const struct submodule_entry *b,
> @@ -235,6 +236,9 @@ static int parse_generic_submodule_config(const char *var,
>                                           const char *key,
>                                           const char *value)
>  {
> +       if (!strcmp(key, "jobs")) {
> +               parallel_jobs = strtol(value, NULL, 10);
> +       }

Style: unnecessary braces

Why does this allow a negative value? The documentation doesn't
mention anything about it.

>         return 0;
>  }
>
> diff --git a/submodule.c b/submodule.c
> index 0257ea3..188ba02 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -752,6 +752,11 @@ int fetch_populated_submodules(const struct argv_array *options,
>         argv_array_push(&spf.args, "--recurse-submodules-default");
>         /* default value, "--submodule-prefix" and its value are added later */
>
> +       if (max_parallel_jobs < 0)
> +               max_parallel_jobs = config_parallel_submodules();
> +       if (max_parallel_jobs < 0)
> +               max_parallel_jobs = 1;

run_process_parallel() itself specially handles max_parallel_jobs==0,
so you don't need to consider it here. Okay.

> +
>         calculate_changed_submodule_paths();
>         run_processes_parallel(max_parallel_jobs,
>                                get_next_submodule,
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 1b4ce69..5c3579c 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -470,4 +470,18 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
>         test_i18ncmp expect.err actual.err
>  '
>
> +test_expect_success 'fetching submodules respects parallel settings' '
> +       git config fetch.recurseSubmodules true &&
> +       (
> +               cd downstream &&
> +               GIT_TRACE=$(pwd)/trace.out git fetch --jobs 7 &&
> +               grep "7 children" trace.out &&
> +               git config submodule.jobs 8 &&
> +               GIT_TRACE=$(pwd)/trace.out git fetch &&
> +               grep "8 children" trace.out &&
> +               GIT_TRACE=$(pwd)/trace.out git fetch --jobs 9 &&
> +               grep "9 children" trace.out
> +       )
> +'

Not specifically related to this test, but maybe add tests to check
cases when --jobs is not specified, and --jobs=1?

> +
>  test_done
> --
> 2.5.0.281.g4ed9cdb
>
