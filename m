From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] branch: support sorting branches by mtime
Date: Thu, 18 Nov 2010 21:22:06 +0700
Message-ID: <1290090126-14471-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 18 15:23:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ5Of-00011j-N0
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 15:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757660Ab0KROX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 09:23:28 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:46276 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757296Ab0KROX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 09:23:27 -0500
Received: by pwj1 with SMTP id 1so450018pwj.19
        for <git@vger.kernel.org>; Thu, 18 Nov 2010 06:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=Vn5X9PilqRX+Gm3ohrn8DgL3au1yXQ0lGvOFComth0M=;
        b=kbOLZYA8G340seNbi6UcNIgkh2Xt2WRAjFnwOuv44Z5we//A7elTZshqqHg5h4hgWJ
         aXkcl0JhX2ko2RvRlxhHVb5pzVeU26fhHwLBOeJLSYOI6mylz5NASIIPPb9gySRe9fYx
         WXIMYU8blW0Tw5wtobgBB9Xe5fCHm4ywVjpi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=L12Aokd64KwsayDa/jFPY6igGpNpCXw2U0G/ZetCaDMUmRxqHrApvdEENvVNVwu6Ce
         TUuhF4qjrF1dGFmUuvCi4xmjV64QRfeg/ChhfbkrLSRwieE9sumVoupCOMim9bWtzEUa
         gsxZU/8HbvBnZo9nEdJS4gjjaXdFeMosOHRFk=
Received: by 10.142.86.13 with SMTP id j13mr511996wfb.418.1290090207207;
        Thu, 18 Nov 2010 06:23:27 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.199.2])
        by mx.google.com with ESMTPS id w22sm554151wfd.7.2010.11.18.06.23.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Nov 2010 06:23:25 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 18 Nov 2010 21:22:08 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161671>

I lost in my branches again while looking for a topic that I feel like
working on tonight. Too old branches are out of question.

This throwaway patch demonstrates the idea. I should have looked into
reflog for this kind of information, but my laziness won over me.

OK Git's fun time is over..
---
 builtin/branch.c |   32 ++++++++++++++++++++++++++++----
 1 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 87976f0..fdc2714 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -232,6 +232,7 @@ struct ref_item {
 	char *name;
 	char *dest;
 	unsigned int kind, len;
+	unsigned long mtime;
 	struct commit *commit;
 };
 
@@ -259,6 +260,7 @@ static char *resolve_symref(const char *src, const char *prefix)
 
 struct append_ref_cb {
 	struct ref_list *ref_list;
+	int collect_mtime;
 	int ret;
 };
 
@@ -270,6 +272,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	struct commit *commit;
 	int kind, i;
 	const char *prefix, *orig_refname = refname;
+	struct stat st;
 
 	static struct {
 		int kind;
@@ -334,6 +337,13 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 	if (newitem->len > ref_list->maxwidth)
 		ref_list->maxwidth = newitem->len;
 
+	kind = kind == REF_LOCAL_BRANCH ? 0 : 1;
+	if (stat(git_path("logs/%s%s", ref_kind[kind].prefix, refname), &st)) {
+		newitem->mtime = 0;
+	}
+	else
+		newitem->mtime = st.st_mtime;
+
 	return 0;
 }
 
@@ -358,6 +368,16 @@ static int ref_cmp(const void *r1, const void *r2)
 	return strcmp(c1->name, c2->name);
 }
 
+static int ref_mtime_cmp(const void *r1, const void *r2)
+{
+	struct ref_item *c1 = (struct ref_item *)(r1);
+	struct ref_item *c2 = (struct ref_item *)(r2);
+
+	if (c1->kind != c2->kind)
+		return c1->kind - c2->kind;
+	return c1->mtime - c2->mtime;
+}
+
 static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
 		int show_upstream_ref)
 {
@@ -492,7 +512,8 @@ static void show_detached(struct ref_list *ref_list)
 	}
 }
 
-static int print_ref_list(int kinds, int detached, int verbose, int abbrev, struct commit_list *with_commit)
+static int print_ref_list(int kinds, int detached, int verbose, int abbrev,
+			  int sort_by_mtime, struct commit_list *with_commit)
 {
 	int i;
 	struct append_ref_cb cb;
@@ -507,6 +528,7 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 		init_revisions(&ref_list.revs, NULL);
 	cb.ref_list = &ref_list;
 	cb.ret = 0;
+	cb.collect_mtime = sort_by_mtime;
 	for_each_rawref(append_ref, &cb);
 	if (merge_filter != NO_FILTER) {
 		struct commit *filter;
@@ -520,7 +542,8 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 			ref_list.maxwidth = calc_maxwidth(&ref_list);
 	}
 
-	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
+	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item),
+	      sort_by_mtime ? ref_mtime_cmp : ref_cmp);
 
 	detached = (detached && (kinds & REF_LOCAL_BRANCH));
 	if (detached)
@@ -614,7 +637,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 {
 	int delete = 0, rename = 0, force_create = 0;
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
-	int reflog = 0;
+	int reflog = 0, sort_by_mtime = 0;
 	enum branch_track track;
 	int kinds = REF_LOCAL_BRANCH;
 	struct commit_list *with_commit = NULL;
@@ -664,6 +687,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_LASTARG_DEFAULT | PARSE_OPT_NONEG,
 			opt_parse_merge_filter, (intptr_t) "HEAD",
 		},
+		OPT_BOOLEAN(0, "mtime", &sort_by_mtime, "sort branch list by modification time"),
 		OPT_END(),
 	};
 
@@ -695,7 +719,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
 	else if (argc == 0)
-		return print_ref_list(kinds, detached, verbose, abbrev, with_commit);
+		return print_ref_list(kinds, detached, verbose, abbrev, sort_by_mtime, with_commit);
 	else if (rename && (argc == 1))
 		rename_branch(head, argv[0], rename > 1);
 	else if (rename && (argc == 2))
-- 
1.7.3.2.210.g045198
