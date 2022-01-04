Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45AAC433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 02:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbiADCgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 21:36:48 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60870 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiADCgr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 21:36:47 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 605F31708CC;
        Mon,  3 Jan 2022 21:36:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=1pLqOtTjrAIr9PXkVV0QQwGiqt31EgLpe92vgjA47Qc=; b=nXhp
        gwNdv80SIfRkHNfExWoqcuYwNeYSHH5AN9dxP8jnUIUtEUtnNwyoWitjMYGyU+7S
        r6Byt/VKcr8RVr3yEyGzsKgrvu0nvmH53SX1k+FrjZosDmDRgrc/72283ObshmrU
        J/ofvjlcLcU81XFC049RbbSBOupuUqkF4eTCSuE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 588551708CB;
        Mon,  3 Jan 2022 21:36:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B3B391708C8;
        Mon,  3 Jan 2022 21:36:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 2/2] builtin/reflog.c: switch to use parse-options
 API for delete subcommand
References: <pull.1175.git.git.1640932151.gitgitgadget@gmail.com>
        <pull.1175.v2.git.git.1641223223.gitgitgadget@gmail.com>
        <f9de21e0f26fd8411ffee141ec67916b1440ad67.1641223223.git.gitgitgadget@gmail.com>
Date:   Mon, 03 Jan 2022 18:36:42 -0800
Message-ID: <xmqqfsq4fcqt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 278EB4D8-6D07-11EC-8221-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Address NEEDSWORK by switching out manual arg parsing for the
> parse-options API for the delete subcommand.
>
> Moves explicit_expiry flag into cmd_reflog_expire_cb struct so a
> callback can set both the value of the expiration as well as the
> explicit_expiry flag.
>
> Signed-off-by: "John Cai" <johncai86@gmail.com>
> ---
>  builtin/reflog.c | 168 ++++++++++++++++++++++++-----------------------
>  1 file changed, 87 insertions(+), 81 deletions(-)
>
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 175c83e7cc2..3552d749e4b 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -12,15 +12,6 @@
>  #include "reachable.h"
>  #include "worktree.h"
>  
> -/* NEEDSWORK: switch to using parse_options */
> -static const char reflog_expire_usage[] =
> -N_("git reflog expire [--expire=<time>] "
> -   "[--expire-unreachable=<time>] "
> -   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
> -   "[--verbose] [--all] <refs>...");
> -static const char reflog_delete_usage[] =
> -N_("git reflog delete [--rewrite] [--updateref] "
> -   "[--dry-run | -n] [--verbose] <refs>...");
>  static const char reflog_exists_usage[] =
>  N_("git reflog exists <ref>");
>  
> @@ -30,6 +21,7 @@ static timestamp_t default_reflog_expire_unreachable;
>  struct cmd_reflog_expire_cb {
>  	struct rev_info revs;
>  	int stalefix;
> +	int explicit_expiry;
>  	timestamp_t expire_total;
>  	timestamp_t expire_unreachable;
>  	int recno;
> @@ -504,18 +496,17 @@ static int reflog_expire_config(const char *var, const char *value, void *cb)
>  	return 0;
>  }
>  
> -static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, const char *ref)
> +static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, const char *ref)
>  {
>  	struct reflog_expire_cfg *ent;
> -
> -	if (slot == (EXPIRE_TOTAL|EXPIRE_UNREACH))
> +	if (cb->explicit_expiry == (EXPIRE_TOTAL|EXPIRE_UNREACH))
>  		return; /* both given explicitly -- nothing to tweak */
>  
>  	for (ent = reflog_expire_cfg; ent; ent = ent->next) {
>  		if (!wildmatch(ent->pattern, ref, 0)) {
> -			if (!(slot & EXPIRE_TOTAL))
> +			if (!(cb->explicit_expiry & EXPIRE_TOTAL))
>  				cb->expire_total = ent->expire_total;
> -			if (!(slot & EXPIRE_UNREACH))
> +			if (!(cb->explicit_expiry & EXPIRE_UNREACH))
>  				cb->expire_unreachable = ent->expire_unreachable;
>  			return;
>  		}
> @@ -525,27 +516,75 @@ static void set_reflog_expiry_param(struct cmd_reflog_expire_cb *cb, int slot, c
>  	 * If unconfigured, make stash never expire
>  	 */
>  	if (!strcmp(ref, "refs/stash")) {
> -		if (!(slot & EXPIRE_TOTAL))
> +		if (!(cb->explicit_expiry & EXPIRE_TOTAL))
>  			cb->expire_total = 0;
> -		if (!(slot & EXPIRE_UNREACH))
> +		if (!(cb->explicit_expiry & EXPIRE_UNREACH))
>  			cb->expire_unreachable = 0;
>  		return;
>  	}
>  
>  	/* Nothing matched -- use the default value */
> -	if (!(slot & EXPIRE_TOTAL))
> +	if (!(cb->explicit_expiry & EXPIRE_TOTAL))
>  		cb->expire_total = default_reflog_expire;
> -	if (!(slot & EXPIRE_UNREACH))
> +	if (!(cb->explicit_expiry & EXPIRE_UNREACH))
>  		cb->expire_unreachable = default_reflog_expire_unreachable;
>  }

OK.

> +static const char * reflog_expire_usage[] = {
> +	N_("git reflog expire [--expire=<time>] "
> +   "[--expire-unreachable=<time>] "
> +   "[--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] "
> +   "[--verbose] [--all] <refs>..."),
> +	NULL
> +};
> +
> +static int expire_unreachable_callback(const struct option *opt,
> +				 const char *arg,
> +				 int unset)
> +{
> +	struct cmd_reflog_expire_cb *cmd = opt->value;
> +	cmd->explicit_expiry |= EXPIRE_UNREACH;
> +	return parse_opt_expiry_date(&cmd->expire_unreachable, arg, unset);

Just as I suspected in the previous step.  Get rid of [1/2] and
add the new helper as a static function to this file.

The thing is that we shouldn't confuse future developers by adding a
random function that cannot be used as OPTION_CALLBACK function in
the parse-options-cb.c file.

> +	for (int i = 0; i < argc; i++) {

Documentation/CodingGuidelines:

 - Declaring a variable in the for loop "for (int i = 0; i < 10; i++)"
   is still not allowed in this codebase.

We have floated a weather balloon by adding a single use of this
construct so that when somebody finds a compiler that do not like
the construct it is easy to revert, and waiting for a feedback.  We
do not want to add the use of the construct to random places yet
that makes us scramble and revert them from all over the place.

>  		const char *spec = strstr(argv[i], "@{");
>  		char *ep, *ref;
>  		int recno;
