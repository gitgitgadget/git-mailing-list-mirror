From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] remote: deprecate --mirror
Date: Wed, 30 Mar 2011 15:53:39 -0400
Message-ID: <20110330195339.GC30624@sigill.intra.peff.net>
References: <20110330195139.GA814@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: chris <jugg@hotmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 21:53:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q51Sc-0000Fk-Vo
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 21:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932799Ab1C3Txm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 15:53:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44339
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932331Ab1C3Txl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 15:53:41 -0400
Received: (qmail 21091 invoked by uid 107); 30 Mar 2011 19:54:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Mar 2011 15:54:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Mar 2011 15:53:39 -0400
Content-Disposition: inline
In-Reply-To: <20110330195139.GA814@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170419>

The configuration created by plain --mirror is dangerous and
useless, and we now have --mirror=fetch and --mirror=push to
replace it. Let's warn the user.

One alternative to this is to try to guess which type the
user wants. In a non-bare repository, a fetch mirror doesn't
make much sense, since it would overwrite local commits. But
in a bare repository, you might use either type, or even
both (e.g., if you are acting as an intermediate drop-point
across two disconnected networks).

So rather than try for complex heuristics, let's keep it
simple. The user knows what they're trying to do, so let
them tell us.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-remote.txt |    4 ----
 builtin/remote.c             |    8 +++++++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 28724a9..528f34a 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -75,10 +75,6 @@ because a fetch would overwrite any local commits.
 +
 When a push mirror is created with `\--mirror=push`, then `git push`
 will always behave as if `\--mirror` was passed.
-+
-The option `\--mirror` (with no type) sets up both push and fetch
-mirror configuration. It is kept for historical purposes, and is
-probably not what you want.
 
 'rename'::
 
diff --git a/builtin/remote.c b/builtin/remote.c
index 570407f..8424152 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -136,13 +136,19 @@ static int add_branch(const char *key, const char *branchname,
 	return git_config_set_multivar(key, tmp->buf, "^$", 0);
 }
 
+static const char mirror_advice[] =
+"--mirror is dangerous and deprecated; please\n"
+"\t use --mirror=fetch or --mirror=push instead";
+
 static int parse_mirror_opt(const struct option *opt, const char *arg, int not)
 {
 	unsigned *mirror = opt->value;
 	if (not)
 		*mirror = MIRROR_NONE;
-	else if (!arg)
+	else if (!arg) {
+		warning("%s", mirror_advice);
 		*mirror = MIRROR_BOTH;
+	}
 	else if (!strcmp(arg, "fetch"))
 		*mirror = MIRROR_FETCH;
 	else if (!strcmp(arg, "push"))
-- 
1.7.4.2.8.g3ccd6
