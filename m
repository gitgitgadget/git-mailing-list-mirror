From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Oct 2012, #09; Mon, 29)
Date: Sun, 4 Nov 2012 07:29:26 -0500
Message-ID: <20121104122926.GD336@sigill.intra.peff.net>
References: <20121029102114.GA14497@sigill.intra.peff.net>
 <5092C234.9000307@ramsay1.demon.co.uk>
 <CAEUsAPb7hUViLn7V7v65r6mOqRHr+180ynRX8K9t3nuJVyePfg@mail.gmail.com>
 <20121102094259.GA28414@sigill.intra.peff.net>
 <20121102095632.GA30221@sigill.intra.peff.net>
 <50943C1A.4090706@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Rorvick <chris@rorvick.com>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Nov 04 13:29:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUzKh-0000zk-9z
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 13:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003Ab2KDM3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 07:29:30 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56545 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502Ab2KDM33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 07:29:29 -0500
Received: (qmail 23323 invoked by uid 107); 4 Nov 2012 12:30:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 04 Nov 2012 07:30:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 Nov 2012 07:29:26 -0500
Content-Disposition: inline
In-Reply-To: <50943C1A.4090706@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209025>

On Fri, Nov 02, 2012 at 09:33:14PM +0000, Ramsay Jones wrote:

> >> I wonder if Ramsay has an older perl that does not do this special
> >> hackery right. I'll see if I can dig up where it first appeared.
> 
> Hmm, sorry for not specifying this upfront, but this failure is on Linux. ;-)

Ah, that's helpful to know.

> (Linux is my main platform, but I like to keep cygwin working because it has
> kept me sane on Windows ever since (about) 1995 ...)
> "Stranger in a strange land" ;-)

I used a different trick around the same time to keep me sane from
Windows, but I think it involved "dd" and "/dev/zero"...

> I'm using perl v5.8.8 on Linux.

Yeah, that is the problem. Calling localtime_r repeatedly while changing
the timezone does not work on some platforms:

  https://rt.perl.org/rt3/Public/Bug/Display.html?id=26136

The fix (to call tzset each time) went into perl 5.10.0.

> > Ramsay, what happens with this patch on top?
> 
> This patch fixes the test for me.

Great. I was guessing blindly when I wrote it, but having seen the perl
bug above, it all makes sense.

We should probably wrap it. I'm planning to queue this on top of Chris's
patch:

-- >8 --
Subject: [PATCH] cvsimport: work around perl tzset issue

On many platforms, the first invocation of localtime_r will
check $TZ in the environment, but subsequent invocations
will use a cache value. That means that setting $ENV{TZ} in
the middle of the program may or may not have an effect on
later calls to localtime.  Perl 5.10.0 and later handles
this automatically for us, but we try to remain portable
back to 5.8. Work around it by calling tzset ourselves.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-cvsimport.perl | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index ceb119d..0a31ebd 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -24,11 +24,11 @@ use File::Basename qw(basename dirname);
 use Time::Local;
 use IO::Socket;
 use IO::Pipe;
-use POSIX qw(strftime dup2 ENOENT);
+use POSIX qw(strftime tzset dup2 ENOENT);
 use IPC::Open2;
 
 $SIG{'PIPE'}="IGNORE";
-$ENV{'TZ'}="UTC";
+set_timezone('UTC');
 
 our ($opt_h,$opt_o,$opt_v,$opt_k,$opt_u,$opt_d,$opt_p,$opt_C,$opt_z,$opt_i,$opt_P, $opt_s,$opt_m,@opt_M,$opt_A,$opt_S,$opt_L, $opt_a, $opt_r, $opt_R);
 my (%conv_author_name, %conv_author_email, %conv_author_tz);
@@ -99,6 +99,15 @@ sub write_author_info($) {
 	close ($f);
 }
 
+# Versions of perl before 5.10.0 may not automatically check $TZ each
+# time localtime is run (most platforms will do so only the first time).
+# We can work around this by using tzset() to update the internal
+# variable whenever we change the environment.
+sub set_timezone {
+	$ENV{TZ} = shift;
+	tzset();
+}
+
 # convert getopts specs for use by git config
 my %longmap = (
 	'A:' => 'authors-file',
@@ -854,9 +863,9 @@ sub commit {
 		}
 	}
 
-	$ENV{'TZ'}=$author_tz;
+	set_timezone($author_tz);
 	my $commit_date = strftime("%s %z", localtime($date));
-	$ENV{'TZ'}="UTC";
+	set_timezone('UTC');
 	$ENV{GIT_AUTHOR_NAME} = $author_name;
 	$ENV{GIT_AUTHOR_EMAIL} = $author_email;
 	$ENV{GIT_AUTHOR_DATE} = $commit_date;
-- 
1.8.0.207.gdf2154c
