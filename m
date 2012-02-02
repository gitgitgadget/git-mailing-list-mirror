From: Jeff King <peff@peff.net>
Subject: [PATCH 9/9] grep: pre-load userdiff drivers when threaded
Date: Thu, 2 Feb 2012 03:24:28 -0500
Message-ID: <20120202082428.GI6786@sigill.intra.peff.net>
References: <20120202081747.GA10271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:24:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsry8-00027k-3F
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 09:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754Ab2BBIYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 03:24:32 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52901
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754443Ab2BBIYb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 03:24:31 -0500
Received: (qmail 18037 invoked by uid 107); 2 Feb 2012 08:31:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 03:31:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 03:24:28 -0500
Content-Disposition: inline
In-Reply-To: <20120202081747.GA10271@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189601>

The low-level grep_source code will automatically load the
userdiff driver to see whether a file is binary. However,
when we are threaded, it will load the drivers in a
non-deterministic order, handling each one as its assigned
thread happens to be scheduled.

Meanwhile, the attribute lookup code (which underlies the
userdiff driver lookup) is optimized to handle paths in
sequential order (because they tend to share the same
gitattributes files). Multi-threading the lookups destroys
the locality and makes this optimization less effective.

We can fix this by pre-loading the userdiff driver in the
main thread, before we hand off the file to a worker thread.
My best-of-five for "git grep foo" on the linux-2.6
repository went from:

  real    0m0.391s
  user    0m1.708s
  sys     0m0.584s

to:

  real    0m0.360s
  user    0m1.576s
  sys     0m0.572s

Not a huge speedup, but it's quite easy to do. The only
trick is that we shouldn't perform this optimization if "-a"
was used, in which case we won't bother checking whether
the files are binary at all.

Signed-off-by: Jeff King <peff@peff.net>
---
The speedup is especially unimpressive when you consider that it won't
grow as the grep load grows. This is a pretty fast grep. If you used a
real regex, the whole thing would take even longer, and you will still
only be shaving off a few tens of milliseconds. So I wouldn't be
heart-broken if this patch was dropped. I included it because it's easy
to do, and maybe somebody with a slower machine would find the absolute
time difference more noticeable.

 builtin/grep.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index bc85a20..9fc3e95 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -85,8 +85,8 @@ static pthread_cond_t cond_result;
 
 static int skip_first_line;
 
-static void add_work(enum grep_source_type type, const char *name,
-		     const void *id)
+static void add_work(struct grep_opt *opt, enum grep_source_type type,
+		     const char *name, const void *id)
 {
 	grep_lock();
 
@@ -95,6 +95,8 @@ static void add_work(enum grep_source_type type, const char *name,
 	}
 
 	grep_source_init(&todo[todo_end].source, type, name, id);
+	if (opt->binary != GREP_BINARY_TEXT)
+		grep_source_load_driver(&todo[todo_end].source);
 	todo[todo_end].done = 0;
 	strbuf_reset(&todo[todo_end].out);
 	todo_end = (todo_end + 1) % ARRAY_SIZE(todo);
@@ -333,7 +335,7 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 
 #ifndef NO_PTHREADS
 	if (use_threads) {
-		add_work(GREP_SOURCE_SHA1, pathbuf.buf, sha1);
+		add_work(opt, GREP_SOURCE_SHA1, pathbuf.buf, sha1);
 		strbuf_release(&pathbuf);
 		return 0;
 	} else
@@ -362,7 +364,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 
 #ifndef NO_PTHREADS
 	if (use_threads) {
-		add_work(GREP_SOURCE_FILE, buf.buf, filename);
+		add_work(opt, GREP_SOURCE_FILE, buf.buf, filename);
 		strbuf_release(&buf);
 		return 0;
 	} else
-- 
1.7.9.3.gc3fce1.dirty
