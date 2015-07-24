From: David Turner <dturner@twopensource.com>
Subject: [PATCH 6/9] pseudorefs: create and use pseudoref update and delete functions
Date: Fri, 24 Jul 2015 00:45:26 -0400
Message-ID: <1437713129-19373-7-git-send-email-dturner@twopensource.com>
References: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jul 24 06:46:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIUs8-0003xD-2E
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 06:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbbGXEqC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 00:46:02 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33014 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbbGXEp4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 00:45:56 -0400
Received: by qkdl129 with SMTP id l129so8261393qkd.0
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 21:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WsmRadxrkOzJXIPkvcG3pISaAy+IbPk5dOysmGhnTrI=;
        b=CO0YEeJ4Qo3flqq4MinDkRvi47vqaJULWHNYDsx+O08BNcESHm+9YsCDp6ewkOs/sJ
         0Qh1G7eAqVvTI/d4xk1meeNWipJmyDbhBpl+8S+vvRTbLnElXsA2+uL1U2kSEFixNtGD
         ADxR5jgIEcNcardRWfswSVgVej9usIEIFdHEpU/ED2C9a23sUY0yvhjXGF+yeledv4VP
         VYIl+e2Vt7cIaPyI9DxggFDJ0hECrZPJVnAewmtzqkVfWegZdbRaKzEMU0O2fdaIhTvw
         kRwGNy17li0C80EhMWs3S2uHt9ELF/HWze1qqOC2SdBAz2fqY9u5QT+KZzr+77+rhKSY
         G4/w==
X-Gm-Message-State: ALoCoQkTpe8Uc45HRzHGt7yGkBOPOMy9yobkJuctQyC0a+q4doeae5qLoQk4bGxiL5fzbmiwRE9V
X-Received: by 10.141.28.78 with SMTP id f75mr18701142qhe.20.1437713155391;
        Thu, 23 Jul 2015 21:45:55 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p74sm3541579qkp.11.2015.07.23.21.45.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2015 21:45:54 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274547>

Pseudorefs should not be updated through the ref API, because the ref
API is for real refs.  Instead, use a dedicated pseudoref API.

This patch changes writes to CHERRY_PICK_HEAD, REVERT_HEAD, and ORIG_HEAD.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/merge.c |  3 +--
 builtin/reset.c |  6 ++----
 refs.c          | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 refs.h          |  5 +++++
 sequencer.c     | 21 ++-------------------
 5 files changed, 64 insertions(+), 26 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 7e2541a..cea57a0 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1354,8 +1354,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		free(list);
 	}
 
-	update_ref("updating ORIG_HEAD", "ORIG_HEAD", head_commit->object.sha1,
-		   NULL, 0, UPDATE_REFS_DIE_ON_ERR);
+	write_pseudoref("ORIG_HEAD", head_commit->object.sha1, NULL);
 
 	if (remoteheads && !common)
 		; /* No common ancestors found. We need a real merge. */
diff --git a/builtin/reset.c b/builtin/reset.c
index 4c08ddc..0282e78 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -252,11 +252,9 @@ static int reset_refs(const char *rev, const unsigned char *sha1)
 		old_orig = sha1_old_orig;
 	if (!get_sha1("HEAD", sha1_orig)) {
 		orig = sha1_orig;
-		set_reflog_message(&msg, "updating ORIG_HEAD", NULL);
-		update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0,
-			   UPDATE_REFS_MSG_ON_ERR);
+		write_pseudoref("ORIG_HEAD", orig, old_orig);
 	} else if (old_orig)
-		delete_ref("ORIG_HEAD", old_orig, 0);
+		delete_pseudoref("ORIG_HEAD", old_orig);
 	set_reflog_message(&msg, "updating HEAD", rev);
 	update_ref_status = update_ref(msg.buf, "HEAD", sha1, orig, 0,
 				       UPDATE_REFS_MSG_ON_ERR);
diff --git a/refs.c b/refs.c
index d31ca42..efa84e3 100644
--- a/refs.c
+++ b/refs.c
@@ -3862,7 +3862,7 @@ int is_per_worktree_ref(const char *refname)
 	return !strcmp(refname, "HEAD");
 }
 
-static int is_pseudoref(const char *refname)
+int is_pseudoref(const char *refname)
 {
 	const char *c;
 
@@ -4544,3 +4544,56 @@ int reflog_expire(const char *refname, const unsigned char *sha1,
 	unlock_ref(lock);
 	return -1;
 }
+
+void write_pseudoref(const char *pseudoref, const unsigned char *sha1,
+		     const unsigned char *old_sha1)
+{
+	const char *filename;
+	int fd;
+	static struct lock_file lock;
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addf(&buf, "%s\n", sha1_to_hex(sha1));
+
+	filename = git_path("%s", pseudoref);
+	fd = hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
+	if (fd < 0)
+		die_errno(_("Could not open '%s' for writing"), filename);
+
+	if (old_sha1) {
+		unsigned char actual_old_sha1[20];
+		read_ref(pseudoref, actual_old_sha1);
+		if (hashcmp(actual_old_sha1, old_sha1))
+			die("Unexpected sha1 when writing %s", pseudoref);
+	}
+	if (write_in_full(fd, buf.buf, buf.len) != buf.len)
+		die_errno(_("Could not write to '%s'"), filename);
+	strbuf_release(&buf);
+	commit_lock_file(&lock);
+}
+
+void delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1)
+{
+	static struct lock_file lock;
+	const char *filename;
+
+	filename = git_path("%s", pseudoref);
+
+	if (old_sha1) {
+		int fd;
+		unsigned char actual_old_sha1[20];
+
+		fd = hold_lock_file_for_update(&lock, filename,
+					       LOCK_DIE_ON_ERROR);
+		if (fd < 0)
+			die_errno(_("Could not open '%s' for writing"), filename);
+		read_ref(pseudoref, actual_old_sha1);
+		if (hashcmp(actual_old_sha1, old_sha1))
+			die("Unexpected sha1 when writing %s", pseudoref);
+
+		unlink(pseudoref);
+		rollback_lock_file(&lock);
+	} else {
+		unlink(pseudoref);
+	}
+}
diff --git a/refs.h b/refs.h
index bd5526e..450860b 100644
--- a/refs.h
+++ b/refs.h
@@ -441,6 +441,11 @@ int update_ref(const char *msg, const char *refname,
 	       const unsigned char *new_sha1, const unsigned char *old_sha1,
 	       unsigned int flags, enum action_on_err onerr);
 
+void write_pseudoref(const char *pseudoref, const unsigned char *sha1,
+		     const unsigned char *old_sha1);
+
+void delete_pseudoref(const char *pseudoref, const unsigned char *old_sha1);
+
 extern int parse_hide_refs_config(const char *var, const char *value, const char *);
 
 extern int ref_is_hidden(const char *);
diff --git a/sequencer.c b/sequencer.c
index c4f4b7d..c9fc9a7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -158,23 +158,6 @@ static void free_message(struct commit *commit, struct commit_message *msg)
 	unuse_commit_buffer(commit, msg->message);
 }
 
-static void write_cherry_pick_head(struct commit *commit, const char *pseudoref)
-{
-	const char *filename;
-	int fd;
-	struct strbuf buf = STRBUF_INIT;
-
-	strbuf_addf(&buf, "%s\n", sha1_to_hex(commit->object.sha1));
-
-	filename = git_path("%s", pseudoref);
-	fd = open(filename, O_WRONLY | O_CREAT, 0666);
-	if (fd < 0)
-		die_errno(_("Could not open '%s' for writing"), filename);
-	if (write_in_full(fd, buf.buf, buf.len) != buf.len || close(fd))
-		die_errno(_("Could not write to '%s'"), filename);
-	strbuf_release(&buf);
-}
-
 static void print_advice(int show_hint, struct replay_opts *opts)
 {
 	char *msg = getenv("GIT_CHERRY_PICK_HELP");
@@ -607,9 +590,9 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	 * write it at all.
 	 */
 	if (opts->action == REPLAY_PICK && !opts->no_commit && (res == 0 || res == 1))
-		write_cherry_pick_head(commit, "CHERRY_PICK_HEAD");
+		write_pseudoref("CHERRY_PICK_HEAD", commit->object.sha1, NULL);
 	if (opts->action == REPLAY_REVERT && ((opts->no_commit && res == 0) || res == 1))
-		write_cherry_pick_head(commit, "REVERT_HEAD");
+		write_pseudoref("REVERT_HEAD", commit->object.sha1, NULL);
 
 	if (res) {
 		error(opts->action == REPLAY_REVERT
-- 
2.0.4.315.gad8727a-twtrsrc
