From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] use wrapper for unchecked setenv/putenv calls
Date: Wed, 14 Dec 2011 13:16:58 -0500
Message-ID: <20111214181658.GA1691@sigill.intra.peff.net>
References: <1323871631-2872-1-git-send-email-kusmabite@gmail.com>
 <1323871631-2872-5-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, schwab@linux-m68k.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 19:17:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RatO7-00072I-Ir
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 19:17:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757889Ab1LNSRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 13:17:03 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50165
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757885Ab1LNSRB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 13:17:01 -0500
Received: (qmail 581 invoked by uid 107); 14 Dec 2011 18:23:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Dec 2011 13:23:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Dec 2011 13:16:58 -0500
Content-Disposition: inline
In-Reply-To: <1323871631-2872-5-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187161>

On Wed, Dec 14, 2011 at 03:07:11PM +0100, Erik Faye-Lund wrote:

> This avoids us from accidentally dropping state, possibly leading
> to unexpected behaviour.

I do think this is fine in a "be extra cautious" kind of way.

> This is especially important on Windows, where the maximum size of
> the environment is 32 kB.

But does your patch actually detect that? As Andreas pointed out, these
limits don't typically come into play at setenv time. Instead, the
environment is allocated on the heap, and then the result is passed to
exec/spawn, which will fail.

So your patch is really detecting a failure to malloc, not an overflow
of the environment size, and Windows is just as (un)likely to run out of
heap as any other platform.

You can check how your platform behaves by applying this patch:

diff --git a/git.c b/git.c
index f10e434..57f6b12 100644
--- a/git.c
+++ b/git.c
@@ -223,6 +223,16 @@ static int handle_alias(int *argcp, const char ***argv)
 				alias_argv[i] = (*argv)[i];
 			alias_argv[argc] = NULL;
 
+			/* make gigantic environment */
+			{
+				int len = 256 * 1024;
+				char *buf = xmalloc(len);
+				memset(buf, 'z', len);
+				buf[len-1] = '\0';
+				if (setenv("FOO", buf, 1))
+					die("setenv failed");
+			}
+
 			ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
 			if (ret >= 0)   /* normal exit */
 				exit(ret);

and then running:

  git -c alias.foo='!echo ok' foo

which yields:

  fatal: cannot exec 'echo ok': Argument list too long

on Linux.

-Peff

PS I tried to come up with an invocation of git that would demonstrate
   this, but it turns out it's really hard. The contents of environment
   variables we set are either constants, come from the environment (so
   they can't be too big already!), or come from filesystem paths. So
   it's possible to overflow now, but you have to have a nearly-full
   environment in the first place, and then have a long path that tips
   it over the limit.
