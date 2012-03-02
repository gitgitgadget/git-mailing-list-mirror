From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH v2 1/3]http: authenticate on NTLM proxies and others suppported
 by CuRL
Date: Fri, 02 Mar 2012 14:55:57 +0100
Message-ID: <4F50D16D.3090800@seap.minhap.es>
References: <4F4FBDBA.8040609@seap.minhap.es> <7v399snnrs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, sam@vilain.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 13:57:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3S3L-0006dP-TV
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 13:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757136Ab2CBM5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 07:57:38 -0500
Received: from luthien2.map.es ([213.9.211.102]:21931 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750753Ab2CBM5h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 07:57:37 -0500
Received: from correo.map.es (unknown [10.1.31.68])
	by luthien2.map.es (Postfix) with ESMTP id 2721C25C720;
	Fri,  2 Mar 2012 13:57:29 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 79CB218003F;
	Fri,  2 Mar 2012 13:57:14 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <7v399snnrs.fsf@alter.siamese.dyndns.org>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 2721C25C720.AAD32
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331297849.35741@wEm7V0PrUjGjTDvIQHCj9g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192037>

On 03/01/2012 08:07 PM, Junio C Hamano wrote:
> Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:
> 
> Thanks; doesn't a missing space before http: above look ugly to you, by
> the way?
> 
>> CURLAUTH_ANY option automatically chooses the best auth method from
>> among those the server supports, that means curl will ask the proxy and
>> use the appropiate, and it will only do that if you are using a proxy
>> (i.e. you've set CURLOPT_PROXY or you have http_proxy env var), also
>> curl will not try to authenticate if you've not provided username or
>> password in the proxy string, as told here[1]..
> 
> The above may justify why you used CURLAUTH_ANY as opposed to
> CURLAUTH_BASIC or other types, but without any description of the problem
> you are trying to solve before that paragraph, it does not justify why you
> are adding a code to use CURLOPT_PROXYAUTH in the first place.
> 
> This is my *guess* of the problem you are trying to solve.

I've ammended the commit message with your wording, text as follows:

When the proxy server specified by the http.proxy configuration or
the http_proxy environment variable requires authentication, git
failed to connect to the proxy, because we did not configure the
cURL handle with CURLOPT_PROXYAUTH.

When a proxy is in use, and you tell git that the proxy requires
authentication by having username in the http.proxy configuration,
an extra request needs to be made to the proxy to find out what
authentication method it supports, as this patch uses CURLAUTH_ANY
to let the library pick the most secure method supported by the
proxy server.

The extra round-trip adds extra latency, but relieves the user
from the burden to configure a specific authentication method.  If
it becomes problem, a later patch could add a configuration option
to specify what method to use, but let's start simple for the time
being.

So as CURLAUTH_ANY provide us out-of-the-box proxy support, we don't
want it activated manually from a config option, instead we added it
automatically when a proxy is being used.

Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
---
 http.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index 0ffd79c..8ac8eb6 100644
--- a/http.c
+++ b/http.c
@@ -295,8 +295,10 @@ static CURL *get_curl_handle(void)
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
 
-	if (curl_http_proxy)
+	if (curl_http_proxy) {
 		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
+		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
+	}
 
 	return result;
 }
-- 
1.7.7.6
