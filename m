From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: warn users about updating existing tags on push
Date: Mon, 30 Aug 2010 01:03:39 -0700
Message-ID: <7v7hj8frxg.fsf@alter.siamese.dyndns.org>
References: <20100828012101.GB2004@burratino>
 <1282983736-3233-1-git-send-email-cxreg@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 10:03:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpzLR-0004vw-Py
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 10:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956Ab0H3IDv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 04:03:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37255 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab0H3IDt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 04:03:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A440D1AC3;
	Mon, 30 Aug 2010 04:03:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=3asuUzPOz1nRJTJ/kel7M/uGs2s=; b=bdxpzmtYA5isSXNJhR/2TAL
	S1eIGkAf0w/Mg2H1kf2gygJSNjfi60j1xi0PCqMWmQ/a83xR/O+9BUO1PzXc/csO
	46swjyQcmihjoniCDxVax7T+UCPrk22h0ODib2SOyNSgI3jXw1gV+phqXZxVFxlr
	xhECuYFTivntVvRU8j7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=QIkX3h7UqOeLQvovlKV2uRnTvpFdIB/2JVBWy6xs+h7IuKTKD
	K6Pzmf5+xO9bIS4Jtyd1amZ3Lodv4e0Sf60FQ+hFTyoAkSZpNz2daBlukbx76/t3
	qFHdpn+eXU2y+EJ+qbh4izcaS3V3MzljvgA1ODEl/nsF91ewIam3Ei7MHQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EBB2AD1ABB;
	Mon, 30 Aug 2010 04:03:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD7B4D1ABA; Mon, 30 Aug
 2010 04:03:40 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1C736DBA-B40D-11DF-B2CC-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154774>

Dave Olszewski <cxreg@pobox.com> writes:

> Generally, tags are considered a write-once ref (or object), and updates
> to them are the exception to the rule.

This may be just the naming issue and you could say "moving them",
"updates to them" or "changing them" interchangeably in the above;
among them, "updates to them" sounds the most natural.

Can you change the "moving" in the patch to make them consistent with the
above description?

> However, there is presently nothing preventing a tag from being
> fast-forwarded, which can happen intentionally or accidentally.
> ... the user should be aware that they are changing something that is
> expected to be immutable and stable.

I actually think prevention of non-fast-forward updates for tags actually
is a misfeature that didn't even come from any concious design; the check
for fast-forwarding refs was to make sure we do not lose histories from
branches.  IOW, I would say this would have been a good feature if things
were like this from day one.

> diff --git a/remote.c b/remote.c
> index 9143ec7..fbca1e6 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -50,6 +50,8 @@ static int explicit_default_remote_name;
>  static struct rewrites rewrites;
>  static struct rewrites rewrites_push;
>  
> +static int deny_moving_tags;
> +
>  #define BUF_SIZE (2048)
>  static char buffer[BUF_SIZE];
>  
> @@ -385,6 +387,10 @@ static int handle_config(const char *key, const char *value, void *cb)
>  			add_instead_of(rewrite, xstrdup(value));
>  		}
>  	}
> +	if (!strcmp(key, "push.denymovingtags")) {
> +		deny_moving_tags = git_config_bool(key, value);
> +		return 0;
> +	}

Hmm, shouldn't this be per-remote (rather, shouldn't a per-remote variant
be allowed to override this)?

> @@ -1266,6 +1272,31 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>  			continue;
>  		}
>  
> +		/* If a tag already exists on the remote and points to
> +		 * a different object, we don't want to push it again
> +		 * without requiring the user to indicate that they know
> +		 * what they are doing.
> +		 */

	/*
         * We try to format
         * multi-line comment
         * like this.
         */

> +		if (!prefixcmp(ref->name, "refs/tags/") &&
> +		    !ref->deletion &&
> +		    !is_null_sha1(ref->old_sha1)) {
> +			if (deny_moving_tags) {
> +				/* Set `nonfastforward` for the sake of displaying
> +				 * this update as forced
> +				 */
> +				ref->nonfastforward = 1;

I think you are propagating this bit to print_ok_ref_status() in
transport.c; it indicates that after your change, "nonfastforward" does
not mean non-fast-forward anymore, doesn't it?

Perhaps the bit needs to be renamed to "update_forced" or something?

> +				if (!ref->force && !force_update) {
> +					ref->status = REF_STATUS_REJECT_MOVING_TAG;
> +				}
> +			} else {
> +				if (!ref->force && !force_update)
> +					warning("You are changing the value of an upstream tag.  This may\n"
> +						"be deprecated in a future version of Git.  Please use --force\n"
> +						"if this was intentional, and consider setting push.denyMovingTags.");
> +			}
> +			continue;
> +		}
> +
>  		/* This part determines what can overwrite what.
>  		 * The rules are:
>  		 *

You are changing the rule that determine what can overwrite what, aren't
you?  It is Ok (although it is in general frowned upon if you do so when
you do not have to) to add your new rule before an existing rule, but your
rule should be added as a new rule to the enumeration in the comment, and
the code that implements the new rule after the comment, no?

> diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
> index c718253..7906ba5 100755
> --- a/t/t5400-send-pack.sh
> +++ b/t/t5400-send-pack.sh
> @@ -106,6 +106,20 @@ test_expect_success 'denyNonFastforwards trumps --force' '
>  	test "$victim_orig" = "$victim_head"
>  '
>  
> +test_expect_success 'denyMovingTags trumps --force' '
> +	(
> +	    cd victim &&
> +	    ( git tag moving_tag master^ || : ) &&

In which circumstance is it allowed for this "git tag" command to
fail and the entire test to succeed?
