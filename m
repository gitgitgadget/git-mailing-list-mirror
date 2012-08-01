From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cherry-picking commits with empty messages
Date: Wed, 01 Aug 2012 10:52:34 -0700
Message-ID: <7vd33afqjh.fsf@alter.siamese.dyndns.org>
References: <20120801111658.GA21272@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 19:52:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Swd6B-0006H3-Qg
	for gcvg-git-2@plane.gmane.org; Wed, 01 Aug 2012 19:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab2HARwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 13:52:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44180 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754518Ab2HARwh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 13:52:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A251A907D;
	Wed,  1 Aug 2012 13:52:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ts0hm0C9BdQtFI34eYAzaocQt98=; b=QYQHGR
	rnTQeSWmIWrfeBjOvauzMYI4Gfbjjb7WSMvaOCP2SfTysGjb8BW64lWsuRJHPsOo
	q0EZZbPam0yjLREdeshefubGNg08eHXMOSTF3YvFAaRsKl1G9/jX8XpMQ5ocgbFH
	ta+p+ZRctYKdEHFwqvQ3ZycxtLUILL4WhNm9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pxvVwJpkElA6K00fYk+U8EuWQDabWh2J
	jio6/tA/gHV7w3ws0Y1fe0TJSD2ifudolc9114nh/HR6T7DzLNhP+xGpsx54QWFC
	gOv55TigCohGPXzU5YPHaDoGDa1EFCouys1FAtiGIYMbgvB4ZqgBxPOurxcIl/s2
	WKncoVVA99A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8854C907C;
	Wed,  1 Aug 2012 13:52:36 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B4D79907B; Wed,  1 Aug 2012
 13:52:35 -0400 (EDT)
In-Reply-To: <20120801111658.GA21272@arachsys.com> (Chris Webb's message of
 "Wed, 1 Aug 2012 12:16:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD3F030E-DC01-11E1-A72A-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202715>

Chris Webb <chris@arachsys.com> writes:

[summary: this, when 59a8fde does not have any commit log message,
refuses to commit]

>   $ git cherry-pick 59a8fde
>   Aborting commit due to empty commit message.

> I can see that this check could make sense when the message has been
> modified, but it seems strange when it hasn't, and isn't ideal behaviour
> when called from rebase -i. (We otherwise make sure we call git commit with
> --allow-empty-message to avoid problems with reordering or editing empty
> commits.)
> 
> I could just remove the check in the 'message unmodified' case with
> something like
>
> diff --git a/sequencer.c b/sequencer.c
> index bf078f2..cf8bc05 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -306,6 +306,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>  	if (!opts->edit) {
>  		argv_array_push(&array, "-F");
>  		argv_array_push(&array, defmsg);
> +		argv_array_push(&array, "--allow-empty-message");
>  	}
>  
>  	if (allow_empty)
>
> but perhaps there are other users of the sequencer for whom this check is
> desirable? If so, would an --allow-empty-message to git cherry-pick be a
> better plan, which git rebase -i can use where appropriate?

A few random thoughts.

 - Any Porcelain commands that implement the sequencing workflow, if
   they know what message to use when they internally run "commit"
   without allowing the user to edit the message, share the same
   issue.

 - We generally try to encourage users to describe commits, and
   commits with empty log messages are strongly frowned upon.

   In that sense, one could argue that cherry-pick did the right
   thing when it gave control back to you upon seeing an empty
   message.  The user is given a chance to fix the commit by running
   "git commit" at that point to give it a descriptive message.

 - These Porcelain programs, however, work from existing commits,
   and the reason why "git commit" invoked by them may be stopped
   due to empty log message is because the original commits had
   empty log message to begin with.  The user must have done so on
   purpose (e.g. by using "commit --allow-empty-message").

   In that sense, it is likely that the user will simply choose to
   run "git commit --allow-empty-message", even if given a chance by
   "cherry-pick" to correct the empty log message.  This is a
   counter-point to the "give the user a chance to fix" above.
   We _might_ not be adding much value to the system by giving the
   control back to the user.

 - We had a similar discussion on what should happen when one step
   in "cherry-pick" results in the same tree as the commit the
   'pick' builds on (i.e. an empty change).  The situation is a bit
   different from yours, because unlike the log message, an empty
   change can result by either (1) the original was an empty change,
   or (2) the change picked was already present in the updated base.
   We added "--keep-redundant-commits" and "--allow-empty" options
   to underlying "cherry-pick" to support this distinction.

   We may want to follow suit by triggering your change above only
   when "cherry-pick --allow-empty-message" was given.  This is
   siding with the "give the user a chance to fix" viewpoint to
   choose the default, and giving the users a way to overriding it.

 - Regarding the choice of default between "--allow-empty-message"
   vs "--no-allow-empty-message", one could argue that the best
   choice of the default depends on the Porcelain command.

   - A non-range cherry-pick (e.g. "cherry-pick A B C") is a strong
     hint from the user that the user wants to replay the specific
     commits that are named on the command line.  This fact may
     favor "the user must have done so on purpose" viewpoint over
     "give the user a chance to fix" viewpoint; defaulting to
     "--allow-empty-message" (and "--allow-empty", and perhaps
     "--keep-redundant-commits") might be more convenient for a
     non-range cherry-pick.

   - A range cherry-pick (e.g. "cherry-pick A..B") and "rebase -i",
     on the other hand, are primarily used to rebuild (and reorder
     in the case of "rebase -i") the history to clean it up, which
     may favor "give the user a chance to fix", i.e. defaulting not
     to enable "--allow-empty"-anything might be more convenient for
     a sequencing operation over a range in general.

   But from the bigger UI consistency point of view, it would be
   chaotic to change the default of some options for a single
   command depending on the nature of the operand, so I would
   recommend against going this route, and pick one view between
   "give the user a chance to fix" or "the user must have done so on
   purpose" and apply it consistently.

My recommendation, backed by the above line of thought, is to add
support for the "--allow-empty-message" option to both "rebase [-i]"
and "cherry-pick", defaulting to false.
