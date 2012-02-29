From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH 3/3] http: when proxy url has username but no password,
 ask for password
Date: Wed, 29 Feb 2012 11:46:08 +0100
Message-ID: <4F4E01F0.8050503@seap.minhap.es>
References: <4F4CCEFD.90402@seap.minhap.es> <20120228193125.GA11725@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sam@vilain.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 29 10:48:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2g9K-00064q-CD
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 10:48:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965102Ab2B2Jse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 04:48:34 -0500
Received: from luthien2.map.es ([82.150.0.102]:35121 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757158Ab2B2Jsb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 04:48:31 -0500
Received: from correo.map.es (unknown [10.1.31.68])
	by luthien2.map.es (Postfix) with ESMTP id 9286824D8A;
	Wed, 29 Feb 2012 10:47:31 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id D9222180099;
	Wed, 29 Feb 2012 10:47:27 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <20120228193125.GA11725@sigill.intra.peff.net>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 9286824D8A.45251
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331113653.08244@FyRTE51/dORXyFd2a9PJfQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191829>

On 02/28/2012 08:31 PM, Jeff King wrote:
> On Tue, Feb 28, 2012 at 01:56:29PM +0100, Nelson Benitez Leon wrote:
> 
>> diff --git a/http.c b/http.c
>> index 79cbe50..68e3f7d 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -306,7 +306,41 @@ static CURL *get_curl_handle(void)
>>  		}
>>  	}
>>  	if (curl_http_proxy) {
>> -		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>> +		char *at, *colon, *proxyuser;
>> +		const char *cp;
>> +		cp = strstr(curl_http_proxy, "://");
>> +		if (cp == NULL) {
>> +			cp = curl_http_proxy;
>> +		} else {
>> +			cp += 3;
>> +		}
>> +		at = strchr(cp, '@');
>> +		colon = strchr(cp, ':');
>> +		if (at && (!colon || at < colon)) {
>> +			/* proxy string has username but no password, ask for password */
> 
> Don't parse the URL by hand. Use credential_from_url, which will do it
> for you (and will properly handle things like unquoting the various
> components).

Will do that

>> +			char *ask_str, *proxyuser, *proxypass;
> 
> Shouldn't these be static globals? If we have multiple curl handles, you
> would want them to share the authentication information we collect here,
> and not have to ask the user again, no?

I didn't think about multiple curl handles, will look at make those static..

>> +			strbuf_addf(&pbuf, "Enter password for proxy %s...", at+1);
>> +			ask_str = strbuf_detach(&pbuf, NULL);
>> +			proxypass = xstrdup(git_getpass(ask_str));
> 
> And this should be using credential_fill(), which will let it use
> credential helpers to save passwords, give it the same type of prompt as
> elsewhere, etc.
> 
> See Documentation/technical/api-credential.txt, and see how regular http
> auth is handled for an example.

I will try the credential api, I did my patch based on the fedora 16 git
version, which didn't have the credential api (I couldn't git clone at
that moment for the proxy problem so I had to use the source rpm from
fedora).
