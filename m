From: Jeff King <peff@peff.net>
Subject: [PATCH 3/2] push: allow --follow-tags to be set by config
 push.followTags
Date: Mon, 16 Feb 2015 00:54:22 -0500
Message-ID: <20150216055422.GB24611@peff.net>
References: <1424055690-32631-1-git-send-email-cxreg@pobox.com>
 <20150216052049.GA5031@peff.net>
 <20150216054550.GA24611@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 06:54:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNEdZ-0001xL-S7
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 06:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbbBPFyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 00:54:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:49377 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750744AbbBPFyY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 00:54:24 -0500
Received: (qmail 8357 invoked by uid 102); 16 Feb 2015 05:54:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 15 Feb 2015 23:54:25 -0600
Received: (qmail 12277 invoked by uid 107); 16 Feb 2015 05:54:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Feb 2015 00:54:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Feb 2015 00:54:22 -0500
Content-Disposition: inline
In-Reply-To: <20150216054550.GA24611@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263873>

On Mon, Feb 16, 2015 at 12:45:50AM -0500, Jeff King wrote:

> On Mon, Feb 16, 2015 at 12:20:49AM -0500, Jeff King wrote:
> 
> > But here you are adding to git_default_push_config, which is in another
> > file.
> > 
> > I'm trying to figure out why git_default_push_config exists at all. The
> > major difference from git_push_config is that the "default" variant will
> > get loaded for _all_ commands, not just "push". So if it affected
> > variables that were used by other commands, it would be needed. But all
> > it sets is push_default, which seems to be specific to builtin/push.c.
> > 
> > So I suspect it can be removed entirely, and folded into
> > git_config_push. But that's outside the scope of your patch.
> 
> Here's that cleanup, plus another one I noticed while doing it.
> 
>   [1/2]: git_push_config: drop cargo-culted wt_status pointer
>   [2/2]: builtin/push.c: make push_default a static variable

And here's what your patch would look like rebased on top. Two nits,
though. One, it could probably use a few basic tests.

And two, the way that the config and --follow-tags interact is a little
non-obvious (as evidenced by the fact that you needed a comment to
explain what was going on).

One way to do it would be similar to how "atomic" is implemented: use
OPT_BOOL to set an int, and then pick up the final value of that int
after config and command-line parsing is done. Then a reader does not
have to wonder why the "follow_tags" variable is not set by
"--follow-tags".

Or alternatively, we could pull the "flags" field from cmd_push out into
a static global "transport_flags", and manipulate it directly from the
config (or if we don't like a global, pass it via the config-callback
void pointer; but certainly a global is more common in git for code like
this). Then we do not have to worry about propagating values from
integers into flag bits at all.

-- >8 --
From: Dave Olszewski <cxreg@pobox.com>
Subject: push: allow --follow-tags to be set by config push.followTags

Signed-off-by: Dave Olszewski <cxreg@pobox.com>
---
 Documentation/config.txt               |  6 ++++++
 Documentation/git-push.txt             |  5 ++++-
 builtin/push.c                         | 11 +++++++++++
 contrib/completion/git-completion.bash |  1 +
 4 files changed, 22 insertions(+), 1 deletion(-)

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
index ab99f4c..7ddf4dd 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -20,6 +20,7 @@ static int deleterefs;
 static const char *receivepack;
 static int verbosity;
 static int progress = -1;
+static int follow_tags;
 
 static struct push_cas_option cas;
 
@@ -511,6 +512,11 @@ static int git_push_config(const char *k, const char *v, void *cb)
 		return 0;
 	}
 
+	if (!strcmp(k, "push.followtags")) {
+		follow_tags = git_config_bool(k, v);
+		return 0;
+	}
+
 	return git_default_config(k, v, NULL);
 }
 
@@ -557,6 +563,11 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 
 	packet_trace_identity("push");
 	git_config(git_push_config, NULL);
+
+	/* set TRANSPORT_PUSH_FOLLOW_TAGS in flags so that --no-follow-tags may unset it */
+	if (follow_tags)
+		flags |= TRANSPORT_PUSH_FOLLOW_TAGS;
+
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 
 	if (deleterefs && (tags || (flags & (TRANSPORT_PUSH_ALL | TRANSPORT_PUSH_MIRROR))))
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
