From: Jeff King <peff@peff.net>
Subject: [PATCH 6/7] ident: reject bogus email addresses with IDENT_STRICT
Date: Thu, 24 May 2012 19:32:37 -0400
Message-ID: <20120524233237.GF11084@sigill.intra.peff.net>
References: <20120524232515.GA11054@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <haggerty@jpk.com>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 01:32:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXhWP-0006D5-0T
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 01:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339Ab2EXXck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 19:32:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54609
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101Ab2EXXcj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 19:32:39 -0400
Received: (qmail 2268 invoked by uid 107); 24 May 2012 23:33:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 19:33:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 19:32:37 -0400
Content-Disposition: inline
In-Reply-To: <20120524232515.GA11054@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198449>

If we come up with a hostname like "foo.(none)" because the
user's machine is not fully qualified, we should reject this
in strict mode (e.g., when we are making a commit object),
just as we reject an empty gecos username.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that in conjunction with the previous patch, you can no longer "git
commit" with such a bogus address. I think this is a good thing.

However, it's possible some old-timers might disagree. I remember Linus
a long time ago mentioning that using the machine-name in the committer
line was a _feature_. These days he seems to set user.email to a real
address, though (and I think that is sane these days, because other
tools really want to do use identities as more than just a token. E.g.,
email tools, gpg-signing, etc).

 ident.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ident.c b/ident.c
index c42258f..ca098d9 100644
--- a/ident.c
+++ b/ident.c
@@ -288,6 +288,12 @@ const char *fmt_ident(const char *name, const char *email,
 		name = pw->pw_name;
 	}
 
+	if (strict && email == git_default_email.buf &&
+	    !strstr(email, "(none)")) {
+		fputs(env_hint, stderr);
+		die("unable to auto-detect email address (got '%s')", email);
+	}
+
 	if (want_date) {
 		if (date_str && date_str[0]) {
 			if (parse_date(date_str, date, sizeof(date)) < 0)
-- 
1.7.10.1.25.g7031a0f
