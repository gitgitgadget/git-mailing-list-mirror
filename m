From: Jeff King <peff@peff.net>
Subject: [PATCH 2/9] add strip_suffix function
Date: Mon, 30 Jun 2014 12:57:51 -0400
Message-ID: <20140630165751.GB16637@sigill.intra.peff.net>
References: <20140630165526.GA15690@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 30 18:58:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1eu0-0000z9-Ia
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jun 2014 18:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990AbaF3Q5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2014 12:57:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:53645 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754728AbaF3Q5w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2014 12:57:52 -0400
Received: (qmail 7678 invoked by uid 102); 30 Jun 2014 16:57:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Jun 2014 11:57:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Jun 2014 12:57:51 -0400
Content-Disposition: inline
In-Reply-To: <20140630165526.GA15690@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252684>

Many callers of ends_with want to not only find out whether
a string has a suffix, but want to also strip it off. Doing
that separately has two minor problems:

  1. We often run over the string twice (once to find
     the suffix, and then once more to find its length to
     subtract the suffix length).

  2. We have to specify the suffix length again, which means
     either a magic number, or repeating ourselves with
     strlen("suffix").

Just as we have skip_prefix to avoid these cases with
starts_with, we can add a strip_suffix to avoid them with
ends_with.

Note that we add two forms of strip_suffix here: one that
takes a string, with the resulting length as an
out-parameter; and one that takes a pointer/length pair, and
reuses the length as an out-parameter. The latter is more
efficient when the caller already has the length (e.g., when
using strbufs), but it can be easy to confuse the two, as
they take the same number and types of parameters.

For that reason, the "mem" form puts its length parameter
next to the buffer (since they are a pair), and the string
form puts it at the end (since it is an out-parameter). The
compiler can notice when you get the order wrong, which
should help prevent writing one when you meant the other.

Signed-off-by: Jeff King <peff@peff.net>
---
I hope the word "strip" is OK, as it does not actually NUL-terminate
(doing so would make it unusable for many cases). Between the comment
below and the "const" in the parameter, I think it should be pretty
clear that it does not touch the string. And I could not think of a
better word.

 git-compat-util.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index b6f03b3..d044c42 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -358,6 +358,33 @@ static inline const char *skip_prefix(const char *str, const char *prefix)
 	return NULL;
 }
 
+/*
+ * If buf ends with suffix, return 1 and subtract the length of the suffix
+ * from *len. Otherwise, return 0 and leave *len untouched.
+ */
+static inline int strip_suffix_mem(const char *buf, size_t *len,
+				   const char *suffix)
+{
+	size_t suflen = strlen(suffix);
+	if (*len < suflen || memcmp(buf + (*len - suflen), suffix, suflen))
+		return 0;
+	*len -= suflen;
+	return 1;
+}
+
+/*
+ * If str ends with suffix, return 1 and set *len to the size of the string
+ * without the suffix. Otherwise, return 0 and set *len to the size of the
+ * string.
+ *
+ * Note that we do _not_ NUL-terminate str to the new length.
+ */
+static inline int strip_suffix(const char *str, const char *suffix, size_t *len)
+{
+	*len = strlen(str);
+	return strip_suffix_mem(str, len, suffix);
+}
+
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
 
 #ifndef PROT_READ
-- 
2.0.0.566.gfe3e6b2
