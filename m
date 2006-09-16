From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: [PATCH] Trivial support for cloning and fetching via ftp://.
Date: Sat, 16 Sep 2006 20:41:34 +0300
Message-ID: <20060916174134.GE17504@sashak.voltaire.com>
References: <20060914022404.GA900@sashak.voltaire.com> <7vk6475408.fsf@assigned-by-dhcp.cox.net> <20060916023717.GA13570@sashak.voltaire.com> <7vwt849nv6.fsf@assigned-by-dhcp.cox.net> <20060916100147.GA17504@sashak.voltaire.com> <7virjnafev.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 16 19:35:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOe54-0003oY-4q
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 19:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWIPRfp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 13:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWIPRfp
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 13:35:45 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:19523 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S932444AbWIPRfo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 13:35:44 -0400
Received: from sashak ([172.25.5.107]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 16 Sep 2006 20:35:41 +0300
Received: by sashak (sSMTP sendmail emulation); Sat, 16 Sep 2006 20:41:34 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virjnafev.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 16 Sep 2006 17:35:41.0118 (UTC) FILETIME=[87BC55E0:01C6D9B6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27120>

On 10:29 Sat 16 Sep     , Junio C Hamano wrote:
> Sasha Khapyorsky <sashak@voltaire.com> writes:
> 
> >> > diff --git a/http-fetch.c b/http-fetch.c
> >> > index a113bb8..46d6029 100644
> >> > --- a/http-fetch.c
> >> > +++ b/http-fetch.c
> >> > @@ -324,7 +324,9 @@ static void process_object_response(void
> >> >  
> >> >  	/* Use alternates if necessary */
> >> >  	if (obj_req->http_code == 404 ||
> >> > -	    obj_req->curl_result == CURLE_FILE_COULDNT_READ_FILE) {
> >> > +	    obj_req->curl_result == CURLE_FILE_COULDNT_READ_FILE ||
> >> > +	    (obj_req->http_code == 550 &&
> >> > +	     obj_req->curl_result == CURLE_FTP_COULDNT_RETR_FILE)) {
> >> 
> >> Here you do the same as the code would for HTTP 404 when you get
> >> 550 _and_ RETR failure...
> >> 
> >> > @@ -538,7 +540,9 @@ static void process_alternates_response(
> >> >  		}
> >> >  	} else if (slot->curl_result != CURLE_OK) {
> >> >  		if (slot->http_code != 404 &&
> >> > -		    slot->curl_result != CURLE_FILE_COULDNT_READ_FILE) {
> >> > +		    slot->curl_result != CURLE_FILE_COULDNT_READ_FILE &&
> >> > +		    (slot->http_code != 550 &&
> >> > +		     slot->curl_result != CURLE_FTP_COULDNT_RETR_FILE)) {
> >> >  			got_alternates = -1;
> >> 
> >> ... but you say, while the original code says "declare error if
> >> it is not HTTP 404", "oh by the way, if it is 550 _or_ if it
> >> is RETR failure then do not trigger this if()".  I suspect you
> >> meant to say this?
> >> 
> >> 	    (slot->http_code != 550 ||
> >> 	     slot->curl_result != CURLE_FTP_COULDNT_RETR_FILE)) {
> >
> > I think with less strict checking this could be done so, but with _and_
> > this also ensures that we are really in FTP mode.
> 
> I was merely pointing out that in one place you have:
> 
> 	(http_code == 550 && result == ERETR)
> 
> and another place that tries to say the opposite you have:
> 
> 	(http_code != 550 && result != ERETR)
> 
> which is not the same thing as
> 
> 	!(http_code == 550 && result == ERETR)
> 
> I understood, from the former "Use alternates if necessary"
> part, that you wanted to make sure that 550 is really from
> FTP_RETR and not other random HTTP error message, and I think
> that is a reasonable thing to do.

Good. Am I need to send the patch or you will integrate it?

Sasha
