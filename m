From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Trivial support for cloning and fetching via ftp://.
Date: Sat, 16 Sep 2006 02:12:13 -0700
Message-ID: <7vwt849nv6.fsf@assigned-by-dhcp.cox.net>
References: <20060914022404.GA900@sashak.voltaire.com>
	<7vk6475408.fsf@assigned-by-dhcp.cox.net>
	<20060916023717.GA13570@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 16 11:12:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOWE0-0003v5-Dg
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 11:12:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWIPJMQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 05:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWIPJMQ
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 05:12:16 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:34763 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964827AbWIPJMO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 05:12:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060916091214.LXSN6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 Sep 2006 05:12:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NxCF1V00L1kojtg0000000
	Sat, 16 Sep 2006 05:12:15 -0400
To: Sasha Khapyorsky <sashak@voltaire.com>
In-Reply-To: <20060916023717.GA13570@sashak.voltaire.com> (Sasha Khapyorsky's
	message of "Sat, 16 Sep 2006 05:37:17 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27113>

Sasha Khapyorsky <sashak@voltaire.com> writes:

> Something like this?
>
> With this change I'm able to clone
> ftp://ftp.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

I think without you would have, just with extra error messages
that http codepath filters out.

> diff --git a/http-fetch.c b/http-fetch.c
> index a113bb8..46d6029 100644
> --- a/http-fetch.c
> +++ b/http-fetch.c
> @@ -324,7 +324,9 @@ static void process_object_response(void
>  
>  	/* Use alternates if necessary */
>  	if (obj_req->http_code == 404 ||
> -	    obj_req->curl_result == CURLE_FILE_COULDNT_READ_FILE) {
> +	    obj_req->curl_result == CURLE_FILE_COULDNT_READ_FILE ||
> +	    (obj_req->http_code == 550 &&
> +	     obj_req->curl_result == CURLE_FTP_COULDNT_RETR_FILE)) {

Here you do the same as the code would for HTTP 404 when you get
550 _and_ RETR failure...

> @@ -538,7 +540,9 @@ static void process_alternates_response(
>  		}
>  	} else if (slot->curl_result != CURLE_OK) {
>  		if (slot->http_code != 404 &&
> -		    slot->curl_result != CURLE_FILE_COULDNT_READ_FILE) {
> +		    slot->curl_result != CURLE_FILE_COULDNT_READ_FILE &&
> +		    (slot->http_code != 550 &&
> +		     slot->curl_result != CURLE_FTP_COULDNT_RETR_FILE)) {
>  			got_alternates = -1;

... but you say, while the original code says "declare error if
it is not HTTP 404", "oh by the way, if it is 550 _or_ if it
is RETR failure then do not trigger this if()".  I suspect you
meant to say this?

	    (slot->http_code != 550 ||
	     slot->curl_result != CURLE_FTP_COULDNT_RETR_FILE)) {
