From: Jeff King <peff@peff.net>
Subject: Re: t0300-credentials: poll failed: invalid argument
Date: Mon, 29 Aug 2011 13:14:11 -0400
Message-ID: <20110829171411.GB756@sigill.intra.peff.net>
References: <5C993C44-D045-4344-95C1-94D3E6DB0316@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 19:14:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy5Pi-00042C-2Z
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 19:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446Ab1H2ROQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 13:14:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48739
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754426Ab1H2ROP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 13:14:15 -0400
Received: (qmail 18607 invoked by uid 107); 29 Aug 2011 17:14:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 29 Aug 2011 13:14:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Aug 2011 13:14:11 -0400
Content-Disposition: inline
In-Reply-To: <5C993C44-D045-4344-95C1-94D3E6DB0316@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180322>

On Sun, Aug 28, 2011 at 12:40:56AM -0400, Brian Gernhardt wrote:

> The only usage of poll I see in the credentials system is:
> 
> credentials-cache--daemon.c
> 177:	if (poll(&pfd, 1, 1000 * wakeup) < 0) {
> 
> My guess is that (1000 * wakeup) is more than INT_MAX and is becoming
> negative as the man page for poll seems to indicate that it will fail
> if timeout < -1.
> 
> Does anyone familiar with the credentials daemon want to try to figure
> out a reasonable fix?

Ugh, sorry, this is my fault. The check_expiration() function can return
a totally bogus value before we actually get any credentials.

Does this patch fix it for you?

-- >8 --
Subject: [PATCH] credential-cache: fix expiration calculation corner cases

The main credential-cache daemon loop calls poll to wait for
a client or to trigger the expiration of credentials. When
the last credential we hold expires, we exit.

However, there is a corner case: when we first start up, we
have no credentials, and are waiting for a client to
provide us with one. In this case, we ended up handing
complete junk for the timeout argument to poll(). On some
systems, this caused us to just wait a long time for the
client (which usually showed up within a second or so). On
OS X, however, the system quite reasonably complained about
our junk value with EINVAL.

Fixing this is pretty straightforward; we just notice that
we have no entries to compare against. However, that bug was
covering up another one: our expiration calculation didn't
give clients a chance to actually connect and provide us
with a credential before we decided that we should exit
because we weren't holding any credentials!

The new algorithm is:

  1. Sleep until it's time to expire the most recent
     credential.

  2. If we don't have any credentials yet, wait 30 seconds
     for a client to contact us and give us one.

  3. After expiring the last credential, wait 30 seconds for
     a client to provide us with one.

Technically only parts (1) and (2) are needed to implement
the original intended behavior.

But (3) is a minor optimization that is made easy by the new
code. When a client gives us a credential, then removes it
(e.g., because it had a bogus password), and then gives us
another one, we used to exit, forcing the client to start a
new daemon instance. Instead, we can just reuse the existing
daemon instance.

Signed-off-by: Jeff King <peff@peff.net>
---
 credential-cache--daemon.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/credential-cache--daemon.c b/credential-cache--daemon.c
index f520347..d6769b1 100644
--- a/credential-cache--daemon.c
+++ b/credential-cache--daemon.c
@@ -57,20 +57,33 @@ static void remove_credential(const struct credential *c)
 
 static int check_expirations(void)
 {
+	static unsigned long wait_for_entry_until;
 	int i = 0;
 	unsigned long now = time(NULL);
 	unsigned long next = (unsigned long)-1;
 
+	/*
+	 * Initially give the client 30 seconds to actually contact us
+	 * and store a credential before we decide there's no point in
+	 * keeping the daemon around.
+	 */
+	if (!wait_for_entry_until)
+		wait_for_entry_until = now + 30;
+
 	while (i < entries_nr) {
 		if (entries[i].expiration <= now) {
 			entries_nr--;
-			if (!entries_nr)
-				return 0;
 			free(entries[i].item.description);
 			free(entries[i].item.unique);
 			free(entries[i].item.username);
 			free(entries[i].item.password);
 			memcpy(&entries[i], &entries[entries_nr], sizeof(*entries));
+			/*
+			 * Stick around 30 seconds in case a new credential
+			 * shows up (e.g., because we just removed a failed
+			 * one, and we will soon get the correct one).
+			 */
+			wait_for_entry_until = now + 30;
 		}
 		else {
 			if (entries[i].expiration < next)
@@ -79,6 +92,12 @@ static int check_expirations(void)
 		}
 	}
 
+	if (!entries_nr) {
+		if (wait_for_entry_until <= now)
+			return 0;
+		next = wait_for_entry_until;
+	}
+
 	return next - now;
 }
 
-- 
1.7.6.10.g62f04
