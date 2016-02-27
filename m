From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch-pack: fix unadvertised requests validation
Date: Sat, 27 Feb 2016 10:25:40 -0800
Message-ID: <xmqqd1riggd7.fsf@gitster.mtv.corp.google.com>
References: <1456577034-6494-1-git-send-email-gabrielfrancosouza@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 27 19:25:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZjYp-0000rW-Gt
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 19:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692AbcB0SZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 13:25:44 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756618AbcB0SZn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 13:25:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E5418442B7;
	Sat, 27 Feb 2016 13:25:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V4xT5HW4VQ6haH+o9NjJbkyt/3w=; b=ggsToJ
	A3EliDIoDY/PkXjwxt5AQ7pwddLUUgEwY2/tl1bRkmfd0o2Xdo5n/tFN4tgraIaC
	J31rWqNgZELo7e/pYY5re47u1FRaH+xLx14oOVez/PpLhj/PE7/DHYZWsHFslov8
	F1COHlwgE1ouAUHJM3fG9E4Ou73C2zHkrMEpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GnPrvqSXVLlH/Wrr5H2CTUNvvYqonnZT
	a0gRtpd7VgzPLLDbxd7e3G8ILY0jks6AQMYWBSmbfLlwTxcv79JDN75Fx59Ij2lL
	lBhvnu4kqflUlLnSXKXWDX0cCMqljRnhFQx6EStDxXhoQ9xsNJXfXshACxPMUP4e
	JqQOOu9stIE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DC765442B5;
	Sat, 27 Feb 2016 13:25:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5E335442B4;
	Sat, 27 Feb 2016 13:25:41 -0500 (EST)
In-Reply-To: <1456577034-6494-1-git-send-email-gabrielfrancosouza@gmail.com>
	(Gabriel Souza Franco's message of "Sat, 27 Feb 2016 09:43:54 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 81DCB5C0-DD7F-11E5-8A61-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287715>

Gabriel Souza Franco <gabrielfrancosouza@gmail.com> writes:

> Check was introduced in b791642 (filter_ref: avoid overwriting
> ref->old_sha1 with garbage, 2015-03-19), but was always false because
> ref->old_oid.hash is empty in this case. Instead copy sha1 from ref->name.
>
> Signed-off-by: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
> ---

Peff, that commit points me at your direction.  And I can see the
original patch avoids overwriting old_sha1 by saving the result from
get_sha1_hex() in a temporary, it is true that old_sha1 is not
updated from the temporary.

The original code before b791642 wanted to say "if ref->name is not
40-hex, continue, and otherwise, do the ref->matched thing" and an
implementation of b791642 that is more faithful to the original
would indeed have been the result of applying this patch from
Gabriel, but I am scratching my head why we have hashcmp() there.

Was it to avoid adding the same thing twice to the resulting list,
or something?


>  fetch-pack.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 01e34b6..83b937b 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -569,11 +569,11 @@ static void filter_refs(struct fetch_pack_args *args,
>  			if (ref->matched)
>  				continue;
>  			if (get_sha1_hex(ref->name, sha1) ||
> -			    ref->name[40] != '\0' ||
> -			    hashcmp(sha1, ref->old_oid.hash))
> +			    ref->name[40] != '\0')
>  				continue;
>  
>  			ref->matched = 1;
> +			hashcpy(ref->old_oid.hash, sha1);
>  			*newtail = copy_ref(ref);
>  			newtail = &(*newtail)->next;
>  		}
