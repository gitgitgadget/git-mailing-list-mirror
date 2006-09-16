From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Trivial support for cloning and fetching via ftp://.
Date: Sat, 16 Sep 2006 10:29:28 -0700
Message-ID: <7virjnafev.fsf@assigned-by-dhcp.cox.net>
References: <20060914022404.GA900@sashak.voltaire.com>
	<7vk6475408.fsf@assigned-by-dhcp.cox.net>
	<20060916023717.GA13570@sashak.voltaire.com>
	<7vwt849nv6.fsf@assigned-by-dhcp.cox.net>
	<20060916100147.GA17504@sashak.voltaire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 16 19:30:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOdz7-0002KU-Bj
	for gcvg-git@gmane.org; Sat, 16 Sep 2006 19:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWIPR3b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 13:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWIPR3a
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 13:29:30 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:55236 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964851AbWIPR33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 13:29:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060916172929.LUJC26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Sat, 16 Sep 2006 13:29:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id P5VW1V00R1kojtg0000000
	Sat, 16 Sep 2006 13:29:30 -0400
To: Sasha Khapyorsky <sashak@voltaire.com>
In-Reply-To: <20060916100147.GA17504@sashak.voltaire.com> (Sasha Khapyorsky's
	message of "Sat, 16 Sep 2006 13:01:47 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27119>

Sasha Khapyorsky <sashak@voltaire.com> writes:

>> > diff --git a/http-fetch.c b/http-fetch.c
>> > index a113bb8..46d6029 100644
>> > --- a/http-fetch.c
>> > +++ b/http-fetch.c
>> > @@ -324,7 +324,9 @@ static void process_object_response(void
>> >  
>> >  	/* Use alternates if necessary */
>> >  	if (obj_req->http_code == 404 ||
>> > -	    obj_req->curl_result == CURLE_FILE_COULDNT_READ_FILE) {
>> > +	    obj_req->curl_result == CURLE_FILE_COULDNT_READ_FILE ||
>> > +	    (obj_req->http_code == 550 &&
>> > +	     obj_req->curl_result == CURLE_FTP_COULDNT_RETR_FILE)) {
>> 
>> Here you do the same as the code would for HTTP 404 when you get
>> 550 _and_ RETR failure...
>> 
>> > @@ -538,7 +540,9 @@ static void process_alternates_response(
>> >  		}
>> >  	} else if (slot->curl_result != CURLE_OK) {
>> >  		if (slot->http_code != 404 &&
>> > -		    slot->curl_result != CURLE_FILE_COULDNT_READ_FILE) {
>> > +		    slot->curl_result != CURLE_FILE_COULDNT_READ_FILE &&
>> > +		    (slot->http_code != 550 &&
>> > +		     slot->curl_result != CURLE_FTP_COULDNT_RETR_FILE)) {
>> >  			got_alternates = -1;
>> 
>> ... but you say, while the original code says "declare error if
>> it is not HTTP 404", "oh by the way, if it is 550 _or_ if it
>> is RETR failure then do not trigger this if()".  I suspect you
>> meant to say this?
>> 
>> 	    (slot->http_code != 550 ||
>> 	     slot->curl_result != CURLE_FTP_COULDNT_RETR_FILE)) {
>
> I think with less strict checking this could be done so, but with _and_
> this also ensures that we are really in FTP mode.

I was merely pointing out that in one place you have:

	(http_code == 550 && result == ERETR)

and another place that tries to say the opposite you have:

	(http_code != 550 && result != ERETR)

which is not the same thing as

	!(http_code == 550 && result == ERETR)

I understood, from the former "Use alternates if necessary"
part, that you wanted to make sure that 550 is really from
FTP_RETR and not other random HTTP error message, and I think
that is a reasonable thing to do.
