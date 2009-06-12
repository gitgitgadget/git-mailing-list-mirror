From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Thu, 11 Jun 2009 23:34:29 -0700
Message-ID: <7vprdaarka.fsf@alter.siamese.dyndns.org>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 08:35:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MF0M6-0007N6-GF
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 08:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760385AbZFLGe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 02:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755067AbZFLGe2
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 02:34:28 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:64094 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbZFLGe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 02:34:27 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090612063429.ODIS18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Fri, 12 Jun 2009 02:34:29 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 2uaV1c0014aMwMQ04uaVKH; Fri, 12 Jun 2009 02:34:29 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=ZkqYN0c8iNwA:10 a=Z2nhhV3jvI0A:10
 a=pGLkceISAAAA:8 a=UJ5Y5Z__AAAA:8 a=n9YbafbBx1sS-NnOzmgA:9
 a=ACehhkqETxRO8-Q40QAeOiP22Q0A:4 a=MSl-tDqOz04A:10 a=s17DTO1fMklqcZH9:21
 a=zFdEVguwP115F5fT:21
X-CM-Score: 0.00
In-Reply-To: <1243480563-5954-1-git-send-email-lodatom@gmail.com> (Mark Lodato's message of "Wed\, 27 May 2009 23\:16\:02 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121391>

Mark Lodato <lodatom@gmail.com> writes:

> @@ -189,6 +207,16 @@ static CURL *get_curl_handle(void)
>  
>  	if (ssl_cert != NULL)
>  		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
> +	if (has_cert_password())
> +		curl_easy_setopt(result,
> +#if LIBCURL_VERSION_NUM >= 0x071700
> +				 CURLOPT_KEYPASSWD,
> +#elif LIBCURL_VERSION_NUM >= 0x070903
> +				 CURLOPT_SSLKEYPASSWD,
> +#else
> +				 CURLOPT_SSLCERTPASSWD,
> +#endif
> +				 ssl_cert_password);

This is purely style and readability, but if you do something like this
much earlier in the file:

    #if !defined(CURLOPT_KEYPASSWD)
    # if defined(CURLOPT_SSLKEYPASSWD)
    #  define CURLOPT_KEYTPASSWD CURLOPT_SSLKEYPASSWD
    # elif defined(CURLOPT_SSLCERTPASSWD
    #  define CURLOPT_KEYTPASSWD CURLOPT_SSLCERTPASSWD
    # endif
    #endif

you can write your main codepath using the latest cURL API without ifdef.
The callsite can simply say:

	if (must_set_cert_password())
        	curl_easy_setopt(result, CURLOPT_KEYPASSWD, ssl_cert_password);

which I think would be much easier to follow.

This assumes that KEYPASSWD is the latest API, and in older versions only
names are different, which your code implies.  I have a vague recollection
that SSLCERTPASSWD actually deprecated KEYPASSWD (i.e. your #if...#endif
chain is wrong), but I didn't actually check the cURL documentation [*1*]
to see if that is the case.

[Reference]

*1* http://cool.haxx.se/cvs.cgi/curl/docs/libcurl/symbols-in-versions?rev=HEAD
