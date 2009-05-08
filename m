From: Jeff King <peff@peff.net>
Subject: Re: Two problems on alias of git
Date: Fri, 8 May 2009 05:06:15 -0400
Message-ID: <20090508090614.GB29737@coredump.intra.peff.net>
References: <op.utgiv92f6f2obg@i220-99-253-139.s27.a098.ap.plala.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kana Natsuno <kana@whileimautomaton.net>
X-From: git-owner@vger.kernel.org Fri May 08 11:06:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2M2E-0003Gs-Rj
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 11:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbZEHJGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 05:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbZEHJGQ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 05:06:16 -0400
Received: from peff.net ([208.65.91.99]:49876 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751191AbZEHJGP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 05:06:15 -0400
Received: (qmail 17240 invoked by uid 107); 8 May 2009 09:06:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 08 May 2009 05:06:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 08 May 2009 05:06:15 -0400
Content-Disposition: inline
In-Reply-To: <op.utgiv92f6f2obg@i220-99-253-139.s27.a098.ap.plala.or.jp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118593>

On Tue, May 05, 2009 at 09:42:04PM +0900, Kana Natsuno wrote:

> The first one is that git crashes with the following situation.
> Without GIT_TRACE, everthing works well.  But with GIT_TRACE=1,
> git crashes every time.

I wasn't able to reproduce on Linux, but valgrind found it. The patch
below should fix it.

-- >8 --
Subject: [PATCH] fix GIT_TRACE segfault with shell-quoted aliases

The alias argv comes from the split_cmdline function, which
splits the config text for the alias into an array of
strings. It returns the number of elements in the array, but
does not actually put a NULL at the end of the array.
Later, the trace function tries to print this argv and
assumes that it has the trailing NULL.

The split_cmdline function is probably at fault, since argv
lists almost always end with a NULL signal. This patch adds
one, in addition to the returned count; this doesn't hurt
the other callers at all, since they were presumably using
the count already (and will never look at the NULL).

While we're there and using ALLOC_GROW, let's clean up the
other manual grow.

Signed-off-by: Jeff King <peff@peff.net>
---
 alias.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/alias.c b/alias.c
index e687fe5..372b7d8 100644
--- a/alias.c
+++ b/alias.c
@@ -38,10 +38,7 @@ int split_cmdline(char *cmdline, const char ***argv)
 			while (cmdline[++src]
 					&& isspace(cmdline[src]))
 				; /* skip */
-			if (count >= size) {
-				size += 16;
-				*argv = xrealloc(*argv, sizeof(char *) * size);
-			}
+			ALLOC_GROW(*argv, count+1, size);
 			(*argv)[count++] = cmdline + dst;
 		} else if (!quoted && (c == '\'' || c == '"')) {
 			quoted = c;
@@ -72,6 +69,9 @@ int split_cmdline(char *cmdline, const char ***argv)
 		return error("unclosed quote");
 	}
 
+	ALLOC_GROW(*argv, count+1, size);
+	(*argv)[count] = NULL;
+
 	return count;
 }
 
-- 
1.6.3.203.g7c7de.dirty
