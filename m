From: Jeff King <peff@peff.net>
Subject: [PATCH 5/9] grep: drop grep_buffer's "name" parameter
Date: Thu, 2 Feb 2012 03:20:10 -0500
Message-ID: <20120202082010.GE6786@sigill.intra.peff.net>
References: <20120202081747.GA10271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:20:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsru0-0000Vo-Su
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 09:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754609Ab2BBIUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 03:20:14 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52871
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063Ab2BBIUN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 03:20:13 -0500
Received: (qmail 17892 invoked by uid 107); 2 Feb 2012 08:27:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 03:27:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 03:20:10 -0500
Content-Disposition: inline
In-Reply-To: <20120202081747.GA10271@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189597>

Before the grep_source interface existed, grep_buffer was
used by two types of callers:

  1. Ones which pulled a file into a buffer, and then wanted
     to supply the file's name for the output (i.e.,
     git grep).

  2. Ones which really just wanted to grep a buffer (i.e.,
     git log --grep).

Callers in set (1) should now be using grep_source. Callers
in set (2) always pass NULL for the "name" parameter of
grep_buffer. We can therefore get rid of this now-useless
parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
This one isn't necessary, obviously, but I think it's a nice clean-up
after the last two patches.

 grep.c     |    4 ++--
 grep.h     |    2 +-
 revision.c |    1 -
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index 8204ca2..2a3fe7c 100644
--- a/grep.c
+++ b/grep.c
@@ -1215,12 +1215,12 @@ int grep_source(struct grep_opt *opt, struct grep_source *gs)
 	return grep_source_1(opt, gs, 0);
 }
 
-int grep_buffer(struct grep_opt *opt, const char *name, char *buf, unsigned long size)
+int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size)
 {
 	struct grep_source gs;
 	int r;
 
-	grep_source_init(&gs, GREP_SOURCE_BUF, name, NULL);
+	grep_source_init(&gs, GREP_SOURCE_BUF, NULL, NULL);
 	gs.buf = buf;
 	gs.size = size;
 
diff --git a/grep.h b/grep.h
index e386ca4..8bf3001 100644
--- a/grep.h
+++ b/grep.h
@@ -127,7 +127,7 @@ extern void append_grep_pattern(struct grep_opt *opt, const char *pat, const cha
 extern void append_header_grep_pattern(struct grep_opt *, enum grep_header_field, const char *);
 extern void compile_grep_patterns(struct grep_opt *opt);
 extern void free_grep_patterns(struct grep_opt *opt);
-extern int grep_buffer(struct grep_opt *opt, const char *name, char *buf, unsigned long size);
+extern int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size);
 
 struct grep_source {
 	char *name;
diff --git a/revision.c b/revision.c
index c97d834..819ff01 100644
--- a/revision.c
+++ b/revision.c
@@ -2149,7 +2149,6 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	if (!opt->grep_filter.pattern_list && !opt->grep_filter.header_list)
 		return 1;
 	return grep_buffer(&opt->grep_filter,
-			   NULL, /* we say nothing, not even filename */
 			   commit->buffer, strlen(commit->buffer));
 }
 
-- 
1.7.9.3.gc3fce1.dirty
