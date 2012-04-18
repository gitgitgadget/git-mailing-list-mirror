From: Lucian Poston <lucian.poston@gmail.com>
Subject: [PATCH v4 2/4] Adjust stat width calculations to take --graph output into account
Date: Tue, 17 Apr 2012 19:29:48 -0700
Message-ID: <1334716196-9870-2-git-send-email-lucian.poston@gmail.com>
References: <1334716196-9870-1-git-send-email-lucian.poston@gmail.com>
Cc: Lucian Poston <lucian.poston@gmail.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 18 04:31:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKKgU-0001QH-Sz
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 04:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568Ab2DRCbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 22:31:50 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:55215 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab2DRCbu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 22:31:50 -0400
Received: by dake40 with SMTP id e40so9159968dak.11
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 19:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=mJB04nt0t2LgIb+QGO0ZNs/HDoY/Pjw6bNKZqGSvVxI=;
        b=WFNGTseoA9YhWm24kImP6qnsFB5tQDIFkt1nw/nUKyQar1UY+zfjJFxsvt81C5hwg0
         3CNPMxDN8sGEbaupmcF+zXADzojNXHBcWv+RVMFuH5JxdEGqhEYB6YTV5oETAv8OC79a
         xweONZ99QMB85QaQhtdh0wQ5b7x/f04VP9tsREn7HebdWSwBS++PeqHo4EfqS6fCY7vr
         ocHkErqqlQVtF2XLGc9/yntQHa8kaDZVzZX6QoSgtP8UObE53R6/Hv/X1nNHXzEG3zZR
         ldeuuthDdWbW7r8WK481Kw2xYFMB/+UUJC2D0ATs5mOpoFqRbsuFuFk+ZIIqGkCPMOH1
         A7fA==
Received: by 10.68.218.38 with SMTP id pd6mr2164809pbc.141.1334716309602;
        Tue, 17 Apr 2012 19:31:49 -0700 (PDT)
Received: from localhost.localdomain (c-76-121-54-246.hsd1.wa.comcast.net. [76.121.54.246])
        by mx.google.com with ESMTPS id vh6sm2178424pbc.25.2012.04.17.19.31.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Apr 2012 19:31:49 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1334716196-9870-1-git-send-email-lucian.poston@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195833>

The recent change to compute the width of diff --stat did not take into
consideration the output from --graph. The consequence is that when both
options are used, e.g. in 'log --stat --graph', the lines are too long.

Add output_prefix_length to diff_options. Initialize the value to 0 and only
set it when graph.c:diff_output_prefix_callback() is called.

Using output_prefix_length, adjust stat width calculations to take --graph
output into account.

t4052: Modify tests to verify that diff stat output is adjusted to compenstate
for the history graph tree.

Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
---
 diff.c                 |    2 +-
 diff.h                 |    1 +
 graph.c                |    3 +++
 t/t4052-stat-output.sh |   34 +++++++++++++++++++++++++---------
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index 377ec1e..0b61cf7 100644
--- a/diff.c
+++ b/diff.c
@@ -1445,7 +1445,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 */
 
 	if (options->stat_width == -1)
-		width = term_columns();
+		width = term_columns() - options->output_prefix_length;
 	else
 		width = options->stat_width ? options->stat_width : 80;
 
diff --git a/diff.h b/diff.h
index cb68743..19d762f 100644
--- a/diff.h
+++ b/diff.h
@@ -150,6 +150,7 @@ struct diff_options {
 	diff_format_fn_t format_callback;
 	void *format_callback_data;
 	diff_prefix_fn_t output_prefix;
+	int output_prefix_length;
 	void *output_prefix_data;
 };
 
diff --git a/graph.c b/graph.c
index 7358416..7e0a099 100644
--- a/graph.c
+++ b/graph.c
@@ -194,8 +194,10 @@ static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void
 	struct git_graph *graph = data;
 	static struct strbuf msgbuf = STRBUF_INIT;
 
+	assert(opt);
 	assert(graph);
 
+	opt->output_prefix_length = graph->width;
 	strbuf_reset(&msgbuf);
 	graph_padding_line(graph, &msgbuf);
 	return &msgbuf;
@@ -245,6 +247,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	 */
 	opt->diffopt.output_prefix = diff_output_prefix_callback;
 	opt->diffopt.output_prefix_data = graph;
+	opt->diffopt.output_prefix_length = 0;
 
 	return graph;
 }
diff --git a/t/t4052-stat-output.sh b/t/t4052-stat-output.sh
index da14984..d748e5e 100755
--- a/t/t4052-stat-output.sh
+++ b/t/t4052-stat-output.sh
@@ -89,7 +89,7 @@ cat >expect200 <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
 cat >expect200-graph <<'EOF'
-|  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+|  abcd | 1000 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
 while read verb expect cmd args
 do
@@ -117,7 +117,7 @@ cat >expect40 <<'EOF'
  abcd | 1000 ++++++++++++++++++++++++++
 EOF
 cat >expect40-graph <<'EOF'
-|  abcd | 1000 ++++++++++++++++++++++++++
+|  abcd | 1000 ++++++++++++++++++++++++
 EOF
 while read verb expect cmd args
 do
@@ -127,12 +127,6 @@ do
 		test_cmp "$expect" actual
 	'
 
-	test_expect_success "$cmd $verb statGraphWidth config" '
-		git -c diff.statGraphWidth=26 $cmd $args >output
-		grep " | " output >actual &&
-		test_cmp "$expect" actual
-	'
-
 	test "$cmd" != diff || continue
 
 	test_expect_success "$cmd --graph $verb not enough COLUMNS (big change)" '
@@ -140,6 +134,28 @@ do
 		grep " | " output >actual &&
 		test_cmp "$expect-graph" actual
 	'
+done <<\EOF
+ignores expect80 format-patch -1 --stdout
+respects expect40 diff HEAD^ HEAD --stat
+respects expect40 show --stat
+respects expect40 log -1 --stat
+EOF
+
+cat >expect40 <<'EOF'
+ abcd | 1000 ++++++++++++++++++++++++++
+EOF
+cat >expect40-graph <<'EOF'
+|  abcd | 1000 ++++++++++++++++++++++++++
+EOF
+while read verb expect cmd args
+do
+	test_expect_success "$cmd $verb statGraphWidth config" '
+		git -c diff.statGraphWidth=26 $cmd $args >output
+		grep " | " output >actual &&
+		test_cmp "$expect" actual
+	'
+
+	test "$cmd" != diff || continue
 
 	test_expect_success "$cmd --graph $verb statGraphWidth config" '
 		git -c diff.statGraphWidth=26 $cmd $args --graph >output
@@ -244,7 +260,7 @@ cat >expect200 <<'EOF'
  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
 cat >expect200-graph <<'EOF'
-|  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+|  aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | 1000 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 EOF
 while read verb expect cmd args
 do
-- 
1.7.3.4
