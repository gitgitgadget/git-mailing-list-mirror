From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/67] strbuf: make strbuf_complete_line more generic
Date: Wed, 16 Sep 2015 05:57:41 -0400
Message-ID: <20150916095740.GC13966@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915152528.GG29753@sigill.intra.peff.net>
 <CAPig+cT9piy2dGx6jbcQNyzY5kQ1XgaEB_mYNUOYBUCJ5wAc_w@mail.gmail.com>
 <xmqqoah3tap6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 11:57:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc9TN-0008Um-R8
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 11:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbbIPJ5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 05:57:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:59837 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751480AbbIPJ5t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 05:57:49 -0400
Received: (qmail 14097 invoked by uid 102); 16 Sep 2015 09:57:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 04:57:49 -0500
Received: (qmail 16421 invoked by uid 107); 16 Sep 2015 09:57:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 05:57:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 05:57:41 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoah3tap6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278013>

On Tue, Sep 15, 2015 at 06:27:49PM -0700, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> >> +static inline void strbuf_complete(struct strbuf *sb, char term)
> >> +{
> >> +       if (sb->len && sb->buf[sb->len - 1] != term)
> >> +               strbuf_addch(sb, term);
> >> +}
> >
> > Hmm, so this only adds 'term' if not already present *and* if 'sb' is
> > not empty, which doesn't seem to match the documentation which says
> > that it "ensures" termination.
> [...]
> So to these two plausible and different set of callers that would be
> helped by this function, the behaviour Peff gives it would match
> what the callers want better than your version.

Right. I think what the function is doing is the right thing (and
certainly it matches what the callers I'm changing are doing already
:) ).

But I agree the docstring is extremely misleading. I've changed it to:

diff --git a/strbuf.h b/strbuf.h
index aef2794..43f27c3 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -491,10 +491,21 @@ extern void strbuf_add_lines(struct strbuf *sb, const char *prefix, const char *
  */
 extern void strbuf_addstr_xml_quoted(struct strbuf *sb, const char *s);
 
+/**
+ * "Complete" the contents of `sb` by ensuring that either it ends with the
+ * character `term`, or it is empty.  This can be used, for example,
+ * to ensure that text ends with a newline, but without creating an empty
+ * blank line if there is no content in the first place.
+ */
+static inline void strbuf_complete(struct strbuf *sb, char term)
+{
+	if (sb->len && sb->buf[sb->len - 1] != term)
+		strbuf_addch(sb, term);
+}
+
 static inline void strbuf_complete_line(struct strbuf *sb)
 {
-	if (sb->len && sb->buf[sb->len - 1] != '\n')
-		strbuf_addch(sb, '\n');
+	strbuf_complete(sb, '\n');
 }
 
 extern int strbuf_branchname(struct strbuf *sb, const char *name);


It may be that we will not find other uses beyond completing slash and
newline, but at least this version should not actively mislead anybody.

-Peff
