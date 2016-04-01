From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 2/2] http.c: implements the GIT_CURL_DEBUG environment
 variable
Date: Fri, 1 Apr 2016 16:03:31 +0100
Message-ID: <56FE8DC3.5080304@ramsayjones.plus.com>
References: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com>
 <1459507482-36678-2-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 17:04:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am0c6-0007Tb-RH
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 17:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758988AbcDAPDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 11:03:38 -0400
Received: from avasout07.plus.net ([84.93.230.235]:35635 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758897AbcDAPDg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 11:03:36 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id d33Z1s0042D2Veb0133aSq; Fri, 01 Apr 2016 16:03:34 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=pGLkceISAAAA:8 a=CjyufE-COO3IhihpHroA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <1459507482-36678-2-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290543>



On 01/04/16 11:44, Elia Pinto wrote:
> Implements the GIT_CURL_DEBUG environment variable to allow a greater
> degree of detail of GIT_CURL_VERBOSE, in particular the complete
> transport header and all the data payload exchanged.
> It might be useful if a particular situation could require a more
> thorough debugging analysis.
> 
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  http.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/http.c b/http.c
> index dfc53c1..079779d 100644
> --- a/http.c
> +++ b/http.c
[snip]

> @@ -532,7 +623,11 @@ static CURL *get_curl_handle(void)
>  			"your curl version is too old (>= 7.19.4)");
>  #endif
>  
> -	if (getenv("GIT_CURL_VERBOSE"))
> +	if (getenv("GIT_CURL_DEBUG")) {
> +		curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
> +		curl_easy_setopt(result, CURLOPT_DEBUGFUNCTION, curl_trace);
> +		curl_easy_setopt(result, CURLOPT_DEBUGDATA, NULL);
> +	} else if (getenv("GIT_CURL_VERBOSE"))
>  		curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
>  
>  	curl_easy_setopt(result, CURLOPT_USERAGENT,
> 

Again, maybe something like:

if (getenv("GIT_CURL_VERBOSE")) {
	curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
	if (getenv("GIT_CURL_DEBUG"))
		curl_easy_setopt(result, CURLOPT_DEBUGFUNCTION, curl_trace);
}

Although that does make GIT_CURL_DEBUG subordinate to GIT_CURL_VERBOSE.
So, that may not be desired ...

ATB,
Ramsay Jones
