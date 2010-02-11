From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] cherry-pick: format help message as strbuf
Date: Thu, 11 Feb 2010 16:07:06 -0500
Message-ID: <20100211210706.GC9066@coredump.intra.peff.net>
References: <20100211210445.GA8819@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 22:07:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfgFk-0005vw-OU
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 22:07:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757080Ab0BKVHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 16:07:05 -0500
Received: from peff.net ([208.65.91.99]:51477 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756853Ab0BKVHD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 16:07:03 -0500
Received: (qmail 22054 invoked by uid 107); 11 Feb 2010 21:07:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 11 Feb 2010 16:07:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Feb 2010 16:07:06 -0500
Content-Disposition: inline
In-Reply-To: <20100211210445.GA8819@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139627>

This gets rid of the fixed-size buffer and an unchecked
sprintf. That sprintf is actually OK as the only
variable-sized thing put in it is an abbreviated sha1, which
is bounded at 40 characters. However, the next patch will
change that to something unbounded.

Note that this function now returns an allocated buffer
instead of a static one; however, it doesn't matter as the
only caller exits immediately.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-revert.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin-revert.c b/builtin-revert.c
index 012c646..77e4f4e 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -200,23 +200,23 @@ static void set_author_ident_env(const char *message)
 
 static char *help_msg(const unsigned char *sha1)
 {
-	static char helpbuf[1024];
+	struct strbuf helpbuf = STRBUF_INIT;
 	char *msg = getenv("GIT_CHERRY_PICK_HELP");
 
 	if (msg)
 		return msg;
 
-	strcpy(helpbuf, "  After resolving the conflicts,\n"
+	strbuf_addstr(&helpbuf, "  After resolving the conflicts,\n"
 		"mark the corrected paths with 'git add <paths>' or 'git rm <paths>'\n"
 		"and commit the result.");
 
 	if (action == CHERRY_PICK) {
-		sprintf(helpbuf + strlen(helpbuf),
+		strbuf_addf(&helpbuf,
 			"  When committing, use the option '-c %s'\n"
 			"to retain authorship and message.",
 			find_unique_abbrev(sha1, DEFAULT_ABBREV));
 	}
-	return helpbuf;
+	return strbuf_detach(&helpbuf, NULL);
 }
 
 static struct tree *empty_tree(void)
-- 
1.7.0.rc2.40.g33ed2.dirty
