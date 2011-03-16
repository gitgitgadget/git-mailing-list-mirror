From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] reflog: silence -O3 -Wuninitialized warning
Date: Wed, 16 Mar 2011 05:57:09 -0500
Message-ID: <20110316105709.GC8277@elie>
References: <20110316024959.GA24932@elie>
 <7vfwqnabbi.fsf@alter.siamese.dyndns.org>
 <4D807E66.40504@viscovery.net>
 <20110316094639.GA8180@elie>
 <4D8088C1.5050901@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 11:57:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzoPp-0001Kv-Oy
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 11:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596Ab1CPK5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 06:57:16 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51048 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab1CPK5O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 06:57:14 -0400
Received: by gwaa18 with SMTP id a18so599287gwa.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 03:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=7G9Sl+ABIk1hhIlWOp5nS5Q8ds/joggFphnnmWNm39I=;
        b=ZL1rKQxdUA+zeFgco8ZJWsP42imXzeBCF+sn+gkbAWnMoaJR3fYkev8Bg5b3Pku2yY
         L4MJDk6QCSk7vYP2tea/Uziu5d0DHRGxQ9+AgUcW7ZC3hYwvHBmODH92t48OcaqRYwK8
         KIEtfoeEog59U4YyoVAjctALz59Ivb7SyxKqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QT5WPiTZzuzc4rwEGHUJpZQ6ekU8r/RxiyUFHXCFfp+rbviYVkDLBDjl6rYDDPyIJ1
         N7iXRPdDfdnMJdT9yK1uXuYPf9HL9QfrnXgpKC37Nd/dr+W3l9GH+3JQOVMwFcGUylQP
         saUxuwcOmrNtVBy4pMNJB1TMrgninrfuqP4EE=
Received: by 10.151.116.6 with SMTP id t6mr1248830ybm.43.1300273033808;
        Wed, 16 Mar 2011 03:57:13 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id x4sm663837ybl.20.2011.03.16.03.57.12
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 03:57:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4D8088C1.5050901@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169136>

Johannes Sixt wrote:

> I don't think so. This is not a special warning, but just
>
> 	warning C4700: uninitialized local variable 'expire' used
>
> That is, if you disable it, you also disable it for locations where the
> warning would be justified. That's not something that I would like to do.

Right.  Below is a patch to play with which gets rid of the
'expire = expire' style suppressions.

It was produced with

	spatch -sp_file self-assignment.cocci $(git ls-files -- '*.c' '*.h')

where self-assignment.cocci is

	@@
	identifier x;
	type T;
	@@

	- T x = x;
	+ T x;

but required some pre- and post-processing to work around coccinelle
bugs. :/
---
 builtin/cat-file.c                     |    2 +-
 builtin/fast-export.c                  |    2 +-
 builtin/rev-list.c                     |    2 +-
 contrib/examples/builtin-fetch--tool.c |    4 ++--
 fast-import.c                          |    8 ++++----
 match-trees.c                          |   12 ++++++------
 merge-recursive.c                      |    2 +-
 run-command.c                          |    2 +-
 submodule.c                            |    2 +-
 transport.c                            |    2 +-
 wt-status.c                            |    2 +-
 11 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 94632db..31cb172 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -168,7 +168,7 @@ static int batch_one_object(const char *obj_name, int print_contents)
 	unsigned char sha1[20];
 	enum object_type type = 0;
 	unsigned long size;
-	void *contents = contents;
+	void *contents;
 
 	if (!obj_name)
 	   return 1;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index daf1945..408156e 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -463,7 +463,7 @@ static void get_tags_and_duplicates(struct object_array *pending,
 	for (i = 0; i < pending->nr; i++) {
 		struct object_array_entry *e = pending->objects + i;
 		unsigned char sha1[20];
-		struct commit *commit = commit;
+		struct commit *commit;
 		char *full_name;
 
 		if (dwim_ref(e->name, strlen(e->name), sha1, &full_name) != 1)
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ba27d39..96d10b0 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -397,7 +397,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		mark_edges_uninteresting(revs.commits, &revs, show_edge);
 
 	if (bisect_list) {
-		int reaches = reaches, all = all;
+		int reaches, all;
 
 		revs.commits = find_bisection(revs.commits, &reaches, &all,
 					      bisect_find_all);
diff --git a/contrib/examples/builtin-fetch--tool.c b/contrib/examples/builtin-fetch--tool.c
index 3140e40..c5bd034 100644
--- a/contrib/examples/builtin-fetch--tool.c
+++ b/contrib/examples/builtin-fetch--tool.c
@@ -416,14 +416,14 @@ static int expand_refs_wildcard(const char *ls_remote_result, int numrefs,
 static int pick_rref(int sha1_only, const char *rref, const char *ls_remote_result)
 {
 	int err = 0;
-	int lrr_count = lrr_count, i, pass;
+	int lrr_count, i, pass;
 	const char *cp;
 	struct lrr {
 		const char *line;
 		const char *name;
 		int namelen;
 		int shown;
-	} *lrr_list = lrr_list;
+	} *lrr_list;
 
 	for (pass = 0; pass < 2; pass++) {
 		/* pass 0 counts and allocates, pass 1 fills... */
diff --git a/fast-import.c b/fast-import.c
index e24ee2c..565d895 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2196,7 +2196,7 @@ static void file_change_m(struct branch *b)
 	const char *p = command_buf.buf + 2;
 	static struct strbuf uq = STRBUF_INIT;
 	const char *endp;
-	struct object_entry *oe = oe;
+	struct object_entry *oe;
 	unsigned char sha1[20];
 	uint16_t mode, inline_data = 0;
 
@@ -2365,7 +2365,7 @@ static void note_change_n(struct branch *b, unsigned char old_fanout)
 {
 	const char *p = command_buf.buf + 2;
 	static struct strbuf uq = STRBUF_INIT;
-	struct object_entry *oe = oe;
+	struct object_entry *oe;
 	struct branch *s;
 	unsigned char sha1[20], commit_sha1[20];
 	char path[60];
@@ -2525,7 +2525,7 @@ static int parse_from(struct branch *b)
 
 static struct hash_list *parse_merge(unsigned int *count)
 {
-	struct hash_list *list = NULL, *n, *e = e;
+	struct hash_list *list = NULL, *n, *e;
 	const char *from;
 	struct branch *s;
 
@@ -2819,7 +2819,7 @@ static void cat_blob(struct object_entry *oe, unsigned char sha1[20])
 static void parse_cat_blob(void)
 {
 	const char *p;
-	struct object_entry *oe = oe;
+	struct object_entry *oe;
 	unsigned char sha1[20];
 
 	/* cat-blob SP <object> LF */
diff --git a/match-trees.c b/match-trees.c
index 26f7ed1..9cfcc8b 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -72,12 +72,12 @@ static int score_trees(const unsigned char *hash1, const unsigned char *hash2)
 		die("%s is not a tree", sha1_to_hex(hash2));
 	init_tree_desc(&two, two_buf, size);
 	while (one.size | two.size) {
-		const unsigned char *elem1 = elem1;
-		const unsigned char *elem2 = elem2;
-		const char *path1 = path1;
-		const char *path2 = path2;
-		unsigned mode1 = mode1;
-		unsigned mode2 = mode2;
+		const unsigned char *elem1;
+		const unsigned char *elem2;
+		const char *path1;
+		const char *path2;
+		unsigned mode1;
+		unsigned mode2;
 		int cmp;
 
 		if (one.size)
diff --git a/merge-recursive.c b/merge-recursive.c
index 2a4f739..8ed0f29 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1583,7 +1583,7 @@ int merge_recursive(struct merge_options *o,
 {
 	struct commit_list *iter;
 	struct commit *merged_common_ancestors;
-	struct tree *mrtree = mrtree;
+	struct tree *mrtree;
 	int clean;
 
 	if (show(o, 4)) {
diff --git a/run-command.c b/run-command.c
index f91e446..f4fb936 100644
--- a/run-command.c
+++ b/run-command.c
@@ -139,7 +139,7 @@ int start_command(struct child_process *cmd)
 {
 	int need_in, need_out, need_err;
 	int fdin[2], fdout[2], fderr[2];
-	int failed_errno = failed_errno;
+	int failed_errno;
 
 	/*
 	 * In case of errors we must keep the promise to close FDs
diff --git a/submodule.c b/submodule.c
index 6f1c107..dcbb2d3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -158,7 +158,7 @@ void show_submodule_summary(FILE *f, const char *path,
 		const char *del, const char *add, const char *reset)
 {
 	struct rev_info rev;
-	struct commit *commit, *left = left, *right = right;
+	struct commit *commit, *left, *right;
 	struct commit_list *merge_bases, *list;
 	const char *message = NULL;
 	struct strbuf sb = STRBUF_INIT;
diff --git a/transport.c b/transport.c
index 0078660..718605f 100644
--- a/transport.c
+++ b/transport.c
@@ -104,7 +104,7 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
 		return;
 
 	for (;;) {
-		int cmp = cmp, len;
+		int cmp, len;
 
 		if (!fgets(buffer, sizeof(buffer), f)) {
 			fclose(f);
diff --git a/wt-status.c b/wt-status.c
index 4daa8bb..3298897 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -153,7 +153,7 @@ static void wt_status_print_change_data(struct wt_status *s,
 {
 	struct wt_status_change_data *d = it->util;
 	const char *c = color(change_type, s);
-	int status = status;
+	int status;
 	char *one_name;
 	char *two_name;
 	const char *one, *two;
-- 
1.7.4.1
