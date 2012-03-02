From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH v2 3/3] http: when proxy url has username but no password,
 ask for password
Date: Fri, 02 Mar 2012 14:33:53 +0100
Message-ID: <4F50CC41.5020307@seap.minhap.es>
References: <4F4FBE6C.5050507@seap.minhap.es><4F4FB69C.7000708@vilain.net> <20120301215812.GG17631@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 13:36:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Ril-0000UA-KY
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 13:36:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818Ab2CBMgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 07:36:22 -0500
Received: from luthien2.map.es ([213.9.211.102]:54920 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756115Ab2CBMgV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 07:36:21 -0500
Received: from correo.map.es (unknown [10.1.24.31])
	by luthien2.map.es (Postfix) with ESMTP id DE419B7223;
	Fri,  2 Mar 2012 13:35:16 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 6737DD4BFE;
	Fri,  2 Mar 2012 13:35:10 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <20120301215812.GG17631@sigill.intra.peff.net>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: DE419B7223.6343D
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331296517.19428@G76wVAfNp/t083HlvM/l5A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192032>

On 03/01/2012 10:58 PM, Jeff King wrote:
> On Thu, Mar 01, 2012 at 09:49:16AM -0800, Sam Vilain wrote:
> 
>>>  	if (curl_http_proxy) {
>>> -		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>>> +		credential_from_url(&proxy_auth, curl_http_proxy);
>>> +		if (proxy_auth.username != NULL&&  proxy_auth.password == NULL) {
>>> +			/* proxy string has username but no password, ask for password */
>>> +			struct strbuf pbuf = STRBUF_INIT;
>>> +			credential_fill(&proxy_auth);
>>
>> Wouldn't it be better to wait until the proxy returns a 403 before
>> assuming that the proxy setting is incorrect/missing a password?
>> What if the administrator expects the user to fill in both the
>> username and password?  That is the behaviour of a web browser.
>>
>> Also, I think you should wait until that 403 to detect whether the
>> proxy setting came from the environment, and only load it explicitly
>> then.
> 
> It's worth looking at what the http auth code does here.
> 
[snip]
> overhaul it.
> 
> Complicating all of this is the fact that I think Nelson's original
> patch was based on an older, pre-986bbc0 version of git, which is why he
> followed the pre-prompt route, copying the style of regular http auth.
> 
> So there's the history lesson. What should proxy auth do?
> 
>   1. Definitely respond to HTTP 407 by prompting on the fly; this code
>      should go along-side the HTTP 401 code in http.c.
> 
>   2. Definitely do the pre-prompt thing when http_proactive_auth is set
>      (which is used only by http-push). Unless somebody really feels
>      like re-writing http-push to handle retries for authentication.
> 
>   3. Consider doing the pre-prompt thing when http_proactive_auth is not
>      set. This can save a round-trip, but we should not do it if there
>      is a good reason not to. The two possible reasons I can think of
>      are:
> 
>        a. Like http auth, if curl will read the proxy credentials from
>           .netrc, then we should not do it for the same reasons
>           mentioned in 986bbc0.
> 
>        b. If people realistically have proxy URLs with usernames but do
>           _not_ want to ask for a password, then the prompt will be
>           annoying. I'm not sure that anybody expects that.

So, trying to sum up, I will try to redo patch-set as follows:
- Ignore PATCH 2/3 , that is, we won't read any env var.
- Let cURL try to connect and if that fails with 407 , then do a credential_fill
and try to reconnect.

Is that ok? or do I need to do something more?
