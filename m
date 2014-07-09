From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] remote-curl: use error instead of fprintf(stderr)
Date: Wed, 9 Jul 2014 17:47:05 -0400
Message-ID: <20140709214705.GB26999@sigill.intra.peff.net>
References: <20140709212043.GC25854@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dmitry <wipedout@yandex.ru>
X-From: git-owner@vger.kernel.org Wed Jul 09 23:47:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4zho-00023v-SL
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 23:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbaGIVrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 17:47:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:58995 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751010AbaGIVrI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 17:47:08 -0400
Received: (qmail 10562 invoked by uid 102); 9 Jul 2014 21:47:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 16:47:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jul 2014 17:47:05 -0400
Content-Disposition: inline
In-Reply-To: <20140709212043.GC25854@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253157>

We usually prefix our error messages with "error: ", but
many error messages from remote-curl are simply printed with
fprintf. This can make the output a little harder to read
(especially because such message may be intermingled with
errors from the parent git process).

There is no reason to avoid error(), as we are already
calling it many places (in addition to libgit.a functions
which use it).

While we're adjusting the messages, we can also drop the
capitalization which makes them unlike other git error
messages.

Signed-off-by: Jeff King <peff@peff.net>
---
I suspect there may be some more improvements we can make (e.g., the
"fetch failed" below seems like it might be redundant with what "git
fetch" will print). But hunting them is a lot of work for little gain;
I'd rather wait to see them in practice and fix them on a case by case
basis.

 remote-curl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 0454ffc..a619b64 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -399,7 +399,7 @@ static curlioerr rpc_ioctl(CURL *handle, int cmd, void *clientp)
 			rpc->pos = 0;
 			return CURLIOE_OK;
 		}
-		fprintf(stderr, "Unable to rewind rpc post data - try increasing http.postBuffer\n");
+		error("unable to rewind rpc post data - try increasing http.postBuffer");
 		return CURLIOE_FAILRESTART;
 
 	default:
@@ -709,7 +709,7 @@ static int fetch_dumb(int nr_heads, struct ref **to_fetch)
 		free(targets[i]);
 	free(targets);
 
-	return ret ? error("Fetch failed.") : 0;
+	return ret ? error("fetch failed.") : 0;
 }
 
 static int fetch_git(struct discovery *heads,
@@ -949,7 +949,7 @@ int main(int argc, const char **argv)
 	git_extract_argv0_path(argv[0]);
 	setup_git_directory_gently(&nongit);
 	if (argc < 2) {
-		fprintf(stderr, "Remote needed\n");
+		error("remote needed");
 		return 1;
 	}
 
@@ -970,7 +970,7 @@ int main(int argc, const char **argv)
 	do {
 		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
 			if (ferror(stdin))
-				fprintf(stderr, "Error reading command stream\n");
+				error("error reading command stream");
 			return 1;
 		}
 		if (buf.len == 0)
@@ -1014,7 +1014,7 @@ int main(int argc, const char **argv)
 			printf("\n");
 			fflush(stdout);
 		} else {
-			fprintf(stderr, "Unknown command '%s'\n", buf.buf);
+			error("unknown command '%s'", buf.buf);
 			return 1;
 		}
 		strbuf_reset(&buf);
-- 
2.0.0.566.gfe3e6b2
