From: Jeff King <peff@peff.net>
Subject: [PATCH 08/13] ident: don't write fallback username into
 git_default_name
Date: Fri, 18 May 2012 19:19:33 -0400
Message-ID: <20120518231933.GH30031@sigill.intra.peff.net>
References: <20120518230528.GA30510@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 19 01:19:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVWSW-0006wX-6A
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 01:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966915Ab2ERXTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 19:19:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48780
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966631Ab2ERXTg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 19:19:36 -0400
Received: (qmail 7819 invoked by uid 107); 18 May 2012 23:20:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 19:20:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 19:19:33 -0400
Content-Disposition: inline
In-Reply-To: <20120518230528.GA30510@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197988>

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
You can trigger bug (2) by having an empty gecos field, no user.name,
and running a merge. The recent credit_person code path will call
git_committer_info(0), then the commit-generating code path will call
git_committer_info(IDENT_ERROR_ON_NO_NAME), and you will end
up with a commit with your username in the "name" field (even though the
second call would want to error out).

I don't think (1) is triggerable in the current code, mainly because we
typically are feeding getenv("GIT_*_NAME") to fmt_ident, and a blank
there will end up causing an error later on in the program.

By the way, I left it so that:

  GIT_COMMITTER_NAME= git ...

will continue to fallback to the passwd username if a caller doesn't
request to die on a blank name. We could pretty easily die in that case,
but people with flaky scripts might be affected. I figured that callers
who don't give ERROR_ON_NO_NAME don't really care too much what's in the
name anyway, so there's not much point in tightening the rules.

 ident.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/ident.c b/ident.c
index d2fa271..f44bcb3 100644
--- a/ident.c
+++ b/ident.c
@@ -330,9 +330,7 @@ const char *fmt_ident(const char *name, const char *email,
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
1.7.10.1.16.g53a707b
