From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH RFC 2/8] push: add push.default = mirror
Date: Mon, 20 Jul 2009 19:49:49 +0200
Message-ID: <1248112195-3761-3-git-send-email-bonzini@gnu.org>
References: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 19:50:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSx09-0005Xp-M1
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 19:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbZGTRuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 13:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753112AbZGTRuH
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 13:50:07 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:56551 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957AbZGTRuF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 13:50:05 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MSx00-00032v-Gp
	for git@vger.kernel.org; Mon, 20 Jul 2009 13:50:05 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1248112195-3761-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123624>

This patch adds a new value for push.default.  The aim of the series is
to support all push.default values as arguments to `--push' in git-clone
and git-remote, and if push.default=mirror works it is easy to make
`--mirror' a synonym for `--push=mirror' in those comments.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/config.txt |    2 ++
 builtin-push.c           |   12 ++++++++++--
 cache.h                  |    1 +
 config.c                 |    4 +++-
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4c27e9d..fa5eb76 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1290,6 +1290,8 @@ push.default::
 * `matching` push all matching branches.
   All branches having the same name in both ends are considered to be
   matching. This is the default.
+* `mirror` pushes all branches forcing non fast-forward updates and
+  deletes branches that do not exist anymore locally.
 * `tracking` push the current branch to its upstream branch.
 * `current` push the current branch to a branch of the same name.
 
diff --git a/builtin-push.c b/builtin-push.c
index e678a9d..8a312a3 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -66,7 +66,6 @@ static void setup_push_tracking(void)
 
 static void setup_default_push_refspecs(void)
 {
-	git_config(git_default_config, NULL);
 	switch (push_default) {
 	default:
 	case PUSH_DEFAULT_UNSPECIFIED:
@@ -74,6 +73,10 @@ static void setup_default_push_refspecs(void)
 		add_refspec(":");
 		break;
 
+	case PUSH_DEFAULT_MIRROR:
+		add_refspec("+refs/*:refs/*");
+		break;
+
 	case PUSH_DEFAULT_TRACKING:
 		setup_push_tracking();
 		break;
@@ -126,8 +129,12 @@ static int do_push(const char *repo, int flags)
 		if (remote->push_refspec_nr) {
 			refspec = remote->push_refspec;
 			refspec_nr = remote->push_refspec_nr;
-		} else if (!(flags & TRANSPORT_PUSH_MIRROR))
+		} else if (!(flags & TRANSPORT_PUSH_MIRROR)
+			   || push_default == PUSH_DEFAULT_MIRROR) {
+			if (push_default == PUSH_DEFAULT_MIRROR)
+				flags |= TRANSPORT_PUSH_MIRROR;
 			setup_default_push_refspecs();
+		}
 	}
 	errs = 0;
 	if (remote->pushurl_nr) {
@@ -184,6 +191,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 
 	if (tags)
diff --git a/cache.h b/cache.h
index f10513f..172d36c 100644
--- a/cache.h
+++ b/cache.h
@@ -549,6 +549,7 @@ enum push_default_type {
 	PUSH_DEFAULT_MATCHING,
 	PUSH_DEFAULT_TRACKING,
 	PUSH_DEFAULT_CURRENT,
+	PUSH_DEFAULT_MIRROR,
 };
 
 struct tracking_config {
diff --git a/config.c b/config.c
index 04380bb..4db5c6d 100644
--- a/config.c
+++ b/config.c
@@ -604,6 +604,8 @@ static int git_default_push_config(const char *var, const char *value)
 			push_default = PUSH_DEFAULT_NOTHING;
 		else if (!strcmp(value, "matching"))
 			push_default = PUSH_DEFAULT_MATCHING;
+		else if (!strcmp(value, "mirror"))
+			push_default = PUSH_DEFAULT_MIRROR;
 		else if (!strcmp(value, "tracking"))
 			push_default = PUSH_DEFAULT_TRACKING;
 		else if (!strcmp(value, "current"))
@@ -611,7 +613,7 @@ static int git_default_push_config(const char *var, const char *value)
 		else {
 			error("Malformed value for %s: %s", var, value);
 			return error("Must be one of nothing, matching, "
-				     "tracking or current.");
+				     "mirror, tracking or current.");
 		}
 		return 0;
 	}
-- 
1.6.2.5
