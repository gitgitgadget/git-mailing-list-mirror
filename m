From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v6 3/4] Refactor submodule push check to use string list instead of integer
Date: Thu, 29 Mar 2012 09:21:23 +0200
Message-ID: <1762667f5d46192f001cc64d71d96dea142742ae.1332968667.git.hvoigt@hvoigt.net>
References: <cover.1332968667.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org, Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <jens.lehmann@web.de>,
	Zbigniew J??drzejewski-Szmek <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 09:22:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD9gR-0002Ub-IB
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 09:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758729Ab2C2HWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 03:22:09 -0400
Received: from darksea.de ([83.133.111.250]:34921 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758717Ab2C2HWH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 03:22:07 -0400
Received: (qmail 32093 invoked from network); 29 Mar 2012 09:22:05 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 29 Mar 2012 09:22:05 +0200
X-Mailer: git-send-email 1.7.10.rc2.31.gd8c60
In-Reply-To: <cover.1332968667.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1332968667.git.hvoigt@hvoigt.net>
References: <cover.1332968667.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194238>

This allows us to tell the user which submodules have not been pushed.
Additionally this is helpful when we want to automatically try to push
submodules that have not been pushed.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 submodule.c |   23 +++++++++++------------
 submodule.h |    3 ++-
 transport.c |   24 ++++++++++++++++++++++--
 3 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/submodule.c b/submodule.c
index 645ff5d..fa7d5f4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -357,21 +357,19 @@ static void collect_submodules_from_diff(struct diff_queue_struct *q,
 					 void *data)
 {
 	int i;
-	int *needs_pushing = data;
+	struct string_list *needs_pushing = data;
 
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		if (!S_ISGITLINK(p->two->mode))
 			continue;
-		if (submodule_needs_pushing(p->two->path, p->two->sha1)) {
-			*needs_pushing = 1;
-			break;
-		}
+		if (submodule_needs_pushing(p->two->path, p->two->sha1))
+			string_list_insert(needs_pushing, p->two->path);
 	}
 }
 
-
-static void commit_need_pushing(struct commit *commit, int *needs_pushing)
+static void find_unpushed_submodule_commits(struct commit *commit,
+		struct string_list *needs_pushing)
 {
 	struct rev_info rev;
 
@@ -382,14 +380,15 @@ static void commit_need_pushing(struct commit *commit, int *needs_pushing)
 	diff_tree_combined_merge(commit, 1, &rev);
 }
 
-int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remotes_name)
+int find_unpushed_submodules(unsigned char new_sha1[20],
+		const char *remotes_name, struct string_list *needs_pushing)
 {
 	struct rev_info rev;
 	struct commit *commit;
 	const char *argv[] = {NULL, NULL, "--not", "NULL", NULL};
 	int argc = ARRAY_SIZE(argv) - 1;
 	char *sha1_copy;
-	int needs_pushing = 0;
+
 	struct strbuf remotes_arg = STRBUF_INIT;
 
 	strbuf_addf(&remotes_arg, "--remotes=%s", remotes_name);
@@ -401,14 +400,14 @@ int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remote
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
 
-	while ((commit = get_revision(&rev)) && !needs_pushing)
-		commit_need_pushing(commit, &needs_pushing);
+	while ((commit = get_revision(&rev)) != NULL)
+		find_unpushed_submodule_commits(commit, needs_pushing);
 
 	reset_revision_walk();
 	free(sha1_copy);
 	strbuf_release(&remotes_arg);
 
-	return needs_pushing;
+	return needs_pushing->nr;
 }
 
 static int is_submodule_commit_present(const char *path, unsigned char sha1[20])
diff --git a/submodule.h b/submodule.h
index 80e04f3..fd58690 100644
--- a/submodule.h
+++ b/submodule.h
@@ -29,6 +29,7 @@ int fetch_populated_submodules(int num_options, const char **options,
 unsigned is_submodule_modified(const char *path, int ignore_untracked);
 int merge_submodule(unsigned char result[20], const char *path, const unsigned char base[20],
 		    const unsigned char a[20], const unsigned char b[20], int search);
-int check_submodule_needs_pushing(unsigned char new_sha1[20], const char *remotes_name);
+int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name,
+		struct string_list *needs_pushing);
 
 #endif
diff --git a/transport.c b/transport.c
index 181f8f2..a095290 100644
--- a/transport.c
+++ b/transport.c
@@ -11,6 +11,7 @@
 #include "branch.h"
 #include "url.h"
 #include "submodule.h"
+#include "string-list.h"
 
 /* rsync support */
 
@@ -1004,6 +1005,20 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 		transport->progress = verbosity >= 0 && isatty(2);
 }
 
+static void die_with_unpushed_submodules(struct string_list *needs_pushing)
+{
+	int i;
+
+	fprintf(stderr, "The following submodule paths contain changes that can\n"
+			"not be found on any remote:\n");
+	for (i = 0; i < needs_pushing->nr; i++)
+		printf("  %s\n", needs_pushing->items[i].string);
+
+	string_list_clear(needs_pushing, 0);
+
+	die("Aborting.");
+}
+
 int transport_push(struct transport *transport,
 		   int refspec_nr, const char **refspec, int flags,
 		   int *nonfastforward)
@@ -1046,10 +1061,15 @@ int transport_push(struct transport *transport,
 
 		if ((flags & TRANSPORT_RECURSE_SUBMODULES_CHECK) && !is_bare_repository()) {
 			struct ref *ref = remote_refs;
+			struct string_list needs_pushing;
+
+			memset(&needs_pushing, 0, sizeof(struct string_list));
+			needs_pushing.strdup_strings = 1;
 			for (; ref; ref = ref->next)
 				if (!is_null_sha1(ref->new_sha1) &&
-				    check_submodule_needs_pushing(ref->new_sha1,transport->remote->name))
-					die("There are unpushed submodules, aborting.");
+				    find_unpushed_submodules(ref->new_sha1,
+					    transport->remote->name, &needs_pushing))
+					die_with_unpushed_submodules(&needs_pushing);
 		}
 
 		push_ret = transport->push_refs(transport, remote_refs, flags);
-- 
1.7.10.rc2.31.gd8c60
