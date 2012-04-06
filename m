From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] compat/mingw.[ch]: Change return type of exec functions
 to int
Date: Thu, 5 Apr 2012 20:24:54 -0400
Message-ID: <20120406002454.GB14224@sigill.intra.peff.net>
References: <4F7DDAFE.1060902@ramsay1.demon.co.uk>
 <20120405181600.GA6340@burratino>
 <20120405220615.GA11751@sigill.intra.peff.net>
 <20120405223408.GA13910@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 06 02:25:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFwzT-0002hP-13
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 02:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756529Ab2DFAZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 20:25:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49394
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753391Ab2DFAY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 20:24:58 -0400
Received: (qmail 29166 invoked by uid 107); 6 Apr 2012 00:25:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Apr 2012 20:25:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2012 20:24:54 -0400
Content-Disposition: inline
In-Reply-To: <20120405223408.GA13910@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194825>

On Thu, Apr 05, 2012 at 05:34:36PM -0500, Jonathan Nieder wrote:

> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -117,8 +117,11 @@ static int exists_in_PATH(const char *file)
> >  
> >  int sane_execvp(const char *file, char * const argv[])
> >  {
> > -	if (!execvp(file, argv))
> > -		return 0;
> > +	/*
> > +	 * No need to check the return value; if it returns at all, an error
> > +	 * occurred.
> > +	 */
> > +	execvp(file, argv);
> >  
> 
> I'd rather have the "return 0" then.  Such a comment that focuses on C
> library details rather than providing additional information for
> understanding the sane_execvp function is distracting.

I think both (attempt to) document the same thing: that if we get past
execvp, we know are in error-checking mode. Which is not explicitly said
anywhere. So maybe:

diff --git a/run-command.c b/run-command.c
index 7123436..e6ece79 100644
--- a/run-command.c
+++ b/run-command.c
@@ -117,10 +117,12 @@ static int exists_in_PATH(const char *file)
 
 int sane_execvp(const char *file, char * const argv[])
 {
-	if (!execvp(file, argv))
-		return 0;
+	execvp(file, argv);
 
 	/*
+	 * If we are still running, we know an error occurred; let's try to
+	 * diagnose it more specifically.
+	 *
 	 * When a command can't be found because one of the directories
 	 * listed in $PATH is unsearchable, execvp reports EACCES, but
 	 * careful usability testing (read: analysis of occasional bug
