From: Dave Olszewski <cxreg@pobox.com>
Subject: [PATCH] push: allow --follow-tags' to be set by config push.followTags
Date: Sun, 15 Feb 2015 15:39:48 -0800
Message-ID: <1424043588-15994-1-git-send-email-cxreg@pobox.com>
Cc: Dave Olszewski <cxreg@pobox.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 16 00:53:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YN90K-0000pP-GW
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 00:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752565AbbBOXxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2015 18:53:32 -0500
Received: from 62.f9.1243.static.theplanet.com ([67.18.249.98]:45519 "EHLO
	62.f9.1243.static.theplanet.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750904AbbBOXxc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Feb 2015 18:53:32 -0500
X-Greylist: delayed 810 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Feb 2015 18:53:31 EST
X-Envelope-From: count@genericorp.net
Received: from bumba (70-56-91-30.tukw.qwest.net [70.56.91.30])
	(authenticated bits=0)
	by 62.f9.1243.static.theplanet.com (8.14.4/8.14.4/Debian-8) with ESMTP id t1FNdwSN007655
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 15 Feb 2015 17:39:59 -0600
Received: from count by bumba with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <count@genericorp.net>)
	id 1YN8n3-0004Ab-6p; Sun, 15 Feb 2015 15:39:53 -0800
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263863>

Signed-off-by: Dave Olszewski <cxreg@pobox.com>
---
 Documentation/config.txt               | 3 +++
 Documentation/git-push.txt             | 5 ++++-
 cache.h                                | 1 +
 config.c                               | 5 +++++
 contrib/completion/git-completion.bash | 1 +
 environment.c                          | 1 +
 transport.c                            | 2 +-
 7 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ae6791d..cdb8a99 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2079,6 +2079,9 @@ new default).
 
 --
 
+push.followTags::
+	If set to true enable '--follow-tags' option by default.
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
diff --git a/cache.h b/cache.h
index f704af5..9318189 100644
--- a/cache.h
+++ b/cache.h
@@ -648,6 +648,7 @@ enum push_default_type {
 extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
 extern enum push_default_type push_default;
+extern int push_follow_tags;
 
 enum object_creation_mode {
 	OBJECT_CREATION_USES_HARDLINKS = 0,
diff --git a/config.c b/config.c
index e5e64dc..cb237cd 100644
--- a/config.c
+++ b/config.c
@@ -977,6 +977,11 @@ static int git_default_push_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "push.followtags")) {
+		push_follow_tags = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
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
diff --git a/environment.c b/environment.c
index 1ade5c9..aef9587 100644
--- a/environment.c
+++ b/environment.c
@@ -52,6 +52,7 @@ unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
+int push_follow_tags = 0;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
diff --git a/transport.c b/transport.c
index 0694a7c..87cd657 100644
--- a/transport.c
+++ b/transport.c
@@ -1148,7 +1148,7 @@ int transport_push(struct transport *transport,
 			match_flags |= MATCH_REFS_MIRROR;
 		if (flags & TRANSPORT_PUSH_PRUNE)
 			match_flags |= MATCH_REFS_PRUNE;
-		if (flags & TRANSPORT_PUSH_FOLLOW_TAGS)
+		if ((flags & TRANSPORT_PUSH_FOLLOW_TAGS) || push_follow_tags)
 			match_flags |= MATCH_REFS_FOLLOW_TAGS;
 
 		if (match_push_refs(local_refs, &remote_refs,
-- 
2.1.4
