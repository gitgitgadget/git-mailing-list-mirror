Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B00E2047F
	for <e@80x24.org>; Mon, 25 Sep 2017 03:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932854AbdIYDne (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 23:43:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50676 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752959AbdIYDnc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 23:43:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BFF99CBEB;
        Sun, 24 Sep 2017 23:43:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZX2F8vZQtfw6MsPm93vAkiCD1so=; b=Hg5x+B
        2HKygB+l004sBTWjI0kHbuAXb2UY3nYvPuKTMlc1aPCidbOmdg8eDUCb/EeBFTz7
        MNLna50smZMsQDxZfAyNa4aE84HCF5oC61Nn1fkAmsSuoE6iIi/wAOTiX78KBB1q
        u5uNMJ3am+Gj75do3GP04SJzS9fVoOWD/rSnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dwi8/Kj72JkRzHpiIACLIxRf4V/ewwlT
        uXFGlI5PEFIIYflK9yRn9+7OttXtfngYXFDik2TzEHinZ0wcOsGyhkfMW6lry2CZ
        ofwpz7KAtzpdWGshwgfqnbxlvqf/ckDnzPePa2AtyShkPcIestOznGKJEsAerW67
        LO71MazPMhM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 315D29CBE9;
        Sun, 24 Sep 2017 23:43:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D9AB9CBE8;
        Sun, 24 Sep 2017 23:43:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     hanwen@google.com, christian.couder@gmail.com, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH v5 2/4] submodule--helper: introduce for_each_listed_submodule()
References: <20170921161059.11750-1-hanwen@google.com>
        <20170924120858.26813-1-pc44800@gmail.com>
        <20170924120858.26813-3-pc44800@gmail.com>
Date:   Mon, 25 Sep 2017 12:43:30 +0900
In-Reply-To: <20170924120858.26813-3-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Sun, 24 Sep 2017 17:38:56 +0530")
Message-ID: <xmqqmv5jfnod.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B319B040-A1A3-11E7-B33F-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> Introduce function for_each_listed_submodule() and replace a loop
> in module_init() with a call to it.
>
> The new function will also be used in other parts of the
> system in later patches.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>  builtin/submodule--helper.c | 36 ++++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)

This looks more or less perfectly done, but I say this basing it on
an assumption that nobody ever would want to initialize a single
submodule without going through module_init() interface.

If there will be a caller that would have made a direct call to
init_submodule() if this patch did not exist, then I think this
patch is better done by keeping the external interface to the
init_submodule() function intact, and introducing an intermediate
helper init_submodule_cb() function that is to be used as the
callback used in for_each_listed_submodule() API.  In general, we
should make sure that these callback functions that take "void
*cb_data" parameters are called _only_ by these iterators that
defined the callback (in this case, for_each_listed_submodule())
and not other functions.

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index d24ac9028..d12790b5c 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -14,6 +14,9 @@
>  #include "refs.h"
>  #include "connect.h"
>  
> +typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
> +				  void *cb_data);
> +
>  static char *get_default_remote(void)
>  {
>  	char *dest = NULL, *ret;
> @@ -352,15 +355,30 @@ static int module_list(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> -static void init_submodule(const char *path, const char *prefix, int quiet)
> +static void for_each_listed_submodule(const struct module_list *list,
> +				      each_submodule_fn fn, void *cb_data)
> +{
> +	int i;
> +	for (i = 0; i < list->nr; i++)
> +		fn(list->entries[i], cb_data);
> +}
> +
> +struct init_cb {
> +	const char *prefix;
> +	unsigned int quiet: 1;
> +};
> +#define INIT_CB_INIT { NULL, 0 }
> +
> +static void init_submodule(const struct cache_entry *list_item, void *cb_data)
>  {
> +	struct init_cb *info = cb_data;
>  	const struct submodule *sub;
>  	struct strbuf sb = STRBUF_INIT;
>  	char *upd = NULL, *url = NULL, *displaypath;
>  
> -	displaypath = get_submodule_displaypath(path, prefix);
> +	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
>  
> -	sub = submodule_from_path(&null_oid, path);
> +	sub = submodule_from_path(&null_oid, list_item->name);
>  
>  	if (!sub)
>  		die(_("No url found for submodule path '%s' in .gitmodules"),
> @@ -372,7 +390,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>  	 *
>  	 * Set active flag for the submodule being initialized
>  	 */
> -	if (!is_submodule_active(the_repository, path)) {
> +	if (!is_submodule_active(the_repository, list_item->name)) {
>  		strbuf_addf(&sb, "submodule.%s.active", sub->name);
>  		git_config_set_gently(sb.buf, "true");
>  		strbuf_reset(&sb);
> @@ -414,7 +432,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>  		if (git_config_set_gently(sb.buf, url))
>  			die(_("Failed to register url for submodule path '%s'"),
>  			    displaypath);
> -		if (!quiet)
> +		if (!info->quiet)
>  			fprintf(stderr,
>  				_("Submodule '%s' (%s) registered for path '%s'\n"),
>  				sub->name, url, displaypath);
> @@ -443,10 +461,10 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>  
>  static int module_init(int argc, const char **argv, const char *prefix)
>  {
> +	struct init_cb info = INIT_CB_INIT;
>  	struct pathspec pathspec;
>  	struct module_list list = MODULE_LIST_INIT;
>  	int quiet = 0;
> -	int i;
>  
>  	struct option module_init_options[] = {
>  		OPT__QUIET(&quiet, N_("Suppress output for initializing a submodule")),
> @@ -471,8 +489,10 @@ static int module_init(int argc, const char **argv, const char *prefix)
>  	if (!argc && git_config_get_value_multi("submodule.active"))
>  		module_list_active(&list);
>  
> -	for (i = 0; i < list.nr; i++)
> -		init_submodule(list.entries[i]->name, prefix, quiet);
> +	info.prefix = prefix;
> +	info.quiet = !!quiet;
> +
> +	for_each_listed_submodule(&list, init_submodule, &info);
>  
>  	return 0;
>  }
