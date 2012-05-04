From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH 2/6] http: handle proxy proactive authentication
Date: Fri, 04 May 2012 13:10:38 +0200
Message-ID: <4FA3B92E.3000200@seap.minhap.es>
References: <4FA2B4DA.60908@seap.minhap.es> <20120504071632.GB21895@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 04 12:14:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQFX0-0002qS-4s
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 12:14:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762Ab2EDKO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 06:14:29 -0400
Received: from luthien1.map.es ([82.150.0.102]:62257 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754698Ab2EDKO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 06:14:29 -0400
Received: from correo.map.es (unknown [10.1.24.31])
	by luthien2.map.es (Postfix) with ESMTP id F137625346;
	Fri,  4 May 2012 12:13:24 +0200 (CEST)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id 41EC5D4DFC;
	Fri,  4 May 2012 12:13:19 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120424 Thunderbird/12.0
In-Reply-To: <20120504071632.GB21895@sigill.intra.peff.net>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: F137625346.7D0DC
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1336731207.94086@ef8hh56KeyNsSbeeWnHwXQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197014>

On 05/04/2012 09:16 AM, Jeff King wrote:
> On Thu, May 03, 2012 at 06:39:54PM +0200, Nelson Benitez Leon wrote:
> 
>> If http_proactive_auth flag is set and there is a username
>> but no password in the proxy url, then interactively ask for
>> the password.
>>
>> This makes possible to not have the password written down in
>> http_proxy env var or in http.proxy config option.
>>
>> Also take care that CURLOPT_PROXY don't include username or
>> password, as we now set them in the new set_proxy_auth() function
>> where we use their specific cURL options.
> 
> Do we actually need to do that? If we set CURLOPT_PROXYUSERNAME, will
> curl ignore it in favor of what's in the URL? I ask, because there is a
> bug here:
> 
>> @@ -351,8 +366,19 @@ static CURL *get_curl_handle(const char *url)
>>  	}
>>  	
>>  	if (curl_http_proxy) {
>> -		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>> +		struct strbuf proxyhost = STRBUF_INIT;
>> +
>> +		if (!proxy_auth.host) /* check to parse only once */
>> +			credential_from_url(&proxy_auth, curl_http_proxy);
>> +
>> +		if (http_proactive_auth && proxy_auth.username && !proxy_auth.password)
>> +			/* proxy string has username but no password, ask for password */
>> +			credential_fill(&proxy_auth);
>> +
>> +		strbuf_addf(&proxyhost, "%s://%s", proxy_auth.protocol, proxy_auth.host);
>> +		curl_easy_setopt(result, CURLOPT_PROXY, strbuf_detach(&proxyhost, NULL));
> 
> When you parse the URL via credential_from_url, the components you get
> will have any URL-encoding removed. So when you regenerate the URL in
> the proxyhost variable, you would need to re-encode.

Can a hostname has url-encoded parts? I thought that was only for the
request uri (/somedir/somefile.php) or the query string ('?var1=val'),
I'm only using the hostname here as a proxy server never has more than
that, apart from the port number.
