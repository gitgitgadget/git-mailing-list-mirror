From: Andrew Wozniak <awozniak@mc.com>
Subject: Re: recent patch breaks the build ?
Date: Wed, 16 Nov 2005 14:47:56 -0500
Message-ID: <437B8CEC.8040002@mc.com>
References: <437B6997.8010903@mc.com> <7v64qs8kuo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 20:52:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcTGO-00067I-V8
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 20:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030468AbVKPTsJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 14:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbVKPTsJ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 14:48:09 -0500
Received: from iris-63.mc.com ([63.96.239.141]:27843 "EHLO mc.com")
	by vger.kernel.org with ESMTP id S1030468AbVKPTsI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 14:48:08 -0500
Received: from ad-email1.ad.mc.com by mc.com (8.8.8+Sun/SMI-SVR4)
	id OAA04184; Wed, 16 Nov 2005 14:47:56 -0500 (EST)
Received: from [172.16.124.85] ([172.16.124.85]) by ad-email1.ad.mc.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Wed, 16 Nov 2005 14:47:39 -0500
User-Agent: Thunderbird 1.5 (Windows/20051025)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64qs8kuo.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 16 Nov 2005 19:47:39.0279 (UTC) FILETIME=[99BFD1F0:01C5EAE6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12045>

Yes, that suggestion worked - it is similar to other code fragments and 
ifdefs within the same file.

Unfortunately, now there are other failures:

gcc -o http-push.o -c -g -O2 -Wall -DSHA1_HEADER='<openssl/sha.h>' 
http-push.c
http-push.c: In function `start_mkcol':
http-push.c:479: `CURLOPT_HTTPGET' undeclared (first use in this function)
http-push.c:479: (Each undeclared identifier is reported only once
http-push.c:479: for each function it appears in.)
http-push.c: In function `start_move':
http-push.c:581: `CURLOPT_HTTPGET' undeclared (first use in this function)
http-push.c: In function `refresh_lock':
http-push.c:615: `CURLOPT_HTTPGET' undeclared (first use in this function)
http-push.c: In function `fetch_index':
http-push.c:890: `CURLOPT_HTTPGET' undeclared (first use in this function)
http-push.c: In function `lock_remote':
http-push.c:1215: `CURLOPT_HTTPGET' undeclared (first use in this function)
http-push.c: In function `main':

I grep'd for these defines and they are nowhere to be found!  Is some 
other package needed to resolve these undefines on my RH7.2 build host?

I'm really surprised that the unmodified tarball source fails to build. 
Just curious, is the git project rebuilt on a "nightly" basis to verify 
recent patches?

Thanks again, Andrew

Junio C Hamano wrote:
> Andrew Wozniak <awozniak@mc.com> writes:
> 
>> Have just started using git for u-boot related development. After 
>> downloading git-snapshot-20051116 tarball and attempting a build under 
>> RH7.2, I get the following failure:
> 
> Would this help?
> 
> -- >8 --
> 
> diff --git a/http-fetch.c b/http-fetch.c
> index 21cc1b9..45e97f9 100644
> --- a/http-fetch.c
> +++ b/http-fetch.c
> @@ -902,16 +902,18 @@ static void fetch_alternates(char *base)
>  	char *data;
>  	struct active_request_slot *slot;
>  	static struct alt_request alt_req;
> -	int num_transfers;
>  
> +#ifdef USE_CURL_MULTI
>  	/* If another request has already started fetching alternates,
>  	   wait for them to arrive and return to processing this request's
>  	   curl message */
>  	while (got_alternates == 0) {
> +		int num_transfers;
>  		curl_multi_perform(curlm, &num_transfers);
>  		process_curl_messages();
>  		process_request_queue();
>  	}
> +#endif
>  
>  	/* Nothing to do if they've already been fetched */
>  	if (got_alternates == 1)
> 
> 
