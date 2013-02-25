From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 2/4] skip_prefix: return a non-const pointer
Date: Mon, 25 Feb 2013 13:39:48 -0500
Message-ID: <20130225183948.GB14438@sigill.intra.peff.net>
References: <20130225183009.GB13912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:40:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA2yG-0006wW-7Q
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 19:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758907Ab3BYSjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 13:39:51 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60091 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754529Ab3BYSjv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 13:39:51 -0500
Received: (qmail 25636 invoked by uid 107); 25 Feb 2013 18:41:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Feb 2013 13:41:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2013 13:39:48 -0500
Content-Disposition: inline
In-Reply-To: <20130225183009.GB13912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217078>

The const rules in C are such that one cannot write a
function that takes a const or non-const pointer and returns
a pointer that matches the input in const-ness. Instead, you
must take a const pointer (because you are promising not to
modify it), and then either return a const pointer (which is
safer, but annoying to callers who originally had a
non-const pointer) or a non-const pointer (less safe, as you
may accidentally drop constness, but less annoying).

This is a well-known problem, and the standard string
functions like strchr take the "less annoying" approach.
Let's mimic them. Even though this is technically less safe,
skip_prefix tends to be used alongside standard string
manipulation functions already, so it is not really
introducing a new problem.

Signed-off-by: Jeff King <peff@peff.net>
---
I have mixed feelings on this. It _is_ less safe, and this is a known
bug in the C standard. Still, it seems like the more idiomatic C thing
to do.

My main motivation is to avoid a bunch of casts in the next patch.

 builtin/commit.c  | 2 +-
 git-compat-util.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 3348aa1..bb6890b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -895,7 +895,7 @@ static int template_untouched(struct strbuf *sb)
 		return 0;
 
 	stripspace(&tmpl, cleanup_mode == CLEANUP_ALL);
-	start = (char *)skip_prefix(sb->buf, tmpl.buf);
+	start = skip_prefix(sb->buf, tmpl.buf);
 	if (!start)
 		start = sb->buf;
 	strbuf_release(&tmpl);
diff --git a/git-compat-util.h b/git-compat-util.h
index b7eaaa9..56c066b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -320,10 +320,10 @@ static inline const char *skip_prefix(const char *str, const char *prefix)
 extern int prefixcmp(const char *str, const char *prefix);
 extern int suffixcmp(const char *str, const char *suffix);
 
-static inline const char *skip_prefix(const char *str, const char *prefix)
+static inline char *skip_prefix(const char *str, const char *prefix)
 {
 	size_t len = strlen(prefix);
-	return strncmp(str, prefix, len) ? NULL : str + len;
+	return strncmp(str, prefix, len) ? NULL : (char *)(str + len);
 }
 
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
-- 
1.8.1.4.4.g265d2fa
