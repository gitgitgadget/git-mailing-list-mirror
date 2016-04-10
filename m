From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git 2.8.1 not working with socks5h https proxy anymore
Date: Sun, 10 Apr 2016 11:11:40 -0700
Message-ID: <xmqqegadtjtv.fsf@gitster.mtv.corp.google.com>
References: <CAEc+GFeG-ZdeTXGsjmwV0QP6QwYvjA4nzCGitka0aXjqEkatfg@mail.gmail.com>
	<xmqq8u0nx66h.fsf@gitster.mtv.corp.google.com>
	<CAEc+GFerpBC_O4jMvtmUhVdLReEN4nvuz5Q30SFUp8qZnQZBmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Felix Ruess <felix.ruess@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 20:12:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apJq0-0001mj-AO
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 20:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092AbcDJSLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 14:11:45 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756053AbcDJSLn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 14:11:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D9C7523E5;
	Sun, 10 Apr 2016 14:11:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9h6cIBkkNNqYAhf+lnZ8dTvpSO0=; b=bmtlb7
	L/fmTyueNBp9URlSerp0Eqc3AZgcWG58vYvFrUJviTpgzQl8bf/tp9Lq1iQaUyDY
	L4EdW+1Z5Scn4+L4DzC/yVGb+gIwvHwDKHGCG/qM+qsLpa+am8k6eqCKuK35s8/V
	gDmufvWlyCvSP1xFt0kstERz+TWZuZXsx4chg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H8B4sReVK1FvzqCMxbAQfTewwCDUaYef
	v2mxY2H3/SG+4paszrQh//heYhqPuGwd3G7baWZpj4XDnZ/MxuJIy+1WNDFYs0el
	EL6TlVX589TV1qLwkWCCCs+u6BsJIYDE13N5f2dnOBkAftbqwgXpCNR5qds4ozqw
	ruxxJ2xykaY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 349EF523E4;
	Sun, 10 Apr 2016 14:11:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A6BC7523E2;
	Sun, 10 Apr 2016 14:11:41 -0400 (EDT)
In-Reply-To: <CAEc+GFerpBC_O4jMvtmUhVdLReEN4nvuz5Q30SFUp8qZnQZBmQ@mail.gmail.com>
	(Felix Ruess's message of "Sat, 9 Apr 2016 14:05:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD1FDE8A-FF47-11E5-B367-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291184>

Felix Ruess <felix.ruess@gmail.com> writes:

> Thanks a lot!
> Tested the patch and it works as expected :-)

Thanks, lets do this, then.

-- >8 --
Subject: [PATCH] http: differentiate socks5:// and socks5h://

Felix Ruess <felix.ruess@gmail.com> noticed that with configuration

    $ git config --global 'http.proxy=socks5h://127.0.0.1:1080'

connections to remote sites time out, waiting for DNS resolution.

The logic to detect various flavours of SOCKS proxy and ask the
libcurl layer to use appropriate one understands the proxy string
that begin with socks5, socks4a, etc., but does not know socks5h,
and we end up using CURLPROXY_SOCKS5.  The correct one to use is
CURLPROXY_SOCKS5_HOSTNAME.

https://curl.haxx.se/libcurl/c/CURLOPT_PROXY.html says

  ..., socks5h:// (the last one to enable socks5 and asking the
  proxy to do the resolving, also known as CURLPROXY_SOCKS5_HOSTNAME
  type).

which is consistent with the way the breakage was reported.

Tested-by: Felix Ruess <felix.ruess@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 http.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/http.c b/http.c
index c29ce81..b560c13 100644
--- a/http.c
+++ b/http.c
@@ -466,7 +466,10 @@ static CURL *get_curl_handle(void)
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
-- 
2.8.1-339-gc925d85
