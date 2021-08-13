Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FA8C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 18:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6E660EE0
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 18:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhHMSdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 14:33:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53663 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbhHMSdc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 14:33:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B928E15591A;
        Fri, 13 Aug 2021 14:33:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aVAuWEYnPVfrNLFFo8tgqtLkuLYnQvgkrnl7um
        5752A=; b=hDPz0VB0JKuprIvjleqf5EER7eR2i/REEqR8Iww0VjoStZGKyqKaPy
        rTPsYmbxxiPtfdWrUDq+JuktGHGk2wqFX+wQNFtjqocbZEeXpZOCInqhVS87dZbB
        MXPXo2+6oL/rltdK4Z2Qu+LYUcNT9/1wPODdL7SVqLqtqwMQMmLqI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B19DC155919;
        Fri, 13 Aug 2021 14:33:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D1459155914;
        Fri, 13 Aug 2021 14:33:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Atharva Raykar <raykar.ath@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [GSoC] [PATCH v3] submodule--helper: run update procedures from C
References: <20210802130627.36170-1-raykar.ath@gmail.com>
        <20210813075653.56817-1-raykar.ath@gmail.com>
Date:   Fri, 13 Aug 2021 11:32:59 -0700
In-Reply-To: <20210813075653.56817-1-raykar.ath@gmail.com> (Atharva Raykar's
        message of "Fri, 13 Aug 2021 13:26:53 +0530")
Message-ID: <xmqqim09w5yc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E380CDE8-FC64-11EB-820C-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atharva Raykar <raykar.ath@gmail.com> writes:

> Add a new submodule--helper subcommand `run-update-procedure` that runs
> the update procedure if the SHA1 of the submodule does not match what
> the superproject expects.
>
> This is an intermediate change that works towards total conversion of
> `submodule update` from shell to C.

OK.  Various things can happen depending on the setting during the
update procedure, and it is complex enough to split it out to a
single step, I guess.

> Specific error codes are returned so that the shell script calling the
> subcommand can take a decision on the control flow, and preserve the
> error messages across subsequent recursive calls of `cmd_update`.
>
> This change is more focused on doing a faithful conversion, so for now we
> are not too concerned with trying to reduce subprocess spawns.
>
> Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Shourya Shukla <periperidip@gmail.com>

Keep trailer lines in chronological order.  The mentors mentored,
the patch was written and finally you signed it off.

> +static int run_update_command(struct update_data *ud, int subforce)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +	char *oid = oid_to_hex(&ud->oid);
> +	int must_die_on_failure = 0;
> +
> +	cp.dir = xstrdup(ud->sm_path);
> +	switch (ud->update_strategy.type) {
> +	case SM_UPDATE_CHECKOUT:
> +		cp.git_cmd = 1;
> +		strvec_pushl(&cp.args, "checkout", "-q", NULL);
> +		if (subforce)
> +			strvec_push(&cp.args, "-f");
> +		break;
> +	case SM_UPDATE_REBASE:
> +		cp.git_cmd = 1;
> +		strvec_push(&cp.args, "rebase");
> +		if (ud->quiet)
> +			strvec_push(&cp.args, "--quiet");
> +		must_die_on_failure = 1;
> +		break;
> +	case SM_UPDATE_MERGE:
> +		cp.git_cmd = 1;
> +		strvec_push(&cp.args, "merge");
> +		if (ud->quiet)
> +			strvec_push(&cp.args, "--quiet");
> +		must_die_on_failure = 1;
> +		break;
> +	case SM_UPDATE_COMMAND:
> +		/* NOTE: this does not handle quoted arguments */
> +		strvec_split(&cp.args, ud->update_strategy.command);

Indeed this doesn't.  I think cp.use_shell would be the right way to
run this.

Study what happens before run_command_v_opt_cd_env() with
RUN_USING_SHELL calls run_command() and make something similar
happen here, instead of doing a manual command line splitting.

	Side note: run_command_v_opt_cd_env() with RUN_USING_SHELL
	is used in places like diff.c::run_external_diff() to invoke
	an external diff command, ll-merge.c::ll_ext_merge() to
	invoke a user-defined low level merge driver,
	sequencer.c::do_exec() to invoke 'x cmd' you write in the
	todo list during an "rebase -i" session.

> +		must_die_on_failure = 1;
> +		break;
> +	case SM_UPDATE_NONE:
> +		BUG("this should have been handled before. How did we reach here?");
> +		break;
> +	case SM_UPDATE_UNSPECIFIED:
> +		BUG("update strategy should have been specified");

These two case arms are not a faithful conversion from the original,
but because you do not carry around a random string from the caller
and instead have parsed enums, it cannot be ;-)  But it makes me
wonder why we want these two cases separate.  Isn't it a BUG() if
anything other than what we handled (i.e. prepared cp.args for)
already is in ud->update_strategy.type?  IOW, wouldn't it be more
forward looking to do

	default:
		BUG("unexpected ud->update_strategy.type (%d)",
		    ud->update_strategy.type (%d)");

or something?  That way, if we ever come up with a new update
strategy and forget to update this part, we will catch such a bug
fairly quickly.

> +	}
> +
> +	strvec_push(&cp.args, oid);
> +
> +	prepare_submodule_repo_env(&cp.env_array);
> +
> +	if (run_command(&cp)) {
> +		if (must_die_on_failure) {
> +			switch (ud->update_strategy.type) {
> +			case SM_UPDATE_CHECKOUT:
> +				die(_("Unable to checkout '%s' in submodule path '%s'"),
> +				      oid, ud->displaypath);
> +				break;
> +			case SM_UPDATE_REBASE:
> +				die(_("Unable to rebase '%s' in submodule path '%s'"),
> +				      oid, ud->displaypath);
> +				break;
> +			case SM_UPDATE_MERGE:
> +				die(_("Unable to merge '%s' in submodule path '%s'"),
> +				      oid, ud->displaypath);
> +				break;
> +			case SM_UPDATE_COMMAND:
> +				die(_("Execution of '%s %s' failed in submodule path '%s'"),
> +				      ud->update_strategy.command, oid, ud->displaypath);
> +				break;

The messages here correspond to what is assigned to $die_message in
the original.  Note that they are emitted to the standard error
stream.

I suspect that these should be "printf()" followed by a call to
exit() with some non-zero value (see below).

> +			case SM_UPDATE_NONE:
> +				BUG("this should have been handled before. How did we reach here?");
> +				break;
> +			case SM_UPDATE_UNSPECIFIED:
> +				BUG("update strategy should have been specified");
> +			}

The same comment applies to the last two case arms of this switch
statement and the next one, too.  I think we just should catch
"everything else" with a simple "default:" label.

Also, don't omit the "break;" from the last case arm in a switch
statement.  It harms the long-term help of the code---the last case
arm may not forever stay to be the last one.

> +		}
> +		/*
> +		 * This signifies to the caller in shell that
> +		 * the command failed without dying
> +		 */
> +		return 1;
> +	}
> +
> +	switch (ud->update_strategy.type) {
> +	case SM_UPDATE_CHECKOUT:
> +		printf(_("Submodule path '%s': checked out '%s'\n"),
> +		       ud->displaypath, oid);
> +		break;
> +	case SM_UPDATE_REBASE:
> +		printf(_("Submodule path '%s': rebased into '%s'\n"),
> +		       ud->displaypath, oid);
> +		break;
> +	case SM_UPDATE_MERGE:
> +		printf(_("Submodule path '%s': merged in '%s'\n"),
> +		       ud->displaypath, oid);
> +		break;
> +	case SM_UPDATE_COMMAND:
> +		printf(_("Submodule path '%s': '%s %s'\n"),
> +		       ud->displaypath, ud->update_strategy.command, oid);
> +		break;
> +	case SM_UPDATE_NONE:
> +		BUG("this should have been handled before. How did we reach here?");
> +		break;
> +	case SM_UPDATE_UNSPECIFIED:
> +		BUG("update strategy should have been specified");

Likewise here.

> +	}
> +
> +	return 0;
> +}
> +
> +static int do_run_update_procedure(struct update_data *ud)
> +{
> +	int subforce = is_null_oid(&ud->suboid) || ud->force;
> +
> +	if (!ud->nofetch) {
> +		/*
> +		 * Run fetch only if `oid` isn't present or it
> +		 * is not reachable from a ref.
> +		 */
> +		if (!is_tip_reachable(ud->sm_path, &ud->oid))
> +			if (fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, NULL) &&
> +			    !ud->quiet)
> +				fprintf_ln(stderr,

OK.  Combining these into a single statement like

		if (!is_tip_reachable(...) &&
		    fetch_in_submodule(...) &&
		    !ud->quiet)
			fprintf_ln(...

would reduce the indentation level, but the way the conditional is
structured may convey the flow of the thought better, i.e.

	if we need to fetch, 
	    try to fetch and if that fails,
		report failure.

On the other hand, if we take that line of thought to the extreme,
the check for !ud->quiet should belong to another level of if
statement so perhaps the more concise version I showed above might
be an overall win.  I dunno.

> +					   _("Unable to fetch in submodule path '%s'; "
> +					     "trying to directly fetch %s:"),
> +					   ud->displaypath, oid_to_hex(&ud->oid));
> +		/*
> +		 * Now we tried the usual fetch, but `oid` may
> +		 * not be reachable from any of the refs.
> +		 */
> +		if (!is_tip_reachable(ud->sm_path, &ud->oid))
> +			if (fetch_in_submodule(ud->sm_path, ud->depth, ud->quiet, &ud->oid))
> +				die(_("Fetched in submodule path '%s', but it did not "
> +				      "contain %s. Direct fetching of that commit failed."),
> +				    ud->displaypath, oid_to_hex(&ud->oid));

Likewise.

> +	}
> +
> +	return run_update_command(ud, subforce);
> +}
> +
>  static void update_submodule(struct update_clone_data *ucd)
>  {
>  	fprintf(stdout, "dummy %s %d\t%s\n",
> @@ -2395,6 +2584,75 @@ static int update_clone(int argc, const char **argv, const char *prefix)
>  	return update_submodules(&suc);
>  }
>  
> +static int run_update_procedure(int argc, const char **argv, const char *prefix)
> +{
> +	int force = 0, quiet = 0, nofetch = 0, just_cloned = 0;
> +	char *prefixed_path, *update = NULL;
> +	struct update_data update_data = UPDATE_DATA_INIT;
> +
> +	struct option options[] = {
> ...
> +		OPT_END()
> +	};
> ...
> +	update_data.displaypath = get_submodule_displaypath(prefixed_path, prefix);
> +
> +	determine_submodule_update_strategy(the_repository, update_data.just_cloned,
> +					    update_data.sm_path, update,
> +					    &update_data.update_strategy);
> +
> +	free(prefixed_path);
> +
> +	if ((!is_null_oid(&update_data.oid) && !is_null_oid(&update_data.suboid) &&
> +	     !oideq(&update_data.oid, &update_data.suboid)) ||
> +	    is_null_oid(&update_data.suboid) || update_data.force)
> +		return do_run_update_procedure(&update_data);

The original does the update procedure if $sha1 and $subsha1 are
different or if $force option is given.  The rewritten seems to skip
the update when .oid is NULL and .suboid is not NULL; intended?

I understand that the division of labour between this function and
do_run_update_procedure() is for the former to only exist to
interface with the script side by populating the update_data
structure, and the latter implements the logic to run update
procedure.  I was a bit surprised that this conditional is
here, not at the very beginning of the callee.

> +	return 3;
> +}
> +
>  static int resolve_relative_path(int argc, const char **argv, const char *prefix)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> @@ -2951,6 +3209,7 @@ static struct cmd_struct commands[] = {
>  	{"add-clone", add_clone, 0},
>  	{"update-module-mode", module_update_module_mode, 0},
>  	{"update-clone", update_clone, 0},
> +	{"run-update-procedure", run_update_procedure, 0},
>  	{"ensure-core-worktree", ensure_core_worktree, 0},
>  	{"relative-path", resolve_relative_path, 0},
>  	{"resolve-relative-url", resolve_relative_url, 0},
> diff --git a/git-submodule.sh b/git-submodule.sh
> index dbd2ec2050..d8e30d1afa 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -519,14 +512,13 @@ cmd_update()
>  
>  		git submodule--helper ensure-core-worktree "$sm_path" || exit 1
>  
> -		update_module=$(git submodule--helper update-module-mode $just_cloned "$sm_path" $update)
> -
>  		displaypath=$(git submodule--helper relative-path "$prefix$sm_path" "$wt_prefix")

On the other side of the API boundary, update_data.displaypath is
populated by value computed in C.  It is a bit unfortunate that we
still need to compute it here and risk the two to drift apart.

>  		if test $just_cloned -eq 1
>  		then
>  			subsha1=
>  		else
> +			just_cloned=
>  			subsha1=$(sanitize_submodule_env; cd "$sm_path" &&
>  				git rev-parse --verify HEAD) ||
>  			die "fatal: $(eval_gettext "Unable to find current revision in submodule path '\$displaypath'")"
> @@ -547,70 +539,38 @@ cmd_update()
>  			die "fatal: $(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
>  		fi
>  
> -		if test "$subsha1" != "$sha1" || test -n "$force"
> -		then
> -			subforce=$force
> -			# If we don't already have a -f flag and the submodule has never been checked out
> -			if test -z "$subsha1" && test -z "$force"
> -			then
> -				subforce="-f"
> -			fi
> +		out=$(git submodule--helper run-update-procedure \
> +			  ${wt_prefix:+--prefix "$wt_prefix"} \
> +			  ${GIT_QUIET:+--quiet} \
> +			  ${force:+--force} \
> +			  ${just_cloned:+--just-cloned} \
> +			  ${nofetch:+--no-fetch} \
> +			  ${depth:+"$depth"} \
> +			  ${update:+--update "$update"} \
> +			  ${prefix:+--recursive-prefix "$prefix"} \
> +			  ${sha1:+--oid "$sha1"} \
> +			  ${subsha1:+--suboid "$subsha1"} \
> +			  "--" \
> +			  "$sm_path")

We'd just show errors directly to the standard error stream from
submodule--helper, but what comes from the printf in the switch
statement at the end of run_update_command() is captured in $out
variable.  Notably, the messages from die()s in the second switch
statement in run_update_command() are not captured in $out here.

> -			if test -z "$nofetch"
> -			then
> -				# Run fetch only if $sha1 isn't present or it
> -				# is not reachable from a ref.
> -				is_tip_reachable "$sm_path" "$sha1" ||
> -				fetch_in_submodule "$sm_path" $depth ||
> -				say "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'; trying to directly fetch \$sha1:")"
> -
> -				# Now we tried the usual fetch, but $sha1 may
> -				# not be reachable from any of the refs
> -				is_tip_reachable "$sm_path" "$sha1" ||
> -				fetch_in_submodule "$sm_path" "$depth" "$sha1" ||
> -				die "fatal: $(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain \$sha1. Direct fetching of that commit failed.")"
> -			fi
> -
> -			must_die_on_failure=
> -			case "$update_module" in
> -			checkout)
> -				command="git checkout $subforce -q"
> -				die_msg="fatal: $(eval_gettext "Unable to checkout '\$sha1' in submodule path '\$displaypath'")"
> -				say_msg="$(eval_gettext "Submodule path '\$displaypath': checked out '\$sha1'")"
> -				;;
> -			rebase)
> -				command="git rebase ${GIT_QUIET:+--quiet}"
> -				die_msg="fatal: $(eval_gettext "Unable to rebase '\$sha1' in submodule path '\$displaypath'")"
> -				say_msg="$(eval_gettext "Submodule path '\$displaypath': rebased into '\$sha1'")"
> -				must_die_on_failure=yes
> -				;;
> -			merge)
> -				command="git merge ${GIT_QUIET:+--quiet}"
> -				die_msg="fatal: $(eval_gettext "Unable to merge '\$sha1' in submodule path '\$displaypath'")"
> -				say_msg="$(eval_gettext "Submodule path '\$displaypath': merged in '\$sha1'")"
> -				must_die_on_failure=yes
> -				;;
> -			!*)
> -				command="${update_module#!}"
> -				die_msg="fatal: $(eval_gettext "Execution of '\$command \$sha1' failed in submodule path '\$displaypath'")"
> -				say_msg="$(eval_gettext "Submodule path '\$displaypath': '\$command \$sha1'")"
> -				must_die_on_failure=yes
> -				;;
> -			*)
> -				die "fatal: $(eval_gettext "Invalid update mode '$update_module' for submodule path '$path'")"
> -			esac
> -
> -			if (sanitize_submodule_env; cd "$sm_path" && $command "$sha1")
> -			then
> -				say "$say_msg"
> -			elif test -n "$must_die_on_failure"
> -			then
> -				die_with_status 2 "$die_msg"
> -			else
> -				err="${err};$die_msg"
> -				continue
> -			fi
> -		fi
> +		# exit codes for run-update-procedure:
> +		# 0: update was successful, say command output
> +		# 128: subcommand died during execution
> +		# 1: update procedure failed, but should not die
> +		# 3: no update procedure was run
> +		res="$?"
> +		case $res in
> +		0)
> +			say "$out"
> +			;;

And the case where there is no error is quite straight-forward.  We
just emit what we saw in the standard output stream of the helper.

> +		128)
> +			exit $res
> +			;;
> +		1)
> +			err="${err};$out"

This part is dubious.  In the original, $err accumulates what is in
$die_msg, which are things like "fatal: Unable to rebase ...", but
with this patch, what used to be the contents of $die_msg are given
to die() after we see run_command() fail, and would have sent to the
standard error stream, not captured in $out here, no?

> +			continue
> +			;;
> +		esac
>  
>  		if test -n "$recursive"
>  		then


Thanks.
