Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75EE41FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 22:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753428AbcHQWMc (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 18:12:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753386AbcHQWMc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 18:12:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DCC4372B4;
	Wed, 17 Aug 2016 18:12:30 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VpAaWRGfPZ7xm/YZojvD71JK5Lw=; b=bwlMmO
	Cot2aMFrNcPhdlMTX5rq4Jyk8Vhw1Vg25r2MLEQ9/ocZ8DOFlhcnMGyqqpU7IaeJ
	5JXcI9Ft1e87uo9Oz8agfllWvxJM4C2Fz0t0PIAOtrtQMxR/exVVR91ItI0DwESh
	wDpF8/1t6r2QFYf0oMIkMz2dZDnbfLvCNjqTM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bm6VRU0WmLfLCEfmgCij7e60OZOEc8x+
	1GSTh0TMEvmvNqrlS8ISZLBOJbJUu8qi3ECHFg6ar5s7F6bZr5z3y1tzL8/LG/w1
	15qN76chET4AAE4zB3oZPusxjc9uwLlvZk/9BbkKEcBwZP+ZJfomu64qdWKVvu3i
	y4m4nVW2+H4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 54765372B3;
	Wed, 17 Aug 2016 18:12:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B0B27372B2;
	Wed, 17 Aug 2016 18:12:29 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
Subject: Re: [PATCHv7 8/8] clone: recursive and reference option triggers submodule alternates
References: <20160817214635.22389-1-sbeller@google.com>
Date:	Wed, 17 Aug 2016 15:12:27 -0700
In-Reply-To: <20160817214635.22389-1-sbeller@google.com> (Stefan Beller's
	message of "Wed, 17 Aug 2016 14:46:35 -0700")
Message-ID: <xmqq8tvv82pg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B01D537A-64C7-11E6-AFE2-E86612518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>  Added a default for alternateErrorStrategy and hence fixed the null pointer
>  for error_strategy in prepare_possible_alternates(),

Looks much better.

> +submodule.alternateLocation::
> +	Specifies how the submodules obtain alternates when submodules are
> +	cloned. Possible values are `no`, `superproject`.
> +	By default `no` is assumed, which doesn't add references. When the
> +	value is set to `superproject` the submodule to be cloned computes
> +	its alternates location relative to the superprojects alternate.

I am not seeing a code that handles 'no' and any other string that
is not 'superproject' differently, though.

I can see that "clone" has codepath that writes 'superproject' to
the variable, but the only thing that seems to care what value the
variable is set to checks "no".  When somebody sets the variable to
"yes", shouldn't we at least say "Sorry, I do not understand" and
preferrably stop before spreading potential damage?  We'd surely end
up doing something that the user who set the value to "yes" did not
expect.

There is something still missing?

> +submodule.alternateErrorStrategy
> +	Specifies how to treat errors with the alternates for a submodule
> +	as computed via `submodule.alternateLocation`. Possible values are
> +	`ignore`, `info`, `die`. Default is `die`.
> +
>  tag.forceSignAnnotated::
>  	A boolean to specify whether annotated tags created should be GPG signed.
>  	If `--annotate` is specified on the command line, it takes
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 0182665..404c5e8 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -947,6 +947,25 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		else
>  			fprintf(stderr, _("Cloning into '%s'...\n"), dir);
>  	}
> +
> +	if (option_recursive) {
> +		if (option_required_reference.nr &&
> +		    option_optional_reference.nr)
> +			die(_("clone --recursive is not compatible with "
> +			      "both --reference and --reference-if-able"));
> +		else if (option_required_reference.nr) {
> +			string_list_append(&option_config,
> +				"submodule.alternateLocation=superproject");
> +			string_list_append(&option_config,
> +				"submodule.alternateErrorStrategy=die");
> +		} else if (option_optional_reference.nr) {
> +			string_list_append(&option_config,
> +				"submodule.alternateLocation=superproject");
> +			string_list_append(&option_config,
> +				"submodule.alternateErrorStrategy=info");
> +		}
> +	}
> +
>  	init_db(option_template, INIT_DB_QUIET);
>  	write_config(&option_config);
>  
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 7096848..f8f35c1 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -472,6 +472,96 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
>  	return run_command(&cp);
>  }
>  
> +struct submodule_alternate_setup {
> +	const char *submodule_name;
> +	enum SUBMODULE_ALTERNATE_ERROR_MODE {
> +		SUBMODULE_ALTERNATE_ERROR_DIE,
> +		SUBMODULE_ALTERNATE_ERROR_INFO,
> +		SUBMODULE_ALTERNATE_ERROR_IGNORE
> +	} error_mode;
> +	struct string_list *reference;
> +};
> +#define SUBMODULE_ALTERNATE_SETUP_INIT { NULL, \
> +	SUBMODULE_ALTERNATE_ERROR_IGNORE, NULL }
> +
> +static int add_possible_reference_from_superproject(
> +		struct alternate_object_database *alt, void *sas_cb)
> +{
> +	struct submodule_alternate_setup *sas = sas_cb;
> +
> +	/* directory name, minus trailing slash */
> +	size_t namelen = alt->name - alt->base - 1;
> +	struct strbuf name = STRBUF_INIT;
> +	strbuf_add(&name, alt->base, namelen);
> +
> +	/*
> +	 * If the alternate object store is another repository, try the
> +	 * standard layout with .git/modules/<name>/objects
> +	 */
> +	if (ends_with(name.buf, ".git/objects")) {
> +		char *sm_alternate;
> +		struct strbuf sb = STRBUF_INIT;
> +		struct strbuf err = STRBUF_INIT;
> +		strbuf_add(&sb, name.buf, name.len - strlen("objects"));
> +		/*
> +		 * We need to end the new path with '/' to mark it as a dir,
> +		 * otherwise a submodule name containing '/' will be broken
> +		 * as the last part of a missing submodule reference would
> +		 * be taken as a file name.
> +		 */
> +		strbuf_addf(&sb, "modules/%s/", sas->submodule_name);
> +
> +		sm_alternate = compute_alternate_path(sb.buf, &err);
> +		if (sm_alternate) {
> +			string_list_append(sas->reference, xstrdup(sb.buf));
> +			free(sm_alternate);
> +		} else {
> +			switch (sas->error_mode) {
> +			case SUBMODULE_ALTERNATE_ERROR_DIE:
> +				die(_("submodule '%s' cannot add alternate: %s"),
> +				    sas->submodule_name, err.buf);
> +			case SUBMODULE_ALTERNATE_ERROR_INFO:
> +				fprintf(stderr, _("submodule '%s' cannot add alternate: %s"),
> +					sas->submodule_name, err.buf);
> +			case SUBMODULE_ALTERNATE_ERROR_IGNORE:
> +				; /* nothing */
> +			}
> +		}
> +		strbuf_release(&sb);
> +	}
> +
> +	strbuf_release(&name);
> +	return 0;
> +}
> +
> +static void prepare_possible_alternates(const char *sm_name,
> +		struct string_list *reference)
> +{
> +	char *sm_alternate = NULL, *error_strategy = NULL;
> +	struct submodule_alternate_setup sas = SUBMODULE_ALTERNATE_SETUP_INIT;
> +
> +	git_config_get_string("submodule.alternateLocation", &sm_alternate);
> +	if (!sm_alternate)
> +		return;
> +
> +	git_config_get_string("submodule.alternateErrorStrategy", &error_strategy);
> +
> +	if (!error_strategy)
> +		error_strategy = xstrdup("die");
> +
> +	sas.submodule_name = sm_name;
> +	sas.reference = reference;
> +	if (!strcmp(error_strategy, "die"))
> +		sas.error_mode = SUBMODULE_ALTERNATE_ERROR_DIE;
> +	if (!strcmp(error_strategy, "info"))
> +		sas.error_mode = SUBMODULE_ALTERNATE_ERROR_INFO;
> +	if (!strcmp(sm_alternate, "superproject"))
> +		foreach_alt_odb(add_possible_reference_from_superproject, &sas);
> +
> +	free(sm_alternate);
> +	free(error_strategy);
> +}
> +
>  static int module_clone(int argc, const char **argv, const char *prefix)
>  {
>  	const char *name = NULL, *url = NULL, *depth = NULL;
> @@ -532,6 +622,9 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  	if (!file_exists(sm_gitdir)) {
>  		if (safe_create_leading_directories_const(sm_gitdir) < 0)
>  			die(_("could not create directory '%s'"), sm_gitdir);
> +
> +		prepare_possible_alternates(name, &reference);
> +
>  		if (clone_submodule(path, sm_gitdir, url, depth, &reference, quiet))
>  			die(_("clone of '%s' into submodule path '%s' failed"),
>  			    url, path);
> diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
> index dff47af..1c1e289 100755
> --- a/t/t7408-submodule-reference.sh
> +++ b/t/t7408-submodule-reference.sh
> @@ -82,4 +82,47 @@ test_expect_success 'updating superproject keeps alternates' '
>  	test_alternate_is_used super-clone/.git/modules/sub/objects/info/alternates super-clone/sub
>  '
>  
> +test_expect_success 'submodules use alternates when cloning a superproject' '
> +	test_when_finished "rm -rf super-clone" &&
> +	git clone --reference super --recursive super super-clone &&
> +	(
> +		cd super-clone &&
> +		# test superproject has alternates setup correctly
> +		test_alternate_is_used .git/objects/info/alternates . &&
> +		# test submodule has correct setup
> +		test_alternate_is_used .git/modules/sub/objects/info/alternates sub
> +	)
> +'
> +
> +test_expect_success 'missing submodule alternate fails clone and submodule update' '
> +	test_when_finished "rm -rf super-clone" &&
> +	git clone super super2 &&
> +	test_must_fail git clone --recursive --reference super2 super2 super-clone &&
> +	(
> +		cd super-clone &&
> +		# test superproject has alternates setup correctly
> +		test_alternate_is_used .git/objects/info/alternates . &&
> +		# update of the submodule succeeds
> +		test_must_fail git submodule update --init &&
> +		# and we have no alternates:
> +		test_must_fail test_alternate_is_used .git/modules/sub/objects/info/alternates sub &&
> +		test_must_fail test_path_is_file sub/file1
> +	)
> +'
> +
> +test_expect_success 'ignoring missing submodule alternates passes clone and submodule update' '
> +	test_when_finished "rm -rf super-clone" &&
> +	git clone --reference-if-able super2 --recursive super2 super-clone &&
> +	(
> +		cd super-clone &&
> +		# test superproject has alternates setup correctly
> +		test_alternate_is_used .git/objects/info/alternates . &&
> +		# update of the submodule succeeds
> +		git submodule update --init &&
> +		# and we have no alternates:
> +		test_must_fail test_alternate_is_used .git/modules/sub/objects/info/alternates sub &&
> +		test_path_is_file sub/file1
> +	)
> +'
> +
>  test_done
