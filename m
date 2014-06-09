From: Jeff King <peff@peff.net>
Subject: [PATCH 06/15] provide a helper to free commit buffer
Date: Mon, 9 Jun 2014 14:11:09 -0400
Message-ID: <20140609181109.GF20315@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 20:11:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu42N-0007F8-C1
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 20:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbaFISLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 14:11:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:40359 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753745AbaFISLL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 14:11:11 -0400
Received: (qmail 15762 invoked by uid 102); 9 Jun 2014 18:11:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jun 2014 13:11:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jun 2014 14:11:09 -0400
Content-Disposition: inline
In-Reply-To: <20140609180236.GA24644@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251092>

This converts two lines into one at each caller. But more
importantly, it abstracts the concept of freeing the buffer,
which will make it easier to change later.

Note that we also need to provide a "detach" mechanism for
the weird case in fsck which passes the buffer back to be
freed.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c       |  3 +--
 builtin/index-pack.c |  2 +-
 builtin/log.c        |  6 ++----
 builtin/rev-list.c   |  3 +--
 commit.c             | 13 +++++++++++++
 commit.h             | 11 +++++++++++
 6 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index fc150c8..8aadca1 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -310,8 +310,7 @@ static int fsck_obj(struct object *obj)
 	if (obj->type == OBJ_COMMIT) {
 		struct commit *commit = (struct commit *) obj;
 
-		free(commit->buffer);
-		commit->buffer = NULL;
+		free_commit_buffer(commit);
 
 		if (!commit->parents && show_root)
 			printf("root %s\n", sha1_to_hex(commit->object.sha1));
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 18f57de..995df39 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -786,7 +786,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			}
 			if (obj->type == OBJ_COMMIT) {
 				struct commit *commit = (struct commit *) obj;
-				commit->buffer = NULL;
+				detach_commit_buffer(commit);
 			}
 			obj->flags |= FLAG_CHECKED;
 		}
diff --git a/builtin/log.c b/builtin/log.c
index 39e8836..226f8f2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -349,8 +349,7 @@ static int cmd_log_walk(struct rev_info *rev)
 			rev->max_count++;
 		if (!rev->reflog_info) {
 			/* we allow cycles in reflog ancestry */
-			free(commit->buffer);
-			commit->buffer = NULL;
+			free_commit_buffer(commit);
 		}
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
@@ -1508,8 +1507,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		    reopen_stdout(rev.numbered_files ? NULL : commit, NULL, &rev, quiet))
 			die(_("Failed to create output files"));
 		shown = log_tree_commit(&rev, commit);
-		free(commit->buffer);
-		commit->buffer = NULL;
+		free_commit_buffer(commit);
 
 		/* We put one extra blank line between formatted
 		 * patches and this flag is used by log-tree code
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 9f92905..e012ebe 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -173,8 +173,7 @@ static void finish_commit(struct commit *commit, void *data)
 		free_commit_list(commit->parents);
 		commit->parents = NULL;
 	}
-	free(commit->buffer);
-	commit->buffer = NULL;
+	free_commit_buffer(commit);
 }
 
 static void finish_object(struct object *obj,
diff --git a/commit.c b/commit.c
index 21957ee..d7b6836 100644
--- a/commit.c
+++ b/commit.c
@@ -245,6 +245,19 @@ int unregister_shallow(const unsigned char *sha1)
 	return 0;
 }
 
+void free_commit_buffer(struct commit *commit)
+{
+	free(commit->buffer);
+	commit->buffer = NULL;
+}
+
+const void *detach_commit_buffer(struct commit *commit)
+{
+	void *ret = commit->buffer;
+	commit->buffer = NULL;
+	return ret;
+}
+
 int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size)
 {
 	const char *tail = buffer;
diff --git a/commit.h b/commit.h
index de57df9..daccf46 100644
--- a/commit.h
+++ b/commit.h
@@ -51,6 +51,17 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 int parse_commit(struct commit *item);
 void parse_commit_or_die(struct commit *item);
 
+/*
+ * Free any cached object buffer associated with the commit.
+ */
+void free_commit_buffer(struct commit *);
+
+/*
+ * Disassociate any cached object buffer from the commit, but do not free it.
+ * The buffer (or NULL, if none) is returned.
+ */
+const void *detach_commit_buffer(struct commit *);
+
 /* Find beginning and length of commit subject. */
 int find_commit_subject(const char *commit_buffer, const char **subject);
 
-- 
2.0.0.729.g520999f
