From: Olivier Marin <dkr+ml.git@free.fr>
Subject: [PATCH 1/4] remote show: fix the -n option
Date: Tue, 10 Jun 2008 16:51:08 +0200
Message-ID: <1213109468-6906-1-git-send-email-dkr+ml.git@free.fr>
References: <1213109413-6842-1-git-send-email-dkr+ml.git@free.fr>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 16:53:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K65Cc-00045J-RT
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 16:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbYFJOvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 10:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbYFJOvI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 10:51:08 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:50329 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752912AbYFJOvG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 10:51:06 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id A151312B6C7;
	Tue, 10 Jun 2008 16:51:03 +0200 (CEST)
Received: from localhost.localdomain (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 3A53412B726;
	Tue, 10 Jun 2008 16:51:02 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.160.gd660c
In-Reply-To: <1213109413-6842-1-git-send-email-dkr+ml.git@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84511>

From: Olivier Marin <dkr@freesurf.fr>

The perl version accepted a -n flag, to show local informations only
without querying remote heads, that seems to have been lost in the C
revrite.

This restores the older behaviour and add a test case.

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---
 Documentation/git-remote.txt |    2 +-
 builtin-remote.c             |   44 +++++++++++++++++++++--------------------
 t/t5505-remote.sh            |   17 ++++++++++++++++
 3 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index 782b055..7bd024e 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git-remote' [-v | --verbose]
 'git-remote' add [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
 'git-remote' rm <name>
-'git-remote' show <name>
+'git-remote' show [-n] <name>
 'git-remote' prune <name>
 'git-remote' update [group]
 
diff --git a/builtin-remote.c b/builtin-remote.c
index c49f00f..efe74c7 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -421,10 +421,10 @@ static void show_list(const char *title, struct path_list *list)
 
 static int show_or_prune(int argc, const char **argv, int prune)
 {
-	int dry_run = 0, result = 0;
+	int no_query = 0, result = 0;
 	struct option options[] = {
 		OPT_GROUP("show specific options"),
-		OPT__DRY_RUN(&dry_run),
+		OPT_BOOLEAN('n', NULL, &no_query, "do not query remotes"),
 		OPT_END()
 	};
 	struct ref_states states;
@@ -442,21 +442,23 @@ static int show_or_prune(int argc, const char **argv, int prune)
 		struct transport *transport;
 		const struct ref *ref;
 		struct strbuf buf;
-		int i, got_states;
+		int i;
 
 		states.remote = remote_get(*argv);
 		if (!states.remote)
 			return error("No such remote: %s", *argv);
-		transport = transport_get(NULL, states.remote->url_nr > 0 ?
-			states.remote->url[0] : NULL);
-		ref = transport_get_remote_refs(transport);
-		transport_disconnect(transport);
 
 		read_branches();
-		got_states = get_ref_states(ref, &states);
-		if (got_states)
-			result = error("Error getting local info for '%s'",
-					states.remote->name);
+
+		if (!no_query) {
+			transport = transport_get(NULL,
+				states.remote->url_nr > 0 ?
+				states.remote->url[0] : NULL);
+			ref = transport_get_remote_refs(transport);
+			transport_disconnect(transport);
+
+			get_ref_states(ref, &states);
+		}
 
 		if (prune) {
 			for (i = 0; i < states.stale.nr; i++) {
@@ -486,17 +488,17 @@ static int show_or_prune(int argc, const char **argv, int prune)
 			printf("\n");
 		}
 
-		if (got_states)
-			continue;
-		strbuf_init(&buf, 0);
-		strbuf_addf(&buf, "  New remote branch%%s (next fetch will "
-			"store in remotes/%s)", states.remote->name);
-		show_list(buf.buf, &states.new);
-		strbuf_release(&buf);
-		show_list("  Stale tracking branch%s (use 'git remote prune')",
-				&states.stale);
-		show_list("  Tracked remote branch%s",
+		if (!no_query) {
+			strbuf_init(&buf, 0);
+			strbuf_addf(&buf, "  New remote branch%%s (next fetch "
+				"will store in remotes/%s)", states.remote->name);
+			show_list(buf.buf, &states.new);
+			strbuf_release(&buf);
+			show_list("  Stale tracking branch%s (use 'git remote "
+				"prune')", &states.stale);
+			show_list("  Tracked remote branch%s",
 				&states.tracked);
+		}
 
 		if (states.remote->push_refspec_nr) {
 			printf("  Local branch%s pushed with 'git push'\n   ",
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 0d7ed1f..c6a7bfb 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -138,6 +138,23 @@ test_expect_success 'show' '
 	 test_cmp expect output)
 '
 
+cat > test/expect << EOF
+* remote origin
+  URL: $(pwd)/one/.git
+  Remote branch merged with 'git pull' while on branch master
+    master
+  Local branches pushed with 'git push'
+    master:upstream +refs/tags/lastbackup
+EOF
+
+test_expect_success 'show -n' '
+	(mv one one.unreachable &&
+	 cd test &&
+	 git remote show -n origin > output &&
+	 mv ../one.unreachable ../one &&
+	 test_cmp expect output)
+'
+
 test_expect_success 'prune' '
 	(cd one &&
 	 git branch -m side side2) &&
-- 
1.5.6.rc2.160.gd660c
