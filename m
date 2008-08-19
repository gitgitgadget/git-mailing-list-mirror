From: Jeff King <peff@peff.net>
Subject: Re: git am with MIME
Date: Tue, 19 Aug 2008 13:07:31 -0400
Message-ID: <20080819170731.GA2424@coredump.intra.peff.net>
References: <48AAEBB6.9070306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 19:09:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVUhC-0001vC-IS
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 19:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753619AbYHSRHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 13:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753622AbYHSRHd
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 13:07:33 -0400
Received: from peff.net ([208.65.91.99]:4966 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601AbYHSRHd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 13:07:33 -0400
Received: (qmail 1894 invoked by uid 111); 19 Aug 2008 17:07:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 19 Aug 2008 13:07:32 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Aug 2008 13:07:31 -0400
Content-Disposition: inline
In-Reply-To: <48AAEBB6.9070306@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92883>

On Tue, Aug 19, 2008 at 05:50:14PM +0200, Lea Wiemann wrote:

> $ wcat -q
> 'http://article.gmane.org/gmane.comp.version-control.git/91305/raw' | git am
> fatal: `pos + len' is too far after the end of the buffer
> $
> 
> It seems to be because of the (unusual?) way the patch uses MIME.  Just
> wanted to post this so it doesn't get lost.

It's the From header actually. The patch below should fix it (though it
sure makes that line of code ugly -- improvements are welcome).

-- >8 --
mailinfo: avoid violating strbuf assertion

In handle_from, we calculate the end boundary of a section
to remove from a strbuf using strcspn like this:

  el = strcspn(buf, set_of_end_boundaries);
  strbuf_remove(&sb, start, el + 1);

This works fine if "el" is the offset of the boundary
character, meaning we remove that character. But if the end
boundary didn't match (that is, we hit the end of the string
as the boundary instead) then we want just "el".

This manifested itself when we got a 'From' header that had
just an email address with nothing else in it (the end of
the string was the end of the address, rather than, e.g., a
trailing '>' character).
---
 builtin-mailinfo.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 26d3e5d..e890f7a 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -107,7 +107,7 @@ static void handle_from(const struct strbuf *from)
 	el = strcspn(at, " \n\t\r\v\f>");
 	strbuf_reset(&email);
 	strbuf_add(&email, at, el);
-	strbuf_remove(&f, at - f.buf, el + 1);
+	strbuf_remove(&f, at - f.buf, el + (at[el] ? 1 : 0));
 
 	/* The remainder is name.  It could be "John Doe <john.doe@xz>"
 	 * or "john.doe@xz (John Doe)", but we have removed the
-- 
1.6.0.96.g2fad1.dirty
