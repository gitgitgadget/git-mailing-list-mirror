From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] remote-testsvn: fix unitialized variable
Date: Fri, 14 Dec 2012 17:11:44 -0500
Message-ID: <20121214221144.GA19677@sigill.intra.peff.net>
References: <20121214220903.GA18418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 23:12:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjdUC-0006Fh-3S
	for gcvg-git-2@plane.gmane.org; Fri, 14 Dec 2012 23:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756046Ab2LNWLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 17:11:47 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55053 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755435Ab2LNWLr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 17:11:47 -0500
Received: (qmail 16184 invoked by uid 107); 14 Dec 2012 22:12:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 14 Dec 2012 17:12:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Dec 2012 17:11:44 -0500
Content-Disposition: inline
In-Reply-To: <20121214220903.GA18418@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211506>

In remote-test-svn, there is a parse_rev_note function to
parse lines of the form "Revision-number" from notes. If it
finds such a line and parses it, it returns 0, copying the
value into a "struct rev_note". If it finds an entry that is
garbled or out of range, it returns -1 to signal an error.

However, if it does not find any "Revision-number" line at
all, it returns success but does not put anything into the
rev_note. So upon a successful return, the rev_note may or
may not be initialized, and the caller has no way of
knowing.

gcc does not usually catch the use of the unitialized
variable because the conditional assignment happens in a
separate function from the point of use. However, when
compiling with -O3, gcc will inline parse_rev_note and
notice the problem.

We can fix it by returning "-1" when no note is found (so on
a zero return, we always found a valid value).

Signed-off-by: Jeff King <peff@peff.net>
---
I think this is the right fix, but I am not too familiar with this code,
so I might be missing a case where a missing "Revision-number" should
provide some sentinel value (like "0") instead of returning an error. In
fact, of the two callsites, one already does such a zero-initialization.

 remote-testsvn.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/remote-testsvn.c b/remote-testsvn.c
index 51fba05..5ddf11c 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -90,10 +90,12 @@ static int parse_rev_note(const char *msg, struct rev_note *res)
 			if (end == value || i < 0 || i > UINT32_MAX)
 				return -1;
 			res->rev_nr = i;
+			return 0;
 		}
 		msg += len + 1;
 	}
-	return 0;
+	/* didn't find it */
+	return -1;
 }
 
 static int note2mark_cb(const unsigned char *object_sha1,
-- 
1.8.0.2.4.g59402aa
