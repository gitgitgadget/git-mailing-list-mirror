From: Olivier Marin <dkr+ml.git@free.fr>
Subject: [PATCH v2] remote show: fix the -n option
Date: Mon, 09 Jun 2008 17:58:26 +0200
Message-ID: <484D5322.6050309@free.fr>
References: <484B2DD3.8050307@free.fr> <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr> <7v63sjk6yo.fsf@gitster.siamese.dyndns.org> <484C7CBE.4070700@free.fr> <484C7DCC.6080303@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 17:59:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5jmW-0007Rp-9g
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 17:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461AbYFIP62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 11:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752436AbYFIP62
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 11:58:28 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:33953 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157AbYFIP61 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 11:58:27 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 42BBB12B76A;
	Mon,  9 Jun 2008 17:58:26 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id EE51C12B6F4;
	Mon,  9 Jun 2008 17:58:25 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <484C7DCC.6080303@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84396>

From: Olivier Marin <dkr@freesurf.fr>

The perl version accepted a -n flag, to show local informations only
without querying remote heads, that seems to have been lost in the C
revrite.

This restores the older behaviour and add a test case.

Signed-off-by: Olivier Marin <dkr@freesurf.fr>
---
 builtin-remote.c  |   44 +++++++++++++++++++++++---------------------
 t/t5505-remote.sh |   17 +++++++++++++++++
 2 files changed, 40 insertions(+), 21 deletions(-)

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
