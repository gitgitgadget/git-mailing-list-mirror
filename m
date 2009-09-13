From: Owen Taylor <otaylor@redhat.com>
Subject: [PATCH 2/4] push: allow configuring default for --confirm
Date: Sun, 13 Sep 2009 19:31:23 -0400
Message-ID: <1252884685-9169-3-git-send-email-otaylor@redhat.com>
References: <1252884685-9169-1-git-send-email-otaylor@redhat.com>
 <1252884685-9169-2-git-send-email-otaylor@redhat.com>
Cc: "Owen W. Taylor" <otaylor@fishsoup.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 01:31:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmyXn-0001Gx-0y
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 01:31:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbZIMXba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 19:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754049AbZIMXb2
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 19:31:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54270 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753992AbZIMXbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 19:31:25 -0400
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8DNVRKk014467;
	Sun, 13 Sep 2009 19:31:28 -0400
Received: from localhost.localdomain (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8DNVPJ1026475;
	Sun, 13 Sep 2009 19:31:27 -0400
In-Reply-To: <1252884685-9169-2-git-send-email-otaylor@redhat.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128427>

From: Owen W. Taylor <otaylor@fishsoup.net>

A new configuration variable push.confirm sets the default
behavior for whether 'git push' should show prompt the user
interactively before proceeding to update refs.

Signed-off-by: Owen W. Taylor <otaylor@fishsoup.net>
---
 Documentation/config.txt |    4 ++++
 builtin-push.c           |    6 +++++-
 cache.h                  |    1 +
 config.c                 |    4 ++++
 environment.c            |    1 +
 5 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index be0b8ca..3bb632f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1303,6 +1303,10 @@ pull.octopus::
 pull.twohead::
 	The default merge strategy to use when pulling a single branch.
 
+push.confirm::
+	If set to true, linkgit:git-push[1] will act as if the --confirm
+	option was passed, unless overriden with --no-confirm.
+
 push.default::
 	Defines the action git push should take if no refspec is given
 	on the command line, no refspec is configured in the remote, and
diff --git a/builtin-push.c b/builtin-push.c
index 231be5d..63a0bb0 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -66,7 +66,6 @@ static void setup_push_tracking(void)
 
 static void setup_default_push_refspecs(void)
 {
-	git_config(git_default_config, NULL);
 	switch (push_default) {
 	default:
 	case PUSH_DEFAULT_MATCHING:
@@ -193,6 +192,11 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	git_config(git_default_config, NULL);
+
+	if (push_confirm)
+		flags |= TRANSPORT_PUSH_CONFIRM;
+
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 
 	if (tags)
diff --git a/cache.h b/cache.h
index 1a6412d..ef8606d 100644
--- a/cache.h
+++ b/cache.h
@@ -558,6 +558,7 @@ enum push_default_type {
 extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
 extern enum push_default_type push_default;
+extern int push_confirm;
 
 enum object_creation_mode {
 	OBJECT_CREATION_USES_HARDLINKS = 0,
diff --git a/config.c b/config.c
index c644061..1bc8e6f 100644
--- a/config.c
+++ b/config.c
@@ -575,6 +575,10 @@ static int git_default_branch_config(const char *var, const char *value)
 
 static int git_default_push_config(const char *var, const char *value)
 {
+	if (!strcmp(var, "push.confirm")) {
+		push_confirm = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "push.default")) {
 		if (!value)
 			return config_error_nonbool(var);
diff --git a/environment.c b/environment.c
index 5de6837..e1c82b9 100644
--- a/environment.c
+++ b/environment.c
@@ -44,6 +44,7 @@ enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
+int push_confirm;
 enum push_default_type push_default = PUSH_DEFAULT_MATCHING;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
-- 
1.6.2.5
