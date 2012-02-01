From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] grep: let grep_buffer callers specify a binary flag
Date: Wed, 1 Feb 2012 18:21:09 -0500
Message-ID: <20120201232109.GA2652@sigill.intra.peff.net>
References: <20120201221437.GA19044@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: =?utf-8?Q?Conrad=C2=A0Irwin?= <conrad.irwin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 00:21:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsjUL-0002CF-73
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 00:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398Ab2BAXVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 18:21:12 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52491
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344Ab2BAXVL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 18:21:11 -0500
Received: (qmail 14442 invoked by uid 107); 1 Feb 2012 23:28:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Feb 2012 18:28:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Feb 2012 18:21:09 -0500
Content-Disposition: inline
In-Reply-To: <20120201221437.GA19044@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189553>

The caller of grep_buffer may have extra information about
whether a buffer is binary or not (e.g., from configuration).
Let's give them a chance to pass along that information and
override our binary auto-detection.

Callers can still pass "-1" to get the regular
auto-detection (and all callers are converted to do this,
meaning there should be no behavior change yet).

We could maintain source compatibility for callers by adding
a new "grep_buffer_with_flags" and leaving "grep_buffer" as
a wrapper that always passes "-1". But there are only 5
callers of grep_buffer, and only 1 of those (grepping commit
buffers) will not be converted to pass something useful in
the next patch. So it's simpler to just add a "-1" there.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/grep.c |    8 ++++----
 grep.c         |   23 ++++++++++++++++-------
 grep.h         |    2 +-
 revision.c     |    1 +
 4 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9ce064a..e328316 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -221,14 +221,14 @@ static void *run(void *arg)
 			void* data = load_sha1(w->identifier, &sz, w->name);
 
 			if (data) {
-				hit |= grep_buffer(opt, w->name, data, sz);
+				hit |= grep_buffer(opt, w->name, -1, data, sz);
 				free(data);
 			}
 		} else if (w->type == WORK_FILE) {
 			size_t sz;
 			void* data = load_file(w->identifier, &sz);
 			if (data) {
-				hit |= grep_buffer(opt, w->name, data, sz);
+				hit |= grep_buffer(opt, w->name, -1, data, sz);
 				free(data);
 			}
 		} else {
@@ -421,7 +421,7 @@ static int grep_sha1(struct grep_opt *opt, const unsigned char *sha1,
 		if (!data)
 			hit = 0;
 		else
-			hit = grep_buffer(opt, name, data, sz);
+			hit = grep_buffer(opt, name, -1, data, sz);
 
 		free(data);
 		free(name);
@@ -483,7 +483,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 		if (!data)
 			hit = 0;
 		else
-			hit = grep_buffer(opt, name, data, sz);
+			hit = grep_buffer(opt, name, -1, data, sz);
 
 		free(data);
 		free(name);
diff --git a/grep.c b/grep.c
index 486230b..e547db2 100644
--- a/grep.c
+++ b/grep.c
@@ -983,8 +983,16 @@ static void std_output(struct grep_opt *opt, const void *buf, size_t size)
 	fwrite(buf, size, 1, stdout);
 }
 
+static int grep_buffer_is_binary(char *buf, unsigned long size, int flag)
+{
+	if (flag == -1)
+		flag = buffer_is_binary(buf, size);
+	return flag;
+}
+
 static int grep_buffer_1(struct grep_opt *opt, const char *name,
-			 char *buf, unsigned long size, int collect_hits)
+			 int is_binary, char *buf, unsigned long size,
+			 int collect_hits)
 {
 	char *bol = buf;
 	unsigned long left = size;
@@ -1017,11 +1025,11 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 
 	switch (opt->binary) {
 	case GREP_BINARY_DEFAULT:
-		if (buffer_is_binary(buf, size))
+		if (grep_buffer_is_binary(buf, size, is_binary))
 			binary_match_only = 1;
 		break;
 	case GREP_BINARY_NOMATCH:
-		if (buffer_is_binary(buf, size))
+		if (grep_buffer_is_binary(buf, size, is_binary))
 			return 0; /* Assume unmatch */
 		break;
 	case GREP_BINARY_TEXT:
@@ -1182,23 +1190,24 @@ static int chk_hit_marker(struct grep_expr *x)
 	}
 }
 
-int grep_buffer(struct grep_opt *opt, const char *name, char *buf, unsigned long size)
+int grep_buffer(struct grep_opt *opt, const char *name, int is_binary,
+		char *buf, unsigned long size)
 {
 	/*
 	 * we do not have to do the two-pass grep when we do not check
 	 * buffer-wide "all-match".
 	 */
 	if (!opt->all_match)
-		return grep_buffer_1(opt, name, buf, size, 0);
+		return grep_buffer_1(opt, name, is_binary, buf, size, 0);
 
 	/* Otherwise the toplevel "or" terms hit a bit differently.
 	 * We first clear hit markers from them.
 	 */
 	clr_hit_marker(opt->pattern_expression);
-	grep_buffer_1(opt, name, buf, size, 1);
+	grep_buffer_1(opt, name, is_binary, buf, size, 1);
 
 	if (!chk_hit_marker(opt->pattern_expression))
 		return 0;
 
-	return grep_buffer_1(opt, name, buf, size, 0);
+	return grep_buffer_1(opt, name, is_binary, buf, size, 0);
 }
diff --git a/grep.h b/grep.h
index fb205f3..8447e4c 100644
--- a/grep.h
+++ b/grep.h
@@ -128,7 +128,7 @@ extern void append_grep_pattern(struct grep_opt *opt, const char *pat, const cha
 extern void append_header_grep_pattern(struct grep_opt *, enum grep_header_field, const char *);
 extern void compile_grep_patterns(struct grep_opt *opt);
 extern void free_grep_patterns(struct grep_opt *opt);
-extern int grep_buffer(struct grep_opt *opt, const char *name, char *buf, unsigned long size);
+extern int grep_buffer(struct grep_opt *opt, const char *name, int is_binary, char *buf, unsigned long size);
 
 extern struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
 extern int grep_threads_ok(const struct grep_opt *opt);
diff --git a/revision.c b/revision.c
index c97d834..3dcd968 100644
--- a/revision.c
+++ b/revision.c
@@ -2150,6 +2150,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 		return 1;
 	return grep_buffer(&opt->grep_filter,
 			   NULL, /* we say nothing, not even filename */
+			   -1,
 			   commit->buffer, strlen(commit->buffer));
 }
 
-- 
1.7.9.3.gc3fce1.dirty
