From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] push: allow --follow-tags to be set by config
 push.followTags
Date: Mon, 16 Feb 2015 01:16:19 -0500
Message-ID: <20150216061619.GC32381@peff.net>
References: <20150216061051.GA29895@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Olszewski <cxreg@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 07:16:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNEyo-0000df-Te
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 07:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbbBPGQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 01:16:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:49409 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751328AbbBPGQW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 01:16:22 -0500
Received: (qmail 9325 invoked by uid 102); 16 Feb 2015 06:16:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 00:16:22 -0600
Received: (qmail 12563 invoked by uid 107); 16 Feb 2015 06:16:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 01:16:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2015 01:16:19 -0500
Content-Disposition: inline
In-Reply-To: <20150216061051.GA29895@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263880>

From: Dave Olszewski <cxreg@pobox.com>

Signed-off-by: Dave Olszewski <cxreg@pobox.com>
---
Again, this is just a preview. Dave should send the final when he thinks
it is good.

The if/else I added to the config callback is kind of ugly. I wonder if
we should have git_config_bit, or even just a function to set/clear a
bit. Then the OPT_BIT code could use it, too. Something like:

  munge_bit(flags, TRANSPORT_PUSH_FOLLOW_TAGS, git_config_bool(k, v));

Or maybe that is getting too fancy and obfuscated for a simple bit
set/clear. I dunno.

 Documentation/config.txt               | 6 ++++++
 Documentation/git-push.txt             | 5 ++++-
 builtin/push.c                         | 9 +++++++++
 contrib/completion/git-completion.bash | 1 +
 4 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ae6791d..e01d21c 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2079,6 +2079,12 @@ new default).
 
 --
 
+push.followTags::
+	If set to true enable '--follow-tags' option by default.  You
+	may override this configuration at time of push by specifying
+	'--no-follow-tags'.
+
+
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index ea97576..caa187b 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -128,7 +128,10 @@ already exists on the remote side.
 	Push all the refs that would be pushed without this option,
 	and also push annotated tags in `refs/tags` that are missing
 	from the remote but are pointing at commit-ish that are
-	reachable from the refs being pushed.
+	reachable from the refs being pushed.  This can also be specified
+	with configuration variable 'push.followTags'.  For more
+	information, see 'push.followTags' in linkgit:git-config[1].
+
 
 --signed::
 	GPG-sign the push request to update refs on the receiving
diff --git a/builtin/push.c b/builtin/push.c
index c25108f..6831c2d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -482,6 +482,7 @@ static int option_parse_recurse_submodules(const struct option *opt,
 
 static int git_push_config(const char *k, const char *v, void *cb)
 {
+	int *flags = cb;
 	int status;
 
 	status = git_gpg_config(k, v, NULL);
@@ -511,6 +512,14 @@ static int git_push_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(k, "push.followtags")) {
+		if (git_config_bool(k, v))
+			*flags |= TRANSPORT_PUSH_FOLLOW_TAGS;
+		else
+			*flags &= ~TRANSPORT_PUSH_FOLLOW_TAGS;
+		return 0;
+	}
+
 	return git_default_config(k, v, NULL);
 }
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c21190d..cffb2b8 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2188,6 +2188,7 @@ _git_config ()
 		pull.octopus
 		pull.twohead
 		push.default
+		push.followTags
 		rebase.autosquash
 		rebase.stat
 		receive.autogc
-- 
2.3.0.rc1.287.g761fd19
