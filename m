From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Oct 2012, #09; Mon, 29)
Date: Fri, 2 Nov 2012 05:56:32 -0400
Message-ID: <20121102095632.GA30221@sigill.intra.peff.net>
References: <20121029102114.GA14497@sigill.intra.peff.net>
 <5092C234.9000307@ramsay1.demon.co.uk>
 <CAEUsAPb7hUViLn7V7v65r6mOqRHr+180ynRX8K9t3nuJVyePfg@mail.gmail.com>
 <20121102094259.GA28414@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 10:56:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUDzc-0002Fv-Rv
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 10:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932852Ab2KBJ4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 05:56:36 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54206 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761150Ab2KBJ4f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 05:56:35 -0400
Received: (qmail 2254 invoked by uid 107); 2 Nov 2012 09:57:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Nov 2012 05:57:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2012 05:56:32 -0400
Content-Disposition: inline
In-Reply-To: <20121102094259.GA28414@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208915>

On Fri, Nov 02, 2012 at 05:43:00AM -0400, Jeff King wrote:

> Yeah, I think that is it. IIRC, Ramsay is on cygwin, and I noticed this
> in perl 5.16's POSIX.xs:
>
> [...]
>    * (4) The CRT strftime() "%Z" implementation calls __tzset(). That
>    * calls CRT tzset(), but only the first time it is called, and in turn
>    * that uses CRT getenv("TZ") to retrieve the timezone info from the CRT
>    * local copy of the environment and hence gets the original setting as
>    * perl never updates the CRT copy when assigning to $ENV{TZ}.
> [...]
> I wonder if Ramsay has an older perl that does not do this special
> hackery right. I'll see if I can dig up where it first appeared.

It looks like that code went into perl 5.11.

I wonder, even with this fix, though, if we need to be calling tzset to
reliably update from the environment. It sounds like it _should_ happen
automatically, except that if the CRT is calling the internal tzset, it
would not do the perl "grab from $ENV" magic. Calling tzset would make
sure the internal TZ is up to date.

Ramsay, what happens with this patch on top?

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index ceb119d..4c44050 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -24,11 +24,12 @@ use File::Basename qw(basename dirname);
 use Time::Local;
 use IO::Socket;
 use IO::Pipe;
-use POSIX qw(strftime dup2 ENOENT);
+use POSIX qw(strftime tzset dup2 ENOENT);
 use IPC::Open2;
 
 $SIG{'PIPE'}="IGNORE";
 $ENV{'TZ'}="UTC";
+tzset();
 
 our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r, $opt_R);
 my (%conv_author_name, %conv_author_email, %conv_author_tz);
@@ -855,8 +856,10 @@ sub commit {
 	}
 
 	$ENV{'TZ'}=$author_tz;
+	tzset();
 	my $commit_date = strftime("%s %z", localtime($date));
 	$ENV{'TZ'}="UTC";
+	tzset();
 	$ENV{GIT_AUTHOR_NAME} = $author_name;
 	$ENV{GIT_AUTHOR_EMAIL} = $author_email;
 	$ENV{GIT_AUTHOR_DATE} = $commit_date;
