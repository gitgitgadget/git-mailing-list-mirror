From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] upload-pack: send the HEAD information
Date: Fri, 06 Sep 2013 10:46:24 -0700
Message-ID: <xmqqsixhyhan.fsf@gitster.dls.corp.google.com>
References: <20130906155204.GE12966@inner.h.apk.li>
	<20130906155608.GF12966@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 06 19:46:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI079-0002X6-WA
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 19:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754Ab3IFRqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 13:46:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47780 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727Ab3IFRqb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 13:46:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 647FA3D632;
	Fri,  6 Sep 2013 17:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JjLfgz8bYsg8rD1u3s/10hPLBOE=; b=nK9Baa
	YrQpJ1K837xlZWwd5vZ+eyfZ2mhhF/Hjo1Rk3btLGHG2O8D6Yeoi1FEW6F1CxyrU
	8rdATWpLg2QY0hXhI4gORw/bhUgulU57HyT6GXnmBeu0cXM1DGRW2mARlm7yndfj
	h0QwGNppHhArqaOizMhOJdVaEcB8dec/ddR9A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XNYNf20lUvih2NA4vfVW4drDZm0gY1kQ
	YCpa2OlJHak1bUTVsF29HoW6RQoGaSlCvQ5r9Q/23p1MW/6+1nPuP6WUd3aUE2E6
	1ux1nbJpFTVRcs7GeHNGnJoIMd5FOl/teJo2qQSh59Uj07gcBTuvh4s3CrRLeiY9
	7zxN5pWT23w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4C943D62E;
	Fri,  6 Sep 2013 17:46:29 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7553B3D622;
	Fri,  6 Sep 2013 17:46:26 +0000 (UTC)
In-Reply-To: <20130906155608.GF12966@inner.h.apk.li> (Andreas Krey's message
	of "Fri, 6 Sep 2013 17:56:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 40E610E2-171C-11E3-AF13-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234077>

Andreas Krey <a.krey@gmx.de> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> This implements the server side of protocol extension to show which branch
> the HEAD points at.  The information is sent as a capability symref=<target>.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Andreas Krey <a.krey@gmx.de>
> ---
>  upload-pack.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index 127e59a..390d1ec 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -745,13 +745,17 @@ static int send_ref(const char *refname, const unsigned char *sha1, int flag, vo
>  	if (mark_our_ref(refname, sha1, flag, cb_data))
>  		return 0;
>  
> -	if (capabilities)
> -		packet_write(1, "%s %s%c%s%s%s agent=%s\n",
> +	if (capabilities) {
> +		unsigned char dummy[20];
> +		const char *target = resolve_ref_unsafe("HEAD", dummy, 0, NULL);
> +		packet_write(1, "%s %s%c%s%s%s%s%s agent=%s\n",
>  			     sha1_to_hex(sha1), refname_nons,
>  			     0, capabilities,
>  			     allow_tip_sha1_in_want ? " allow-tip-sha1-in-want" : "",
>  			     stateless_rpc ? " no-done" : "",
> +			     target ? " symref=" : "", target ? target : 0,
>  			     git_user_agent_sanitized());
> +	}
>  	else
>  		packet_write(1, "%s %s\n", sha1_to_hex(sha1), refname_nons);
>  	capabilities = NULL;

I think it is perfectly fine to expose _only_ HEAD now, and wait
until we find a good reason that we should send this information for
other symbolic refs in the repository.

However, because we already anticipate that we may find such a good
reason later, on-the-wire format should be prepared to support such
later enhancement.  I think sending

	symref=HEAD:refs/heads/master

is probably one good way to do so, as Peff suggested in that old
thread ($gmane/102070; note that back then this wasn't suggested as
a proper capability so the exact format he suggests in the message
is different).  Then we could later add advertisements for other
symbolic refs if we find it necessary to do so, e.g.

	symref=HEAD:refs/heads/master
        symref=refs/remotes/origin/HEAD:refs/remotes/origin/master

(all on one line together with other capabilities separated with a
SP in between).
