From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [RFC/PATCH] Colorize commit decorations
Date: Thu, 17 Jun 2010 00:57:30 +0800
Message-ID: <1276707450-19396-1-git-send-email-ayiehere@gmail.com>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 16 18:56:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOvv0-0000km-Ml
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 18:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400Ab0FPQ4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 12:56:44 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47481 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261Ab0FPQ4n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 12:56:43 -0400
Received: by pva4 with SMTP id 4so746902pva.19
        for <git@vger.kernel.org>; Wed, 16 Jun 2010 09:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=cGj+Ud8c3hzasRNlcxLnvSWkg9tNjVJdRJsvk8GYm3Y=;
        b=dkA9Fbb4ElzM8zTEuspzPI+s/0x7dcNyFTTErlxwH6d1gotK3H5EvI3CRYUEgvM8DU
         C3CmdpebR738lLcyt7KIdaAVxjzOmzaBR0z7KkBQL9tNc4CBkC+oOon8gQVTSA/ODCTE
         fhamVpbqWiebVhQ83toQGCFuqryWbhEZcP3Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=VQv+8JzjxRbjGRA/ZCt7Q7vdNtn/tkFbVqc2EwwqPtSD7d6PA4KzBt5TKoLtkACrMd
         g30w0976U9FisaoBEJfD26Z9j5UouazNI7Pee5RADfuf4EhdHs8cLokEbLgNV0UgTvis
         irVvC8iGgDMyhJ+YsPpVe4oMYZrMNrZpJAaMY=
Received: by 10.142.60.21 with SMTP id i21mr648078wfa.149.1276707391216;
        Wed, 16 Jun 2010 09:56:31 -0700 (PDT)
Received: from localhost.localdomain ([115.135.175.80])
        by mx.google.com with ESMTPS id u34sm3520718wfh.8.2010.06.16.09.56.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jun 2010 09:56:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.245.g7c42e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149266>

Use different color for each type of ref (local, remote, tags, HEAD,
stash). This will make the decorations and their type stand out more and
easier to distinguish in 'git log --decorate'.

Currently all the different type of decorations are shown in the same
color as the commit id, which is not that easy to spot.
---
If there are no strong objections to this patch I'll look into the remaining
work if needed:

	1. config.color.log.decorate.<slot>
	2. See the FIXME part in this patch (most of the work here was copied
           from diff coloring).

 commit.h   |    1 +
 decorate.c |   18 ++++++++++++++++++
 decorate.h |   14 ++++++++++++++
 log-tree.c |   35 +++++++++++++++++++++++++++--------
 4 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/commit.h b/commit.h
index 6ef88dc..a49cfe3 100644
--- a/commit.h
+++ b/commit.h
@@ -28,6 +28,7 @@ extern const char *commit_type;
 extern struct decoration name_decoration;
 struct name_decoration {
 	struct name_decoration *next;
+	enum decoration_type type;
 	char name[1];
 };
 
diff --git a/decorate.c b/decorate.c
index 2f8a63e..8444867 100644
--- a/decorate.c
+++ b/decorate.c
@@ -5,6 +5,24 @@
 #include "cache.h"
 #include "object.h"
 #include "decorate.h"
+#include "color.h"
+
+static char decoration_colors[][COLOR_MAXLEN] = {
+	GIT_COLOR_RESET,	/* DECORATION_NONE */
+	GIT_COLOR_BOLD_GREEN,	/* DECORATION_REF_LOCAL */
+	GIT_COLOR_BOLD_RED,	/* DECORATION_REF_REMOTE */
+	GIT_COLOR_BOLD_YELLOW,	/* DECORATION_TAG */
+	GIT_COLOR_BOLD_MAGENTA,	/* DECORATION_STASH */
+	GIT_COLOR_BOLD_CYAN	/* DECORATION_HEAD */
+};
+
+const char *decorate_get_color(int decorate_use_color, enum decoration_type ix)
+{
+	if (decorate_use_color) {
+		return decoration_colors[ix];
+	}
+	return "";
+}
 
 static unsigned int hash_obj(const struct object *obj, unsigned int n)
 {
diff --git a/decorate.h b/decorate.h
index e732804..7d6e7e5 100644
--- a/decorate.h
+++ b/decorate.h
@@ -12,6 +12,20 @@ struct decoration {
 	struct object_decoration *hash;
 };
 
+enum decoration_type {
+	DECORATION_NONE = 0,
+	DECORATION_REF_LOCAL,
+	DECORATION_REF_REMOTE,
+	DECORATION_TAG,
+	DECORATION_STASH,
+	DECORATION_HEAD
+};
+
+const char *decorate_get_color(int diff_use_color, enum decoration_type ix);
+/* FIXME DIFF_OPT_TST -> DECORATE_OPT_TST? */
+#define decorate_get_color_opt(o, ix) \
+	decorate_get_color(DIFF_OPT_TST((o), COLOR_DIFF), ix)
+
 extern void *add_decoration(struct decoration *n, const struct object *obj, void *decoration);
 extern void *lookup_decoration(struct decoration *n, const struct object *obj);
 
diff --git a/log-tree.c b/log-tree.c
index d3ae969..485ce3c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -10,29 +10,41 @@
 
 struct decoration name_decoration = { "object names" };
 
-static void add_name_decoration(const char *prefix, const char *name, struct object *obj)
+static void add_name_decoration(enum decoration_type type, const char *name, struct object *obj)
 {
-	int plen = strlen(prefix);
 	int nlen = strlen(name);
-	struct name_decoration *res = xmalloc(sizeof(struct name_decoration) + plen + nlen);
-	memcpy(res->name, prefix, plen);
-	memcpy(res->name + plen, name, nlen + 1);
+	struct name_decoration *res = xmalloc(sizeof(struct name_decoration) + nlen);
+	memcpy(res->name, name, nlen + 1);
+	res->type = type;
 	res->next = add_decoration(&name_decoration, obj, res);
 }
 
 static int add_ref_decoration(const char *refname, const unsigned char *sha1, int flags, void *cb_data)
 {
 	struct object *obj = parse_object(sha1);
+	enum decoration_type type = DECORATION_NONE;
 	if (!obj)
 		return 0;
+
+	if (!prefixcmp(refname, "refs/heads"))
+		type = DECORATION_REF_LOCAL;
+	else if (!prefixcmp(refname, "refs/remotes"))
+		type = DECORATION_REF_REMOTE;
+	else if (!prefixcmp(refname, "refs/tags"))
+		type = DECORATION_TAG;
+	else if (!prefixcmp(refname, "refs/stash"))
+		type = DECORATION_STASH;
+	else if (!prefixcmp(refname, "HEAD"))
+		type = DECORATION_HEAD;
+
 	if (!cb_data || *(int *)cb_data == DECORATE_SHORT_REFS)
 		refname = prettify_refname(refname);
-	add_name_decoration("", refname, obj);
+	add_name_decoration(type, refname, obj);
 	while (obj->type == OBJ_TAG) {
 		obj = ((struct tag *)obj)->tagged;
 		if (!obj)
 			break;
-		add_name_decoration("tag: ", refname, obj);
+		add_name_decoration(DECORATION_TAG, refname, obj);
 	}
 	return 0;
 }
@@ -60,6 +72,7 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 {
 	const char *prefix;
 	struct name_decoration *decoration;
+	const char *color_commit = diff_get_color_opt(&opt->diffopt, DIFF_COMMIT);
 
 	if (opt->show_source && commit->util)
 		printf("\t%s", (char *) commit->util);
@@ -70,7 +83,13 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 		return;
 	prefix = " (";
 	while (decoration) {
-		printf("%s%s", prefix, decoration->name);
+		printf("%s", prefix);
+		fputs(decorate_get_color_opt(&opt->diffopt, decoration->type), stdout);
+		if (decoration->type == DECORATION_TAG)
+			fputs("tag: ", stdout);
+		printf("%s", decoration->name);
+		fputs(GIT_COLOR_RESET, stdout);
+		fputs(color_commit, stdout);
 		prefix = ", ";
 		decoration = decoration->next;
 	}
-- 
1.7.1.245.g7c42e.dirty
