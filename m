From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4.1 5/5] push: update remote tags only with force
Date: Mon, 19 Nov 2012 12:23:20 -0800
Message-ID: <7va9udxryf.fsf@alter.siamese.dyndns.org>
References: <1353183397-17719-6-git-send-email-chris@rorvick.com>
 <1353189237-19491-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 21:23:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaXsd-0005zh-ED
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 21:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754826Ab2KSUX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 15:23:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57850 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754782Ab2KSUX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 15:23:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6B57A10A;
	Mon, 19 Nov 2012 15:23:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CW4KQsIpeTJviNBx5m79ga+Iv2Y=; b=kFBfh0
	P8dQKwYhmQqCDNhtQKkPkD8KcxrM3W2o/syBgqPhC8gvNQq7XE49M3EfpzYHuARP
	ut6g+OGjlgKIg4aRAv+Gxl24AMUoZNv46WnILzeIQP4tqxC749okRefa3lhj2gAp
	Kv9yBc+Lo2jlNzVPL5LL5RlEMvBsVenRxKaMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dEguN//cTKowShBpXN7ycY6Hc3t7fh+S
	11C1Mlz5+GXFyacZ3B/wsHjKsIYqzxiFi5Gdefl/CNLEBA9FUUjYGcugDERjf5kX
	qO4g0iKEx42ecwDgwBj8GPYdc8VOQSrvXvCadah1Aml572bIrRj8GayaUHVigRNQ
	S3HsXeivXCY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2FEEA109;
	Mon, 19 Nov 2012 15:23:25 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10FD0A103; Mon, 19 Nov 2012
 15:23:25 -0500 (EST)
In-Reply-To: <1353189237-19491-1-git-send-email-chris@rorvick.com> (Chris
 Rorvick's message of "Sat, 17 Nov 2012 15:53:57 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F886AC32-3286-11E2-B860-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210051>

Chris Rorvick <chris@rorvick.com> writes:

> References are allowed to update from one commit-ish to another if the
> former is a ancestor of the latter.  This behavior is oriented to
> branches which are expected to move with commits.  Tag references are
> expected to be static in a repository, though, thus an update to a
> tag (lightweight and annotated) should be rejected unless the update is
> forced.
>
> To enable this functionality, the following checks have been added to
> set_ref_status_for_push() for updating refs (i.e, not new or deletion)
> to restrict fast-forwarding in pushes:
>
>   1) The old and new references must be commits.  If this fails,
>      it is not a valid update for a branch.
>
>   2) The reference name cannot start with "refs/tags/".  This
>      catches lightweight tags which (usually) point to commits
>      and therefore would not be caught by (1).
>
> If either of these checks fails, then it is flagged (by default) with a
> status indicating the update is being rejected due to the reference
> already existing in the remote.  This can be overridden by passing
> --force to git push.

This, if it were implemented back when we first added "git push",
would have been a nice safety, but added after 1.8.0 it would be a
regression, so we would need backward compatibility notes in the
release notes.

Not an objection; just making a mental note.

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index fe46c42..479e25f 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -51,11 +51,11 @@ be named. If `:`<dst> is omitted, the same ref as <src> will be
>  updated.
>  +
>  The object referenced by <src> is used to update the <dst> reference
> -on the remote side, but by default this is only allowed if the
> -update can fast-forward <dst>.  By having the optional leading `+`,
> -you can tell git to update the <dst> ref even when the update is not a
> -fast-forward.  This does *not* attempt to merge <src> into <dst>.  See
> -EXAMPLES below for details.
> +on the remote side.  By default this is only allowed if the update is
> +a branch, and then only if it can fast-forward <dst>.  By having the

I can already see the next person asking "I can update refs/notes
the same way.  The doc says it applies only to the branches.  Is
this a bug?".

> diff --git a/cache.h b/cache.h
> index f410d94..127e504 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1004,13 +1004,14 @@ struct ref {
>  		requires_force:1,
>  		merge:1,
>  		nonfastforward:1,
> -		is_a_tag:1,
> +		forwardable:1,

This is somewhat an unfortunate churn.  Perhaps is_a_tag could have
started its life under its final name in the series?

I am assuming that the struct members will be initialized to 0 (false),
so everything by default is now not forwardable if somebody forgets
to set this flag?

>  	enum {
>  		REF_STATUS_NONE = 0,
>  		REF_STATUS_OK,
>  		REF_STATUS_REJECT_NONFASTFORWARD,
> +		REF_STATUS_REJECT_ALREADY_EXISTS,
>  		REF_STATUS_REJECT_NODELETE,
>  		REF_STATUS_UPTODATE,
>  		REF_STATUS_REMOTE_REJECT,
> diff --git a/remote.c b/remote.c
> index 44e72d6..a723f7a 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1311,14 +1311,24 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>  		 *     to overwrite it; you would not know what you are losing
>  		 *     otherwise.
>  		 *
> -		 * (3) if both new and old are commit-ish, and new is a
> -		 *     descendant of old, it is OK.
> +		 * (3) if new is commit-ish and old is a commit, new is a
> +		 *     descendant of old, and the reference is not of the
> +		 *     refs/tags/ hierarchy it is OK.
>  		 *
>  		 * (4) regardless of all of the above, removing :B is
>  		 *     always allowed.
>  		 */

I think this is unreadable.  Isn't this more like

    (1.5) if the destination is inside refs/tags/ and already
          exists, you are not allowed to overwrite it without
          --force or +A:B notation.

early in the rule set?

> -		ref->is_a_tag = !prefixcmp(ref->name, "refs/tags/");
> +		if (prefixcmp(ref->name, "refs/tags/")) {
> +			/* Additionally, disallow fast-forwarding if
> +			 * the old object is not a commit.  This kicks
> +			 * out annotated tags that might pass the
> +			 * is_newer() test but dangle if the reference
> +			 * is updated.
> +			 */

Huh?  prefixcmp() excludes refs/tags/ hierarchy. What is an
annotated tag doing there?  Is this comment outdated???

	/*
         * Also please end the first line of a multi-line
         * comment with '/', '*', and nothing else.
         */

Regarding the other arm of this "if (not in refs/tags/ hierarchy)",
what happens when refs/tags/foo is a reference to a blob or a tree?
This series declares that the point of tag is not to let people to
move it willy-nilly, and I think it is in line with its spirit if
you just rejected non-creation events.

Also, I suspect that you do not even need to have old object locally
when looking at refs/tags/ hierarchy.  "Do not overwrite tags" can
be enforced by only noticing that they already have something; you
do not know what that something actually is to prevent yourself from
overwriting it.  You may have to update the rule (2) in remote.c
around l.1311 for this.

> +test_expect_success 'push requires --force to update lightweight tag' '
> +	mk_test heads/master &&
> +	mk_child child1 &&
> +	mk_child child2 &&
> +	(
> +		cd child1 &&
> +		git tag Tag &&
> +		git push ../child2 Tag &&

Don't you want to make sure that another "git push ../child2 Tag" at
this point, i.e. attempt to update Tag with the same, should succeed
without --force?
