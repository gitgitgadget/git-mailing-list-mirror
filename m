From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/5] http: handle proxy proactive authentication
Date: Mon, 09 Apr 2012 14:39:47 -0700
Message-ID: <7v398cvb30.fsf@alter.siamese.dyndns.org>
References: <4F5F53CA.7090003@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, sam@vilain.net,
	spearce@spearce.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Mon Apr 09 23:40:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHMJY-0002aZ-Ql
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 23:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755551Ab2DIVjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 17:39:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60478 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734Ab2DIVju (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 17:39:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA3966313;
	Mon,  9 Apr 2012 17:39:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sqG7Ie1WcvloXNVYiJRRvAmUx5E=; b=UGXoL3
	S05fcZ/a1nq7kJujMFGJBZa/lxhXmrV8v0D20tm4ohTKcHtM447Cf7ltWvNu8XaZ
	AfAB9l8W7VYLiKYrz7BLRedrPQzXTgSRgq62vDZRx1Md2yvPrrUXzVHy56U0xNB/
	TFNl6I6lVT7A4byNiqmEGQLqi5QJw70DLkBQU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J2pdT0fr8TwCbyNw5NPBAGmlh9MBYb1w
	HIvM9QQVrGhv0uk5RLN0r31fRbMM0GsTf/DOQrzax87KQdWZJR8MjEzbEuZ0Fss2
	fyjoIgp4lp27vupZdAiAwZqhQbB5CWlHyhkv8BPBgk4vY5wpOtLyehDkaqjY0QsH
	2gwB52oJJUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1E8A6312;
	Mon,  9 Apr 2012 17:39:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 475716311; Mon,  9 Apr 2012
 17:39:49 -0400 (EDT)
In-Reply-To: <4F5F53CA.7090003@seap.minhap.es> (Nelson Benitez Leon's message
 of "Tue, 13 Mar 2012 15:03:54 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8862F762-828C-11E1-B714-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195041>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

>  	if (curl_http_proxy) {
> -		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> +		if (!proxy_auth.host) /* check to parse only once */
> +			credential_from_url(&proxy_auth, curl_http_proxy);
> +
> +		if (http_proactive_auth && proxy_auth.username && !proxy_auth.password)
> +			/* proxy string has username but no password, ask for password */
> +			credential_fill(&proxy_auth);
> +
> +		struct strbuf proxyhost = STRBUF_INIT;
> +		strbuf_addf(&proxyhost, "%s://%s", proxy_auth.protocol, proxy_auth.host);
> +		curl_easy_setopt(result, CURLOPT_PROXY, strbuf_detach(&proxyhost, NULL));

How well has this code been tested?  The documentation for CURLOPT_PROXY
says this:

   CURLOPT_PROXY

   Set HTTP proxy to use. The parameter should be a char * to a zero
   terminated string holding the host name or dotted IP address. To
   specify port number in this string, append :[port] to the end of the
   host name. The proxy string may be prefixed with [protocol]:// since
   any such prefix will be ignored. The proxy's port number may optionally
   be specified with the separate option. If not specified, libcurl will
   default to using port 1080 for proxies. CURLOPT_PROXYPORT.

If the user has been happily using "127.0.0.1:4321" in curl_http_proxy
(i.e. without the meaningless <proto>:// part), the original code would
have called curl_easy_setopt with that string, and that would have been
how everything used to work.

If you haven't figured out proxy_auth.host at this point in the codepath,
you call credential_from_url() but the function only knows how to parse
the value for

	"<proto>://[<user>[:<pass>]@]<host>[:<port>]/..."

Specifically, it will punt with anything without "://" in it.

And then you use proxy_auth.protocol and proxy_auth.host to build
proxyhost.buf that presumably mimick the original curl_http_proxy (but
without the credential part).

I haven't formed an opinion on what the proper solution should be, but
either the credential_from_url() function needs to be updated to accept
the scp style [user@]<host>:<port> argument, or this specific caller
should take the responsibility to do special case the syntax.

>  		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> +		set_proxy_auth(result);
>  	}
>  
>  	return result;
