From: Owen Taylor <otaylor@redhat.com>
Subject: [PATCH 4/4] push: allow configuring default for --show-subjects
Date: Sun, 13 Sep 2009 19:31:25 -0400
Message-ID: <1252884685-9169-5-git-send-email-otaylor@redhat.com>
References: <1252884685-9169-1-git-send-email-otaylor@redhat.com>
 <1252884685-9169-2-git-send-email-otaylor@redhat.com>
 <1252884685-9169-3-git-send-email-otaylor@redhat.com>
 <1252884685-9169-4-git-send-email-otaylor@redhat.com>
Cc: "Owen W. Taylor" <otaylor@fishsoup.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 01:31:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmyXo-0001Gx-HZ
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 01:31:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbZIMXbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 19:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754150AbZIMXbb
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 19:31:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63511 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029AbZIMXb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 19:31:26 -0400
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8DNVTNm026022;
	Sun, 13 Sep 2009 19:31:29 -0400
Received: from localhost.localdomain (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8DNVPJ3026475;
	Sun, 13 Sep 2009 19:31:29 -0400
In-Reply-To: <1252884685-9169-4-git-send-email-otaylor@redhat.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128430>

From: Owen W. Taylor <otaylor@fishsoup.net>

A new configuration variable push.show-subjects sets the default
behavior for whether 'git push' should show a commit synopsis with
each updated ref.

Signed-off-by: Owen W. Taylor <otaylor@fishsoup.net>
---
 Documentation/config.txt |    4 ++++
 builtin-push.c           |    2 ++
 cache.h                  |    1 +
 config.c                 |    4 ++++
 environment.c            |    1 +
 5 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3bb632f..83bc5a5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1320,6 +1320,10 @@ push.default::
 * `tracking` push the current branch to its upstream branch.
 * `current` push the current branch to a branch of the same name.
 
+push.show-subjects::
+	If set to true, linkgit:git-push[1] will act as if the --show-subjects
+	option was passed, unless overriden with --no-show-subjects.
+
 rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
diff --git a/builtin-push.c b/builtin-push.c
index 7c9e394..e3dc579 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -197,6 +197,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 
 	if (push_confirm)
 		flags |= TRANSPORT_PUSH_CONFIRM;
+	if (push_show_subjects)
+		flags |= TRANSPORT_PUSH_SHOW_SUBJECTS;
 
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 
diff --git a/cache.h b/cache.h
index ef8606d..9e6a1e6 100644
--- a/cache.h
+++ b/cache.h
@@ -559,6 +559,7 @@ extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
 extern enum push_default_type push_default;
 extern int push_confirm;
+extern int push_show_subjects;
 
 enum object_creation_mode {
 	OBJECT_CREATION_USES_HARDLINKS = 0,
diff --git a/config.c b/config.c
index 1bc8e6f..bc78876 100644
--- a/config.c
+++ b/config.c
@@ -597,6 +597,10 @@ static int git_default_push_config(const char *var, const char *value)
 		}
 		return 0;
 	}
+	if (!strcmp(var, "push.show-subjects")) {
+		push_show_subjects = git_config_bool(var, value);
+		return 0;
+	}
 
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
diff --git a/environment.c b/environment.c
index e1c82b9..303c54f 100644
--- a/environment.c
+++ b/environment.c
@@ -46,6 +46,7 @@ enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 int push_confirm;
 enum push_default_type push_default = PUSH_DEFAULT_MATCHING;
+int push_show_subjects;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
-- 
1.6.2.5
