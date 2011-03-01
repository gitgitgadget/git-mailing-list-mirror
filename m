From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2 v2] push: better error messages when push.default =
 tracking
Date: Tue, 01 Mar 2011 10:34:02 -0800
Message-ID: <7vhbbmellx.fsf@alter.siamese.dyndns.org>
References: <1298927645-2716-1-git-send-email-Matthieu.Moy@imag.fr>
 <1298970662-25828-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Mar 01 19:34:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuUOn-0007L8-OR
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 19:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756773Ab1CASeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 13:34:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756194Ab1CASeL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 13:34:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5819F4BE1;
	Tue,  1 Mar 2011 13:35:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dDe0AvLnk7010gon7PqmWe6tKi8=; b=dYM4O/
	/NulR9sfQzZ//O42TsR5jtDYvWBvwU5y4uDRTGpUpbGcGgdXkvZ04u79fAQXpa5e
	ySHipBHP8kwvL/sqRJSXb816We9izBdF5ZAnU159ujJe6SWel/OXyBis2A+aTPkG
	VRoc0i6pTjvHUiQ3mYu9wlDGv5gtqegVDR90w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rUfjGtsqOl2lybI21pwhrl2oXTWB19as
	Syg5thxiqlmN2NkiNuIJsxa2gLV5gCUcTc4Vn362jK8xHPkrZ8UfqRrDq3y2AlD5
	8Dm1gV0wUBBJboBcWj05KrskadjQxSblCQAM0rFS0Gnuo+6n8xxEY8yHymdJlY2u
	d9a8ziC0OuY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 320994BE0;
	Tue,  1 Mar 2011 13:35:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 176BD4BDA; Tue,  1 Mar 2011
 13:35:24 -0500 (EST)
In-Reply-To: <1298970662-25828-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Tue\,  1 Mar 2011 10\:11\:01 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AE221094-4432-11E0-BDBB-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168236>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> diff --git a/builtin/push.c b/builtin/push.c
> index 31da418..c949187 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -64,14 +64,23 @@ static void set_refspecs(const char **refs, int nr)
>  	}
>  }
>  
> -static void setup_push_upstream(void)
> +static void setup_push_upstream(struct remote *remote)
>  {
>  	struct strbuf refspec = STRBUF_INIT;
>  	struct branch *branch = branch_get(NULL);
>  	if (!branch)
> -		die("You are not currently on a branch.");
> +		die("You are not currently on a branch (detached HEAD).\n"
> +		    "To push a specific branch and set the remote as upstream, use\n"
> +		    "\n"
> +		    "    git push --set-upstream %s <branch-name>\n",
> +		    remote->name);

For all the other cases covered in this patch, the sequence that lead to
this situation would be like this:

	git checkout somebranch
        hack hack hack including commits
        git push

and it is very clear that the user wants to push the current branch to the
corresponding place but the user is getting an error because there is no
"corresponding place" mapping established yet.

I agree "push --set-upstream" is a very good advice to give under that
scenario---it would push the history s/he wanted to push right now, while
establishing the mapping for later use, both at the same time with a
single command.

However, I don't think that applies to this case with detached HEAD; it is
more likely that the user came here this way:

	git checkout somebranch~4 ;# the tip 3 are not quite ready
        hack hack quickfix to do only the sure part of the tip 3 did
        commit and test
        git push

Maybe the user needed to quickly push out a minimum fix out of the more
elaborate work, in which case, what would follow in the workflow is first
to:

	git push origin HEAD:somebranch

in order to unblock others.  This will then be followed by a more
leisurely:

	git rebase HEAD somebranch

to get back to the more elaborate work that is not yet presentable.

It is not likely that the end user wanted to:

	git checkout $not_a_branch_tip ;# detached
        hack hack hack including commits
        git push origin an_unrelated_branch

and wanted to omit "where and what" part.  We are talking about "push the
current branch only to corresponding destination" people, so if that
unrelated branch were already ready for external consumption, they would
have already pushed it out at the end of the session when they were on
that branch (and seen the other advice you are adding in this patch).

That is why I suggested to advice an explicit push, without checkout nor
set upstream, in my original review message.  IOW, I think the message
should instead suggest:

	If you want to push the history leading to the current (detached)
	state now, use

	    git push $remote HEAD:the-branch-you-want-to-push-to
