From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "http: don't always prompt for password"
Date: Tue, 13 Dec 2011 13:25:18 -0800
Message-ID: <7v62hkuptt.fsf@alter.siamese.dyndns.org>
References: <20111213201704.GA12072@sigill.intra.peff.net>
 <20111213202508.GA12187@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Naewe <stefan.naewe@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Eric <eric.advincula@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 13 22:25:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaZqo-0006uy-VU
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 22:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023Ab1LMVZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 16:25:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46375 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754093Ab1LMVZV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 16:25:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D04377EC3;
	Tue, 13 Dec 2011 16:25:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RudPoHdKj4h2sM+ErNv4pLRuMBk=; b=eWVyKG
	mnVl7sgCDrX4scwxZ1jQ060M7HsW3Z6dXsLAUCzB5Ifjp1qhPb3j8zz3y1WaLrSS
	i6UoFeWk/j1rELvst2ASt+wYv9g01T8Xf1QODXnYyXilXdIUXarhjfSSFl9trlK+
	rWIKQ0BunFFCfn8m1/5zrHgB2qgvqu5m9BYtc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZJbfrk4z8w2O7yZuc4GHjZ4elOBJJMg6
	jR1YZjPLX5z5/1VY0BSEcs8BM5Oj/1+ozO7yiv8Y3+cRZK36r8VPqpIx5i3dKmmS
	tw6Jk9fBR2qrADhBBKFTP7dIb5fi6KJ3pvoviIX96AqbHZ+5dSUGLJgQ007bNCbv
	5uWZHZlrBQw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C279F7EC2;
	Tue, 13 Dec 2011 16:25:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55EEC7EC1; Tue, 13 Dec 2011
 16:25:20 -0500 (EST)
In-Reply-To: <20111213202508.GA12187@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 Dec 2011 15:25:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5B6C42E-25D0-11E1-9084-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187063>

Jeff King <peff@peff.net> writes:

> @@ -844,7 +846,7 @@ static int http_request(const char *url, void *result, int target, int options)
>  		else if (missing_target(&results))
>  			ret = HTTP_MISSING_TARGET;
>  		else if (results.http_code == 401) {
> -			if (user_name && user_pass) {
> +			if (user_name) {
>  				ret = HTTP_NOAUTH;
>  			} else {
>  				/*

In the credential series, this is where we declare the given credential is
to be rejected (if we have both username and password), or ask them to be
filled by calling credential_fill(), so I think the code in the credential
series does not need this revert. Right?

> @@ -853,8 +855,7 @@ static int http_request(const char *url, void *result, int target, int options)
>  				 * but that is non-portable.  Using git_getpass() can at least be stubbed
>  				 * on other platforms with a different implementation if/when necessary.
>  				 */
> -				if (!user_name)
> -					user_name = xstrdup(git_getpass_with_description("Username", description));
> +				user_name = xstrdup(git_getpass_with_description("Username", description));
>  				init_curl_http_auth(slot->curl);
>  				ret = HTTP_REAUTH;
>  			}

So is this one.
