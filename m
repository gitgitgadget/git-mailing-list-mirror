Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFD2C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 22:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352488AbhLFWwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 17:52:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54825 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353398AbhLFWwF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 17:52:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D2091036AB;
        Mon,  6 Dec 2021 17:48:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fW+W7zq2ctSH4fRvKh40vzb5J/Q/6MkF80BmZg
        LB/h0=; b=TxNV1b7F/vufH7pgtlgETzIFKCgvz5rMgqHzSt32CvzDmKPFzsZz/m
        dDb4BDMcyJYO+f0aaYMJowyux3g9v/s92O1GHdn/q6AORA5Xjx0Wg8rhZQFrbJV3
        NhzVkx8Mo2GspuSQtT9x7jnvbPQqLWxrkquRCOQYCRiEzTovAPAPY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54C011036AA;
        Mon,  6 Dec 2021 17:48:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA4191036A9;
        Mon,  6 Dec 2021 17:48:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v2 1/3] branch: move --set-upstream-to behavior to
 setup_tracking()
References: <20211122223252.19922-1-chooglen@google.com>
        <20211206215528.97050-1-chooglen@google.com>
        <20211206215528.97050-2-chooglen@google.com>
Date:   Mon, 06 Dec 2021 14:48:33 -0800
In-Reply-To: <20211206215528.97050-2-chooglen@google.com> (Glen Choo's message
        of "Mon, 6 Dec 2021 13:55:26 -0800")
Message-ID: <xmqqbl1tcptq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A4BAC758-56E6-11EC-8609-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> As Jonathan noted in v1, the diff is quite large. I could shrink this
> by forward-declaring setup_tracking() so that the function definitions
> are in the same order; let me know if that would be preferred.

If you are not making any changes to setup_tracking() and just
moving, then the patch size inflated by the move is OK.

If you are moving and changing at the same time, well, that would
make it harder to read what is going on in the patch, so you want to
find a way to avoid it.  Splitting it the pure move into a separate
patch or use of forward-declaration may be good ways to do so.




>  branch.c          | 195 ++++++++++++++++++++++++++--------------------
>  branch.h          |  13 +++-
>  builtin/branch.c  |   7 +-
>  t/t3200-branch.sh |  17 ++++
>  4 files changed, 139 insertions(+), 93 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 07a46430b3..a635a60f8b 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -126,43 +126,6 @@ int install_branch_config(int flag, const char *local, const char *origin, const
>  	return -1;
>  }
>  
> -/*
> - * This is called when new_ref is branched off of orig_ref, and tries
> - * to infer the settings for branch.<new_ref>.{remote,merge} from the
> - * config.
> - */
> -static void setup_tracking(const char *new_ref, const char *orig_ref,
> -			   enum branch_track track, int quiet)
> -{
> -	struct tracking tracking;
> -	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
> -
> -	memset(&tracking, 0, sizeof(tracking));
> -	tracking.spec.dst = (char *)orig_ref;
> -	if (for_each_remote(find_tracked_branch, &tracking))
> -		return;
> -
> -	if (!tracking.matches)
> -		switch (track) {
> -		case BRANCH_TRACK_ALWAYS:
> -		case BRANCH_TRACK_EXPLICIT:
> -		case BRANCH_TRACK_OVERRIDE:
> -			break;
> -		default:
> -			return;
> -		}
> -
> -	if (tracking.matches > 1)
> -		die(_("Not tracking: ambiguous information for ref %s"),
> -		    orig_ref);
> -
> -	if (install_branch_config(config_flags, new_ref, tracking.remote,
> -			      tracking.src ? tracking.src : orig_ref) < 0)
> -		exit(-1);
> -
> -	free(tracking.src);
> -}
> -
>  int read_branch_desc(struct strbuf *buf, const char *branch_name)
>  {
>  	char *v = NULL;
> @@ -243,33 +206,35 @@ N_("\n"
>  "will track its remote counterpart, you may want to use\n"
>  "\"git push -u\" to set the upstream config as you push.");
>  
> -void create_branch(struct repository *r,
> -		   const char *name, const char *start_name,
> -		   int force, int clobber_head_ok, int reflog,
> -		   int quiet, enum branch_track track)
> +/**
> + * Validates whether a ref is a valid starting point for a branch, where:
> + *
> + *   - r is the repository to validate the branch for
> + *
> + *   - start_name is the ref that we would like to test. This is
> + *     expanded with DWIM and assigned to real_ref.
> + *
> + *   - track is the tracking mode of the new branch. If tracking is
> + *     explicitly requested, start_name must be a branch (because
> + *     otherwise start_name cannot be tracked)
> + *
> + *   - oid is an out parameter containing the object_id of start_name
> + *
> + *   - real_ref is an out parameter containing the full, 'real' form of
> + *     start_name e.g. refs/heads/main instead of main
> + *
> + */

Good description that will help reviewers and future developers.
Very much appreciated.

> +static void validate_branch_start(struct repository *r, const char *start_name,
> +				  enum branch_track track,
> +				  struct object_id *oid, char **real_ref)
>  {
>  	struct commit *commit;
> -	struct object_id oid;
> -	char *real_ref;
> -	struct strbuf ref = STRBUF_INIT;
> -	int forcing = 0;
> -	int dont_change_ref = 0;
>  	int explicit_tracking = 0;
>  
>  	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
>  		explicit_tracking = 1;
>  
> -	if ((track == BRANCH_TRACK_OVERRIDE || clobber_head_ok)
> -	    ? validate_branchname(name, &ref)
> -	    : validate_new_branchname(name, &ref, force)) {
> -		if (!force)
> -			dont_change_ref = 1;
> -		else
> -			forcing = 1;
> -	}
> -
> -	real_ref = NULL;
> -	if (get_oid_mb(start_name, &oid)) {
> +	if (repo_get_oid_mb(r, start_name, oid)) {
>  		if (explicit_tracking) {
>  			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
>  				error(_(upstream_missing), start_name);

The post context continues with:

				advise(_(upstream_advice));
				exit(1);
			}
			die(_(upstream_missing), start_name);

This is not a problem with this patch, and it should not be fixed as
part of this series, but since I noticed it, I'll mention it as a
leftover low-hanging fruit to be fixed after the dust settles.  The
exit(1) looks wrong.  We should exit with 128 just like die() does.
Issuing of an advice message should not affect the exit code.

> +void setup_tracking(const char *new_ref, const char *orig_ref,
> +			   enum branch_track track, int quiet, int expand_orig)

It is unclear what expand_orig option is supposed to do and how it
would help the caller.  Perhaps a comment before the function is in
order (the comment in branch.h before the declaration of this
function does not make it clear, either).

> +{
> +	struct tracking tracking;
> +	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
> +	char *full_orig_ref;
> +	struct object_id unused_oid;
> +
> +	memset(&tracking, 0, sizeof(tracking));
> +	if (expand_orig)
> +		validate_branch_start(the_repository, orig_ref, track, &unused_oid, &full_orig_ref);

So, the idea is, because we are setting up a new_ref to "track"
orig_ref, we may be better off pretending that we are "creating a
new branch from the orig_ref and tracking it", so that orig_ref that
is not something we can track will be caught with the same logic?

This will cause full_orig_ref to start with "refs/heads/" or
"refs/remotes/" if 'track' is something that requires tracking.

> +	else
> +		full_orig_ref = xstrdup(orig_ref);

Even though the variable claims to be FULL orig_ref, when this side
of if/else is taken, nobody guarantees that full_orig_ref is in fact
a full ref, or merely the name of the branch, no?  Would that cause
problems later?

> +	tracking.spec.dst = full_orig_ref;
> +	if (for_each_remote(find_tracked_branch, &tracking))
> +		goto cleanup;
> +
> +	if (!tracking.matches)
> +		switch (track) {
> +		case BRANCH_TRACK_ALWAYS:
> +		case BRANCH_TRACK_EXPLICIT:
> +		case BRANCH_TRACK_OVERRIDE:
> +			break;
> +		default:
> +			goto cleanup;
> +		}
> +
> +	if (tracking.matches > 1)
> +		die(_("Not tracking: ambiguous information for ref %s"),
> +		    full_orig_ref);

What's the next step for the user to take, after seeing this message?
Do we have the necessary info readily available to help them at this
point in tracking.* structure (e.g. "it could be following X or Y and
we cannot decide between the two for you"), or have we discarded the
information already?

If tracking.matches == 0, because we broke out of the switch() for
some values of track, we will make this install_branch_config()
using members of the tracking structure, which is a bit unnerving.

> +	if (install_branch_config(config_flags, new_ref, tracking.remote,
> +			      tracking.src ? tracking.src : full_orig_ref) < 0)

But tracking.src==NULL is substituted with full_orig_ref, so as long
as the value in that variable is sensible, we would probably be ok
on the 4th parameter.  I am not sure who set tracking.remote or if
it is always set to a sensible value.  Especially when tracking.matches
is zero.

> +		exit(-1);

Don't exit with a negative value.

> +cleanup:
> +	free(tracking.src);
> +	free(full_orig_ref);
> +}

I'll stop here for now.

Thanks.

