From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] remote-curl: do not complain on EOF from parent git
Date: Wed, 9 Jul 2014 17:45:43 -0400
Message-ID: <20140709214542.GA26999@sigill.intra.peff.net>
References: <20140709212043.GC25854@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Dmitry <wipedout@yandex.ru>
X-From: git-owner@vger.kernel.org Wed Jul 09 23:45:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4zgT-000109-9j
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 23:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732AbaGIVpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 17:45:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:58990 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753189AbaGIVpp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 17:45:45 -0400
Received: (qmail 10482 invoked by uid 102); 9 Jul 2014 21:45:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 16:45:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jul 2014 17:45:43 -0400
Content-Disposition: inline
In-Reply-To: <20140709212043.GC25854@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253156>

The parent git process is supposed to send us an empty line
to indicate that the conversation is over. However, the
parent process may die() if there is a problem with the
operation (e.g., we try to fetch a ref that does not exist).
In this case, it produces a useful message, but then
remote-curl _also_ produces an unhelpful message:

  $ git pull origin matser
  fatal: couldn't find remote ref matser
  Unexpected end of command stream

The "right" way to fix this is to teach the parent git to
always cleanly close the connection to the helper, letting
it know that we are done. Implementing that is rather
clunky, though, as it would involve either replacing die()
operations with returning errors up the stack (until we
disconnect the transport), or adding an atexit handler to
clean up any transport helpers left open.

It's much simpler to just suppress the EOF message in
remote-curl. It was not added to address any real-world
situation in the first place, but rather a "we should
probably report unexpected things" suggestion[1].

It is the parent git which drives the operation, and whose
exit value actually matters. If the parent dies, then the
helper has no need to complain (except as a debugging aid).
In the off chance that the pipe is closed without the parent
dying, it can still notice the non-zero exit code.

[1] http://article.gmane.org/gmane.comp.version-control.git/176036

Signed-off-by: Jeff King <peff@peff.net>
---
Repost fixing commit message typo (and indicating it as the first of 3
patches).

 remote-curl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 4493b38..0454ffc 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -971,8 +971,6 @@ int main(int argc, const char **argv)
 		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
 			if (ferror(stdin))
 				fprintf(stderr, "Error reading command stream\n");
-			else
-				fprintf(stderr, "Unexpected end of command stream\n");
 			return 1;
 		}
 		if (buf.len == 0)
-- 
2.0.0.566.gfe3e6b2
