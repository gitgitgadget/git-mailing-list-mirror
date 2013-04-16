From: Jeff King <peff@peff.net>
Subject: [PATCH v2 2/2] run-command: use thread-aware die_is_recursing routine
Date: Tue, 16 Apr 2013 15:50:07 -0400
Message-ID: <20130416195006.GB11185@sigill.intra.peff.net>
References: <20130416194418.GA7187@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Apr 16 21:50:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USBtb-0004xv-O2
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 21:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935935Ab3DPTuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 15:50:13 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48349 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935589Ab3DPTuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 15:50:09 -0400
Received: (qmail 7865 invoked by uid 107); 16 Apr 2013 19:52:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 16 Apr 2013 15:52:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Apr 2013 15:50:07 -0400
Content-Disposition: inline
In-Reply-To: <20130416194418.GA7187@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221460>

If we die from an async thread, we do not actually exit the
program, but just kill the thread. This confuses the static
counter in usage.c's default die_is_recursing function; it
updates the counter once for the thread death, and then when
the main program calls die() itself, it erroneously thinks
we are recursing. The end result is that we print "recursion
detected in die handler" instead of the real error in such a
case (the easiest way to trigger this is having a remote
connection hang up while running a sideband demultiplexer).

This patch solves it by using a per-thread counter when the
async_die function is installed; we detect recursion in each
thread (including the main one), but they do not step on
each other's toes.

Other threaded code does not need to worry about this, as
they do not install specialized die handlers; they just let
a die() from a sub-thread take down the whole program.

Since we are overriding the default recursion-check
function, there is an interesting corner case that is not a
problem, but bears some explanation. Imagine the main thread
calls die(), and then in the die_routine starts an async
call. We will switch to using thread-local storage, which
starts at 0, for the main thread's counter, even though
the original counter was actually at 1. That's OK, though,
for two reasons:

  1. It would miss only the first level of recursion, and
     would still find recursive failures inside the async
     helper.

  2. We do not currently and are not likely to start doing
     anything as heavyweight as starting an async routine
     from within a die routine or helper function.

Signed-off-by: Jeff King <peff@peff.net>
---
 run-command.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/run-command.c b/run-command.c
index 765c2ce..1b32a12 100644
--- a/run-command.c
+++ b/run-command.c
@@ -588,6 +588,7 @@ static pthread_key_t async_key;
 static pthread_t main_thread;
 static int main_thread_set;
 static pthread_key_t async_key;
+static pthread_key_t async_die_counter;
 
 static void *run_thread(void *data)
 {
@@ -614,6 +615,14 @@ static NORETURN void die_async(const char *err, va_list params)
 
 	exit(128);
 }
+
+static int async_die_is_recursing(void)
+{
+	void *ret = pthread_getspecific(async_die_counter);
+	pthread_setspecific(async_die_counter, (void *)1);
+	return ret != NULL;
+}
+
 #endif
 
 int start_async(struct async *async)
@@ -695,7 +704,9 @@ int start_async(struct async *async)
 		main_thread_set = 1;
 		main_thread = pthread_self();
 		pthread_key_create(&async_key, NULL);
+		pthread_key_create(&async_die_counter, NULL);
 		set_die_routine(die_async);
+		set_die_is_recursing_routine(async_die_is_recursing);
 	}
 
 	if (proc_in >= 0)
-- 
1.8.2.8.g44e4c28
