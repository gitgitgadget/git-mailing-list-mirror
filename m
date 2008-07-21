From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] builtin-merge: give a proper error message for invalid strategies in config
Date: Mon, 21 Jul 2008 18:10:47 +0200
Message-ID: <1216656647-16897-1-git-send-email-vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 18:11:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKxyu-0008H2-8Y
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 18:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbYGUQKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 12:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbYGUQKY
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 12:10:24 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:55095 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbYGUQKX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 12:10:23 -0400
Received: from vmobile.example.net (dsl5401C482.pool.t-online.hu [84.1.196.130])
	by yugo.frugalware.org (Postfix) with ESMTP id 589601DDC5B;
	Mon, 21 Jul 2008 18:10:21 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 585A91AA738; Mon, 21 Jul 2008 18:10:48 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.4.433.g09651.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89363>

Till now 'git merge -s foobar' bailed out with an error message, but
foobar in pull.twohead or pull.octopus was just silently ignored. It's
better to inform the user then just silently doing nothing.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-merge.c              |   35 +++++++++++++++--------------------
 t/t7601-merge-pull-config.sh |    6 ++++++
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index e97c79e..5037acf 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -93,28 +93,13 @@ static void append_strategy(struct strategy *s)
 	use_strategies[use_strategies_nr++] = s;
 }
 
+static void add_strategies(const char *string, unsigned attr);
+
 static int option_parse_strategy(const struct option *opt,
 				 const char *name, int unset)
 {
-	int i;
-	struct strategy *s;
-
-	if (unset)
-		return 0;
-
-	s = get_strategy(name);
-
-	if (s)
-		append_strategy(s);
-	else {
-		struct strbuf err;
-		strbuf_init(&err, 0);
-		for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
-			strbuf_addf(&err, " %s", all_strategy[i].name);
-		fprintf(stderr, "Could not find merge strategy '%s'.\n", name);
-		fprintf(stderr, "Available strategies are:%s.\n", err.buf);
-		exit(1);
-	}
+	if (!unset)
+		add_strategies(name, 0);
 	return 0;
 }
 
@@ -639,7 +624,7 @@ static void split_merge_strategies(const char *string, struct strategy **list,
 static void add_strategies(const char *string, unsigned attr)
 {
 	struct strategy *list = NULL;
-	int list_alloc = 0, list_nr = 0, i;
+	int list_alloc = 0, list_nr = 0, i, j;
 
 	memset(&list, 0, sizeof(list));
 	split_merge_strategies(string, &list, &list_nr, &list_alloc);
@@ -650,6 +635,16 @@ static void add_strategies(const char *string, unsigned attr)
 			s = get_strategy(list[i].name);
 			if (s)
 				append_strategy(s);
+			else {
+				struct strbuf err;
+
+				strbuf_init(&err, 0);
+				for (j = 0; j < ARRAY_SIZE(all_strategy); j++)
+					strbuf_addf(&err, " %s", all_strategy[j].name);
+				fprintf(stderr, "Could not find merge strategy '%s'.\n", list[i].name);
+				fprintf(stderr, "Available strategies are:%s.\n", err.buf);
+				exit(1);
+			}
 		}
 		return;
 	}
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 95b4d71..ca63451 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -126,4 +126,10 @@ test_expect_success 'merge picks up the best result' '
 	test $auto_count != $resolve_count
 '
 
+test_expect_success 'merge errors out on invalid strategy' '
+	git config pull.twohead "foobar" &&
+	git reset --hard c5 &&
+	test_must_fail git merge c6
+'
+
 test_done
-- 
1.5.6.4.433.g09651.dirty
