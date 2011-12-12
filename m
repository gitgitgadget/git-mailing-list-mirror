From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] mv: be quiet about overwriting
Date: Mon, 12 Dec 2011 11:59:52 -0800
Message-ID: <7vk46136iv.fsf@alter.siamese.dyndns.org>
References: <20111212074503.GB16511@sigill.intra.peff.net>
 <20111212075407.GE17532@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 12 21:00:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaC2a-0006pk-OA
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 21:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638Ab1LLT74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 14:59:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42578 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430Ab1LLT7z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 14:59:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E00E61A1;
	Mon, 12 Dec 2011 14:59:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ug21Ic+v/x/IKNiQDPRcr6D3AWA=; b=tgtFV2
	ub47ziKMwYIXx0QQzJVUdRO2kkq1jAzQHcaECYrTVxE8OhqxN13bimQJ345hTqua
	FMRljD2bx7vg3hwR+YLc6TCxlpRM8gny/4SsuJTKOAcYnBuuYHrouNKoBA/dw71H
	LsdlLTVabJgUTVdqb+Nyseg00Zct8Lb9ztLZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qruDbIflI2CV7xbOwWlF37UeXV5M9N06
	bV6hBoI1YwCjC8aXWK9F626EB9V+dV2TFM6vZKOciORQ7xMhimIk4e8IIQ6cK3AH
	CngwZPYjIMDANUBSjqKQWgi1k+QcBtvxMom8/Rl8jgTHckAC3ChULIqTxc+NqFe9
	cpKEdWKQ+6Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5664261A0;
	Mon, 12 Dec 2011 14:59:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A931D619E; Mon, 12 Dec 2011
 14:59:54 -0500 (EST)
In-Reply-To: <20111212075407.GE17532@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Dec 2011 02:54:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC2B0B1C-24FB-11E1-96C4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186943>

Jeff King <peff@peff.net> writes:

> When a user asks us to force a mv and overwrite the
> destination, we print a warning. However, since a typical
> use would be:
>
>   $ git mv one two
>   fatal: destination exists, source=one, destination=two
>   $ git mv -f one two
>   warning: destination exists (will overwrite), source=one, destination=two
>
> this warning is just noise. We already know we're
> overwriting; that's why we gave -f!
>
> This patch silences the warning unless "--verbose" is given.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> You could perhaps argue that it is useful in the case of moving multiple
> files into a directory (since it tells you _which_ files were
> overwritten). We could turn the warning on in that case, but I'm
> inclined to leave it. If the user cares about this information, they can
> use "-v" along with "-f".

Makes sense, but I also think even under verbose mode we should avoid the
future tense.  I.e. something like this:

    $ git mv -v -f one two
    warning: overwriting two
    $ git mv -v -f one two three
    warning: overwriting three/one

>  builtin/mv.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index c9ecb03..b6e7e4f 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -177,8 +177,9 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  				 * check both source and destination
>  				 */
>  				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
> -					warning(_("%s (will overwrite), source=%s, destination=%s"),
> -						bad, src, dst);
> +					if (verbose)
> +						warning(_("%s (will overwrite), source=%s, destination=%s"),
> +							bad, src, dst);
>  					bad = NULL;
>  				} else
>  					bad = _("Cannot overwrite");
