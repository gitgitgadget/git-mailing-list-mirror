From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/13] credential helpers
Date: Fri, 09 Dec 2011 15:34:08 -0800
Message-ID: <7vehwdcob3.fsf@alter.siamese.dyndns.org>
References: <20111206062127.GA29046@sigill.intra.peff.net>
 <7v7h29fkfy.fsf@alter.siamese.dyndns.org>
 <20111207064231.GA499@sigill.intra.peff.net>
 <7vmxb2hhne.fsf@alter.siamese.dyndns.org>
 <20111209022913.GA2600@sigill.intra.peff.net>
 <7vzkf1fwvn.fsf@alter.siamese.dyndns.org>
 <20111209231800.GA14376@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 10 00:34:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ9xJ-0002J2-Pn
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 00:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721Ab1LIXeM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 18:34:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36749 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363Ab1LIXeL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 18:34:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1CF8677A;
	Fri,  9 Dec 2011 18:34:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QLL36YtvwmCBsqSep3M99QXCadI=; b=fUKp9M
	3E9ZLLHAO/7V8BXvxkfHVp0PTLrzTHcsgSqPaSxDtilzhtQY5XW3IVaod2wtWcBW
	UX4ItL8U8dsInX6SX+LWXVC0oblmsSilBjpymSFo+ywRwaFscVCQ904qZ3Je4GZB
	UPRVLOiug9+P/qkkf5k/xRPW4zEncABnKfQY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wggeuEMCLpWSDuXINEx+a74q9ipYPSHS
	4Q+/jIsi1NYcFklMJ6pEbfPCv8g/2WLaYk74Zp9NAAeiLvVNcqumLM09vgDoj/tc
	8v6qCaW9fybAYYfC32tQeLRKA4J8gwDz5eh+6if475nGD+PUPAZoRBSGo0S9V3pZ
	wYsIJ6NFolM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B95E36779;
	Fri,  9 Dec 2011 18:34:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D6446777; Fri,  9 Dec 2011
 18:34:10 -0500 (EST)
In-Reply-To: <20111209231800.GA14376@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 9 Dec 2011 18:18:00 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B709126-22BE-11E1-8711-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186703>

Jeff King <peff@peff.net> writes:

> Yeah, I think that's a reasonable compromise. Instead of the patch I
> posted earlier, how about this:
>
> diff --git a/credential-store.c b/credential-store.c
> index a2c2cd0..26f7589 100644
> --- a/credential-store.c
> +++ b/credential-store.c
> @@ -96,7 +96,16 @@ static void store_credential(const char *fn, struct credential *c)
>  
>  static void remove_credential(const char *fn, struct credential *c)
>  {
> -	rewrite_credential_file(fn, c, NULL);
> +	/*
> +	 * Sanity check that we actually have something to match
> +	 * against. The input we get is a restrictive pattern,
> +	 * so technically a blank credential means "erase everything".
> +	 * But it is too easy to accidentally send this, since it is equivalent
> +	 * to empty input. So explicitly disallow it, and require that the
> +	 * pattern have some actual content to match.
> +	 */
> +	if (c->protocol || c->host || c->path || c->username)
> +		rewrite_credential_file(fn, c, NULL);
>  }

Looks very sane.

> We _could_ modify credential_match() to automatically reject such a
> pattern at that level,...

I do not think that is such a good idea to modify "match()" function
either, as I agree match with empty has its uses, but that does not stop
"rewrite_credential_file()" from being safe by default, no? After all, the
one that makes the decision to drop things that match the pattern is that
function (it chooses to give NULL to match_cb).

> So the "empty pattern" does actually have a use, from the end-users's
> point of view. It's just that with removal, it's a little more dangerous
> and a little less likely to be useful (as compared to lookup).
>
> -Peff
