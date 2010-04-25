From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH 2/3] pretty: make %H/%h dependent on --abbrev[-commit]
Date: Sun, 25 Apr 2010 16:42:54 +0100
Message-ID: <1272210175-20484-3-git-send-email-wmpalmer@gmail.com>
References: <1272210175-20484-1-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 25 17:44:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O640Y-0000hW-HX
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 17:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709Ab0DYPoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 11:44:17 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:64660 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab0DYPoF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 11:44:05 -0400
Received: by wwg30 with SMTP id 30so845872wwg.19
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=CCK4+AS49NT9GfMV0z1f6fBgk7rSOT8iMsfhmhcJ5/A=;
        b=Fu/xlaXEal8jRi9KJHK8g1zN1MoIKkLeNXHChTmCl+pgUkBB4DyARBlH2slVH3yb4F
         +Ak7o+ubEfZHiwL9A5XoCP6ntYHir3yD1jVzFFixaBYbP+WsVNkTYQCaFQDSvC8Nokgz
         mBjroITwHc64VYDJgw8LwEkvjYqvCJrdmkF6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QmUHQhiBTlosgKGyl2eWOFGq0BpALuEPUSCd4ONQU2bw3ixdPCkxMZNE4So+/O0o8C
         5COJkVXR4SnhuIcT1IBtOuyQ9iTKj39Rd00xRJGK16AEgdj5my42aK94VhJClUZnvfcR
         o52h+/ida64MXN1/8c9C/u9mQ3isPPzZk7LHg=
Received: by 10.216.86.208 with SMTP id w58mr3612244wee.45.1272210243886;
        Sun, 25 Apr 2010 08:44:03 -0700 (PDT)
Received: from localhost.localdomain (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id x1sm16755457wbx.19.2010.04.25.08.44.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 08:44:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.13.gbb0a0a.dirty
In-Reply-To: <1272210175-20484-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145744>

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
 builtin/rev-list.c |    1 +
 builtin/shortlog.c |    2 ++
 commit.h           |    1 +
 log-tree.c         |    2 ++
 pretty.c           |   30 +++++++++++++++++++-----------
 5 files changed, 25 insertions(+), 11 deletions(-)

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
index b6caf91..7a476a0 100644
--- a/commit.h
+++ b/commit.h
@@ -72,6 +72,7 @@ struct pretty_print_context
 	int need_8bit_cte;
 	int show_notes;
 	int use_color;
+	int abbrev_commit;
 	struct reflog_walk_info *reflog_info;
 };
 
diff --git a/log-tree.c b/log-tree.c
index b743c43..9bd4f47 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -282,6 +282,8 @@ void show_log(struct rev_info *opt, int use_color)
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
 	const char *extra_headers = opt->extra_headers;
 	struct pretty_print_context ctx = {0};
+	ctx.abbrev = opt->abbrev;
+	ctx.abbrev_commit = opt->abbrev_commit;
 	ctx.use_color = use_color;
 
 	opt->loginfo = NULL;
diff --git a/pretty.c b/pretty.c
index fdb5e16..f884f48 100644
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
+				      p->item->object.sha1,
+				      c->pretty_ctx->abbrev));
 		}
 		c->abbrev_parent_hashes.len = sb->len -
 		                              c->abbrev_parent_hashes.off;
-- 
1.7.1.rc1.13.gbb0a0a.dirty
