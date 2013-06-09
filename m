From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 20/36] cherry-pick: copy notes and run hooks
Date: Sun,  9 Jun 2013 14:24:34 -0500
Message-ID: <1370805890-3453-21-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:27:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllHM-0003fR-0l
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357Ab3FIT1m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:27:42 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:35216 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab3FIT1l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:41 -0400
Received: by mail-ob0-f171.google.com with SMTP id dn14so9054333obc.2
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vsv3qx8E9K89UwjNrKbMi3+HKegDNEB8KZr9yA0Jiv0=;
        b=Bl64TCeAg9TFnCgYQcC6eXdSJUfD6ZwRFltBOU6ASK0KdrngohzOBe/flkkvHVO0He
         7GkMtGDgP8WBShoflveDLq/lGsgRgYNhUxqJEttzc7dfXA7mJv9UGyYmXQcLQKriazWq
         BtCP5wFSfcRYWpHjN2TQHw6zLRlEw7qTSVwf6YxHykyVITK38utM+73vNsM2NDEfBStJ
         azjfM5NuMMo+c8E2mZ+bgkDO+cNouJXPwl+5PVAx6xTHDsyuA7UjFcfgvmrRwRr9mqsB
         nV3YO+HN9DcUXkWWoeGH3JiGfS4AaVZbez6cLaLw5ESRj84TfYxELqaqvo8jbviyAVZN
         5NOw==
X-Received: by 10.182.40.132 with SMTP id x4mr5521660obk.61.1370806061082;
        Sun, 09 Jun 2013 12:27:41 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id c20sm16269581oez.4.2013.06.09.12.27.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227130>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt   |  9 ++++-----
 Documentation/githooks.txt |  8 ++++----
 builtin/rewrite.c          |  1 +
 builtin/sequencer.c        | 18 +++++++++++++++++-
 4 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7fd4035..d72d2d2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1679,11 +1679,10 @@ GIT_NOTES_REF) is also implicitly added to the list of refs to be
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
diff --git a/builtin/rewrite.c b/builtin/rewrite.c
index 02e0ea9..acbad44 100644
--- a/builtin/rewrite.c
+++ b/builtin/rewrite.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "rewrite.h"
 #include "run-command.h"
+#include "builtin.h"
 
 void add_rewritten(struct rewritten *list, unsigned char *from, unsigned char *to)
 {
diff --git a/builtin/sequencer.c b/builtin/sequencer.c
index d40fda9..c87008e 100644
--- a/builtin/sequencer.c
+++ b/builtin/sequencer.c
@@ -21,6 +21,15 @@
 
 static struct rewritten rewritten;
 
+static void finish(struct replay_opts *opts)
+{
+	if (opts->action != REPLAY_PICK)
+		return;
+
+	copy_rewrite_notes(&rewritten, "cherry-pick");
+	run_rewrite_hook(&rewritten, "cherry-pick");
+}
+
 static void remove_sequencer_state(void)
 {
 	struct strbuf seq_dir = STRBUF_INIT;
@@ -935,6 +944,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 		}
 	}
 
+	finish(opts);
+
 	/*
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
@@ -1006,8 +1017,13 @@ static int sequencer_skip(struct replay_opts *opts)
 
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
1.8.3.698.g079b096
