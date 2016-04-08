From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 2.8.1 not working with socks5h https proxy anymore
Date: Fri, 08 Apr 2016 12:16:06 -0700
Message-ID: <xmqq8u0nx66h.fsf@gitster.mtv.corp.google.com>
References: <CAEc+GFeG-ZdeTXGsjmwV0QP6QwYvjA4nzCGitka0aXjqEkatfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Felix Ruess <felix.ruess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 21:16:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aobt9-00058C-8l
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 21:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758854AbcDHTQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 15:16:11 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:50064 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758848AbcDHTQK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 15:16:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8D94E51B43;
	Fri,  8 Apr 2016 15:16:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UJ7Gj4qn0wYPafnunIzZuyV+MNo=; b=UVh2GZ
	5lUHZ+nvIKZb5YDzyFvSLLfPeD2JcCTeizjGMIPzMbjgbHufEkXsMDJSCf9/XwsF
	ffB9+Qq4pvA203gve5VVMe8+QYyWO33rlO642h4hiIWq82CaoWNelX1/cr/yqY0E
	+XBo6THtJZ6ZJ0358KNMD45ijnFwvUx4SRvNE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C06c0IIkcsPa7tmUL0225F2PEVLTIjQ5
	aKK1wKkHcyiISnS9/VC26RrSWghgCcBah37F1IT6zzDnNj/S5fD0EglshpT2EFjY
	S4DfRNW7dXvRUPkMdQIdaB3WXyf5HAgJArkmbxBoUvNPzIivd56MtClPbnrfBuBS
	HJ1ry6Xk7nE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8455951B41;
	Fri,  8 Apr 2016 15:16:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 01DC151B40;
	Fri,  8 Apr 2016 15:16:07 -0400 (EDT)
In-Reply-To: <CAEc+GFeG-ZdeTXGsjmwV0QP6QwYvjA4nzCGitka0aXjqEkatfg@mail.gmail.com>
	(Felix Ruess's message of "Fri, 8 Apr 2016 20:46:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 58CE6CE6-FDBE-11E5-9E27-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291055>

Felix Ruess <felix.ruess@gmail.com> writes:

> I just encountered a problem with the latest git version (2.8.1) that
> looks like a regression to me:
> When trying to clone a repo via a https socks5 proxy the connection times out:
>
> $ git config --global 'http.proxy=socks5h://127.0.0.1:1080'

The first version of Git that has code that explicitly supports
socks proxy is 2.6.4, it seems.  Since then we have always used
CURLPROXY_SOCKS5 for curl_http_proxy that begins with a string
"socks5".

Checking

    https://github.com/curl/curl/blob/master/docs/libcurl/symbols-in-versions

I find that that at curl 7.18.0, curl added a separate
CURLPROXY_SOCKS5_HOSTNAME that can be triggered by "socks5h:" that
is separate from CURLPROXY_SOCKS5, and I am guessing that the
differences in behaviour between these two is what is causing you
trouble.  https://curl.haxx.se/libcurl/c/CURLOPT_PROXY.html says

  ..., socks5h:// (the last one to enable socks5 and asking the proxy
  to do the resolving, also known as CURLPROXY_SOCKS5_HOSTNAME type)

and because not using _HOSTNAME variant would likely not ask the
proxy to do the resolving, it explains the stall on your end, if
your box cannot resolve external hostname.

Perhaps the attached patch may help?

I do not know if Pat is still active as a developer, but I am
wondering what the reason was to use starts_with(..., "socks5")
instead of "socks5:", "socks4a:", etc. when identifying the proxy
type.

 http.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index 69da445..4304b80 100644
--- a/http.c
+++ b/http.c
@@ -605,7 +605,10 @@ static CURL *get_curl_handle(void)
 	if (curl_http_proxy) {
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
 #if LIBCURL_VERSION_NUM >= 0x071800
-		if (starts_with(curl_http_proxy, "socks5"))
+		if (starts_with(curl_http_proxy, "socks5h"))
+			curl_easy_setopt(result,
+				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5_HOSTNAME);
+		else if (starts_with(curl_http_proxy, "socks5"))
 			curl_easy_setopt(result,
 				CURLOPT_PROXYTYPE, CURLPROXY_SOCKS5);
 		else if (starts_with(curl_http_proxy, "socks4a"))
