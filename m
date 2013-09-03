From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pager: turn on "cat" optimization for DEFAULT_PAGER
Date: Tue, 03 Sep 2013 10:35:22 -0700
Message-ID: <xmqqzjrtst9h.fsf@gitster.dls.corp.google.com>
References: <201308261957.r7QJvfjF028935@freeze.ariadne.com>
	<xmqqd2ozhhob.fsf@gitster.dls.corp.google.com>
	<201308281819.r7SIJmnh025977@freeze.ariadne.com>
	<xmqqr4dd8suz.fsf@gitster.dls.corp.google.com>
	<201308291541.r7TFfuJr023110@freeze.ariadne.com>
	<vpqsixsv6dq.fsf@anie.imag.fr>
	<201309030227.r832RmBd013888@freeze.ariadne.com>
	<20130903074150.GE3608@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dale R. Worley" <worley@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 03 19:35:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGuVo-0007eS-6L
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 19:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757104Ab3ICRf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 13:35:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57114 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755433Ab3ICRf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 13:35:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EEE93FA03;
	Tue,  3 Sep 2013 17:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=65K/ezc1voGt1WpLVEcK9rwCBtE=; b=t/8qnu
	EcxxBpP0NJvKP56OhCPviEj3e7h0KCK8uNVSumo+sZtTrVdD4WeqfxrXJizhtwLD
	THgjUrzl3NCzpzlZMKcTcD/DtETVJbm9BccjRCmbJkb+zQVa89RTgyNEQV9baYi1
	AfNJiMzzvH4FMHHzPTtMyZMcRXIRs1YTDrbfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F8VonnOGKy4E+SRUjWrSHI+A5g8dinid
	A8HTjStAGryAOlGe83O4FS5LGHwggrTpdonTigHCn0yNIMWGm1TmEuI04O2vVnJQ
	ZJ04XC370r/iWbyjbUDf2E9upkIbQdJz54KYfIFVBCwLQjEJ2z7Wf+JyORu/AQO6
	2DrJY/bbeCw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4515C3FA02;
	Tue,  3 Sep 2013 17:35:26 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 554773F9FD;
	Tue,  3 Sep 2013 17:35:25 +0000 (UTC)
In-Reply-To: <20130903074150.GE3608@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 3 Sep 2013 03:41:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 377EA1D6-14BF-11E3-AEE1-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233750>

Jeff King <peff@peff.net> writes:

> I'll venture my opinion. We should do this:
>
> -- >8 --
> Subject: pager: turn on "cat" optimization for DEFAULT_PAGER
>
> If the user specifies a pager of "cat" (or the empty
> string), whether it is in the environment or from config, we
> automagically optimize it out to mean "no pager" and avoid
> forking at all. We treat an empty pager variable similary.
>
> However, we did not apply this optimization when
> DEFAULT_PAGER was set to "cat" (or the empty string). There
> is no reason to treat DEFAULT_PAGER any differently. The
> optimization should not be user-visible (unless the user has
> a bizarre "cat" in their PATH). And even if it is, we are
> better off behaving consistently between the compile-time
> default and the environment and config settings.
>
> The stray "else" we are removing from this code was
> introduced by 402461a (pager: do not fork a pager if PAGER
> is set to empty., 2006-04-16). At that time, the line
> directly above used:
>
>    if (!pager)
> 	   pager = "less";
>
> as a fallback, meaning that it could not possibly trigger
> the optimization. Later, a3d023d (Provide a build time
> default-pager setting, 2009-10-30) turned that constant into
> a build-time setting which could be anything, but didn't
> loosen the "else" to let DEFAULT_PAGER use the optimization.
>
> Noticed-by: Dale R. Worley <worley@alum.mit.edu>
> Suggested-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Makes sense.  Thanks.

>  pager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pager.c b/pager.c
> index c1ecf65..fa19765 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -54,7 +54,7 @@ const char *git_pager(int stdout_is_tty)
>  		pager = getenv("PAGER");
>  	if (!pager)
>  		pager = DEFAULT_PAGER;
> -	else if (!*pager || !strcmp(pager, "cat"))
> +	if (!*pager || !strcmp(pager, "cat"))
>  		pager = NULL;
>  
>  	return pager;
