From: Jeff King <peff@peff.net>
Subject: [tig PATCH] treat empty '/' as "find next"
Date: Tue, 3 Feb 2009 00:49:08 -0500
Message-ID: <20090203054907.GA21695@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Tue Feb 03 06:50:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUEBD-0004XZ-TG
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 06:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbZBCFtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 00:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbZBCFtN
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 00:49:13 -0500
Received: from peff.net ([208.65.91.99]:35511 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352AbZBCFtM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 00:49:12 -0500
Received: (qmail 14787 invoked by uid 107); 3 Feb 2009 05:49:23 -0000
Received: from c-75-75-4-229.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (75.75.4.229)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 03 Feb 2009 00:49:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Feb 2009 00:49:08 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108148>

When the user requests a forward or backwards search, if
they provide no search string then we just abort the search.
However, many other programs (such as less and vi) treat
this as "repeat the last search", so users may have their
fingers trained to do this rather than use the explicit
"find next" feature.

This patch causes tig, if there was a previous search, to
find the next (or previous, if "?" was used) match in such a
case.

Signed-off-by: Jeff King <peff@peff.net>
---
I tried retraining my fingers, but they just won't do it. :)

Related is the fact that searching for "foo", followed by another search
for "foo" will find the same line. That is, the second search won't move
at all, which is not the case for "less". I'm not sure what is the right
mental model for that behavior:

  1. Searches always start at line n+1

  2. There is a special case for searching for the thing we last
     matched, which by definition we already know is on the current
     line.

"less" seems to implement (1). That is, if you do this:

 for i in one two three; do echo $i line; done | less

entering "/two" will take you the second line. Entering "/line" after
that will take you to the _third_ line. This is mostly intuitive, since
you have already looked at the current line and want to search forward.
But it is confusing if you try "/one" on the first line: you get
"pattern not found" since it is not in any line after the first (but you
are searching because you haven't even looked at the first line).

So in some ways tig's behavior is better, and in some ways worse. And I
have to admit, my main reason for "/foo" followed by "/foo" was that
just using "/" for the second one didn't work. Which the patch below
should deal with.

 tig.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/tig.c b/tig.c
index b4e4b59..c02f71b 100644
--- a/tig.c
+++ b/tig.c
@@ -6812,6 +6812,10 @@ main(int argc, const char *argv[])
 
 			if (search)
 				string_ncopy(opt_search, search, strlen(search));
+			else if (*opt_search)
+				request = request == REQ_SEARCH ?
+					REQ_FIND_NEXT :
+					REQ_FIND_PREV;
 			else
 				request = REQ_NONE;
 			break;
-- 
1.6.1.2.465.g1dfd1
