From: Jeff King <peff@peff.net>
Subject: [PATCH v3 08/19] write_or_die: raise SIGPIPE when we get EPIPE
Date: Wed, 20 Feb 2013 15:01:36 -0500
Message-ID: <20130220200136.GH25647@sigill.intra.peff.net>
References: <20130220195147.GA25332@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 20 21:02:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Frh-0004N8-4y
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 21:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935103Ab3BTUBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 15:01:39 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54587 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935098Ab3BTUBi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 15:01:38 -0500
Received: (qmail 17715 invoked by uid 107); 20 Feb 2013 20:03:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Feb 2013 15:03:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Feb 2013 15:01:36 -0500
Content-Disposition: inline
In-Reply-To: <20130220195147.GA25332@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216722>

The write_or_die function will always die on an error,
including EPIPE. However, it currently treats EPIPE
specially by suppressing any error message, and by exiting
with exit code 0.

Suppressing the error message makes some sense; a pipe death
may just be a sign that the other side is not interested in
what we have to say. However, exiting with a successful
error code is not a good idea, as write_or_die is frequently
used in cases where we want to be careful about having
written all of the output, and we may need to signal to our
caller that we have done so (e.g., you would not want a push
whose other end has hung up to report success).

This distinction doesn't typically matter in git, because we
do not ignore SIGPIPE in the first place. Which means that
we will not get EPIPE, but instead will just die when we get
a SIGPIPE. But it's possible for a default handler to be set
by a parent process, or for us to add a callsite inside one
of our few SIGPIPE-ignoring blocks of code.

This patch converts write_or_die to actually raise SIGPIPE
when we see EPIPE, rather than exiting with zero. This
brings the behavior in line with the "normal" case that we
die from SIGPIPE (and any callers who want to check why we
died will see the same thing). We also give the same
treatment to other related functions, including
write_or_whine_pipe and maybe_flush_or_die.

Signed-off-by: Jeff King <peff@peff.net>
---
 write_or_die.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/write_or_die.c b/write_or_die.c
index 960f448..b50f99a 100644
--- a/write_or_die.c
+++ b/write_or_die.c
@@ -1,5 +1,15 @@
 #include "cache.h"
 
+static void check_pipe(int err)
+{
+	if (err == EPIPE) {
+		signal(SIGPIPE, SIG_DFL);
+		raise(SIGPIPE);
+		/* Should never happen, but just in case... */
+		exit(141);
+	}
+}
+
 /*
  * Some cases use stdio, but want to flush after the write
  * to get error handling (and to get better interactive
@@ -34,8 +44,7 @@ void maybe_flush_or_die(FILE *f, const char *desc)
 			return;
 	}
 	if (fflush(f)) {
-		if (errno == EPIPE)
-			exit(0);
+		check_pipe(errno);
 		die_errno("write failure on '%s'", desc);
 	}
 }
@@ -50,8 +59,7 @@ void write_or_die(int fd, const void *buf, size_t count)
 void write_or_die(int fd, const void *buf, size_t count)
 {
 	if (write_in_full(fd, buf, count) < 0) {
-		if (errno == EPIPE)
-			exit(0);
+		check_pipe(errno);
 		die_errno("write error");
 	}
 }
@@ -59,8 +67,7 @@ int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
 int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg)
 {
 	if (write_in_full(fd, buf, count) < 0) {
-		if (errno == EPIPE)
-			exit(0);
+		check_pipe(errno);
 		fprintf(stderr, "%s: write error (%s)\n",
 			msg, strerror(errno));
 		return 0;
-- 
1.8.2.rc0.9.g352092c
