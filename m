From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Mon, 6 Aug 2012 18:42:22 -0400
Message-ID: <20120806224222.GA16721@sigill.intra.peff.net>
References: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca>
 <7vboio231n.fsf@alter.siamese.dyndns.org>
 <1344220427-sup-3468@pinkfloyd.chass.utoronto.ca>
 <20120806193958.GA10039@sigill.intra.peff.net>
 <1344287843-sup-6200@pinkfloyd.chass.utoronto.ca>
 <20120806213404.GA14320@sigill.intra.peff.net>
 <1344290892-sup-1108@pinkfloyd.chass.utoronto.ca>
 <20120806223113.GA16298@sigill.intra.peff.net>
 <1344292395-sup-1921@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Aug 07 00:42:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyW0N-0001P4-SH
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 00:42:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731Ab2HFWm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 18:42:26 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53829 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755922Ab2HFWm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 18:42:26 -0400
Received: (qmail 20786 invoked by uid 107); 6 Aug 2012 22:42:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Aug 2012 18:42:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2012 18:42:22 -0400
Content-Disposition: inline
In-Reply-To: <1344292395-sup-1921@pinkfloyd.chass.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202997>

On Mon, Aug 06, 2012 at 06:39:55PM -0400, Ben Walton wrote:

> Excerpts from Jeff King's message of Mon Aug 06 18:31:13 -0400 2012:
> 
> > Looking over the code, I recall now why I used stdio: strbuf_getline
> > requires it. These days we have strbuf_getwholeline_fd. It's
> > slightly less efficient (it has to read() a character at a time),
> > but since we are talking about a few characters of keyboard input,
> > it should be OK.
> 
> I noticed the same requirement.  I'm currently building/testing a
> patch that switches from FILE -> fd and also to
> strbuf_getwholeline_fd.  Personally, I like this approach more than
> calling an open function multiple times.

OK, I'll stop working on the same thing, then. :)

We might want to do this to factor out the extra chomp you'll need by
using strbuf_getwholeline_fd:

-- >8 --
Subject: [PATCH] strbuf: implement strbuf_getline_fd

When reading a line into a strbuf, we have two options:

  1. Read from stdio, or from a descriptor

  2. Chomp the terminator, or leave it in

We already have:

  strbuf_getwholeline:    stdio, nochomp
  strbuf_getline:         stdio,   chomp
  strbuf_getwholeline_fd:    fd, nochomp

This patch adds the missing orthogonal function:

  strbuf_getline_fd:         fd,   chomp
---
 strbuf.c | 8 ++++++++
 strbuf.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index ec88266..a6dffcc 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -399,6 +399,14 @@ int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term)
 	return 0;
 }
 
+int strbuf_getline_fd(struct strbuf *sb, int fd, int term)
+{
+	if (strbuf_getwholeline(sb, fd, term))
+		return EOF;
+	if (sb->buf[sb->len-1] == term)
+		strbuf_setlen(sb, sb->len-1);
+}
+
 int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 {
 	int fd, len;
diff --git a/strbuf.h b/strbuf.h
index b888d40..cc1abb2 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -119,6 +119,7 @@ extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
 extern int strbuf_getwholeline(struct strbuf *, FILE *, int);
 extern int strbuf_getline(struct strbuf *, FILE *, int);
 extern int strbuf_getwholeline_fd(struct strbuf *, int, int);
+extern int strbuf_getline_fd(struct strbuf *, int, int);
 
 extern void stripspace(struct strbuf *buf, int skip_comments);
 extern int launch_editor(const char *path, struct strbuf *buffer, const char *const *env);
