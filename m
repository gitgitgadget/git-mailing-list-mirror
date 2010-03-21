From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] find_unique_abbrev: early out without a memcpy
Date: Sun, 21 Mar 2010 13:23:38 -0700
Message-ID: <7v39ztmnjp.fsf@alter.siamese.dyndns.org>
References: <1269111329-5896-1-git-send-email-kusmabite@gmail.com>
 <1269111329-5896-4-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, rene.scharfe@lsrfire.ath.cx
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Mar 21 21:23:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtRgj-0004ta-Tn
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 21:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387Ab0CUUXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 16:23:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646Ab0CUUXs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 16:23:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E5F10A4913;
	Sun, 21 Mar 2010 16:23:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zAvGz/rN8VbbjSjpS4u8C0UVn5w=; b=AhSP2Q
	oudgDdC25c9yMnPtsdIJDtOo4yf+V71atlvStAHsmf8S8E43FyMwKJQiqOeQrIvC
	OPMnf2UWKr2kvm9uJesuwxoJ+u4x/OYWFz3m2vy5Mku50buOHBtsLmVq2beIL6tx
	iyZLURv/n3Q+JNTR4qv8qDQHSMtS7fFkoJiyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gHMQT1aMONP9RsvY0PG7DnW2sVD8Bp0c
	b6f2h1LQrg93WRk1Jk2K708fy+ZqrshFgOh68iYmJ5aZQgnGYWOvS6yjQEFGNqKg
	DBN0GJBj5RbEdusMeHJYym3ATbgwOJ0pGnWWhIYzS30PX+d+qVf+q0rJdTdChPfb
	UpZP8W2gtXw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B0D3EA490F;
	Sun, 21 Mar 2010 16:23:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 059B3A490E; Sun, 21 Mar
 2010 16:23:39 -0400 (EDT)
In-Reply-To: <1269111329-5896-4-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Sat\, 20 Mar 2010 19\:55\:29 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A5416166-3527-11DF-A655-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142858>

Erik Faye-Lund <kusmabite@googlemail.com> writes:

> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>  sha1_name.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index bf92417..2b1be58 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -196,10 +196,10 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
>  	int status, exists;
>  	static char hex[41];
>  
> +	if (len == 40 || !len)
> +		return sha1_to_hex(sha1);
>  	exists = has_sha1_file(sha1);
>  	memcpy(hex, sha1_to_hex(sha1), 40);
> -	if (len == 40 || !len)
> -		return hex;

This is somewhat iffy.  hex[] being static means there can only be one
outstanding return value from f-u-a being used, iow

	printf("%s %s", f-u-a(a, 0), f-u-a(b, 0))

is a no-no.  But at the same time, it means that you can use one more
recycled buffer than sha1_to_hex() gives us, so this may be safe:

	char *ua = f-u-a(a, 0);
        printf("%s %s %s %s %s", ua,
            sha1_to_hex(b), sha1_to_hex(c),  sha1_to_hex(d), sha1_to_hex(e));

but with the above it probably is not anymore, no?

As an optimization patch, I would buy that delaying the "exists" check
until the "no abbreviation" check returned early would make sense, though.
