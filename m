From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/2] avoid bogus "recursion detected in die handler"
 message
Date: Tue, 16 Apr 2013 15:44:18 -0400
Message-ID: <20130416194418.GA7187@sigill.intra.peff.net>
References: <20130415230651.GA16670@sigill.intra.peff.net>
 <20130415230802.GA11267@sigill.intra.peff.net>
 <CA+sFfMes99EepY4FCW32s1L3ywv_gyFb76=Y=35rvPbc2K1BWA@mail.gmail.com>
 <20130416004228.GA14995@sigill.intra.peff.net>
 <CA+sFfMdzTNjH10FKxhvJy+7hZg+0=1Wrqy9k8KaPoJg1DuDpmg@mail.gmail.com>
 <20130416025024.GA20932@sigill.intra.peff.net>
 <516CFB56.1090805@viscovery.net>
 <20130416130154.GA17976@sigill.intra.peff.net>
 <516D5CA4.7000500@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Apr 16 21:44:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USBnn-0005Cs-0x
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 21:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935637Ab3DPToW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 15:44:22 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48336 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935589Ab3DPToV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 15:44:21 -0400
Received: (qmail 7746 invoked by uid 107); 16 Apr 2013 19:46:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Apr 2013 15:46:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Apr 2013 15:44:18 -0400
Content-Disposition: inline
In-Reply-To: <516D5CA4.7000500@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221456>

On Tue, Apr 16, 2013 at 04:13:56PM +0200, Johannes Sixt wrote:

> > I'm not clear on what you are suggesting. That we protect only the main
> > thread from recursion, or that we drop the check entirely? Or that we
> > implement thread-local storage for this case without using pthread_once?
> 
> Anything(*) that does not require pthread_once. A pthread_once
> implementation on Windows would be tricky and voluminous and and on top of
> it very likely to be done differently for gcc and MSVC. I don't like to go
> there if we can avoid it.

We don't need to use pthread_once, as we can just do the initialization
of the thread-local storage along with starting the first thread (where
we already do similar initialization).  Patch series to follow:

  [1/2]: usage: allow pluggable die-recursion checks
  [2/2]: run-command: use thread-aware die_is_recursing routine

> (*) That includes doing nothing, but does not include ripping out the
> recursion check, as it protects us from crashes.

I don't think doing nothing is a good idea. The recursion-detection is
triggering erroneously, blocking real error messages and replacing them
with the scary red-herring "recursion detected in die handler".

The absolute simplest thing I think we could do is basically:

diff --git a/run-command.c b/run-command.c
index 765c2ce..3b0ad44 100644
--- a/run-command.c
+++ b/run-command.c
@@ -599,11 +599,14 @@ static NORETURN void die_async(const char *err, va_list params)
 	return (void *)ret;
 }
 
+extern int dying;
+
 static NORETURN void die_async(const char *err, va_list params)
 {
 	vreportf("fatal: ", err, params);
 
 	if (!pthread_equal(main_thread, pthread_self())) {
+		dying = 0; /* undo counter */
 		struct async *async = pthread_getspecific(async_key);
 		if (async->proc_in >= 0)
 			close(async->proc_in);
diff --git a/usage.c b/usage.c
index 40b3de5..cf8a968 100644
--- a/usage.c
+++ b/usage.c
@@ -6,7 +6,7 @@
 #include "git-compat-util.h"
 #include "cache.h"
 
-static int dying;
+int dying;
 
 void vreportf(const char *prefix, const char *err, va_list params)
 {

Obviously it would help to wrap it in a "clear_die_counter()" function,
but it would still suffer from the problem that there is no
synchronization. In the moment between incrementing and resetting the
dying counter, another thread (including the main program) could check
it. In practice, this does not happen in the current code, because we
do not start many async threads (and we only die in the main thread once
the async thread dies). But it seems unnecessarily flaky and prone to
future problems.

It would also be possible to use mutexes to make it work reliably, but
I'd be very concerned about increasing the complexity of the die code
path.  We would never want a hung thread to prevent the main program
from successfully exiting, for example.

So I think the right solution is just a per-thread counter.

-Peff
