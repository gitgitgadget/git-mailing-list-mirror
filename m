From: Jeff King <peff@peff.net>
Subject: [PATCH 4/7] format-patch: use GIT_COMMITTER_EMAIL in message ids
Date: Thu, 24 May 2012 19:28:25 -0400
Message-ID: <20120524232825.GD11084@sigill.intra.peff.net>
References: <20120524232515.GA11054@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <haggerty@jpk.com>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 01:28:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXhSK-0003Aw-Go
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 01:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759327Ab2EXX22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 19:28:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54591
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752419Ab2EXX21 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 19:28:27 -0400
Received: (qmail 2189 invoked by uid 107); 24 May 2012 23:28:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 19:28:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 19:28:25 -0400
Content-Disposition: inline
In-Reply-To: <20120524232515.GA11054@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198447>

Before commit 43ae9f4, we generated the tail of a message id
by calling git_committer_info and parsing the email out of
the result. 43ae9f4 changed to use ident_default_email
directly, so we didn't have to bother with parsing. As a
side effect, it meant we no longer used GIT_COMMITTER_EMAIL
at all.

In general, this is probably reasonable behavior. Either the
default email is sane on your system, or you are using
user.email to provide something sane. The exception is if
you rely on GIT_COMMITTER_EMAIL being set all the time to
override the bogus generated email.

This is unlikely to match anybody's real-life setup, but we
do use it in the test environment. And furthermore, it's
what we have always done, and the change in 43ae9f4 was
about cleaning up, not fixing any bug; we should be
conservative and keep the behavior identical.

Signed-off-by: Jeff King <peff@peff.net>
---
This one should fix Michael's test failure. Let me know if it doesn't.

Arguably the call to ident_default_email() in http-push.c should be
converted in the same way. I'm unclear on how that value is actually
used, so it may not matter at all.

 builtin/log.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 8010a40..4538309 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -740,7 +740,8 @@ static void gen_message_id(struct rev_info *info, char *base)
 {
 	struct strbuf buf = STRBUF_INIT;
 	strbuf_addf(&buf, "%s.%lu.git.%s", base,
-		    (unsigned long) time(NULL), ident_default_email());
+		    (unsigned long) time(NULL),
+		    git_committer_info(IDENT_NO_NAME|IDENT_NO_DATE));
 	info->message_id = strbuf_detach(&buf, NULL);
 }
 
-- 
1.7.10.1.25.g7031a0f
