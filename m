From: Jeff King <peff@peff.net>
Subject: [PATCH] remote: allow "-t" with fetch mirrors
Date: Thu, 26 May 2011 11:11:00 -0400
Message-ID: <20110526151100.GA2881@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jimmie WESTER <jimmie.wester@stericsson.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 17:11:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPcDP-0004eZ-6P
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 17:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017Ab1EZPLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 11:11:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38372
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693Ab1EZPLD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 11:11:03 -0400
Received: (qmail 12251 invoked by uid 107); 26 May 2011 15:11:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 11:11:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 11:11:00 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174519>

Commit 13fc2c1 (remote: disallow some nonsensical option
combinations, 2011-03-30) made it impossible to use "remote
add -t foo --mirror". The argument was that specifying
specific branches is useless because:

  1. Push mirrors do not want a refspec at all.

  2. The point of fetch mirroring is to use a broad refspec
     like "refs/*", but using "-t" overrides that.

Point (1) is valid; "-t" with push mirrors is useless. But
point (2) ignored another side effect of using --mirror: it
fetches the refs directly into the refs/ namespace as they
are found upstream, instead of placing them in a
separate-remote layout.

So 13fc2c1 was overly constrictive, and disallowed
reasonable specific-branch mirroring, like:

  git remote add -t heads/foo -t heads/bar --mirror=fetch

which makes the local "foo" and "bar" branches direct
mirrors of the remote, but does not fetch anything else.

This patch restores the original behavior, but only for
fetch mirrors.

Signed-off-by: Jeff King <peff@peff.net>
---
This is on top of the jk/maint-remote-mirror-safer branch which made it
into 1.7.5 (the tip of which was 0990248).

If I were designing "git remote" from scratch, I would probably have
"-t" specify branches in refs/heads, even in mirror mode, for
consistency with non-mirror mode. But making them relative to refs/ in
mirror mode is how it has always worked, and I look at this patch not as
adding a new feature but as unbreaking a feature that worked before.
So:

  git remote add -t heads/foo -t heads/bar --mirror

will continue to work as it did before the original series (though it
will nag that you should be using --mirror=fetch).

 builtin/remote.c  |    4 ++--
 t/t5505-remote.sh |   22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index eb1229d..c2eaa2d 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -193,8 +193,8 @@ static int add(int argc, const char **argv)
 
 	if (mirror && master)
 		die("specifying a master branch makes no sense with --mirror");
-	if (mirror && track.nr)
-		die("specifying branches to track makes no sense with --mirror");
+	if (mirror && !(mirror & MIRROR_FETCH) && track.nr)
+		die("specifying branches to track makes no sense with non-fetch mirrors");
 
 	name = argv[0];
 	url = argv[1];
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 4e69c90..0d0222e 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -347,6 +347,21 @@ test_expect_success 'fetch mirrors do not act as mirrors during push' '
 	)
 '
 
+test_expect_success 'add fetch mirror with specific branches' '
+	git init --bare mirror-fetch/track &&
+	(cd mirror-fetch/track &&
+	 git remote add --mirror=fetch -t heads/new parent ../parent
+	)
+'
+
+test_expect_success 'fetch mirror respects specific branches' '
+	(cd mirror-fetch/track &&
+	 git fetch parent &&
+	 git rev-parse --verify refs/heads/new &&
+	 test_must_fail git rev-parse --verify refs/heads/renamed
+	)
+'
+
 test_expect_success 'add --mirror=push' '
 	mkdir mirror-push &&
 	git init --bare mirror-push/public &&
@@ -382,6 +397,13 @@ test_expect_success 'push mirrors do not act as mirrors during fetch' '
 	)
 '
 
+test_expect_success 'push mirrors do not allow you to specify refs' '
+	git init mirror-push/track &&
+	(cd mirror-push/track &&
+	 test_must_fail git remote add --mirror=push -t new public ../public
+	)
+'
+
 test_expect_success 'add alt && prune' '
 	(mkdir alttst &&
 	 cd alttst &&
-- 
1.7.4.5.13.gd3ff5
