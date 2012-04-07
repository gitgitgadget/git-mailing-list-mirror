From: Jeff King <peff@peff.net>
Subject: [PATCH] credential: do not store credentials received from helpers
Date: Fri, 6 Apr 2012 23:34:17 -0400
Message-ID: <20120407033417.GA13914@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 07 05:34:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGMQS-0005cR-Fr
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 05:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308Ab2DGDeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 23:34:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53055
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439Ab2DGDeU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 23:34:20 -0400
Received: (qmail 18170 invoked by uid 107); 7 Apr 2012 03:34:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Apr 2012 23:34:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2012 23:34:17 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194930>

The typical call flow for the credential API is something
like:

  1. Network code (like http.c) wants a credential. It calls
     credential_fill() to get it, and one of the two happens:

     a. We call out to any helpers with a "get" request,
	one of which provides the credential.

     b. No helper provides us the credential, so we ask the
        user.

  2. The network code uses the credential. Let's imagine
     that the request completes successfully.

  3. The network code informs the credential subsystem of
     success by calling credential_approve(). The credential
     code then calls out to any helpers with a "store"
     request, so they can optionally store it if they want.

In the case of (1b), this is a good thing. The credential
comes from the user, gets used, and then gets put into
storage for later use again. But in the case of (1a), we end
up feeding the helper with a credential that came from
itself already (or possibly from another helper).

Most of the time, this is harmless and slightly inefficient.
But it has two user-visible impacts:

  1. If you have two helpers, you end up propagating data
     between them. For instance, imagine you have a helper
     "git-credential-wallet" which pulls data from a a
     read-only password wallet. You might configure git like
     this:

       [credential]
		helper = wallet
		helper = cache

     to check the wallet first, and then fall back to asking
     the user and caching the result. But when we do get
     something out of the wallet, git will then ask for it
     to be stored in the wallet (which is a no-op), and the
     cache. So your credential migrates from the wallet into
     the cache, which may not be what you want (e.g.,
     because the wallet implements more strict security
     policies than the cache).

  2. If you use a time-based storage helper like
     "git-credential-cache", every time you run a git
     command which uses the credential, it will also
     re-insert the credential after use, freshening the
     cache timestamp. So the cache will eventually expire N
     time units after the last _use_, not after the time the
     user actually typed the password. This is probably not
     what most users expect or want (and if they do, we
     should do it explicitly by providing an option to
     refresh the timestamp on use).

We can solve this by marking a credential that comes from a
helper, so we don't bother feeding it back to the helpers.
The credential struct already has an "approved" flag so
that we try to store it only once, rather than for each
successful http request. We can use the same flag to
"pre-approve" a credential which comes from a helper, and
enver try to store it at all.

Signed-off-by: Jeff King <peff@peff.net>
---
Whew, that was a long explanation. Fortunately the patch text itself is
pleasantly simple.

 credential.c          |    4 +++-
 t/t5550-http-fetch.sh |    6 +++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/credential.c b/credential.c
index 62d1c56..813e77a 100644
--- a/credential.c
+++ b/credential.c
@@ -272,8 +272,10 @@ void credential_fill(struct credential *c)
 
 	for (i = 0; i < c->helpers.nr; i++) {
 		credential_do(c, c->helpers.items[i].string, "get");
-		if (c->username && c->password)
+		if (c->username && c->password) {
+			c->approved = 1;
 			return;
+		}
 	}
 
 	credential_getpass(c);
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index e5e6b8f..82e0d37 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -104,13 +104,17 @@ test_expect_success 'http auth can request both user and pass' '
 test_expect_success 'http auth respects credential helper config' '
 	test_config_global credential.helper "!f() {
 		cat >/dev/null
+		echo helper: \$* >>helper-trace
 		echo username=user@host
 		echo password=user@host
 	}; f" &&
+	>helper-trace &&
 	>askpass-query &&
 	echo wrong >askpass-response &&
 	git clone "$HTTPD_URL/auth/repo.git" clone-auth-helper &&
-	expect_askpass none
+	expect_askpass none &&
+	echo "helper: get" >helper-expect &&
+	test_cmp helper-expect helper-trace
 '
 
 test_expect_success 'http auth can get username from config' '
-- 
1.7.10.rc4.31.g355de
