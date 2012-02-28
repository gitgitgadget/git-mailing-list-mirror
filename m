From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Tue, 28 Feb 2012 15:57:33 +0100
Message-ID: <4F4CEB5D.5020808@seap.minhap.es>
References: <4F4CCE8A.4010800@seap.minhap.es> <878vjn8823.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, sam.vilain@catalyst.net.nz,
	sam@vilain.net
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 28 14:59:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2NaE-0003Hd-MF
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 14:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab2B1N7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 08:59:08 -0500
Received: from luthien2.map.es ([213.9.211.102]:7985 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831Ab2B1N7H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 08:59:07 -0500
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id B1AF524802;
	Tue, 28 Feb 2012 14:58:59 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 1BA6E2C801;
	Tue, 28 Feb 2012 14:58:50 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <878vjn8823.fsf@thomas.inf.ethz.ch>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: B1AF524802.1AD1E
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331042340.08058@mn/agg6zd0cJB1nbpfzmYg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191732>

On 02/28/2012 01:19 PM, Thomas Rast wrote:
> Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:
> 
>> +	if (!curl_http_proxy) {
>> +		const char *env_proxy;
>> +		env_proxy = getenv("HTTP_PROXY");
>> +		if (!env_proxy) {
>> +			env_proxy = getenv("http_proxy");
>> +		}
>> +		if (env_proxy) {
>> +			curl_http_proxy = xstrdup(env_proxy);
>> +		}
>> +	}
> 
> Admittedly I'm mostly clueless about curl, but while investigating the
> NTLM login thing I noticed this bit in curl(1):
> 
> ENVIRONMENT
>        The environment variables can be specified in lower case or upper
>        case. The lower case version has precedence. http_proxy is an
>        exception as it is only available in lower case.
> 
> Which raises the questions:
> 
> * Why is this needed?  Does git's use of libcurl ignore http_proxy?  [1]
>   seems to indicate that libcurl respects <protocol>_proxy
>   automatically.

It could not be needed, because, as you noted, curl already reads it, but then we will
loose the feature on patch [3/3] because if $http_proxy has username but no password
curl will not ask you for the password.. instead if we read it we could detect that,
and ask for the password. 

As a minor note if we let curl to read it then patch [1/1] has
to be changed to include CURLOPT_PROXYAUTH unconditionally (ie. out of the 
'if (curl_http_proxy)'). I personally like the feature of not writing my password 
on $http_proxy at the cost of reading the env vars ourselves.


> 
> * Why do you (need to?) support HTTP_PROXY when curl doesn't?

I found somewhere documented HTTP_PROXY as well as http_proxy, but I've just checked 
wget[1] and also only supports http_proxy so I think we can discard it as is not widely 
used..

[1] http://www.gnu.org/software/wget/manual/html_node/Proxies.html

> 
> 
> [1] http://curl.haxx.se/libcurl/c/libcurl-tutorial.html, "Environment Variables"
> 
