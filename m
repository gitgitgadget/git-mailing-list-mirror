Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A35B20A26
	for <e@80x24.org>; Mon, 25 Sep 2017 05:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbdIYFHD (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 01:07:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57555 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753121AbdIYFHC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 01:07:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72D029DC10;
        Mon, 25 Sep 2017 01:07:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ocAzowV+w/Rm1jJETALLAwRSGuA=; b=D5pZlQ
        nqTn6W4AeDst+CabRyxKbGF5OBm9+DEAaY9J4fSdSDP0vxHNKFPYNbOEb4a84FUg
        RqU95mELULFE/VDHh/XlBHXcYcCgGD2UUMMRlu/TEkbz2MGDnd7dQEZdA9Z6MSrg
        5axUKtpymlWGClNw2QvbrCRlR35onEr3w42gc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=I7J4kmd71jUsqi9qnf9dYQM0xE+vACVR
        ZkeQFCJdgV85Qlfg2rQ+NOBGHOLgkZmj9ZoiYHX8yZvfWgCFhQnZ0oDcajwn7Ojz
        lPcvl1b9DPe30agJkpdH8NWzJDLwL+JaOEV+fSDEa1lLygB5IN26UaIvqlS5TTKo
        ANuMmWVQMwA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 434AA9DC0E;
        Mon, 25 Sep 2017 01:07:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 287D69DC0D;
        Mon, 25 Sep 2017 01:07:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     hanwen@google.com, christian.couder@gmail.com, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH v5 4/4] submodule: port submodule subcommand 'status' from shell to C
References: <20170921161059.11750-1-hanwen@google.com>
        <20170924120858.26813-1-pc44800@gmail.com>
        <20170924120858.26813-5-pc44800@gmail.com>
Date:   Mon, 25 Sep 2017 14:06:58 +0900
In-Reply-To: <20170924120858.26813-5-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Sun, 24 Sep 2017 17:38:58 +0530")
Message-ID: <xmqq4lrrfjt9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C87B75C-A1AF-11E7-A060-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> This aims to make git-submodule 'status' a built-in. Hence, the function
> cmd_status() is ported from shell to C. This is done by introducing
> three functions: module_status(), submodule_status() and print_status().

Well then it does not just aim to, but it does, doesn't it ;-)?

> @@ -559,6 +544,151 @@ static int module_init(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +struct status_cb {
> +	const char *prefix;
> +	unsigned int quiet: 1;
> +	unsigned int recursive: 1;
> +	unsigned int cached: 1;
> +};
> +#define STATUS_CB_INIT { NULL, 0, 0, 0 }
> +
> +static void print_status(struct status_cb *info, char state, const char *path,
> +			 const struct object_id *oid, const char *displaypath)
> +{
> +	if (info->quiet)
> +		return;
> +
> +	printf("%c%s %s", state, oid_to_hex(oid), displaypath);
> +
> +	if (state == ' ' || state == '+')
> +		printf(" (%s)", compute_rev_name(path, oid_to_hex(oid)));
> +
> +	printf("\n");
> +}
> +
> +static int handle_submodule_head_ref(const char *refname,
> +				     const struct object_id *oid, int flags,
> +				     void *cb_data)
> +{
> +	struct object_id *output = cb_data;
> +	if (oid)
> +		oidcpy(output, oid);
> +
> +	return 0;
> +}

All of the above look sensible.

> +static void status_submodule(const struct cache_entry *list_item, void *cb_data)
> +{
> +	struct status_cb *info = cb_data;
> +	char *displaypath;
> +	struct argv_array diff_files_args = ARGV_ARRAY_INIT;
> +
> +	if (!submodule_from_path(&null_oid, list_item->name))
> +		die(_("no submodule mapping found in .gitmodules for path '%s'"),
> +		      list_item->name);
> +
> +	displaypath = get_submodule_displaypath(list_item->name, info->prefix);
> +
> +	if (ce_stage(list_item)) {
> +		print_status(info, 'U', list_item->name,
> +			     &null_oid, displaypath);
> +		goto cleanup;
> +	}
> +
> +	if (!is_submodule_active(the_repository, list_item->name)) {
> +		print_status(info, '-', list_item->name, &list_item->oid,
> +			     displaypath);
> +		goto cleanup;
> +	}
> +
> +	argv_array_pushl(&diff_files_args, "diff-files",
> +			 "--ignore-submodules=dirty", "--quiet", "--",
> +			 list_item->name, NULL);
> +
> +	if (!cmd_diff_files(diff_files_args.argc, diff_files_args.argv,
> +			    info->prefix)) {

Calling any cmd_foo() from places other than git.c, especially if it
is done more than once, is a source of bug.  I didn't check closely
if cmd_diff_files() currently has any of the potential problems, but
these functions are free to (1) modify global or file-scope static
variables, assuming that they will not be called again, leaving
these variables in a state different from the original and making
cmd_foo() unsuitable to be called twice, and (2) exit instead of
return at the end, among other things.

The functions in diff-lib.c (I think run_diff_files() for this
application) are designed to be called multiple times as library-ish
helpers; this caller should be using them instead.

> +		print_status(info, ' ', list_item->name, &list_item->oid,
> +			     displaypath);
> +	} else {
> +		if (!info->cached) {

By using "else if (!info->cached) {" here, you can reduce the
nesting level, perhaps?

> +static int module_status(int argc, const char **argv, const char *prefix)
> +{
> +	struct status_cb info = STATUS_CB_INIT;
> +	struct pathspec pathspec;
> +	struct module_list list = MODULE_LIST_INIT;
> +	int quiet = 0;
> +	int cached = 0;
> +	int recursive = 0;
> +
> +	struct option module_status_options[] = {
> +		OPT__QUIET(&quiet, N_("Suppress submodule status output")),
> +		OPT_BOOL(0, "cached", &cached, N_("Use commit stored in the index instead of the one stored in the submodule HEAD")),
> +		OPT_BOOL(0, "recursive", &recursive, N_("Recurse into nested submodules")),
> +		OPT_END()
> +	};
> +
> +	const char *const git_submodule_helper_usage[] = {
> +		N_("git submodule status [--quiet] [--cached] [--recursive] [<path>...]"),
> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, module_status_options,
> +			     git_submodule_helper_usage, 0);
> +
> +	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
> +		return 1;
> +
> +	info.prefix = prefix;
> +	info.quiet = !!quiet;
> +	info.recursive = !!recursive;
> +	info.cached = !!cached;
> +
> +	for_each_listed_submodule(&list, status_submodule, &info);
> +
> +	return 0;
> +}

The same comment as [2/4] on "init_submodule()?  don't you want
init_submodule_cb() instead?" applies to "status_submodule()".  I
suspect that in the future we would want more direct calls to show
the status of one single submodule, without indirectly controlling
what is chosen via the &list interface, and if that is the case,
you'd want the interface into the leaf level helper function to be a
more direct one that is not based on "void *cb_data", with a thin
wrapper around it that is to be used as the callback function by
for_each_listed_submodule().

Other than that, looks very cleanly done.

Thanks.
