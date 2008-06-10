From: Olivier Marin <dkr+ml.git@free.fr>
Subject: [PATCH 2/4] builtin-remote: split show_or_prune() in two separate functions
Date: Tue, 10 Jun 2008 16:51:21 +0200
Message-ID: <1213109481-6939-1-git-send-email-dkr+ml.git@free.fr>
References: <1213109413-6842-1-git-send-email-dkr+ml.git@free.fr>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 16:52:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K65Co-0004Bx-O0
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 16:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753074AbYFJOvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 10:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752977AbYFJOvR
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 10:51:17 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:50532 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752482AbYFJOvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 10:51:16 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 6C8EE12B70D;
	Tue, 10 Jun 2008 16:51:15 +0200 (CEST)
Received: from localhost.localdomain (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 1842412B6B7;
	Tue, 10 Jun 2008 16:51:14 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.160.gd660c
In-Reply-To: <1213109413-6842-1-git-send-email-dkr+ml.git@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84509>

From: Olivier Marin <dkr@freesurf.fr>

This allow us to add different features to each of them and keep the
code simple at the same time. Also create a get_remote_ref_states()
to avoid duplicated code.

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---
 builtin-remote.c |  101 +++++++++++++++++++++++++++++++++++------------------
 1 files changed, 67 insertions(+), 34 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index efe74c7..745a4ee 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -419,7 +419,32 @@ static void show_list(const char *title, struct path_list *list)
 	printf("\n");
 }
 
-static int show_or_prune(int argc, const char **argv, int prune)
+static int get_remote_ref_states(const char *name,
+				 struct ref_states *states,
+				 int query)
+{
+	struct transport *transport;
+	const struct ref *ref;
+
+	states->remote = remote_get(name);
+	if (!states->remote)
+		return error("No such remote: %s", name);
+
+	read_branches();
+
+	if (query) {
+		transport = transport_get(NULL, states->remote->url_nr > 0 ?
+			states->remote->url[0] : NULL);
+		ref = transport_get_remote_refs(transport);
+		transport_disconnect(transport);
+
+		get_ref_states(ref, states);
+	}
+
+	return 0;
+}
+
+static int show(int argc, const char **argv)
 {
 	int no_query = 0, result = 0;
 	struct option options[] = {
@@ -431,42 +456,15 @@ static int show_or_prune(int argc, const char **argv, int prune)
 
 	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
 
-	if (argc < 1) {
-		if (!prune)
-			return show_all();
-		usage_with_options(builtin_remote_usage, options);
-	}
+	if (argc < 1)
+		return show_all();
 
 	memset(&states, 0, sizeof(states));
 	for (; argc; argc--, argv++) {
-		struct transport *transport;
-		const struct ref *ref;
 		struct strbuf buf;
 		int i;
 
-		states.remote = remote_get(*argv);
-		if (!states.remote)
-			return error("No such remote: %s", *argv);
-
-		read_branches();
-
-		if (!no_query) {
-			transport = transport_get(NULL,
-				states.remote->url_nr > 0 ?
-				states.remote->url[0] : NULL);
-			ref = transport_get_remote_refs(transport);
-			transport_disconnect(transport);
-
-			get_ref_states(ref, &states);
-		}
-
-		if (prune) {
-			for (i = 0; i < states.stale.nr; i++) {
-				const char *refname = states.stale.items[i].util;
-				result |= delete_ref(refname, NULL);
-			}
-			goto cleanup_states;
-		}
+		get_remote_ref_states(*argv, &states, !no_query);
 
 		printf("* remote %s\n  URL: %s\n", *argv,
 			states.remote->url_nr > 0 ?
@@ -513,7 +511,42 @@ static int show_or_prune(int argc, const char **argv, int prune)
 			}
 			printf("\n");
 		}
-cleanup_states:
+
+		/* NEEDSWORK: free remote */
+		path_list_clear(&states.new, 0);
+		path_list_clear(&states.stale, 0);
+		path_list_clear(&states.tracked, 0);
+	}
+
+	return result;
+}
+
+static int prune(int argc, const char **argv)
+{
+	int no_query = 0, result = 0;
+	struct option options[] = {
+		OPT_GROUP("prune specific options"),
+		OPT_BOOLEAN('n', NULL, &no_query, "do not query remotes"),
+		OPT_END()
+	};
+	struct ref_states states;
+
+	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
+
+	if (argc < 1)
+		usage_with_options(builtin_remote_usage, options);
+
+	memset(&states, 0, sizeof(states));
+	for (; argc; argc--, argv++) {
+		int i;
+
+		get_remote_ref_states(*argv, &states, !no_query);
+
+		for (i = 0; i < states.stale.nr; i++) {
+			const char *refname = states.stale.items[i].util;
+			result |= delete_ref(refname, NULL);
+		}
+
 		/* NEEDSWORK: free remote */
 		path_list_clear(&states.new, 0);
 		path_list_clear(&states.stale, 0);
@@ -634,9 +667,9 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
 	else if (!strcmp(argv[0], "rm"))
 		result = rm(argc, argv);
 	else if (!strcmp(argv[0], "show"))
-		result = show_or_prune(argc, argv, 0);
+		result = show(argc, argv);
 	else if (!strcmp(argv[0], "prune"))
-		result = show_or_prune(argc, argv, 1);
+		result = prune(argc, argv);
 	else if (!strcmp(argv[0], "update"))
 		result = update(argc, argv);
 	else {
-- 
1.5.6.rc2.160.gd660c
