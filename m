From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 1/2] imap-send.c: implements the GIT_CURL_DEBUG
 environment variable
Date: Fri, 1 Apr 2016 15:56:37 +0100
Message-ID: <56FE8C25.8020607@ramsayjones.plus.com>
References: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 16:56:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am0VE-0003kU-AN
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 16:56:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbcDAO4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 10:56:44 -0400
Received: from avasout07.plus.net ([84.93.230.235]:32961 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410AbcDAO4n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 10:56:43 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id d2wf1s0072D2Veb012wgvC; Fri, 01 Apr 2016 15:56:41 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=pGLkceISAAAA:8 a=OOO5joY655SWX732VFsA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <1459507482-36678-1-git-send-email-gitter.spiros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290542>



On 01/04/16 11:44, Elia Pinto wrote:
> Implements the GIT_CURL_DEBUG environment variable to allow a greater
> degree of detail of GIT_CURL_VERBOSE, in particular the complete
> transport header and all the data payload exchanged.
> It might be useful if a particular situation could require a more
> thorough debugging analysis.
> 
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  imap-send.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 97 insertions(+), 2 deletions(-)
> 
> diff --git a/imap-send.c b/imap-send.c
> index 4d3b773..cf79e7f 100644
> --- a/imap-send.c
> +++ b/imap-send.c
[snip]

> @@ -1442,8 +1532,13 @@ static CURL *setup_curl(struct imap_server_conf *srvc)
>  
>  	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
>  
> -	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
> -		curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
> +	if (0 < verbosity )

previously it was sufficient to set GIT_CURL_VERBOSE, now I have to
set verbosity too?

[Does it matter that you change "1L" to "1" in the curl_easy_setopt()
call? In http.c (line 567) it also uses "1", but ...]

> +		if (getenv("GIT_CURL_DEBUG")) {
> +			curl_easy_setopt(curl, CURLOPT_VERBOSE, 1);
> +			curl_easy_setopt(curl, CURLOPT_DEBUGFUNCTION, curl_trace);
> +		} else if (getenv("GIT_CURL_VERBOSE"))
> +			curl_easy_setopt(curl, CURLOPT_VERBOSE, 1);
> +
>  
>  	return curl;
>  }
> 

I would have expected something like:

if (0 < verbosity || getenv("GIT_CURL_VERBOSE")) {
	curl_easy_setopt(curl, CURLOPT_VERBOSE, 1L);
	if (getenv("GIT_CURL_DEBUG"))
		curl_easy_setopt(curl, CURLOPT_DEBUGFUNCTION, curl_trace);
}

Hope That Helps.

ATB,
Ramsay Jones
