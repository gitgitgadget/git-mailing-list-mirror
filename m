From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 11/28] cherry-pick: copy notes and run hooks
Date: Fri, 30 Aug 2013 00:56:05 -0500
Message-ID: <1377842182-18724-12-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:01:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHm3-0007Jh-3H
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755658Ab3H3GBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:30 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:38371 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755636Ab3H3GB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:28 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so1450000obc.26
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rc5nDgR18khxi2pWDydYrO1lVsqOmQX6frl27VSIbGQ=;
        b=cAnJqnQD5tlqMZXIV6rP4y59AYxKIYOiLPU5eDd9ECMEkFw7qQlPDDlt6JZhTvwmdD
         8AFWG+uLE4GwnaN40uzn1Z0kMmvBShtWUmdjW7vb9xlFkWv+GgpOy9iRzoeehVE888WR
         /8N/n2ZNkZ+oCHCePaSIf6/esczKFnqqZGKSnMIIpgyC3wl15HcP7mADr4OhGnTuySaN
         ohEWaPEDrMZC2xRHe8DcptyAKXKzwBc72u3NhBZ4e0Vbl4J5iJJATi/MwT8AVnXaS5n+
         P4nrYC+0I12+vxT9R4eYgs9T8EgQu2F1LDhYRQtKNxV94CNzsc+eeBwid4TO9N6g92Y2
         1ang==
X-Received: by 10.60.52.244 with SMTP id w20mr5568452oeo.30.1377842488287;
        Thu, 29 Aug 2013 23:01:28 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm32420999obu.4.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233403>

If no action-name is specified, nothing is done.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt   |  9 ++++-----
 Documentation/githooks.txt |  8 ++++----
 rewrite.c                  |  1 +
 sequencer.c                | 25 ++++++++++++++++++++++++-
 4 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ec57a15..7e7f89f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1691,11 +1691,10 @@ GIT_NOTES_REF) is also implicitly added to the list of refs to be
 displayed.
 
 notes.rewrite.<command>::
-	When rewriting commits with <command> (currently `amend` or
-	`rebase`) and this variable is set to `true`, Git
-	automatically copies your notes from the original to the
-	rewritten commit.  Defaults to `true`, but see
-	"notes.rewriteRef" below.
+	When rewriting commits with <command> (currently `amend`, `rebase`, or
+	`cherry-pick`) and this variable is set to `true`, Git automatically
+	copies your notes from the original to the rewritten commit.  Defaults
+	to `true`, but see "notes.rewriteRef" below.
 
 notes.rewriteMode::
 	When copying notes during a rewrite (see the
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d48bf4d..8cfa13b 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -352,10 +352,10 @@ post-rewrite
 ~~~~~~~~~~~~
 
 This hook is invoked by commands that rewrite commits (`git commit
---amend`, 'git-rebase'; currently 'git-filter-branch' does 'not' call
-it!).  Its first argument denotes the command it was invoked by:
-currently one of `amend` or `rebase`.  Further command-dependent
-arguments may be passed in the future.
+--amend`, `git rebase`, `git cherry-pick`; currently `git filter-branch` does
+'not' call it!).  Its first argument denotes the command it was invoked by
+(e.g. `rebase`).  Further command-dependent arguments may be passed in the
+future.
 
 The hook receives a list of the rewritten commits on stdin, in the
 format
diff --git a/rewrite.c b/rewrite.c
index 4dddcd9..4f95094 100644
--- a/rewrite.c
+++ b/rewrite.c
@@ -2,6 +2,7 @@
 #include "rewrite.h"
 #include "run-command.h"
 #include "notes-utils.h"
+#include "builtin.h"
 
 void add_rewritten(struct rewritten *list, unsigned char *from, unsigned char *to)
 {
diff --git a/sequencer.c b/sequencer.c
index 46848c4..076bb9d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -22,6 +22,22 @@ const char sign_off_header[] = "Signed-off-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 static struct rewritten rewritten;
 
+static void finish(struct replay_opts *opts)
+{
+	const char *name;
+
+	if (opts->action != REPLAY_PICK)
+		return;
+
+	name = opts->action_name ? opts->action_name : "cherry-pick";
+
+	if (!*name)
+		return;
+
+	copy_rewrite_notes(&rewritten, name, "Notes added by 'git cherry-pick'");
+	run_rewrite_hook(&rewritten, name);
+}
+
 static int is_rfc2822_line(const char *buf, int len)
 {
 	int i;
@@ -1033,6 +1049,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 		}
 	}
 
+	finish(opts);
+
 	/*
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
@@ -1104,8 +1122,13 @@ static int sequencer_skip(struct replay_opts *opts)
 
 static int single_pick(struct commit *cmit, struct replay_opts *opts)
 {
+	int ret;
 	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);
-	return do_pick_commit(cmit, opts);
+	ret = do_pick_commit(cmit, opts);
+	if (ret)
+		return ret;
+	finish(opts);
+	return 0;
 }
 
 int sequencer_pick_revisions(struct replay_opts *opts)
-- 
1.8.4-fc
