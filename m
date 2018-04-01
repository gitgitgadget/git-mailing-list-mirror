Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 006A61F404
	for <e@80x24.org>; Sun,  1 Apr 2018 20:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753945AbeDAU5X (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 16:57:23 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:35554
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751028AbeDAU5W (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Apr 2018 16:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1522616241;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=2V6jMAVmvFpMz9TmbLD9mnHMQ+/xX13TAADx27b536c=;
        b=NY5M6DlyVysAmMnE0EtRhrmwcnDbpuNQ54RmfTtZast5nfak690WWdmQ1RdbecQl
        z9JapC6fVmc4QehNZZcucSZbDJY96/mB4Omc17adU5GJXj2I3jpc1h4shzqKRJw8jZR
        NUkg7mwmtnWDLdcGWkYF6QUgz2+exMkPa6OIaN4A=
From:   Lyubomyr Shaydariv <lsh.dev@ukr.net>
To:     git@vger.kernel.org
Message-ID: <0102016283000c69-b09d1499-8a50-45a7-9f41-01be648398bc-000000@eu-west-1.amazonses.com>
Subject: [PATCH] graph.c: log.showRootMark to indicate root commits
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sun, 1 Apr 2018 20:57:21 +0000
X-SES-Outgoing: 2018.04.01-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When log.showRootMark is set, root commits are marked with
the at sign (@).

When log.showRootMark is not set, root commits are marked with
the asterisk sign (*). This is the default behavior.

Signed-off-by: Lyubomyr Shaydariv <lsh.dev@ukr.net>
---
 Documentation/config.txt  |  5 +++++
 Documentation/git-log.txt |  5 +++++
 graph.c                   | 20 ++++++++++++++++++++
 t/t4202-log.sh            | 16 ++++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4e0cff87f62f5..0a32357e3c625 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2254,6 +2254,11 @@ log.showRoot::
 	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
 	normally hide the root commit will now show it. True by default.
 
+log.showRootMark::
+	If true, the initial commit in `git log --graph` will be marked
+	with the at sign (`@`). Otherwise the initial commit will be
+	marked with the default asterisk sign (`*`). False by default.
+
 log.showSignature::
 	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
 	linkgit:git-whatchanged[1] assume `--show-signature`.
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 5437f8b0f0e66..7f5436231b6d7 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -205,6 +205,11 @@ log.showRoot::
 	`git log -p` output would be shown without a diff attached.
 	The default is `true`.
 
+log.showRootMark::
+	If true, the initial commit in `git log --graph` will be marked
+	with the at sign (`@`). Otherwise the initial commit will be
+	marked with the default asterisk sign (`*`). False by default.
+
 log.showSignature::
 	If `true`, `git log` and related commands will act as if the
 	`--show-signature` option was passed to them.
diff --git a/graph.c b/graph.c
index e1f6d3bddb38a..d14ffec7a975c 100644
--- a/graph.c
+++ b/graph.c
@@ -80,6 +80,7 @@ static void graph_show_line_prefix(const struct diff_options *diffopt)
 
 static const char **column_colors;
 static unsigned short column_colors_max;
+static int show_root_mark;
 
 static void parse_graph_colors_config(struct argv_array *colors, const char *string)
 {
@@ -256,6 +257,16 @@ void graph_setup_line_prefix(struct diff_options *diffopt)
 }
 
 
+static int git_graph_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "log.showrootmark")) {
+		show_root_mark = git_config_bool(var, value);
+		return 0;
+	}
+
+	return git_default_config(var, value, cb);
+}
+
 struct git_graph *graph_init(struct rev_info *opt)
 {
 	struct git_graph *graph = xmalloc(sizeof(struct git_graph));
@@ -276,6 +287,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 						custom_colors.argc - 1);
 		}
 	}
+	git_config(git_graph_config, NULL);
 
 	graph->commit = NULL;
 	graph->revs = opt;
@@ -835,6 +847,14 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
 		return;
 	}
 
+	/*
+	 * If the commit has no parents, it's a root commit
+	 */
+	if (show_root_mark && !graph->num_parents) {
+		strbuf_addch(sb, '@');
+		return;
+	}
+
 	/*
 	 * get_revision_mark() handles all other cases without assert()
 	 */
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 25b1f8cc73bc3..350e35264362f 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -455,6 +455,22 @@ test_expect_success 'simple log --graph' '
 	test_cmp expect actual
 '
 
+cat > expect <<EOF
+* Second
+* sixth
+* fifth
+* fourth
+* third
+* second
+@ initial
+EOF
+
+test_expect_success 'simple log --graph' '
+	test_config log.showRootMark true &&
+	git log --graph --pretty=tformat:%s >actual &&
+	test_cmp expect actual
+'
+
 cat > expect <<EOF
 123 * Second
 123 * sixth

--
https://github.com/git/git/pull/478
