Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3C6E1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 21:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeAIVYc (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 16:24:32 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60889 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752479AbeAIVYb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 16:24:31 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD54AC08EC;
        Tue,  9 Jan 2018 16:24:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=agZ4NMw6iU11KNEXYsAt5Ri9+5E=; b=HRGAfe
        oSGVwwIIcfn9V3Lr9AzPeLzpkV6RP44MTf35hDGilhDWzGzEBu0KAIhFBtsx05Hf
        L1lPWYNfa5txP4skOp8JR6cv8rwT+rlLDHy98Fx4Wl+3qEBhDsEObJiDNoPAYwu2
        kBasw09jBSpsDCBSMvAcoBI70GfSUE/ptId4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gC2Rnn2JmoX3oWGh/IktX5T+nir27Kp0
        M3lsD0q4yzf2tVpSepzqg+ZBP46lxa7dxfa42aaRoReSgUzBtGo6rsUafs6Vu4Sj
        6pj/sEKWraJIEdhx/wKW+3Diaa/OhHkt0eHxViR9jHlz9547MbDG8Q9/bLs6FoHj
        KsV+fP1iezE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5B52C08EB;
        Tue,  9 Jan 2018 16:24:30 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 423A5C08E8;
        Tue,  9 Jan 2018 16:24:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [PATCH v1 2/2] submodule: port submodule subcommand 'deinit' from shell to C
References: <20180109175703.4793-1-pc44800@gmail.com>
        <20180109175703.4793-3-pc44800@gmail.com>
Date:   Tue, 09 Jan 2018 13:24:29 -0800
In-Reply-To: <20180109175703.4793-3-pc44800@gmail.com> (Prathamesh Chavan's
        message of "Tue, 9 Jan 2018 23:27:03 +0530")
Message-ID: <xmqq7esq4tf6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7A810272-F583-11E7-8A68-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prathamesh Chavan <pc44800@gmail.com> writes:

> The same mechanism is used even for porting this submodule
> subcommand, as used in the ported subcommands till now.
> The function cmd_deinit in split up after porting into four
> functions: module_deinit(), for_each_listed_submodule(),
> deinit_submodule() and deinit_submodule_cb().
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>  builtin/submodule--helper.c | 153 ++++++++++++++++++++++++++++++++++++++++++++
>  git-submodule.sh            |  55 +---------------
>  2 files changed, 154 insertions(+), 54 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index dd7737acd..54b0e46fc 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -20,6 +20,7 @@
>  #define OPT_QUIET (1 << 0)
>  #define OPT_CACHED (1 << 1)
>  #define OPT_RECURSIVE (1 << 2)
> +#define OPT_FORCE (1 << 3)
>  
>  typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
>  				  void *cb_data);
> @@ -908,6 +909,157 @@ static int module_sync(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> +struct deinit_cb {
> +	const char *prefix;
> +	unsigned int flags;
> +};
> +#define DEINIT_CB_INIT { NULL, 0 }
> +
> +static void deinit_submodule(const char *path, const char *prefix,
> +			     unsigned int flags)
> +{
> +	const struct submodule *sub;
> +	char *displaypath = NULL;
> +	struct child_process cp_config = CHILD_PROCESS_INIT;
> +	struct strbuf sb_config = STRBUF_INIT;
> +	char *sub_git_dir = xstrfmt("%s/.git", path);
> +	mode_t mode = 0777;
> +
> +	sub = submodule_from_path(&null_oid, path);
> +
> +	if (!sub || !sub->name)
> +		goto cleanup;
> +
> +	displaypath = get_submodule_displaypath(path, prefix);
> +
> +	/* remove the submodule work tree (unless the user already did it) */
> +	if (is_directory(path)) {
> +		struct stat st;
> +		/*
> +		 * protect submodules containing a .git directory
> +		 * NEEDSWORK: automatically call absorbgitdirs before
> +		 * warning/die.
> +		 */

I guess that you mean "instead of dying, automatically call absorb
and (possibly) warn"?  That sounds like a sensible improvement.

> +		if (is_directory(sub_git_dir))
> +			die(_("Submodule work tree '%s' contains a .git "
> +			      "directory use 'rm -rf' if you really want "
> +			      "to remove it including all of its history"),

This changes the message text by removing () around "use ... history",
which I do not think you intended to do.

> +			      displaypath);
> +
> +		if (!(flags & OPT_FORCE)) {
> +			struct child_process cp_rm = CHILD_PROCESS_INIT;
> +			cp_rm.git_cmd = 1;
> +			argv_array_pushl(&cp_rm.args, "rm", "-qn",
> +					 path, NULL);
> +
> +			if (run_command(&cp_rm))
> +				die(_("Submodule work tree '%s' contains local "
> +				      "modifications; use '-f' to discard them"),
> +				      displaypath);
> +		}
> +
> +		if (!lstat(path, &st)) {

What is this if statement doing here?  It does not make sense,
especially without an 'else' clause on the other side, at least to
me.

At this point in the flow, the code has already determined that path
is a directory above before starting to check if it has ".git/"
immediately below it, or trying to run "git rm" in the dry run mode
to see if it yields an error, so at this point lstat() should
succeed (and would say it is a directory).  I would sort-of
understand it if this "if()" has an "else" clause to act on an
error, but that is not something the original does not do, so I am
not sure if it belongs to a "rewrite to C" patch.

> +			struct strbuf sb_rm = STRBUF_INIT;
> +			const char *format;
> +
> +			strbuf_addstr(&sb_rm, path);
> +
> +			if (!remove_dir_recursively(&sb_rm, 0))
> +				format = _("Cleared directory '%s'\n");
> +			else
> +				format = _("Could not remove submodule work tree '%s'\n");
> +
> +			if (!(flags & OPT_QUIET))
> +				printf(format, displaypath);
> +
> +			mode = st.st_mode;
> +
> +			strbuf_release(&sb_rm);
> +		}
> +	}

If the reason is "avoid losing the original directory mode by
removing and recreating", then you should be able to do much better
by using REMOVE_DIR_KEEP_TOPLEVEL in the above "do we still have a
directory?  if so get rid of working tree contents" thing.  And the
call to mkdir() below can be placed in the else clause of that
check, i.e. "the user has removed the directory as well, but there
should be an empty directory even for a de-initialized submodule"
side of this.

That of course does not have to be part of "rewrite to C" patch.  In
fact, it probably should come as a follow-up improvement after the
dust settles.

> +	if (mkdir(path, mode))
> +		die_errno(_("could not create empty submodule directory %s"),
> +		      displaypath);
> + ...
> +
> +static int module_deinit(int argc, const char **argv, const char *prefix)
> +{
> +...
> +	if (module_list_compute(argc, argv, prefix, &pathspec, &list) < 0)
> +		BUG("module_list_compute should not choke on empty pathspec");
> +...
> +	if (all && argc) {
> +		error("pathspec and --all are incompatible");
> +		usage_with_options(git_submodule_helper_usage,
> +				   module_deinit_options);
> +	}
> +
> +	if (!argc && !all)
> +		die(_("Use '--all' if you really want to deinitialize all submodules"));

Shouldn't these two checks come before we call module_list_compute()?  

> +
> +	for_each_listed_submodule(&list, deinit_submodule_cb, &info);
> +
> +	return 0;
> +}
