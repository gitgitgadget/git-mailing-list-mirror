From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] strbuf: add an optimized 1-character strbuf_grow
Date: Sat, 4 Apr 2015 21:11:28 -0400
Message-ID: <20150405011127.GD30127@peff.net>
References: <20150405010611.GA15901@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 05 03:11:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeZ67-0001bS-43
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 03:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbbDEBLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 21:11:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:42553 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752371AbbDEBLa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 21:11:30 -0400
Received: (qmail 19411 invoked by uid 102); 5 Apr 2015 01:11:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 20:11:30 -0500
Received: (qmail 1923 invoked by uid 107); 5 Apr 2015 01:11:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Apr 2015 21:11:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Apr 2015 21:11:28 -0400
Content-Disposition: inline
In-Reply-To: <20150405010611.GA15901@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266793>

We have to call strbuf_grow anytime we are going to add data
to a strbuf. In most cases, it's a noop (since we grow the
buffer aggressively), and the cost of the function call and
size check is dwarfed by the actual buffer operation.

For a tight loop of single-character additions, though, this
overhead is noticeable. Furthermore, the single-character
case is much easier to check; since the "extra" parameter is
1, we can do it without worrying about overflow.

This patch adds a simple inline function for checking
single-character growth. For the growth case, it just calls
into the regular strbuf_grow(). This is redundant, as
strbuf_grow will check again whether we need to grow. But it
keeps our inline code simple, and most calls will not need
to grow, so it's OK to treat this as a rare "slow path".

We apply the new function to strbuf_getwholeline. Running
"git rev-parse refs/heads/does-not-exist" on a repo with an
extremely large (1.6GB) packed-refs file went from
(best-of-3):

  real    0m10.953s
  user    0m10.384s
  sys     0m0.580s

to:

  real    0m8.910s
  user    0m8.452s
  sys     0m0.468s

for a wall-clock speedup of 18%.

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.c | 2 +-
 strbuf.h | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index af2bad4..2facd5f 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -445,7 +445,7 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 	strbuf_reset(sb);
 	flockfile(fp);
 	while ((ch = getc_unlocked(fp)) != EOF) {
-		strbuf_grow(sb, 1);
+		strbuf_grow_ch(sb);
 		sb->buf[sb->len++] = ch;
 		if (ch == term)
 			break;
diff --git a/strbuf.h b/strbuf.h
index 1883494..ef41151 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -137,6 +137,15 @@ static inline size_t strbuf_avail(const struct strbuf *sb)
  */
 extern void strbuf_grow(struct strbuf *, size_t);
 
+/*
+ * An optimized version of strbuf_grow() for a single character.
+ */
+static inline void strbuf_grow_ch(struct strbuf *sb)
+{
+	if (!sb->alloc || sb->alloc - 1 <= sb->len)
+		strbuf_grow(sb, 1);
+}
+
 /**
  * Set the length of the buffer to a given value. This function does *not*
  * allocate new memory, so you should not perform a `strbuf_setlen()` to a
-- 
2.4.0.rc0.363.gf9f328b
