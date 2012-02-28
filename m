From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH 1/3] http: authenticate on NTLM proxies and others suppported,
 by CuRL
Date: Tue, 28 Feb 2012 19:15:40 +0100
Message-ID: <4F4D19CC.5030303@seap.minhap.es>
References: <4F4CCE01.8080300@seap.minhap.es> <8762er6nb2.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, sam@vilain.net,
	sam.vilain@catalyst.net.nz
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 28 19:25:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Rjv-0005Gr-EG
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 19:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730Ab2B1SZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 13:25:27 -0500
Received: from luthien2.map.es ([82.150.0.102]:4011 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753411Ab2B1SZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 13:25:26 -0500
X-Greylist: delayed 4091 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Feb 2012 13:25:26 EST
Received: from correo.map.es (unknown [10.1.24.31])
	by luthien2.map.es (Postfix) with ESMTP id 6E917F8793;
	Tue, 28 Feb 2012 18:17:04 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 38AB4D4C8E;
	Tue, 28 Feb 2012 18:16:58 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <8762er6nb2.fsf@thomas.inf.ethz.ch>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 6E917F8793.F36C7
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331054224.74312@8kZtSu5LqML2euO12WOi+Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191756>

On 02/28/2012 03:32 PM, Thomas Rast wrote:
> Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:
> 
>> -	if (curl_http_proxy)
>> +	if (curl_http_proxy) {
>>  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>> +		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
>> +	}
> 
> There was another attempt at doing the same very recently:
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/191140
> 
> I could swear there was a second one, but apparently that was you.
> Neither you nor Marco submitter have so far answered the question I
> raised in
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/191155
> 
> which can be summarized as: please make a case -- and put it in the
> message! -- for or against making this configurable.  Is there a speed
> tradeoff?  (However, you could steal some of Daniel Stenberg's
> reasoning!)

I don't see any reason to make this configurable, CuRL people made this
cool CURLAUTH_ANY option that automatically chooses the best auth method
from among those the server supports, that means you don't have to 
investigate if your proxy is using Basic, Digest or NTLM methods, and
use a specific curl option for each of them, instead curl
will ask the proxy and use the appropiate, and it will only do that if 
you are using a proxy (i.e. you've set CURLOPT_PROXY or you have http_proxy
env var), also curl will not try to authenticate if you've not provided
username or password in the proxy string, as I've been told here[1]..

so, setting CURLOPT_PROXYAUTH = CURLAUTH_ANY will not affect the speed of
normal curl use, only if 1) you are using a proxy and 2) your proxy requires
authentication, only then curl will just make two or three roundtrips to find out
the auth method the proxy is using, that is a tiny cost compared to having the
user find out the proxy auth type and set an specifically config option to enable
that type.

So I would call CURLAUTH_ANY as out-of-the-box proxy support, and I don't want it
activated from a config option, I want it to still be out-of-the-box in git also..

[1] https://bugzilla.redhat.com/show_bug.cgi?id=769254#c6
