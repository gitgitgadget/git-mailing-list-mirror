From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/2] merge-recursive: move call_depth to struct merge_options
Date: Wed,  3 Sep 2008 00:05:32 +0200
Message-ID: <b96b1e10babd379daea483e72d99d8e520e34506.1220392547.git.vmiklos@frugalware.org>
References: <cover.1220392547.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 00:06:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kae1O-00039s-PJ
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 00:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbYIBWFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 18:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752921AbYIBWFk
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 18:05:40 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:47075 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbYIBWFj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 18:05:39 -0400
Received: from vmobile.example.net (dsl5401C449.pool.t-online.hu [84.1.196.73])
	by yugo.frugalware.org (Postfix) with ESMTP id E4ED31DDC5B;
	Wed,  3 Sep 2008 00:05:35 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 1ED4184C9; Wed,  3 Sep 2008 00:05:33 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.1
In-Reply-To: <cover.1220392547.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1220392547.git.vmiklos@frugalware.org>
References: <cover.1220392547.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94725>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 merge-recursive.c |   25 ++++++++++++-------------
 merge-recursive.h |    1 +
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 457ad84..5bb20aa 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -80,12 +80,11 @@ struct stage_data
 static struct string_list current_file_set = {NULL, 0, 0, 1};
 static struct string_list current_directory_set = {NULL, 0, 0, 1};
 
-static int call_depth = 0;
 static struct strbuf obuf = STRBUF_INIT;
 
 static int show(struct merge_options *o, int v)
 {
-	return (!call_depth && o->verbosity >= v) || o->verbosity >= 5;
+	return (!o->call_depth && o->verbosity >= v) || o->verbosity >= 5;
 }
 
 static void flush_output(void)
@@ -104,9 +103,9 @@ static void output(struct merge_options *o, int v, const char *fmt, ...)
 	if (!show(o, v))
 		return;
 
-	strbuf_grow(&obuf, call_depth * 2 + 2);
-	memset(obuf.buf + obuf.len, ' ', call_depth * 2);
-	strbuf_setlen(&obuf, obuf.len + call_depth * 2);
+	strbuf_grow(&obuf, o->call_depth * 2 + 2);
+	memset(obuf.buf + obuf.len, ' ', o->call_depth * 2);
+	strbuf_setlen(&obuf, obuf.len + o->call_depth * 2);
 
 	va_start(ap, fmt);
 	len = vsnprintf(obuf.buf + obuf.len, strbuf_avail(&obuf), fmt, ap);
@@ -129,11 +128,11 @@ static void output(struct merge_options *o, int v, const char *fmt, ...)
 		flush_output();
 }
 
-static void output_commit_title(struct commit *commit)
+static void output_commit_title(struct merge_options *o, struct commit *commit)
 {
 	int i;
 	flush_output();
-	for (i = call_depth; i--;)
+	for (i = o->call_depth; i--;)
 		fputs("  ", stdout);
 	if (commit->util)
 		printf("virtual %s\n", (char *)commit->util);
@@ -1230,8 +1229,8 @@ int merge_recursive(struct merge_options *o,
 
 	if (show(o, 4)) {
 		output(o, 4, "Merging:");
-		output_commit_title(h1);
-		output_commit_title(h2);
+		output_commit_title(o, h1);
+		output_commit_title(o, h2);
 	}
 
 	if (!ca) {
@@ -1242,7 +1241,7 @@ int merge_recursive(struct merge_options *o,
 	if (show(o, 5)) {
 		output(o, 5, "found %u common ancestor(s):", commit_list_count(ca));
 		for (iter = ca; iter; iter = iter->next)
-			output_commit_title(iter->item);
+			output_commit_title(o, iter->item);
 	}
 
 	merged_common_ancestors = pop_commit(&ca);
@@ -1258,7 +1257,7 @@ int merge_recursive(struct merge_options *o,
 
 	for (iter = ca; iter; iter = iter->next) {
 		const char *saved_b1, *saved_b2;
-		call_depth++;
+		o->call_depth++;
 		/*
 		 * When the merge fails, the result contains files
 		 * with conflict markers. The cleanness flag is
@@ -1275,14 +1274,14 @@ int merge_recursive(struct merge_options *o,
 				NULL, &merged_common_ancestors);
 		o->branch1 = saved_b1;
 		o->branch2 = saved_b2;
-		call_depth--;
+		o->call_depth--;
 
 		if (!merged_common_ancestors)
 			die("merge returned no commit");
 	}
 
 	discard_cache();
-	if (!call_depth) {
+	if (!o->call_depth) {
 		read_cache();
 		index_only = 0;
 	} else
diff --git a/merge-recursive.h b/merge-recursive.h
index 72f0a28..4f55374 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -9,6 +9,7 @@ struct merge_options {
 	int verbosity;
 	int diff_rename_limit;
 	int merge_rename_limit;
+	int call_depth;
 };
 
 /* merge_trees() but with recursive ancestor consolidation */
-- 
1.6.0.1
