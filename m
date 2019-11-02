Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8537E1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 10:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfKBKHY (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 06:07:24 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54452 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfKBKHX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 06:07:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA43388155;
        Sat,  2 Nov 2019 06:07:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CpFX4W//0lOvbEf3hHz1/iagb40=; b=MlUApk
        eabxc+tG2RWaPyaOPMsBMksYK8Uh7qcgw2WhQACUqcwf3LsOsylRyD5XcEdyWYWd
        J98pnhbWA9YHAEx5GgkeAOuJR1de+1DfLUOtYznMxc+3+YCPPVHAkKCBjDGXURY1
        VDi5pLMB5iPI9ZnES6rjAYgQ4J5WyvGvis5I8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FFKUi/jIkUYsBFRUYAi3KbsS/ZTkOGpT
        WfZs8k5uTbaOmtzwGZtEHVciJQPUpnNOgNiHumCvqrQ4T6sZQOQgg4WcuzoRKQmp
        kf/0IzaY2WZ5qoYPHF9X2N1/h3uXzNLOWtJwShlQXBek4bpyqC/ampbBL6oOpJUV
        rWk62xTsVeo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EFE388152;
        Sat,  2 Nov 2019 06:07:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B889C88151;
        Sat,  2 Nov 2019 06:07:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Davide Berardi <berardi.dav@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net
Subject: Re: [PATCH] Segmentation Fault on non-commit --branch clone
References: <20191101002432.GA49846@carpenter.lan>
Date:   Sat, 02 Nov 2019 19:07:17 +0900
In-Reply-To: <20191101002432.GA49846@carpenter.lan> (Davide Berardi's message
        of "Fri, 1 Nov 2019 01:24:32 +0100")
Message-ID: <xmqqlfsy1tii.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E4A7B88-FD58-11E9-9D44-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Davide Berardi <berardi.dav@gmail.com> writes:

> +static int fallback_on_noncommit(const struct ref *check,
> +				 const struct ref *remote,
> +				 const char *msg)
> +{
> +	if (check == NULL)
> +		return 1;
> +	struct commit *c = lookup_commit_reference_gently(the_repository,
> +						   &check->old_oid, 1);

This is decl-after-stmt.  Can check be NULL, though?  IOW, the first
two lines in this function should go.

> +	if (c == NULL) {

We tend to say "if (!c) {" instead.

> +		/* Fallback HEAD to fallback refs */

You are falling back to just a single ref (i.e. s/refs/ref/) but
more importantly, what the code is doing is obvious enough without
this comment.  What we want commenting on is _why_ we do this.

	/*
	 * The ref specified to be checked out does not point at a
	 * commit so pointing HEAD at it will leave us a broken
         * repository.  But we need to have _something_ plausible
	 * in HEAD---otherwise the result would not be a repository.
	 */

would explain why we point HEAD to the default 'master' branch.

> +		warning(_("%s is not a valid commit object, HEAD will fallback to %s"),
> +			check->name, FALLBACK_REF);
> +		update_ref(msg, FALLBACK_REF, &remote->old_oid, NULL,
> +			   REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);

Having said that, I was hoping that this would use the help from the
guess_remote_head() like the case without "-b" option does, so that
we do not have to use a hardcoded default.

> +	}
> +
> +	return c == NULL;

Our API convention is 0 for success and negavive for failure.

> +}
> +
> static void update_head(const struct ref *our, const struct ref *remote,
> 			const char *msg)
> {
> 	const char *head;
> 	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
> +		if (fallback_on_noncommit(our, remote, msg) != 0)
> +			return;
> 		/* Local default branch link */
> 		if (create_symref("HEAD", our->name, NULL) < 0)
> 			die(_("unable to update HEAD"));
> @@ -718,12 +739,17 @@ static void update_head(const str

Here in the patch context is a "do this in a non-bare repository"
guard, and crucially, we do this:

> 			install_branch_config(0, head, option_origin, our->name);

That is, we add configuration for our->name (which is now
"refs/heads/master"), but I do not think we updated any of the other
field in *our to make the world a consistent place.  Is the object
pointed at by our local refs/heads/master in a reasonable
relationship with the object at the tip of the 'master' branch at
the remote site, or is can totally be unrelated because we made no
attempt to make our->old_oid or whatever field consistent with the
"corrected" reality?

Given the potential complication, and given that we are doing a
corretive action only so that we leave some repository the user can
fix manually, I am inclined to say that we should avoid falling into
this codepath.  I'll wonder about a totally different approach later
in this message that makes the fallback_on_noncommit() helper and
change to these existing parts of the update_head() function
unnecessary.

> 		}
> 	} else if (our) {
> +		if (fallback_on_noncommit(our, remote, msg) != 0)
> +			return;
> +		/* here commit is valid */
> 		struct commit *c = lookup_commit_reference(the_repository,
> 							   &our->old_oid);

What makes us certain that commit is valid?  our->old_oid is not
adjusted by the fallback_on_noncommit() function, but we did check
if it is a commit by doing the exact same lookup_commit_reference()
in there already, and we know it found a commit (otherwise the
function would have returned a non-zero to signal an error).

But it also means that we are making a redundant and unnecessary
call if the code is structured better.

This makes me wonder why we are not adding a single call to a helper
function at the beginning of the function, something like

	const struct oid *tip = NULL;
	struct commit *tip_commit = NULL;

	if (our)
		tip = &our->old_oid;
	else if (remote)
		tip = &remote->old_oid;

	if (!tip)
		return;

	tip_commit = lookup_commit_reference_gently(the_repository, tip);

Then, if !tip_commit, we know we need to fall back to something.  I
actually think it would probably be cleanest if we added

	if (!tip_commit) {
		/*
		 * The given non-commit cannot be checked out,
                 * so have a 'master' branch and leave it unborn.
                 */
		warning(_"non-commit cannot be checked out");
		create_symref("HEAD", "refs/heads/master", msg);
		return;
	}

That is, we always check out an unborn 'master' branch (which would
yield another warning at the beginning of checkout() function, which
is what we want) doing minimum damage, without even configuring any
remote tracking information.

The rest of the update_head() function could be left as-is, but with
the "see what we would be checking out first" approach, we probably
can lose some code (like the call to lookup_commit_reference() in
the "detached HEAD" case), without adding any extra logic.

> 	} else if (remote) {
> +		if (fallback_on_noncommit(remote, remote, msg) != 0)
> +			return;
> 		/*
> 		 * We know remote HEAD points to a non-branch, or
> 		 * HEAD points to a branch but we don't know which one.

Thanks.
