From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH] Colorize commit decorations
Date: Fri, 18 Jun 2010 00:15:44 +0800
Message-ID: <1276791344-25550-1-git-send-email-ayiehere@gmail.com>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 17 18:16:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPHlq-0002qn-1R
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 18:16:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932984Ab0FQQQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 12:16:44 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:53265 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932708Ab0FQQQm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 12:16:42 -0400
Received: by pxi12 with SMTP id 12so45440pxi.19
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 09:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=drQlMtac+PWBdXU2b+5/UIXrIFhKAWlvKH/NI0B2Jcs=;
        b=IopglCDIR77VdVq1jQy+0PZTewf1AF6UKlAKlC7uKnkpjb6qETI0aPAWPhb1IMMnp7
         uEBDS+yJbKiGOBjUUego+LnkdLceC3Pn5PA1DfSKLpQpHQ0PtE7OpFwOm2gtmMwJs109
         wVnTFpR7Qs104pXyUECD75iXngk/jJrPCzu/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=GxR14c2QDldFUKP6St01pAy1VGXD5yfAG+dQG8ZM0x+15riyPzkmxYP5HXl6wJaJhx
         EdXGCnIF4W0qFWebztYn5txpS8aihNT+FPjGrG38/4LZvLvt8z6c+7ZjHz822Nxq6yO/
         eawxiRVJ55ZyIvqlVDZKjK8R4vKjeJ8fEPmuw=
Received: by 10.140.58.15 with SMTP id g15mr8494615rva.96.1276791402446;
        Thu, 17 Jun 2010 09:16:42 -0700 (PDT)
Received: from localhost.localdomain ([115.132.104.117])
        by mx.google.com with ESMTPS id q10sm8233610rvp.20.2010.06.17.09.16.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Jun 2010 09:16:40 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.245.g7c42e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149317>

Use different color for each type of refs (local, remote, tags, HEAD,
and stash). This makes the decorations and their type stand out more
and easier to distinguish in 'git log --decorate'.

Currently all the different types of decorations are shown in the same
color as the commit id, which is not that easy to spot.

The color applied for each type of refs are customizable via
color.log.decorate.<slot> config entry, as documented in
Documentation/config.txt.
---
 Documentation/config.txt |    5 +++++
 builtin/log.c            |    2 ++
 commit.h                 |    1 +
 decorate.c               |   42 ++++++++++++++++++++++++++++++++++++++++++
 decorate.h               |   27 +++++++++++++++++++++++++++
 log-tree.c               |   39 +++++++++++++++++++++++++++++++--------
 6 files changed, 108 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 95cf73c..afa4f5a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -725,6 +725,11 @@ color.interactive.<slot>::
 	commands.  The values of these variables may be specified as
 	in color.branch.<slot>.
 
+color.log.decorate.<slot>::
+	Use customized color for 'git log --decorate' output.
+	`<slot>` is one of `local`, `remote`, `tag`, `stash` or `head`
+	for local refs, remote refs, tags, stash and HEAD, respectively.
+
 color.pager::
 	A boolean to enable/disable colored output when the pager is in
 	use (default is true).
diff --git a/builtin/log.c b/builtin/log.c
index 976e16f..bbc5d02 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -296,6 +296,8 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		default_show_root = git_config_bool(var, value);
 		return 0;
 	}
+	if (!prefixcmp(var, "color.log.decorate."))
+		return parse_decorate_color_config(var, 19, value);
 	return git_diff_ui_config(var, value, cb);
 }
 
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
index 2f8a63e..cbef2b4 100644
--- a/decorate.c
+++ b/decorate.c
@@ -5,6 +5,48 @@
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
+
+static int parse_decorate_color_slot(const char *slot) {
+	if (!strcasecmp(slot, "local"))
+		return COLOR_DECORATION_REF_LOCAL;
+	if (!strcasecmp(slot, "remote"))
+		return COLOR_DECORATION_REF_REMOTE;
+	if (!strcasecmp(slot, "tag"))
+		return COLOR_DECORATION_TAG;
+	if (!strcasecmp(slot, "stash"))
+		return COLOR_DECORATION_STASH;
+	if (!strcasecmp(slot, "head"))
+		return COLOR_DECORATION_HEAD;
+	return -1;
+}
+
+int parse_decorate_color_config(const char *var, const int ofs, const char *value) {
+	int slot = parse_decorate_color_slot(var + ofs);
+	if (slot < 0)
+		return 0;
+	if (!value)
+		return config_error_nonbool(var);
+	color_parse(value, var, decoration_colors[slot]);
+	return 0;
+}
 
 static unsigned int hash_obj(const struct object *obj, unsigned int n)
 {
diff --git a/decorate.h b/decorate.h
index e732804..d593d32 100644
--- a/decorate.h
+++ b/decorate.h
@@ -12,6 +12,33 @@ struct decoration {
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
+enum color_decoration {
+	COLOR_DECORATION_RESET = 0,
+	COLOR_DECORATION_REF_LOCAL,
+	COLOR_DECORATION_REF_REMOTE,
+	COLOR_DECORATION_TAG,
+	COLOR_DECORATION_STASH,
+	COLOR_DECORATION_HEAD
+};
+
+const char *decorate_get_color(int diff_use_color, enum decoration_type ix);
+
+/*
+ * log-tree.c uses DIFF_OPT_TST for determining whether to use color
+ * for showing the commit sha1, use the same check for --decorate
+ */
+#define decorate_get_color_opt(o, ix) \
+	decorate_get_color(DIFF_OPT_TST((o), COLOR_DIFF), ix)
+
 extern void *add_decoration(struct decoration *n, const struct object *obj, void *decoration);
 extern void *lookup_decoration(struct decoration *n, const struct object *obj);
 
diff --git a/log-tree.c b/log-tree.c
index d3ae969..95ebf1a 100644
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
@@ -60,6 +72,10 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 {
 	const char *prefix;
 	struct name_decoration *decoration;
+	const char *color_commit =
+		diff_get_color_opt(&opt->diffopt, DIFF_COMMIT);
+	const char *color_reset =
+		decorate_get_color_opt(&opt->diffopt, DECORATION_NONE);
 
 	if (opt->show_source && commit->util)
 		printf("\t%s", (char *) commit->util);
@@ -70,7 +86,14 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
 		return;
 	prefix = " (";
 	while (decoration) {
-		printf("%s%s", prefix, decoration->name);
+		printf("%s", prefix);
+		fputs(decorate_get_color_opt(&opt->diffopt, decoration->type),
+		      stdout);
+		if (decoration->type == DECORATION_TAG)
+			fputs("tag: ", stdout);
+		printf("%s", decoration->name);
+		fputs(color_reset, stdout);
+		fputs(color_commit, stdout);
 		prefix = ", ";
 		decoration = decoration->next;
 	}
-- 
1.7.1.245.g7c42e.dirty
