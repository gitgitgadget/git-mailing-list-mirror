From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add a pre-merge hook
Date: Wed, 27 Aug 2008 11:02:18 -0700
Message-ID: <7v63pmqqtx.fsf@gitster.siamese.dyndns.org>
References: <E1KW9NC-0003mM-6F@fencepost.gnu.org>
 <E1KYK3t-0000ZX-3b@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 20:03:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYPMf-0008Uv-Tq
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 20:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbYH0SCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 14:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbYH0SCZ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 14:02:25 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbYH0SCY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 14:02:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B0F246AA25;
	Wed, 27 Aug 2008 14:02:23 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8C88A6AA21; Wed, 27 Aug 2008 14:02:20 -0400 (EDT)
In-Reply-To: <E1KYK3t-0000ZX-3b@fencepost.gnu.org> (Paolo Bonzini's message
 of "Tue, 27 Aug 2008 14:19:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4CEC314E-7462-11DD-9950-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93910>

Paolo Bonzini <bonzini@gnu.org> writes:

> +pre-merge
> +---------
> +
> +This hook is invoked before a merge is attempted.  The command
> +line passed to the hook can have multiple parameters.  The
> +first parameter is the type of merge, which can be one of
> +"squash" (if --squash was given on the command line), "ff"
> +(fast-forward), "trivial" (trivial in-index merge), "merge"
> +(non-trivial 2-head merge), "octopus" (any other merge).  After this
> +there is a "--" argument, followed by the commit SHA1 values for the
> +heads being merged.

I think we should have done something like this for post_merge, not just
"1/0 to show if it is a squash" which was an ill-thought-out hack.  Is
there a clean way to fix the interface without breaking existing
post_merge hooks in people's repositories?

> +The hook can interrupt the merge by returning a non-zero
> +status.  The default hook checks for a boolean configuration
> +key `branch.<branch-name>.allowmerges`, where `<branch-name>`
> +is the current branch.  If the key is false, only squash or
> +fast-forward merges are allowed.

Please call whatever you install from template/hooks--* a "sample", not
"default".

> +static int run_hook(const char *name, struct commit_list *heads, ...)
>  {
> + ...
> +	if (heads) {
> +		argv[i] = "--";
> +		first_remote_head = i + 1;
> +		for (; heads; heads = heads->next)
> +			argv[++i] = xstrdup(sha1_to_hex(heads->item->object.sha1));
> +		argv[++i] = NULL;
> +	} else
> +		first_remote_head = i;

Making this function varargs is fine, but this heads==NULL condition needs
some explanation.

If it is primarily a hack to support calling post-merge with an non-object
name "0" or "1", probably it will be _much_ cleaner to make this a
separate function that does not know anything about post-merge calling
convention (it can share the boilerplate parts such as "hook.no_stdin = 1"
with the function that calls post-merge, of course).

> +static int run_pre_merge_hook(const char *kind)
> +{
> +	return run_hook("pre-merge", remoteheads,
> +			squash ? "squash" : kind, "--", NULL);
>  }

remoteheads is a commit_list, you have the name of the hook and kind, so
this extra "--" is only for run_hook() hackery to distinguish between the
callers to post-merge and the callers to new pre-merge?

The general idea to add "pre-merge" hook may be sound, but the run_hook()
implementation looks quite unclean.
