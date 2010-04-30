From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH v3 2/5] pretty: make %H/%h/etc respect --abbrev[-commit]
Date: Fri, 30 Apr 2010 20:35:25 +0100
Message-ID: <1272656128-2002-3-git-send-email-wmpalmer@gmail.com>
References: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com, peff@peff.net,
	raa.lkml@gmail.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 30 21:38:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7w2x-0008Of-Hs
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 21:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649Ab0D3Tgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 15:36:47 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:47873 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757495Ab0D3Tgj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 15:36:39 -0400
Received: by wwb34 with SMTP id 34so447610wwb.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 12:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=l97WLzppDSO4yAgGfavUuyekhDl0m9g7wHQlOpdFZkA=;
        b=W1P5DwoD4jX9QdS+mE86zpio7oO6KJEnII5I99TiamkfISTlfq9EDecicgGsFJExBn
         dhbd2KxXz/EZgpOHqiFi6kta52Og2nEMUXMIWR8qZ4nT0zOOczLbNmA8utt+lLaXDUsv
         OccBxZcyOvhqXYEzpO/sx0O7rWpATTElGmg8s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VVQE3ZZKQ2h0KeUQ1O/Pc61XgY2iqnasawbkFuXXxYu3uZUd0Sggc9PV/sUGGU2XDi
         nfK/lXFaPCzUXkq/yEeIpg9ZhfTZ5gLN5sJVzUiZkYRMgInQNFaGtQByoCmzabhqG/u0
         IQqzc8vAcAlZBAQddqUdDOSgeyblPoP5q3HkI=
Received: by 10.216.172.73 with SMTP id s51mr2796499wel.113.1272656140436;
        Fri, 30 Apr 2010 12:35:40 -0700 (PDT)
Received: from localhost.localdomain (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id z3sm17896470wbs.4.2010.04.30.12.35.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Apr 2010 12:35:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.13.gbb0a0a.dirty
In-Reply-To: <1272656128-2002-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146057>

Prior to this, the output of %H was always 40 characters long, and the
output of %h always DEFAULT_ABBREV characters long, without regard to
whether --abbrev-commit or --abbrev had been passed.

Here we make "git log --pretty=%H --abbrev-commit" synonymous with
"git log --pretty=%h", and make %h/abbreviated-%H respect the length
specified for --abbrev.

The same is applied to other commit-placeholders %P and %p, and
--abbrev is respected for %t, though %T is not changed.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 builtin/rev-list.c            |    1 +
 builtin/shortlog.c            |    2 ++
 commit.h                      |    3 ++-
 log-tree.c                    |    6 ++++--
 pretty.c                      |   30 +++++++++++++++++++-----------
 t/t4205-log-pretty-formats.sh |   17 +++++++++++++++++
 6 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 5a53862..1d1e59c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -98,6 +98,7 @@ static void show_commit(struct commit *commit, void *data)
 		struct strbuf buf = STRBUF_INIT;
 		struct pretty_print_context ctx = {0};
 		ctx.abbrev = revs->abbrev;
+		ctx.abbrev_commit = revs->abbrev_commit;
 		ctx.date_mode = revs->date_mode;
 		ctx.use_color = DIFF_OPT_TST(&revs->diffopt, COLOR_DIFF);
 		pretty_print_commit(revs->commit_format, commit, &buf, &ctx);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 7aee491..5c0721c 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -143,6 +143,8 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit, struct rev
 	struct strbuf ufbuf = STRBUF_INIT;
 	struct pretty_print_context ctx = {0};
 
+	ctx.abbrev = rev->abbrev;
+	ctx.abbrev_commit = rev->abbrev_commit;
 	ctx.use_color = DIFF_OPT_TST(&rev->diffopt, COLOR_DIFF);
 	pretty_print_commit(CMIT_FMT_RAW, commit, &buf, &ctx);
 	buffer = buf.buf;
diff --git a/commit.h b/commit.h
index b6caf91..4c52069 100644
--- a/commit.h
+++ b/commit.h
@@ -65,7 +65,8 @@ enum cmit_fmt {
 
 struct pretty_print_context
 {
-	int abbrev;
+	int abbrev; /* length of abbreviated hashes */
+	int abbrev_commit; /* whether or not to abbreviate commit hashes */
 	const char *subject;
 	const char *after_subject;
 	enum date_mode date_mode;
diff --git a/log-tree.c b/log-tree.c
index 6bb4748..02233ed 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -279,10 +279,13 @@ void show_log(struct rev_info *opt)
 	struct strbuf msgbuf = STRBUF_INIT;
 	struct log_info *log = opt->loginfo;
 	struct commit *commit = log->commit, *parent = log->parent;
-	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
+	int abbrev_commit;
 	const char *extra_headers = opt->extra_headers;
 	struct pretty_print_context ctx = {0};
+	ctx.abbrev = opt->diffopt.abbrev;
+	ctx.abbrev_commit = opt->abbrev_commit && opt->commit_format != CMIT_FMT_RAW;
 	ctx.use_color = DIFF_OPT_TST(&opt->diffopt, COLOR_DIFF);
+	abbrev_commit = ctx.abbrev_commit ? ctx.abbrev : 40;
 
 	opt->loginfo = NULL;
 	ctx.show_notes = opt->show_notes;
@@ -411,7 +414,6 @@ void show_log(struct rev_info *opt)
 	if (ctx.need_8bit_cte >= 0)
 		ctx.need_8bit_cte = has_non_ascii(opt->add_signoff);
 	ctx.date_mode = opt->date_mode;
-	ctx.abbrev = opt->diffopt.abbrev;
 	ctx.after_subject = extra_headers;
 	ctx.reflog_info = opt->reflog_info;
 	pretty_print_commit(opt->commit_format, commit, &msgbuf, &ctx);
diff --git a/pretty.c b/pretty.c
index fdb5e16..60ed9f6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -725,13 +725,16 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 
 	switch (placeholder[0]) {
 	case 'H':		/* commit hash */
-		strbuf_addstr(sb, sha1_to_hex(commit->object.sha1));
-		return 1;
 	case 'h':		/* abbreviated commit hash */
+		if (placeholder[0] != 'h' && !c->pretty_ctx->abbrev_commit) {
+			strbuf_addstr(sb, sha1_to_hex(commit->object.sha1));
+			return 1;
+		}
+
 		if (add_again(sb, &c->abbrev_commit_hash))
 			return 1;
 		strbuf_addstr(sb, find_unique_abbrev(commit->object.sha1,
-		                                     DEFAULT_ABBREV));
+						     c->pretty_ctx->abbrev));
 		c->abbrev_commit_hash.len = sb->len - c->abbrev_commit_hash.off;
 		return 1;
 	case 'T':		/* tree hash */
@@ -741,24 +744,29 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 		if (add_again(sb, &c->abbrev_tree_hash))
 			return 1;
 		strbuf_addstr(sb, find_unique_abbrev(commit->tree->object.sha1,
-		                                     DEFAULT_ABBREV));
+						     c->pretty_ctx->abbrev));
 		c->abbrev_tree_hash.len = sb->len - c->abbrev_tree_hash.off;
 		return 1;
 	case 'P':		/* parent hashes */
-		for (p = commit->parents; p; p = p->next) {
-			if (p != commit->parents)
-				strbuf_addch(sb, ' ');
-			strbuf_addstr(sb, sha1_to_hex(p->item->object.sha1));
-		}
-		return 1;
 	case 'p':		/* abbreviated parent hashes */
+		if (placeholder[0] != 'p' && !c->pretty_ctx->abbrev_commit) {
+			for (p = commit->parents; p; p = p->next) {
+				if (p != commit->parents)
+					strbuf_addch(sb, ' ');
+				strbuf_addstr(sb,
+					      sha1_to_hex(p->item->object.sha1));
+			}
+			return 1;
+		}
+
 		if (add_again(sb, &c->abbrev_parent_hashes))
 			return 1;
 		for (p = commit->parents; p; p = p->next) {
 			if (p != commit->parents)
 				strbuf_addch(sb, ' ');
 			strbuf_addstr(sb, find_unique_abbrev(
-					p->item->object.sha1, DEFAULT_ABBREV));
+					p->item->object.sha1,
+					c->pretty_ctx->abbrev));
 		}
 		c->abbrev_parent_hashes.len = sb->len -
 		                              c->abbrev_parent_hashes.off;
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index b7ec943..a33f157 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -48,5 +48,22 @@ for color in red green blue reset; do
 
 done
 done
+test_expect_success "reset color flags" "git config --unset color.ui"
+
+test_expect_success "%H with --abbrev-commit should be synonym for %h" \
+	"git log -1 --pretty='format:%H' --abbrev-commit > expected &&
+	git log -1 --pretty='format:%h' > actual &&
+	test_cmp expected actual"
+
+test_expect_success "%H with --abbrev-commit should respect --abbrev" \
+	'test 20 = $(git log -1 --pretty="format:%H" --abbrev-commit --abbrev=20 | wc -c)'
+
+test_expect_success "%h should respect --abbrev" \
+	'test 20 = $(git log -1 --pretty="format:%h" --abbrev-commit --abbrev=20 | wc -c)'
+
+test_expect_success "log --pretty=raw should NOT respect --abbrev-commit" \
+	'git log -1 --pretty=raw > expected &&
+	git log -1 --pretty=raw --abbrev-commit > actual &&
+	test_cmp expected actual'
 
 test_done
-- 
1.7.1.rc1.13.gbb0a0a.dirty
