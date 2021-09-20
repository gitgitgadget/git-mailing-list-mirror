Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8205DC433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 16:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6921B615A7
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 16:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245379AbhITQ4P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 12:56:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50529 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245513AbhITQy0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 12:54:26 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3EA06147607;
        Mon, 20 Sep 2021 12:52:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PVP7H2ZZLk+yvwKZbkglkcd1WDSjUaG/amus59
        B9kjo=; b=PTlPf0zEv8YpReyGuAJwtc3ulHFiHnCpc9waxa+epomEudbu3iggch
        udtpPYWJWPep6UsAqFtvt35Hm3Fh3LQAwkLMF2MVXCP4Z7dtxy1a1/zqSo10sqLc
        vV+CvrfdYhNRCnbhe1BaHg1OHcQanv0Qx2ST8k3RsYm7C444M+F24=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D3CC147606;
        Mon, 20 Sep 2021 12:52:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8AFAC147603;
        Mon, 20 Sep 2021 12:52:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, jrnieder@gmail.com,
        kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: Re: [PATCH v2 2/8] submodule--helper: get remote names from any
 repository
References: <20210907115932.36068-1-raykar.ath@gmail.com>
        <20210916103241.62376-1-raykar.ath@gmail.com>
        <20210916103241.62376-3-raykar.ath@gmail.com>
Date:   Mon, 20 Sep 2021 09:52:54 -0700
In-Reply-To: <20210916103241.62376-3-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Thu, 16 Sep 2021 16:02:35 +0530")
Message-ID: <xmqqr1djchp5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33C585AA-1A33-11EC-B7EC-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> `get_default_remote()` retrieves the name of a remote by resolving the
> refs from of the current repository's ref store.
>
> Thus in order to use it for retrieving the remote name of a submodule,
> we have to start a new subprocess which runs from the submodule
> directory.
>
> Let's instead introduce a function called `repo_get_default_remote()`
> which takes any repository object and retrieves the remote accordingly.
>
> `get_default_remote()` is then defined as a call to
> `repo_get_default_remote()` with 'the_repository' passed to it.
>
> Now that we have `repo_get_default_remote()`, we no longer have to start
> a subprocess that called `submodule--helper get-default-remote` from
> within the submodule directory.
>
> So let's make a function called `get_default_remote_submodule()` which
> takes a submodule path, and returns the default remote for that
> submodule, all within the same process.
>
> We can now use this function to save an unnecessary subprocess spawn in
> `sync_submodule()`, and also in the next patch, which will require this
> functionality.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> ---
>  builtin/submodule--helper.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)

The above covers a lot of stuff, because this change does a lot of
things ;-)

The commit could be split into 3 logically distinct phases (two
independent, the third depends on the other two):

 - extract the part that uses the run-command() API to run
   "submodule--helper print-default-remote" from sync_submodule()
   and create get_default_remote_submodule() function out of it.

 - move bulk of get_default_remote() into repo_get_default_remote()
   and reimplement the former as a thin wrapper of the latter.

 - using the repo_get_default_remote() created in the second step,
   update the get_default_remote_submodule() created in the first
   step to work in-process without a subprocess.

but a bit larger granularity used here is probably OK.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 97512ccf0b..f6c4fc349b 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -29,11 +29,10 @@
>  typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
>  				  void *cb_data);
>  
> -static char *get_default_remote(void)
> +static char *repo_get_default_remote(struct repository *repo, const char *refname)
>  {
>  	char *dest = NULL, *ret;
>  	struct strbuf sb = STRBUF_INIT;
> -	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
>  
>  	if (!refname)
>  		die(_("No such ref: %s"), "HEAD");
> @@ -46,7 +45,7 @@ static char *get_default_remote(void)
>  		die(_("Expecting a full ref name, got %s"), refname);
>  
>  	strbuf_addf(&sb, "branch.%s.remote", refname);
> -	if (git_config_get_string(sb.buf, &dest))
> +	if (repo_config_get_string(repo, sb.buf, &dest))
>  		ret = xstrdup("origin");
>  	else
>  		ret = dest;
> @@ -55,6 +54,25 @@ static char *get_default_remote(void)
>  	return ret;
>  }
>  
> +static char *get_default_remote_submodule(const char *module_path)
> +{
> +	const char *refname;
> +	const struct submodule *sub;
> +	struct repository subrepo;
> +
> +	refname = refs_resolve_ref_unsafe(get_submodule_ref_store(module_path),
> +					  "HEAD", 0, NULL, NULL);
> +	sub = submodule_from_path(the_repository, null_oid(), module_path);
> +	repo_submodule_init(&subrepo, the_repository, sub);
> +	return repo_get_default_remote(&subrepo, refname);
> +}
> +
> +static char *get_default_remote(void)
> +{
> +	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
> +	return repo_get_default_remote(the_repository, refname);
> +}
> +
>  static int print_default_remote(int argc, const char **argv, const char *prefix)
>  {
>  	char *remote;
> @@ -1369,7 +1387,6 @@ static void sync_submodule(const char *path, const char *prefix,
>  	char *remote_key = NULL;
>  	char *sub_origin_url, *super_config_url, *displaypath;
>  	struct strbuf sb = STRBUF_INIT;
> -	struct child_process cp = CHILD_PROCESS_INIT;
>  	char *sub_config_path = NULL;
>  
>  	if (!is_submodule_active(the_repository, path))
> @@ -1418,14 +1435,9 @@ static void sync_submodule(const char *path, const char *prefix,
>  	if (!is_submodule_populated_gently(path, NULL))
>  		goto cleanup;
>  
> -	prepare_submodule_repo_env(&cp.env_array);
> -	cp.git_cmd = 1;
> -	cp.dir = path;
> -	strvec_pushl(&cp.args, "submodule--helper",
> -		     "print-default-remote", NULL);
> -
>  	strbuf_reset(&sb);
> -	if (capture_command(&cp, &sb, 0))
> +	strbuf_addstr(&sb, get_default_remote_submodule(path));
> +	if (!sb.buf)
>  		die(_("failed to get the default remote for submodule '%s'"),
>  		      path);

There is this line after the post context presented here:

        strbuf_strip_suffix(&sb, "\n");
        remote_key = xstrfmt("remote.%s.url", sb.buf);

The LF was expected to come from the capture_command(), but it no
longer is needed after get_default_remote_submodule() switches to
use the in-process method.  In fact, the use of sb for the purpose
of forming remote_key is not needed.

    tmp = get_default_remote_submodule(path);
    if (!tmp)
	die(_("failed to get..."));
    remote_key = xstrfmt("remote.%s.url", tmp);
    free(tmp);

Yes, I think the new code leaks, and makes it impossible not to
leak, the returned value from get_default_remote_submodule() by
passing the call as an argument to strbuf_addstr().

Both of the two bugs pointed out here would have been easier to spot
if the commits were smaller, I would think, but as I said, a bit
larger granularity used here was still manageable.

Thanks.
