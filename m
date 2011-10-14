From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not
 allowed
Date: Fri, 14 Oct 2011 15:27:41 -0400
Message-ID: <20111014192741.GA13029@sigill.intra.peff.net>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
 <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net>
 <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
 <20111013182816.GA17573@sigill.intra.peff.net>
 <7vvcrs181e.fsf@alter.siamese.dyndns.org>
 <20111014131041.GC7808@sigill.intra.peff.net>
 <20111014192326.GA7713@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 21:27:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REnQ6-0003nM-21
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 21:27:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756345Ab1JNT1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 15:27:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60786
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753950Ab1JNT1p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 15:27:45 -0400
Received: (qmail 14137 invoked by uid 107); 14 Oct 2011 19:27:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Oct 2011 15:27:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Oct 2011 15:27:41 -0400
Content-Disposition: inline
In-Reply-To: <20111014192326.GA7713@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183604>

On Fri, Oct 14, 2011 at 03:23:26PM -0400, Jeff King wrote:

> Subject: [PATCH] daemon: give friendlier error messages to clients
> 
> When the git-daemon is asked about an inaccessible
> repository, it simply hangs up the connection without saying
> anything further. This makes it hard to distinguish between
> a repository we cannot access (e.g., due to typo), and a
> service or network outage.
> 
> Instead, let's print an "ERR" line, which git clients
> understand since v1.6.1 (2008-12-24).
> 
> Because there is a risk of leaking information about
> non-exported repositories, by default all errors simply say
> "access denied". Open sites can pass a flag to turn on more
> specific messages.

I'm tempted to suggest this on top:

-- >8 --
Subject: [PATCH] daemon: turn on informative errors by default

These are only a problem if you have a bunch of inaccessible
repositories served from the same root as your regular
exported repositories, and you are sensitive about people
learning about the existence of those repositories.

Git is foremost an open system, and our defaults should
reflect that.

Signed-off-by: Jeff King <peff@peff.net>
---
But since it is a potential security issue, it does seem kind of mean to
closed sites to just flip the switch on them.

 Documentation/git-daemon.txt |    6 +++---
 daemon.c                     |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index ac57c6d..2b17175 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -161,12 +161,12 @@ the facility of inet daemon to achieve the same before spawning
 	repository configuration.  By default, all the services
 	are overridable.
 
---informative-errors::
-	Return more verbose errors to the client, differentiating
+--no-informative-errors::
+	By default, we return verbose errors to the client, differentiating
 	conditions like "no such repository" from "repository not
 	exported". This is more convenient for clients, but may leak
 	information about the existence of unexported repositories.
-	Without this option, all errors report "access denied" to the
+	With this option, all errors report "access denied" to the
 	client.
 
 <directory>::
diff --git a/daemon.c b/daemon.c
index e5869ec..ba41a40 100644
--- a/daemon.c
+++ b/daemon.c
@@ -20,7 +20,7 @@
 static int log_syslog;
 static int verbose;
 static int reuseaddr;
-static int informative_errors;
+static int informative_errors = 1;
 
 static const char daemon_usage[] =
 "git daemon [--verbose] [--syslog] [--export-all]\n"
-- 
1.7.6.4.37.g43b58b
