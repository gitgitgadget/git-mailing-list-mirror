From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/5] http: handle proxy proactive authentication
Date: Thu, 12 Apr 2012 08:54:22 -0700
Message-ID: <7vwr5leyj5.fsf@alter.siamese.dyndns.org>
References: <4F5F53CA.7090003@seap.minhap.es>
 <7v398cvb30.fsf@alter.siamese.dyndns.org>
 <7vsjgcs8pq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, sam@vilain.net, spearce@spearce.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 17:54:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIMLu-0001m1-RA
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 17:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169Ab2DLPy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 11:54:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48913 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934441Ab2DLPyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 11:54:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 861306C4B;
	Thu, 12 Apr 2012 11:54:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TOxpUUsc0jYzjYdwCvksvqGaV4c=; b=qR5QOT
	XM36gZbRaWhMZysC0Cx1OyTwo1BxqWEaA+QLhVOcH8uRN/7Kt60bGtukxBOB0msi
	3U/gsKLIo7UE9a1lroo8MHTh+w1fiCvguY57sv3J9zip+GTJXxDWgR2vB3hTsHzj
	7S2QRgN0ZWmG2tju2oKMdXudNVOGVTordYGjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QlNOTS/o0oRW5AyB8DeWmeVuzFSRkpVH
	vgGmfwXNTlO3YpTpG+o5Fpi9UN+EmqevAN4W9sL+Fl+UjvyZk4j0j8qLGz2Eco1U
	7+u7LU6z3VMJvJdbctndM4axp91xPJVTN2XBCjxevH8XvSC559aJXk/VwiZhQce+
	78HIdFSbkd8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C29C6C4A;
	Thu, 12 Apr 2012 11:54:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08EFD6C49; Thu, 12 Apr 2012
 11:54:23 -0400 (EDT)
In-Reply-To: <7vsjgcs8pq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 09 Apr 2012 17:59:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C66D16C8-84B7-11E1-950A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195339>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I haven't formed an opinion on what the proper solution should be, but
>> either the credential_from_url() function needs to be updated to accept
>> the scp style [user@]<host>:<port> argument, or this specific caller
>> should take the responsibility to do special case the syntax.
>
> Well, calling the above "scp" style is a mistake (it is not scp style at
> all), but the patch to teach the credentail_from_url() to handle the proxy
> specification may look like this:

Jeff, do you have an opinion on this?  I briefly wondered if we also want
to teach the traditional [user@]host:/path/to/repo to this function (it is
not a URL in RFC1738 sense, but it is in the remote.$name.url sense), but
because SSH does its own thing interacting with agents, perhaps it may not
help to teach our credential layer to store and supply cached passphrases
(or passwords, if the authentication is done by merely sending password
over the encrypted channel).

A safer approach might be to keep externally visible API to this function
as before, but add another function only for the use of http_proxy and
friends (whose kosher format is "host:address" without the "<scheme>://"
part), and call it from the codepath broken by the patch.

>  credential.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/credential.c b/credential.c
> index 62d1c56..482ae88 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -324,11 +324,13 @@ void credential_from_url(struct credential *c, const char *url)
>  	 *   (1) proto://<host>/...
>  	 *   (2) proto://<user>@<host>/...
>  	 *   (3) proto://<user>:<pass>@<host>/...
> +	 * or "proto://"-less variants of the above for *_proxy variables.
>  	 */
>  	proto_end = strstr(url, "://");
> -	if (!proto_end)
> -		return;
> -	cp = proto_end + 3;
> +	if (proto_end)
> +		cp = proto_end + 3;
> +	else
> +		cp = url;
>  	at = strchr(cp, '@');
>  	colon = strchr(cp, ':');
>  	slash = strchrnul(cp, '/');
> @@ -348,7 +350,7 @@ void credential_from_url(struct credential *c, const char *url)
>  		host = at + 1;
>  	}
>  
> -	if (proto_end - url > 0)
> +	if (proto_end && proto_end != url)
>  		c->protocol = xmemdupz(url, proto_end - url);
>  	if (slash - host > 0)
>  		c->host = url_decode_mem(host, slash - host);
