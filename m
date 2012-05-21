From: Jeff King <peff@peff.net>
Subject: [PATCHv2 09/15] ident: don't write fallback username into
 git_default_name
Date: Mon, 21 May 2012 19:10:14 -0400
Message-ID: <20120521231014.GI10981@sigill.intra.peff.net>
References: <20120521230917.GA474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 01:10:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWbkC-00086Z-Pt
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 01:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756777Ab2EUXKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 19:10:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51226
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756301Ab2EUXKR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 19:10:17 -0400
Received: (qmail 7876 invoked by uid 107); 21 May 2012 23:10:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 19:10:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 19:10:14 -0400
Content-Disposition: inline
In-Reply-To: <20120521230917.GA474@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198154>

The fmt_ident function gets a flag that tells us whether to
die if the name field is blank. If it is blank and we don't
die, then we fall back to the username from the passwd file.

The current code writes the value into git_default_name.
However, that's not necessarily correct, as the empty value
might have come from git_default_name, or it might have been
passed in.  This leads to two potential problems:

  1. If we are overriding an empty name in the passed-in
     value, then we may be overwriting a perfectly good name
     (from gitconfig or gecos) in the git_default_name
     buffer. Later calls to fmt_ident will end up using the
     fallback name, even though a better name was available.

  2. If we override an empty gecos name, we end up with the
     fallback name in git_default_name. A later call that
     uses IDENT_ERROR_ON_NO_NAME will see the fallback name
     and think that it is a good name, instead of producing
     an error. In other words, a blank gecos name would
     cause an error with this code:

       git_committer_info(IDENT_ERROR_ON_NO_NAME);

     but not this:

       git_committer_info(0);
       git_committer_info(IDENT_ERROR_ON_NO_NAME);

     because in the latter case, the first call has polluted
     the name buffer.

Instead, let's make the fallback a per-invocation variable.
We can just use the pw->pw_name string directly, since it
only needs to persist through the rest of the function (and
we don't do any other getpwent calls).

Note that while this solves (1) for future invocations of
fmt_indent, the current invocation might use the fallback
when it could in theory load a better value from
git_default_name. However, by not passing
IDENT_ERROR_ON_NO_NAME, the caller is indicating that it
does not care too much about the name, anyway, so we don't
bother; this is primarily about protecting future callers
who do care.

Signed-off-by: Jeff King <peff@peff.net>
---
 ident.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/ident.c b/ident.c
index 3b92c44..87e3cbe 100644
--- a/ident.c
+++ b/ident.c
@@ -334,9 +334,7 @@ const char *fmt_ident(const char *name, const char *email,
 		pw = getpwuid(getuid());
 		if (!pw)
 			die("You don't exist. Go away!");
-		strlcpy(git_default_name, pw->pw_name,
-			sizeof(git_default_name));
-		name = git_default_name;
+		name = pw->pw_name;
 	}
 
 	strcpy(date, ident_default_date());
-- 
1.7.10.1.19.g711d603
