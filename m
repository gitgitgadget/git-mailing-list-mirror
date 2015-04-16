From: Jeff King <peff@peff.net>
Subject: [PATCH 7/9] strbuf_getwholeline: use getdelim if it is available
Date: Thu, 16 Apr 2015 05:01:38 -0400
Message-ID: <20150416090138.GG17938@peff.net>
References: <20150416084733.GA17811@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 11:02:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yifgs-0008UQ-NB
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 11:02:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757209AbbDPJC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 05:02:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:46124 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757076AbbDPJBl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 05:01:41 -0400
Received: (qmail 22151 invoked by uid 102); 16 Apr 2015 09:01:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 04:01:41 -0500
Received: (qmail 23592 invoked by uid 107); 16 Apr 2015 09:02:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 05:02:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 05:01:38 -0400
Content-Disposition: inline
In-Reply-To: <20150416084733.GA17811@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267268>

We spend a lot of time in strbuf_getwholeline in a tight
loop reading characters from a stdio handle into a buffer.
The libc getdelim() function can do this for us with less
overhead. It's in POSIX.1-2008, and was a GNU extension
before that. Therefore we can't rely on it, but can fall
back to the existing getc loop when it is not available.

The HAVE_GETDELIM knob is turned on automatically for Linux,
where we have glibc. We don't need to set any new
feature-test macros, because we already define _GNU_SOURCE.
Other systems that implement getdelim may need to other
macros (probably _POSIX_C_SOURCE >= 200809L), but we can
address that along with setting the Makefile knob after
testing the feature on those systems.

Running "git rev-parse refs/heads/does-not-exist" on a repo
with an extremely large (1.6GB) packed-refs file went from
(best-of-5):

  real    0m8.601s
  user    0m8.084s
  sys     0m0.524s

to:

  real    0m6.768s
  user    0m6.340s
  sys     0m0.432s

for a wall-clock speedup of 21%.

Based on a patch from Rasmus Villemoes <rv@rasmusvillemoes.dk>.

Signed-off-by: Jeff King <peff@peff.net>
---
If somebody has a FreeBSD or OS X system to test on, I'd
love to see what is needed to compile with HAVE_GETDELIM
there. And to confirm that the performance is much better.
Sharing my 1.6GB packed-refs file would be hard, but you
should be able to generate something large and ridiculous.
I'll leave that as an exercise to the reader.

 Makefile         |  6 ++++++
 config.mak.uname |  1 +
 strbuf.c         | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/Makefile b/Makefile
index 5f3987f..36655d5 100644
--- a/Makefile
+++ b/Makefile
@@ -359,6 +359,8 @@ all::
 # compiler is detected to support it.
 #
 # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl function.
+#
+# Define HAVE_GETDELIM if your system has the getdelim() function.
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1437,6 +1439,10 @@ ifdef HAVE_BSD_SYSCTL
 	BASIC_CFLAGS += -DHAVE_BSD_SYSCTL
 endif
 
+ifdef HAVE_GETDELIM
+	BASIC_CFLAGS += -DHAVE_GETDELIM
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
diff --git a/config.mak.uname b/config.mak.uname
index f4e77cb..d26665f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -36,6 +36,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_DEV_TTY = YesPlease
 	HAVE_CLOCK_GETTIME = YesPlease
 	HAVE_CLOCK_MONOTONIC = YesPlease
+	HAVE_GETDELIM = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H = YesPlease
diff --git a/strbuf.c b/strbuf.c
index 921619e..0d4f4e5 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -435,6 +435,47 @@ int strbuf_getcwd(struct strbuf *sb)
 	return -1;
 }
 
+#ifdef HAVE_GETDELIM
+int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
+{
+	ssize_t r;
+
+	if (feof(fp))
+		return EOF;
+
+	strbuf_reset(sb);
+
+	/* Translate slopbuf to NULL, as we cannot call realloc on it */
+	if (!sb->alloc)
+		sb->buf = NULL;
+	r = getdelim(&sb->buf, &sb->alloc, term, fp);
+
+	if (r > 0) {
+		sb->len = r;
+		return 0;
+	}
+	assert(r == -1);
+
+	/*
+	 * Normally we would have called xrealloc, which will try to free
+	 * memory and recover. But we have no way to tell getdelim() to do so.
+	 * Worse, we cannot try to recover ENOMEM ourselves, because we have
+	 * no idea how many bytes were read by getdelim.
+	 *
+	 * Dying here is reasonable. It mirrors what xrealloc would do on
+	 * catastrophic memory failure. We skip the opportunity to free pack
+	 * memory and retry, but that's unlikely to help for a malloc small
+	 * enough to hold a single line of input, anyway.
+	 */
+	if (errno == ENOMEM)
+		die("Out of memory, getdelim failed");
+
+	/* Restore slopbuf that we moved out of the way before */
+	if (!sb->buf)
+		strbuf_init(sb, 0);
+	return EOF;
+}
+#else
 int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 {
 	int ch;
@@ -458,6 +499,7 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 	sb->buf[sb->len] = '\0';
 	return 0;
 }
+#endif
 
 int strbuf_getline(struct strbuf *sb, FILE *fp, int term)
 {
-- 
2.4.0.rc2.384.g7297a4a
