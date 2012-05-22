From: Jeff King <peff@peff.net>
Subject: [PATCH] avoid segfault when reading header of malformed commits
Date: Tue, 22 May 2012 00:52:17 -0400
Message-ID: <20120522045217.GA23155@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 06:52:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWh58-0000Wb-MR
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 06:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352Ab2EVEwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 00:52:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51459
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753149Ab2EVEwV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 00:52:21 -0400
Received: (qmail 12357 invoked by uid 107); 22 May 2012 04:52:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 May 2012 00:52:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 May 2012 00:52:17 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198172>

If a commit object has a header line at the end of the
buffer that is missing its newline (or if it appears so
because the content on the header line contains a stray
NUL), then git will segfault.

Interestingly, this case is explicitly handled and we do
correctly scan the final line for the header we are looking
for. But if we don't find it, we will dereference NULL while
trying to look at the next line.

Git will never generate such a commit, but it's good to be
defensive. We could die() in such a case, but since it's
easy enough to handle it gracefully, let's just issue a
warning and continue (so you could still view such a commit
with "git show", though you might be missing headers after
the NUL).

Signed-off-by: Jeff King <peff@peff.net>
---
I happened to notice this while experimenting with somebody else's
problem and generating a bogus commit with hash-object. I don't know of
any actual implementation which generates this particular bug.

 pretty.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/pretty.c b/pretty.c
index 02a0a2b..dc57e5b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -436,29 +436,32 @@ static void add_merge_info(const struct pretty_print_context *pp,
 
 static char *get_header(const struct commit *commit, const char *key)
 {
 	int key_len = strlen(key);
 	const char *line = commit->buffer;
 
-	for (;;) {
+	while (line) {
 		const char *eol = strchr(line, '\n'), *next;
 
 		if (line == eol)
 			return NULL;
 		if (!eol) {
+			warning("malformed commit (header is missing newline): %s",
+				sha1_to_hex(commit->object.sha1));
 			eol = line + strlen(line);
 			next = NULL;
 		} else
 			next = eol + 1;
 		if (eol - line > key_len &&
 		    !strncmp(line, key, key_len) &&
 		    line[key_len] == ' ') {
 			return xmemdupz(line + key_len + 1, eol - line - key_len - 1);
 		}
 		line = next;
 	}
+	return NULL;
 }
 
 static char *replace_encoding_header(char *buf, const char *encoding)
 {
 	struct strbuf tmp = STRBUF_INIT;
 	size_t start, len;
-- 
1.7.9.7.33.gc430a50
