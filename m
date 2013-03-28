From: Jeff King <peff@peff.net>
Subject: [PATCH 2/6] dir.c::match_basename(): pay attention to the length of
 string parameters
Date: Thu, 28 Mar 2013 17:47:28 -0400
Message-ID: <20130328214728.GB10936@sigill.intra.peff.net>
References: <20130328214358.GA10685@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, avila.jn@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 22:48:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULKfz-0005xg-N6
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 22:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164Ab3C1Vrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 17:47:36 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44049 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753688Ab3C1Vrf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 17:47:35 -0400
Received: (qmail 30733 invoked by uid 107); 28 Mar 2013 21:49:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 28 Mar 2013 17:49:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Mar 2013 17:47:28 -0400
Content-Disposition: inline
In-Reply-To: <20130328214358.GA10685@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219464>

From: Junio C Hamano <gitster@pobox.com>

The function takes two counted strings (<basename, basenamelen> and
<pattern, patternlen>) as parameters, together with prefix (the
length of the prefix in pattern that is to be matched literally
without globbing against the basename) and EXC_* flags that tells it
how to match the pattern against the basename.

However, it did not pay attention to the length of these counted
strings.  Update them to do the following:

 * When the entire pattern is to be matched literally, the pattern
   matches the basename only when the lengths of them are the same,
   and they match up to that length.

 * When the pattern is "*" followed by a string to be matched
   literally, make sure that the basenamelen is equal or longer than
   the "literal" part of the pattern, and the tail of the basename
   string matches that literal part.

 * Otherwise, use the new fnmatch_icase_mem helper to make
   sure we only lookmake sure we use only look at the
   counted part of the strings.  Because these counted strings are
   full strings most of the time, we check for termination
   to avoid unnecessary allocation.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
---
Compared to v1:

  - This factors the fnmatch bits into a helper function so we can reuse it
    later. As a result, the variable names are changed a bit.

  - The original did:

      if (use_pat)
              strbuf_release(&pat);

    but AFAICT that was a useless conditional; use_pat always points to
    either the incoming buffer or the strbuf. But strbuf_release will
    handle both cases for us.

 dir.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/dir.c b/dir.c
index 5a83aa7..fac82c1 100644
--- a/dir.c
+++ b/dir.c
@@ -34,6 +34,33 @@ int fnmatch_icase(const char *pattern, const char *string, int flags)
 	return fnmatch(pattern, string, flags | (ignore_case ? FNM_CASEFOLD : 0));
 }
 
+static int fnmatch_icase_mem(const char *pattern, int patternlen,
+			     const char *string, int stringlen,
+			     int flags)
+{
+	int match_status;
+	struct strbuf pat_buf = STRBUF_INIT;
+	struct strbuf str_buf = STRBUF_INIT;
+	const char *use_pat = pattern;
+	const char *use_str = string;
+
+	if (pattern[patternlen]) {
+		strbuf_add(&pat_buf, pattern, patternlen);
+		use_pat = pat_buf.buf;
+	}
+	if (string[stringlen]) {
+		strbuf_add(&str_buf, string, stringlen);
+		use_str = str_buf.buf;
+	}
+
+	match_status = fnmatch_icase(use_pat, use_str, 0);
+
+	strbuf_release(&pat_buf);
+	strbuf_release(&str_buf);
+
+	return match_status;
+}
+
 static size_t common_prefix_len(const char **pathspec)
 {
 	const char *n, *first;
@@ -537,15 +564,20 @@ int match_basename(const char *basename, int basenamelen,
 		   int flags)
 {
 	if (prefix == patternlen) {
-		if (!strcmp_icase(pattern, basename))
+		if (patternlen == basenamelen &&
+		    !strncmp_icase(pattern, basename, basenamelen))
 			return 1;
 	} else if (flags & EXC_FLAG_ENDSWITH) {
+		/* "*literal" matching against "fooliteral" */
 		if (patternlen - 1 <= basenamelen &&
-		    !strcmp_icase(pattern + 1,
-				  basename + basenamelen - patternlen + 1))
+		    !strncmp_icase(pattern + 1,
+				   basename + basenamelen - (patternlen - 1),
+				   patternlen - 1))
 			return 1;
 	} else {
-		if (fnmatch_icase(pattern, basename, 0) == 0)
+		if (fnmatch_icase_mem(pattern, patternlen,
+				      basename, basenamelen,
+				      0) == 0)
 			return 1;
 	}
 	return 0;
-- 
1.8.2.13.g0f18d3c
