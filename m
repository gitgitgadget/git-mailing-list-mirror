From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH v3 3/4] http: handle proxy proactive authentication
Date: Tue, 06 Mar 2012 11:58:59 +0100
Message-ID: <4F55EDF3.2030201@seap.minhap.es>
References: <4F54D98C.2070909@seap.minhap.es> <20120306083052.GD21199@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sam@vilain.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 11:00:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4rCN-00010t-37
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 11:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121Ab2CFKAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 05:00:45 -0500
Received: from luthien1.mpt.es ([82.150.0.102]:52139 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758660Ab2CFKAo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 05:00:44 -0500
Received: from correo.map.es (unknown [10.1.31.23])
	by luthien2.map.es (Postfix) with ESMTP id 9F6A6F84F9;
	Tue,  6 Mar 2012 11:00:29 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 1E6F8203815;
	Tue,  6 Mar 2012 11:00:21 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <20120306083052.GD21199@sigill.intra.peff.net>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 9F6A6F84F9.4AF35
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331632830.9032@T2ULvxdhVkjtXpEOBnd77Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192327>

On 03/06/2012 09:30 AM, Jeff King wrote:
> On Mon, Mar 05, 2012 at 04:19:40PM +0100, Nelson Benitez Leon wrote:
> 
>> diff --git a/http.c b/http.c
>> index 8932da5..b0b4362 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -43,6 +43,7 @@ static int curl_ftp_no_epsv;
>>  static const char *curl_http_proxy;
>>  static const char *curl_cookie_file;
>>  static struct credential http_auth = CREDENTIAL_INIT;
>> +static struct credential proxy_auth = CREDENTIAL_INIT;
>>  static int http_proactive_auth;
>>  static const char *user_agent;
>>  
>> @@ -303,6 +304,17 @@ static CURL *get_curl_handle(void)
>>  		}
>>  	}
>>  	if (curl_http_proxy) {
>> +		credential_from_url(&proxy_auth, curl_http_proxy);
>> +		if (http_proactive_auth && proxy_auth.username && !proxy_auth.password) {
>> +			/* proxy string has username but no password, ask for password */
>> +			struct strbuf pbuf = STRBUF_INIT;
>> +			credential_fill(&proxy_auth);
>> +			strbuf_addf(&pbuf, "%s://%s:%s@%s",proxy_auth.protocol,
>> +			    	proxy_auth.username, proxy_auth.password,
>> +			    	proxy_auth.host);
> 
> Can we pull this out into a helper function, since the next patch will
> need to do the exact same thing in the 407 case?

Ok.

> Also, when turning it back into a URL to hand to curl, should we be
> percent-encoding the items we put in? If my password has an "@" in it,
> wouldn't we generate a bogus URL? Although looking at how the http auth
> code handles this, we set CURLOPT_USERPWD directly. Should you be
> setting CURLOPT_PROXYUSERPWD instead of munging the proxy URL?

Ok, but it seems is CURLOPT_PROXYUSERNAME and CURLOPT_PROXYPASSWORD what
we need here as per documentation[1]

[1] http://curl.haxx.se/libcurl/c/curl_easy_setopt.html#CURLOPTPROXYUSERNAME

>> +			free ((void *)curl_http_proxy);
> 
> Please don't cast to void. This is C, not C++, and casts to void
> pointers are implicit.  They can never help, and might cover up an
> actual type error (e.g., casting a non-pointer type).

Ok, will remove it, I copy/paste it from the http code and I must admit
I didn't understand why this was needed.
