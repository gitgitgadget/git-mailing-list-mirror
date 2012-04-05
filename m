From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] compat/mingw.[ch]: Change return type of exec functions
 to int
Date: Thu, 5 Apr 2012 18:06:15 -0400
Message-ID: <20120405220615.GA11751@sigill.intra.peff.net>
References: <4F7DDAFE.1060902@ramsay1.demon.co.uk>
 <20120405181600.GA6340@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 00:06:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFuox-0007HV-KZ
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 00:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755741Ab2DEWGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 18:06:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49282
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755318Ab2DEWGS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 18:06:18 -0400
Received: (qmail 27945 invoked by uid 107); 5 Apr 2012 22:06:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Apr 2012 18:06:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2012 18:06:15 -0400
Content-Disposition: inline
In-Reply-To: <20120405181600.GA6340@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194816>

On Thu, Apr 05, 2012 at 01:16:01PM -0500, Jonathan Nieder wrote:

> Ramsay Jones wrote:
> 
> >         CC run-command.o
> >     run-command.c: In function 'sane_execvp':
> >     run-command.c:124: error: invalid use of void expression
> >     make: *** [run-command.o] Error 1
> >
> > My first reaction was to simply remove the conditional since, if execvp()
> > returns at all, the result will always be -1 and so the condition will
> > always be false. ie. the conditional is pointless.
> >
> > However, I found the incorrect return type of the mingw_execv[p]() to be
> > a gratuitous incompatibility, so ... :-P

Yeah, it is just asking for trouble to #define a new execvp that does
not match the declaration of the existing one, so I think Ramsay's patch
is good.

> My bad.  I agree that in addition to making the return type fix,
> squashing the following into jk/run-command-eacces would be a good
> idea.
> 
> diff --git i/run-command.c w/run-command.c
> index 04f0190d..fcd7e192 100644
> --- i/run-command.c
> +++ w/run-command.c
> @@ -59,8 +59,7 @@ static int exists_in_PATH(const char *file)
>  
>  int sane_execvp(const char *file, char * const argv[])
>  {
> -	if (!execvp(file, argv))
> -		return 0;
> +	execvp(file, argv);

I don't have a strong opinion. The "return 0" is a little misleading,
since it will never be called, but I think we should at least have a
comment like:

diff --git a/run-command.c b/run-command.c
index 7123436..5b6a368 100644
--- a/run-command.c
+++ b/run-command.c
@@ -117,8 +117,11 @@ static int exists_in_PATH(const char *file)
 
 int sane_execvp(const char *file, char * const argv[])
 {
-	if (!execvp(file, argv))
-		return 0;
+	/*
+	 * No need to check the return value; if it returns at all, an error
+	 * occurred.
+	 */
+	execvp(file, argv);
 
 	/*
 	 * When a command can't be found because one of the directories
