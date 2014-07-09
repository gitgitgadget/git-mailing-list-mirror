From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] remote-curl: mark helper-protocol errors more clearly
Date: Wed, 9 Jul 2014 17:47:20 -0400
Message-ID: <20140709214720.GC26999@sigill.intra.peff.net>
References: <20140709212043.GC25854@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Dmitry <wipedout@yandex.ru>
X-From: git-owner@vger.kernel.org Wed Jul 09 23:47:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4zi2-0002FQ-OP
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 23:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576AbaGIVrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 17:47:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:58998 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751169AbaGIVrW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 17:47:22 -0400
Received: (qmail 10626 invoked by uid 102); 9 Jul 2014 21:47:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 16:47:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jul 2014 17:47:20 -0400
Content-Disposition: inline
In-Reply-To: <20140709212043.GC25854@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253158>

When we encounter an error in remote-curl, we generally just
report it to stderr. There is no need for the user to care
that the "could not connect to server" error was generated
by git-remote-https rather than a function in the parent
git-fetch process.

However, when the error is in the protocol between git and
the helper, it makes sense to clearly identify which side is
complaining. These cases shouldn't ever happen, but when
they do, we can make them less confusing by being more
verbose.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index a619b64..1f6905d 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -949,7 +949,7 @@ int main(int argc, const char **argv)
 	git_extract_argv0_path(argv[0]);
 	setup_git_directory_gently(&nongit);
 	if (argc < 2) {
-		error("remote needed");
+		error("remote-curl: usage: git remote-curl <remote> [<url>]");
 		return 1;
 	}
 
@@ -970,14 +970,14 @@ int main(int argc, const char **argv)
 	do {
 		if (strbuf_getline(&buf, stdin, '\n') == EOF) {
 			if (ferror(stdin))
-				error("error reading command stream");
+				error("remote-curl: error reading command stream from git");
 			return 1;
 		}
 		if (buf.len == 0)
 			break;
 		if (starts_with(buf.buf, "fetch ")) {
 			if (nongit)
-				die("Fetch attempted without a local repo");
+				die("remote-curl: fetch attempted without a local repo");
 			parse_fetch(&buf);
 
 		} else if (!strcmp(buf.buf, "list") || starts_with(buf.buf, "list ")) {
@@ -1014,7 +1014,7 @@ int main(int argc, const char **argv)
 			printf("\n");
 			fflush(stdout);
 		} else {
-			error("unknown command '%s'", buf.buf);
+			error("remote-curl: unknown command '%s' from git", buf.buf);
 			return 1;
 		}
 		strbuf_reset(&buf);
-- 
2.0.0.566.gfe3e6b2
