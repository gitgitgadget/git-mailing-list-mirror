From: Jeff King <peff@peff.net>
Subject: [PATCH] remote-curl: do not complain on EOF from parent git
Date: Wed, 9 Jul 2014 17:20:43 -0400
Message-ID: <20140709212043.GC25854@sigill.intra.peff.net>
References: <787461404891471@web12h.yandex.ru>
 <20140709205902.GB25854@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dmitry <wipedout@yandex.ru>
X-From: git-owner@vger.kernel.org Wed Jul 09 23:20:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4zIH-0006kp-Pr
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 23:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755152AbaGIVUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 17:20:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:58973 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751235AbaGIVUp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 17:20:45 -0400
Received: (qmail 8769 invoked by uid 102); 9 Jul 2014 21:20:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 16:20:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jul 2014 17:20:43 -0400
Content-Disposition: inline
In-Reply-To: <20140709205902.GB25854@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253152>

The parent git process is supposed to send us an empty line
to indicate that the conversation is over. However, the
parent process may die() if there is a problem with the
operaiton (e.g., we try to fetch a ref that does not exist).
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
dying, the parent can still notice the non-zero exit code.

[1] http://article.gmane.org/gmane.comp.version-control.git/176036

Reported-by: Dmitry <wipedout@yandex.ru>
Signed-off-by: Jeff King <peff@peff.net>
---
The original discussion that led to this code being implemented was due
to us checking the helper's exit code in the first place. However, we
seem to be inconsistent about doing so. I'm not inclined to pursue it
further, though, as these subtle details of the transport helper code
usually turn into a can of worms, and more importantly, I don't think it
hurts anything in the real world. Either the parent git gets the
expected protocol output from the helper or it doesn't, and we report
errors on that. An error from a helper after the operation completes is
not really important to the parent git either way.

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
