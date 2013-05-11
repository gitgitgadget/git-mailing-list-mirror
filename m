From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 08/10] builtin/branch.c: Refactor ref_item.name and .dest into strbufs
Date: Sat, 11 May 2013 18:21:18 +0200
Message-ID: <1368289280-30337-9-git-send-email-johan@herland.net>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 18:21:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCYO-0007Zt-8T
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753449Ab3EKQVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:21:42 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:40154 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382Ab3EKQVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:21:40 -0400
Received: by mail-wi0-f181.google.com with SMTP id hi5so185013wib.8
        for <git@vger.kernel.org>; Sat, 11 May 2013 09:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=S37gW+Uhq6FWB8U46ZHKIqVOPf9lmZ0lR1YNgkny+to=;
        b=LMRF0rjCRwHFzDQvoF89c6xBA2HGTk9Uf1wVvvRKMYEI0/PRfd1mbZJG0K/cXx8sHw
         18TzuLeaBooyeWmcarISTP5gJWVcbSdZ3uddqBH9VQs86xfzTFFjBgXFQibOCgUjcx+d
         lzwpoNNQwrjHMRt+XCeLo0oJr0+096wWgUbbc+yS1PKjJU20dFwvQ1hJ9x2dbdKsMpe8
         V7M30MD212k1TzHd4ghUni8aJDAYCECGLikIJTFoWeBe7EmZn5Gcwypv47ozc1CAuTL1
         YOcTV6qWoY6sVcM9cz0kif9iBRHgJERe5CRBuGBpigpR5l6tHKe9avKksEy/gpEAO9ni
         88CQ==
X-Received: by 10.180.185.135 with SMTP id fc7mr9829786wic.29.1368289299405;
        Sat, 11 May 2013 09:21:39 -0700 (PDT)
Received: from localhost.localdomain ([213.221.117.228])
        by mx.google.com with ESMTPSA id er17sm4722405wic.0.2013.05.11.09.21.37
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 09:21:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1368289280-30337-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223987>

In preparation of a future patch which reorganizes how the display of the
ref_list is done.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin/branch.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 0836890..c8b49e3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -276,8 +276,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 }
 
 struct ref_item {
-	char *name;
-	char *dest;
+	struct strbuf name;
+	struct strbuf dest;
 	unsigned int kind, width;
 	struct commit *commit;
 };
@@ -380,11 +380,15 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 
 	/* Record the new item */
 	newitem = &(ref_list->list[ref_list->index++]);
-	newitem->name = xstrdup(refname);
+	strbuf_init(&newitem->name, 0);
+	strbuf_addstr(&newitem->name, refname);
 	newitem->kind = kind;
 	newitem->commit = commit;
 	newitem->width = utf8_strwidth(refname);
-	newitem->dest = resolve_symref(orig_refname, prefix);
+	strbuf_init(&newitem->dest, 0);
+	orig_refname = resolve_symref(orig_refname, prefix);
+	if (orig_refname)
+		strbuf_addstr(&newitem->dest, orig_refname);
 	/* adjust for "remotes/" */
 	if (newitem->kind == REF_REMOTE_BRANCH &&
 	    ref_list->kinds != REF_REMOTE_BRANCH)
@@ -400,8 +404,8 @@ static void free_ref_list(struct ref_list *ref_list)
 	int i;
 
 	for (i = 0; i < ref_list->index; i++) {
-		free(ref_list->list[i].name);
-		free(ref_list->list[i].dest);
+		strbuf_release(&ref_list->list[i].name);
+		strbuf_release(&ref_list->list[i].dest);
 	}
 	free(ref_list->list);
 }
@@ -413,7 +417,7 @@ static int ref_cmp(const void *r1, const void *r2)
 
 	if (c1->kind != c2->kind)
 		return c1->kind - c2->kind;
-	return strcmp(c1->name, c2->name);
+	return strbuf_cmp(&c1->name, &c2->name);
 }
 
 static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
@@ -496,7 +500,7 @@ static void add_verbose_info(struct strbuf *out, struct ref_item *item,
 	}
 
 	if (item->kind == REF_LOCAL_BRANCH)
-		fill_tracking_info(&stat, item->name, verbose > 1);
+		fill_tracking_info(&stat, item->name.buf, verbose > 1);
 
 	strbuf_addf(out, " %s %s%s",
 		find_unique_abbrev(item->commit->object.sha1, abbrev),
@@ -534,7 +538,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		color = BRANCH_COLOR_CURRENT;
 	}
 
-	strbuf_addf(&name, "%s%s", prefix, item->name);
+	strbuf_addf(&name, "%s%s", prefix, item->name.buf);
 	if (verbose) {
 		int utf8_compensation = strlen(name.buf) - utf8_strwidth(name.buf);
 		strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
@@ -544,8 +548,8 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 		strbuf_addf(&out, "%c %s%s%s", c, branch_get_color(color),
 			    name.buf, branch_get_color(BRANCH_COLOR_RESET));
 
-	if (item->dest)
-		strbuf_addf(&out, " -> %s", item->dest);
+	if (item->dest.len)
+		strbuf_addf(&out, " -> %s", item->dest.buf);
 	else if (verbose)
 		/* " f7c0c00 [ahead 58, behind 197] vcs-svn: drop obj_pool.h" */
 		add_verbose_info(&out, item, verbose, abbrev);
@@ -601,15 +605,16 @@ static void show_detached(struct ref_list *ref_list)
 
 	if (head_commit && is_descendant_of(head_commit, ref_list->with_commit)) {
 		struct ref_item item;
-		item.name = get_head_description();
-		item.width = utf8_strwidth(item.name);
+		strbuf_init(&item.name, 0);
+		strbuf_addstr(&item.name, get_head_description());
+		item.width = utf8_strwidth(item.name.buf);
 		item.kind = REF_LOCAL_BRANCH;
-		item.dest = NULL;
+		strbuf_init(&item.dest, 0);
 		item.commit = head_commit;
 		if (item.width > ref_list->maxwidth)
 			ref_list->maxwidth = item.width;
 		print_ref_item(&item, ref_list->maxwidth, ref_list->verbose, ref_list->abbrev, 1, "");
-		free(item.name);
+		strbuf_release(&item.name);
 	}
 }
 
@@ -655,7 +660,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 	for (i = 0; i < ref_list.index; i++) {
 		int current = !detached &&
 			(ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
-			!strcmp(ref_list.list[i].name, head);
+			!strcmp(ref_list.list[i].name.buf, head);
 		char *prefix = (kinds != REF_REMOTE_BRANCH &&
 				ref_list.list[i].kind == REF_REMOTE_BRANCH)
 				? "remotes/" : "";
-- 
1.8.1.3.704.g33f7d4f
