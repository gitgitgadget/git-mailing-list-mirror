From: Jeff King <peff@peff.net>
Subject: [PATCH 06/13] format-patch: use default email for generating message
 ids
Date: Fri, 18 May 2012 19:13:47 -0400
Message-ID: <20120518231347.GF30031@sigill.intra.peff.net>
References: <20120518230528.GA30510@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 19 01:14:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVWMx-0007bp-GM
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 01:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946901Ab2ERXNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 19:13:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48769
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946775Ab2ERXNu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 19:13:50 -0400
Received: (qmail 7725 invoked by uid 107); 18 May 2012 23:14:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 19:14:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 19:13:47 -0400
Content-Disposition: inline
In-Reply-To: <20120518230528.GA30510@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197986>

We try to generate a sane message id for cover letters and
threading by appending some changing bits to the front of
the user's email address. The current code parses the email
out of the results of git_committer_info, but we can do this
much more easily by just calling ident_default_email
ourselves.

Signed-off-by: Jeff King <peff@peff.net>
---
Technically this is a regression if you really wanted:

  GIT_COMMITTER_EMAIL=some.addr@example.com \
  git format-patch --thread=deep

to make your environment variable part of the message-ids. I don't think
it matters, but I can adjust it if we care.

 builtin/log.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 690caa7..656bddf 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -737,15 +737,9 @@ static void get_patch_ids(struct rev_info *rev, struct patch_ids *ids, const cha
 
 static void gen_message_id(struct rev_info *info, char *base)
 {
-	const char *committer = git_committer_info(IDENT_WARN_ON_NO_NAME);
-	const char *email_start = strrchr(committer, '<');
-	const char *email_end = strrchr(committer, '>');
 	struct strbuf buf = STRBUF_INIT;
-	if (!email_start || !email_end || email_start > email_end - 1)
-		die(_("Could not extract email from committer identity."));
-	strbuf_addf(&buf, "%s.%lu.git.%.*s", base,
-		    (unsigned long) time(NULL),
-		    (int)(email_end - email_start - 1), email_start + 1);
+	strbuf_addf(&buf, "%s.%lu.git.%s", base,
+		    (unsigned long) time(NULL), ident_default_email());
 	info->message_id = strbuf_detach(&buf, NULL);
 }
 
-- 
1.7.10.1.16.g53a707b
