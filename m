From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] revert: only suggest to commit if not passing -n
Date: Thu, 12 Aug 2010 21:54:41 -0700
Message-ID: <7vvd7fkt7y.fsf@alter.siamese.dyndns.org>
References: <20100723164218.GA2284@localhost.localdomain>
 <1280062470-21891-1-git-send-email-carenas@sajinet.com.pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
X-From: git-owner@vger.kernel.org Fri Aug 13 06:55:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjmIH-0008Qu-Ic
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 06:55:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670Ab0HMEyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 00:54:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:61273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab0HMEyu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 00:54:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E599CD0D3;
	Fri, 13 Aug 2010 00:54:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3GYVIOz2tEUVnGvYYIQsws88nz4=; b=uX8FVi
	RbqYaNJuUiSsNyHbvyGvUaoovxiWm1Mt+jFQwFm3iE9r3/zuCM7qnLHtZawWphWg
	vD3Xh4G4/qYTHR5/GsQVGO1t5iA1JTWHurUo6rvN+l+bJeKnaTA/Iu0cbQ8hyRPI
	Q1YMz9yHe5KuDTs9G+R3ksAP3ovj070C2faLU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tYA7up4rbNzaqa0wFBvs2RJTvqCbFfv4
	zPEmMwQulqw/4Uc5SUimZ87iV5D2jsAsqbNSoS1qw4URSc80lBul47HShYUpG208
	XVcOECa4cDP19h7rCZhBfaIzznr3F+WAZKEjCB27VoPvi3soKPEPltP9ICkS2Lbv
	7uJkrlvdhhg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 57CACCD0D2;
	Fri, 13 Aug 2010 00:54:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71148CD0D1; Fri, 13 Aug
 2010 00:54:43 -0400 (EDT)
In-Reply-To: <1280062470-21891-1-git-send-email-carenas@sajinet.com.pe>
 (Carlo Marcelo Arenas Belon's message of "Sun\, 25 Jul 2010 05\:54\:30
 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E518FA8E-A696-11DF-A270-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153461>

Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe> writes:

> while doing revert or cherry-pick, if the automatic merge fails
> and the user specifically suggested he didn't want to commit,
> then don't suggest to do that as part of the conflict resolution.

I agree that the suggestion does not make sense, but realistically, when
the user said

    git cherry-pick --no-commit $something

we have no idea if the user wants to add or remove once the conflict has
been resolved.  More often than not, "cherry-pick --no-commit" is followed
by further edit, at least in the use cases I've seen, so "git add/rm" is
not the first command the user will run after resolving the conflicts.

So it _might_ make sense not to even suggest "add/rm" in that case.

After all, this is a help/advice message, and "cherry-pick --no-commit"
is sort of an advanced feature anyway, so...

> Signed-off-by: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
> ---
>  builtin/revert.c |   20 ++++++++++++--------
>  1 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 8b9d829..b7cb69b 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -250,14 +250,18 @@ static char *help_msg(void)
>  		return msg;
>  
>  	strbuf_addstr(&helpbuf, "  After resolving the conflicts,\n"
> -		"mark the corrected paths with 'git add <paths>' or 'git rm <paths>'\n"
> -		"and commit the result");
> +		"mark the corrected paths with 'git add <paths>' or 'git rm <paths>'");
> +	if (!no_commit) {
> +		strbuf_addstr(&helpbuf, "\nand commit the result");
>  
> -	if (action == CHERRY_PICK) {
> -		strbuf_addf(&helpbuf, " with: \n"
> -			"\n"
> -			"        git commit -c %s\n",
> -			    sha1_to_hex(commit->object.sha1));
> +		if (action == CHERRY_PICK) {
> +			strbuf_addf(&helpbuf, " with: \n"
> +				"\n"
> +				"        git commit -c %s\n",
> +				    sha1_to_hex(commit->object.sha1));
> +		}
> +		else
> +			strbuf_addch(&helpbuf, '.');
>  	}
>  	else
>  		strbuf_addch(&helpbuf, '.');
> -- 
> 1.7.2
