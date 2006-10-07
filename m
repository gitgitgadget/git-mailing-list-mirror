From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC PATCH] Add WEBDAV timeout to http-fetch.
Date: Sat, 07 Oct 2006 03:15:58 -0700
Message-ID: <7viriwsa75.fsf@assigned-by-dhcp.cox.net>
References: <20061006212616.GA5175@lumumba.uhasselt.be>
	<20061006220542.GA5890@lumumba.uhasselt.be>
	<BAYC1-PASMTP08A34A8FB0703E4D2ABAF9AE130@CEZ.ICE>
	<BAYC1-PASMTP11CF83A008B0B3BA5F6B15AE100@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	takis@lumumba.uhasselt.be (Panagiotis Issaris),
	Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Sat Oct 07 12:16:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW9Dz-0001XO-Ln
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 12:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbWJGKQB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 06:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWJGKQB
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 06:16:01 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:41346 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750737AbWJGKQA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 06:16:00 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061007101559.NIEU6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Oct 2006 06:15:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XNG21V0061kojtg0000000
	Sat, 07 Oct 2006 06:16:02 -0400
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP11CF83A008B0B3BA5F6B15AE100@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Fri, 6 Oct 2006 22:04:01 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28470>

Sean <seanlkml@sympatico.ca> writes:

> If a server is having problems delivering the Git repo over WEBDAV,
> timeout after two minutes so that a regular http transfer can
> be tried.
>
> ---
>
>  http-fetch.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> Not sure if this is the correct fix, but it should improve the situation
> for cloning and fetching from servers like Takis's.  When connecting to
> his server WEBDAV doesn't respond after the initial connection.  Nothing
> proceeds until the OS connection times out many minutes later.
>
> This patch sets the CURL timeout to two minutes so that things proceed
> sooner.  Even with this patch it takes two extra minutes of "dead time"
> to complete all operations; obivously this still sucks.
>
> However, I don't know if the two minute timeout is long enough for
> all cases with a server where WEBDAV is functioning properly.
> Hopefully someone who knows more about Curl can comment and perhaps
> offer another solution.
>
> Maybe the real solution is just to figure out and fix whatever is
> going on with the WEBDAV server and forget this patch.

I think it is prudent to protect the client from a broken server
and it is independent from "fixing" the server side.  It would
perhaps make sense to make this overridable somehow but I am not
sure how -- .git/config is too global (the problem would be per
remote site), and having the user to set environment variable
only when going to specific server is too cumbersome to be
useful.  This ideally should be a per-remote configuration
item.

> diff --git a/http-fetch.c b/http-fetch.c
> index bc74f30..046245a 100644
> --- a/http-fetch.c
> +++ b/http-fetch.c
> @@ -861,6 +861,7 @@ static int remote_ls(struct alt_base *re
>  	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 1);
>  	curl_easy_setopt(slot->curl, CURLOPT_CUSTOMREQUEST, DAV_PROPFIND);
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
> +	curl_easy_setopt(slot->curl, CURLOPT_TIMEOUT, 120);
>  
>  	if (start_active_slot(slot)) {
>  		run_active_slot(slot);
> -- 
> 1.4.2.3.gabd697
