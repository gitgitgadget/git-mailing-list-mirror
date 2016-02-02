From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: don't fall back to Basic auth if we haven't tried Negotiate
Date: Tue, 02 Feb 2016 12:37:19 -0800
Message-ID: <xmqqegcusvb4.fsf@gitster.mtv.corp.google.com>
References: <1454404284-2197-1-git-send-email-dmitry.a.vilkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Feb 02 21:37:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQhhW-0002FZ-Ov
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 21:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933678AbcBBUhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 15:37:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58284 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756016AbcBBUhW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 15:37:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F224D40328;
	Tue,  2 Feb 2016 15:37:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/qN4g2yINP8M1HdkV+D8+bbgFO8=; b=CepaIq
	iLqT5/CDsKZlrdIVkOJIVapHto14ZtOdvgFvn1Cw7VZpkBfYD1dBKIwxrYZfXlh6
	PyGo7omsDEb3HdAhmYujCv0Ts0uooBgcthw1Hpz2/GHUW3TP3jt6wWF6e7DGSgP/
	XECoaODMVNfa7JajjnqtG42JXFOmFoE2mLdWc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xTiURqE/t7H6o3SqIjj8phQLIMvkwyXo
	5U8y6E/o3aWWxmrc9hiO8CEeKGI6euvI+qB+42vNStldVqkcufh/xoW0XPsOE/q3
	iZnjgJ2HOe/x4xJw6GZ98xJt4ahDy42rcI63yPZTt0d2U9RUQbrEzK6ilon83Hzs
	951VzUEN4S0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E86AC40327;
	Tue,  2 Feb 2016 15:37:20 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 69FCD40325;
	Tue,  2 Feb 2016 15:37:20 -0500 (EST)
In-Reply-To: <1454404284-2197-1-git-send-email-dmitry.a.vilkov@gmail.com>
	(Dmitry Vilkov's message of "Tue, 2 Feb 2016 12:11:24 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C1BC8680-C9EC-11E5-B178-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285304>

Dmitry Vilkov <dmitry.a.vilkov@gmail.com> writes:

> This is fix of bug introduced by 4dbe66464 commit.

That would be 4dbe6646 (remote-curl: fall back to Basic auth if
Negotiate fails, 2015-01-08) that appears in v2.3.1 and onward.

> The problem is that when username/password combination was not set,
> the first HTTP(S) request will fail and user will be asked for
> credentials. As a side effect of first HTTP(S) request, libcurl auth
> method GSS-Negotiate will be disabled unconditionally. Although, we
> haven't tried yet provided credentials for this auth method.

Brian, comments?  Here is what you wrote in that commit:

    If Basic and something else are offered, libcurl will never
    attempt to use Basic, even if the other option fails.  Teach the
    HTTP client code to stop trying authentication mechanisms that
    don't use a password (currently Negotiate) after the first
    failure, since if they failed the first time, they will never
    succeed.

Thanks.

> Signed-off-by: Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
> ---
>  http.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/http.c b/http.c
> index 0da9e66..707ea84 100644
> --- a/http.c
> +++ b/http.c
> @@ -951,12 +951,15 @@ static int handle_curl_result(struct slot_results *results)
>  		return HTTP_MISSING_TARGET;
>  	else if (results->http_code == 401) {
>  		if (http_auth.username && http_auth.password) {
> +#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
> +			if (http_auth_methods & CURLAUTH_GSSNEGOTIATE) {
> +				http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
> +				return HTTP_REAUTH;
> +			}
> +#endif
>  			credential_reject(&http_auth);
>  			return HTTP_NOAUTH;
>  		} else {
> -#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
> -			http_auth_methods &= ~CURLAUTH_GSSNEGOTIATE;
> -#endif
>  			return HTTP_REAUTH;
>  		}
>  	} else {
