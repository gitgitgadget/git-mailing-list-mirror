From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/4] git-cherry-pick: Add keep-redundant-commits
 option
Date: Wed, 11 Apr 2012 13:57:24 -0700
Message-ID: <7v1unuj8az.fsf@alter.siamese.dyndns.org>
References: <1334175716-11391-1-git-send-email-nhorman@tuxdriver.com>
 <1334175716-11391-3-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 22:57:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI4bh-0000OG-Ti
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 22:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932962Ab2DKU5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 16:57:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64770 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761200Ab2DKU52 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 16:57:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6A4B6312;
	Wed, 11 Apr 2012 16:57:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rs52mPGcKOlcGjp0plykdcPCRX4=; b=uyWo+z
	MdCV0WpGW5aV2CapVlWCce3bWZlP+zhVel2fPKAXjdGt7jYxaKNXzX5jpzqCwHvu
	X2fpXNPJuiuMjylHWP3coFYk9jM1rlDoPus2LIfz38vI8I5LerACiHiCKGCHoBk5
	0ua4BrrmNL5ogrGYdCHDJJseWBbGrakIXcwkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p2wfr9Q1s8DgVbkvN4LA/JR+bYqFbDJC
	lE88+VNA+6hx+eCvekguuYu7VImf0FL0ip5NvaDtQHjXOC3Jec69y9ph07CGN3m/
	Zp8Km9lKnDw69Pp1ZkdXqrZI6qEvAY3s+TIXGylQJGbCX8vvaJdkI4VwiF8z9jDV
	nYyR8uk+UbY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD27D6311;
	Wed, 11 Apr 2012 16:57:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF8E6630D; Wed, 11 Apr 2012
 16:57:25 -0400 (EDT)
In-Reply-To: <1334175716-11391-3-git-send-email-nhorman@tuxdriver.com> (Neil
 Horman's message of "Wed, 11 Apr 2012 16:21:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F13DE656-8418-11E1-B4FC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195253>

Neil Horman <nhorman@tuxdriver.com> writes:

> The git-cherry-pick --allow-empty command by default only preserves empty
> commits that were originally empty, i.e only those commits for which
> <commit>^{tree} and <commit>^^{tree} are equal.  By default commits which are
> non-empty, but were made empty by the inclusion of a prior commit on the current
> history are filtered out.  This option allows us to override that behavior and
> include redundant commits as empty commits in the change history.
>
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> ---
>  Documentation/git-cherry-pick.txt |   12 +++++-
>  builtin/revert.c                  |    8 +++-
>  sequencer.c                       |   91 +++++++++++++++++++++++++++++++-----
>  sequencer.h                       |    1 +
>  4 files changed, 97 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> index 730237a..f96b8c5 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -110,7 +110,17 @@ effect to your index in a row.
>  	behavior, allowing empty commits to be preserved automatically
>  	in a cherry-pick. Note that when "--ff" is in effect, empty
>  	commits that meet the "fast-forward" requirement will be kept
> -	even without this option.
> +	even without this option.  Note also, that use of this option only
> +	keeps commits that were initially empty (i.e. where for commit C
> +	C^{tree} and C^^{tree} are equal).  Commits which are made empty due to

It is OK to be technical in the log message, but I think

	commits that were initially empty (i.e. the commit recorded the
	same tree as its parent)

would be far easier to read in the documentation meant for the end users.

> +	a previous commit are ignored.  To force the inclusion of those commits
> +	use `--keep-redundant-commits`

And end the sentence with a full-stop.

> +--keep-redundant-commits::
> +	If a commit being cherry picked duplicates a commit already in the
> +	current history, it will result in an empty changeset.  By default these
> +	redundant commits are ignored.  This option overrides that behavior and
> +	creates an empty commit object.  Implies `--allow-empty`

Likewise.

> diff --git a/builtin/revert.c b/builtin/revert.c
> index 06b00e6..4f0d979 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -115,13 +115,15 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  		OPT_END(),
>  		OPT_END(),
>  		OPT_END(),
> +		OPT_END(),
>  	};
>  
>  	if (opts->action == REPLAY_PICK) {
>  		struct option cp_extra[] = {
>  			OPT_BOOLEAN('x', NULL, &opts->record_origin, "append commit name"),
>  			OPT_BOOLEAN(0, "ff", &opts->allow_ff, "allow fast-forward"),
> -			OPT_BOOLEAN(0, "allow-empty", &opts->allow_empty, "preserve empty commits"),
> +			OPT_BOOLEAN(0, "allow-empty", &opts->allow_empty, "preserve initially empty commits"),
> +			OPT_BOOLEAN(0, "keep-redundant-commits", &opts->keep_if_made_empty, "keep redundant, empty commits"),
>  			OPT_END(),
>  		};
>  		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
> @@ -139,6 +141,10 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  				"--abort", rollback,
>  				NULL);
>  
> +	/* keep_if_made_empty implies allow_empty */
> +	if (opts->keep_if_made_empty)
> +		opts->allow_empty = 1;
> +
>  	/* Set the subcommand */
>  	if (remove_state)
>  		opts->subcommand = REPLAY_REMOVE_STATE;
> diff --git a/sequencer.c b/sequencer.c
> index 71929ba..442f364 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -13,6 +13,7 @@
>  #include "rerere.h"
>  #include "merge-recursive.h"
>  #include "refs.h"
> +#include "argv-array.h"
>  
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>  
> @@ -258,26 +259,85 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>   * If we are revert, or if our cherry-pick results in a hand merge,
>   * we had better say that the current user is responsible for that.
>   */
> -static int run_git_commit(const char *defmsg, struct replay_opts *opts)
> +int run_git_commit(const char *defmsg, struct replay_opts *opts, int empty)
>  {
> -	/* 7 is max possible length of our args array including NULL */
> -	const char *args[7];
> -	int i = 0;
> +	struct argv_array array;
> +	int rc;
> +
> +	if (!empty && !opts->keep_if_made_empty) {
> +		unsigned char head_sha1[20];
> +		struct commit *head_commit;
> +		int need_free = 0;
> +
> +		resolve_ref_unsafe("HEAD", head_sha1, 1, NULL);
> +		head_commit = lookup_commit(head_sha1);

No error checking whatsoever?  HEAD might be pointing at a branch that
hasn't been born, for example.

> +		if (parse_commit(head_commit) < 0)
> +			return error(_("could not parse commit %s\n"),
> +				     sha1_to_hex(head_commit->object.sha1));
> +
> +		if (!active_cache_tree) {
> +			active_cache_tree = cache_tree();
> +			need_free = 1;
> +		}

I think this is wrong.  If for whatever reason the process does not have
the index it is about to tell "git commit" to use to make a commit in-core,
it should first be doing read_cache().
> +
> +		if (!cache_tree_fully_valid(active_cache_tree))
> +			cache_tree_update(active_cache_tree, active_cache,
> +					  active_nr, 0);

I do not recall offhand if cache_tree_update() can give you an error, but
if it does, it should be checked here.

> +		rc = !hashcmp(active_cache_tree->sha1, head_commit->tree->object.sha1);
> +
> +		if (need_free)
> +			cache_tree_free(&active_cache_tree);

and I don't see a need for nuking the cache tree here, unless you are
discarding the_index as well.

> +		if (rc)
> +			/*
> + 			 * The head tree and the parent tree match
> + 			 * meaning the commit is empty.  Since it wasn't created
> + 			 * empty (based on the previous test), we can conclude
> + 			 * the commit has been made redundant.  Since we don't
> + 			 * want to keep redundant commits, just skip this one
> + 			 */
> +			return 0;
> +	}
> +
> +	argv_array_init(&array);
> +	argv_array_push(&array, "commit");
> +	argv_array_push(&array, "-n");
>  
> -	args[i++] = "commit";
> -	args[i++] = "-n";
>  	if (opts->signoff)
> -		args[i++] = "-s";
> +		argv_array_push(&array, "-s");
>  	if (!opts->edit) {
> -		args[i++] = "-F";
> -		args[i++] = defmsg;
> +		argv_array_push(&array, "-F");
> +		argv_array_push(&array, defmsg);
>  	}
> +	
>  	if (opts->allow_empty)
> -		args[i++] = "--allow-empty";
> +		argv_array_push(&array, "--allow-empty");

If --keep-if-made-empty is not given but --allow-empty was, it is fine to
give --allow-empty here, but otherwise, it logically is iffy and is likely
to become a cause of future bugs to pass --allow-empty to "git commit",
even though the earlier check _ought_ to catch problematic cases, no?
