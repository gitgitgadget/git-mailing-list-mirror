From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH v3 2/4] http: try http_proxy env var when http.proxy config
 option is not set
Date: Tue, 06 Mar 2012 13:22:46 +0100
Message-ID: <4F560196.8070500@seap.minhap.es>
References: <4F54D91C.6080905@seap.minhap.es> <7v4nu32bwp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, sam@vilain.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 12:24:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4sVM-0004l7-99
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 12:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252Ab2CFLY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 06:24:27 -0500
Received: from luthien2.mpt.es ([213.9.211.102]:3755 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965144Ab2CFLY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 06:24:26 -0500
Received: from correo.map.es (unknown [10.1.24.31])
	by luthien2.map.es (Postfix) with ESMTP id 4A1E7F87CC;
	Tue,  6 Mar 2012 12:24:15 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 61B12D4BEB;
	Tue,  6 Mar 2012 12:24:07 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
In-Reply-To: <7v4nu32bwp.fsf@alter.siamese.dyndns.org>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 4A1E7F87CC.5C4D1
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331637856.50002@TtVQctS0or0Ro6NTvGnvuQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192334>

On 03/05/2012 06:30 PM, Junio C Hamano wrote:
> Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:
> 
>> cURL already reads it, but if $http_proxy has username but no password
>> cURL will not ask you for the password and so failed to authenticate
>> returning a 407 error code. So we read it ourselves to detect that and
>> ask for the password. Also we read it prior to connection to be able to
>> make a proactive authentication in case the flag http_proactive_auth is
>> set.
>>
>> Signed-off-by: Nelson Benitez Leon <nbenitezl@gmail.com>
>> ---
> 
> The above does not address my earlier worries about compatibility
> across curl applications (it does not even say "it does not matter;
> we do not care about other's application"), so let's spell it out
> again.  When the user has
> 
> 	http_proxy=http://me@proxy.example.com
> 	export http_proxy
> 
> with your patch, git might do whatever we desire to do, and the end
> result may be better, but how would the user experience be for the
> user when using other curl based programs on the same system?

As I said in the commit message, in that cases a 407 error will be
returned from those applications, because curl will not ask you for
the password, I tested that myself, maybe my message is not clear
enough, you can suggest me a better wording or feel free to amend it
yourself :-). 

An $http_proxy without password means it needs support from the application,
I expect users who put a proxy url without password to be confident that 
the application they're using will ask them for the password (git in this
case), if they're not sure they have to go with the standard approach of
setting both username and password in $http_proxy to obtain full
compatibility amongst any programs (at the cost of having the password
written down somewhere).

> 
> Also I thought the conclusion from the other thread was that even if
> we were to do this, we should apply the http_proxy environment only
> when we are talking to http:// and for https:// we would instead
> read HTTPS_PROXY or something?

Ok I completely miss this, can this be added in a later patch?

> 
>>  http.c |    7 +++++++
>>  1 files changed, 7 insertions(+), 0 deletions(-)
>>
>> diff --git a/http.c b/http.c
>> index 8ac8eb6..8932da5 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -295,6 +295,13 @@ static CURL *get_curl_handle(void)
>>  	if (curl_ftp_no_epsv)
>>  		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
>>  
>> +	if (!curl_http_proxy) {
>> +		const char *env_proxy;
>> +		env_proxy = getenv("http_proxy");
>> +		if (env_proxy) {
>> +			curl_http_proxy = xstrdup(env_proxy);
>> +		}
>> +	}
>>  	if (curl_http_proxy) {
>>  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>>  		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
