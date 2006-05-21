From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove possible segfault in http-fetch.
Date: Sun, 21 May 2006 00:49:19 -0700
Message-ID: <7vverzzukg.fsf@assigned-by-dhcp.cox.net>
References: <87fyj4y1lx.fsf@mid.deneb.enyo.de>
	<BAYC1-PASMTP082397700A9527CC2F3786AEA40@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nick Hengeveld <nickh@reactrix.com>
X-From: git-owner@vger.kernel.org Sun May 21 09:49:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fhigy-0003uZ-24
	for gcvg-git@gmane.org; Sun, 21 May 2006 09:49:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWEUHtV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 03:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWEUHtV
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 03:49:21 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:23736 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751489AbWEUHtU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 03:49:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060521074920.FUNR5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 21 May 2006 03:49:20 -0400
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP082397700A9527CC2F3786AEA40@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Sat, 20 May 2006 18:46:33 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20434>

Sean <seanlkml@sympatico.ca> writes:

> Free the curl string lists after running http_cleanup to
> avoid an occasional segfault in the curl library.  Seems
> to only occur if the website returns a 405 error.
>...
> It comes with a big disclaimer because I don't really know the
> code in here all that well.  However gdb reports the segfault
> happens in a strncasecmp call, and seeing as we've released a
> bunch of strings prior to the call....
>
>  http-fetch.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/http-fetch.c b/http-fetch.c
> index 861644b..178f1ee 100644
> --- a/http-fetch.c
> +++ b/http-fetch.c
> @@ -1269,10 +1269,10 @@ int main(int argc, char **argv)
>  	if (pull(commit_id))
>  		rc = 1;
>  
> -	curl_slist_free_all(no_pragma_header);
> -
>  	http_cleanup();
>  
> +	curl_slist_free_all(no_pragma_header);
> +
>  	if (corrupt_object_found) {
>  		fprintf(stderr,
>  "Some loose object were found to be corrupt, but they might be just\n"

curl_easy_cleanup() which is called from http_cleanup() says it
is safe to remove the strings _after_ you call that function, so
I think the change makes sense -- it was apparently unsafe to
free them before calling cleanup.

Knowing nothing about quirks in curl libraries, one thing that
is mystery to me is that we slist_append() to other two lists
(pragma_header and range_header) but we do not seem to ever free
them.  Another slist dav_headers is allocated and then freed
inside a function, so that call-pattern seems well-formed.

Nick, care to help us out?
