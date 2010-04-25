From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH v2 2/3] pretty: make %H/%h dependent on --abbrev[-commit]
Date: Sun, 25 Apr 2010 22:56:18 +0100
Message-ID: <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
Cc: wmpalmer@gmail.com, gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 25 23:57:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O69pq-0002Dg-R9
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 23:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095Ab0DYV5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 17:57:38 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:56096 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab0DYV5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 17:57:25 -0400
Received: by mail-ww0-f46.google.com with SMTP id 22so56835wwb.19
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 14:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rVF2NvAUVnhQtiDmIuLcNJbbI8aoxOKIGd76JosLeS0=;
        b=kALfknmhN0imJEEd+yBwv/c9/f5rXl+GPcSZ/DGMI3MU27Q6z4UZJYYjASppAA3j4Z
         hqnOXr7nm5veCVP6PopL8agvZZwCBdXvWpmX+jlBGHxkHzDZtZJZMXq33k2RQl60+Q2T
         vDByRgiYAM91HYjrRCcPt29JODRtB6AFctJ6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EOm6963uR3B4qOE9h7E8yGPeCdpW3A61ZG5LfqfDysSxJgid1FmPIxpG/P8Ci7xJSl
         lEMyvWBa/Iu3mjvfqEzyPvGr5Uvyhun5xAYoez9mOEMlDA7nXu/M9RI9bAaPdsB3s7OO
         r5zGqQi9xFH6REDDwWNDXq28SLjroR13M37iY=
Received: by 10.216.91.12 with SMTP id g12mr4181474wef.77.1272232645207;
        Sun, 25 Apr 2010 14:57:25 -0700 (PDT)
Received: from localhost.localdomain (5acc34b2.bb.sky.com [90.204.52.178])
        by mx.google.com with ESMTPS id r29sm16328252wbv.9.2010.04.25.14.57.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Apr 2010 14:57:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.13.gbb0a0a.dirty
In-Reply-To: <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145771>

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
index 6bb4748..0a2309c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -282,6 +282,8 @@ void show_log(struct rev_info *opt)
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
 	const char *extra_headers = opt->extra_headers;
 	struct pretty_print_context ctx = {0};
+	ctx.abbrev = opt->abbrev;
+	ctx.abbrev_commit = opt->abbrev_commit;
 	ctx.use_color = DIFF_OPT_TST(&opt->diffopt, COLOR_DIFF);
 
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
