From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fix http auth with multiple curl handles
Date: Thu, 12 Apr 2012 15:50:08 -0700
Message-ID: <7v4nso4lb3.fsf@alter.siamese.dyndns.org>
References: <20120402083115.GA2235@sigill.intra.peff.net>
 <1334051620-18044-1-git-send-email-drizzd@aon.at>
 <1334051620-18044-3-git-send-email-drizzd@aon.at>
 <20120412070910.GA31122@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 13 00:50:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SISqI-0007AY-SB
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 00:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966131Ab2DLWuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 18:50:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45209 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757869Ab2DLWuL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 18:50:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A998775E0;
	Thu, 12 Apr 2012 18:50:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bG3aDWJrcO0I5xkoGxP+sys3Ea4=; b=YcKMg6
	xZe7TRB/zRbuSp4KyAG02FPuXKz2IIjCE6KXx+fliBakKYoNuVBfI5NigJzmSeHy
	F3ONjBuon09fuTvgPmvvDriGtOcBb4NgFJE2ZK7CiA12h7xJw+9JJP86R0Xrv6Rn
	7PCxIy6GyChyD1WhvV3xFa/TubavvNxhnpKjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gtht9HqAQsfsLkQ8BqIEwsT/9Qo49l+K
	A7gTlVBysYkfgDCemj4+FN+OUWj1fIwItV0pUdYP38rG3efgv9NFgPgh7+/te+qN
	SvDQU1CtmArHqAZelRTHrJBsuBMKB0K3PzqqeaAMivuqrDEqd5LppjqfgTqL8Hn6
	S1GroIRPio4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FCEB75DF;
	Thu, 12 Apr 2012 18:50:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 05BC775DD; Thu, 12 Apr 2012
 18:50:09 -0400 (EDT)
In-Reply-To: <20120412070910.GA31122@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 12 Apr 2012 03:09:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB60A1AA-84F1-11E1-A4CE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195383>

Jeff King <peff@peff.net> writes:

> ...
> I think the best we can do is to put the auth data in a static buffer
> and feed that to curl. We end up rewriting the auth data into our buffer
> over and over, but at least we don't re-malloc it. Like this:
>
> diff --git a/http.c b/http.c
> index f3f83d7..374c3bb 100644
> --- a/http.c
> +++ b/http.c
> @@ -211,12 +211,12 @@ static int http_options(const char *var, const char *value, void *cb)
>  static void init_curl_http_auth(CURL *result)
>  {
>  	if (http_auth.username) {
> -		struct strbuf up = STRBUF_INIT;
> +		static struct strbuf up = STRBUF_INIT;
>  		credential_fill(&http_auth);
> +		strbuf_reset(&up);
>  		strbuf_addf(&up, "%s:%s",
>  			    http_auth.username, http_auth.password);
> -		curl_easy_setopt(result, CURLOPT_USERPWD,
> -				 strbuf_detach(&up, NULL));
> +		curl_easy_setopt(result, CURLOPT_USERPWD, up.buf);
>  	}
>  }

Yeah, that's sad but I agree that is probably the best we could do.  Do
you want me to squash it in?

> By the way, this touches on an area that I noticed while refactoring the
> http auth code a while ago, but decided not to tackle at the time. We
> fill in the auth information early, and then never bother to revisit it
> as URLs change. So for example, if I got a redirect from host A to host
> B, we would continue to use the credential for host A and host B. Which
> is maybe convenient, and maybe a security issue.

Good point.  Do we follow redirects, though?
