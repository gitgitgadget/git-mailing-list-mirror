From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] branch: borrow --sort and --count from for-each-ref
Date: Tue, 17 Jan 2012 20:11:47 +0700
Message-ID: <1326805907-19416-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 14:14:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn8px-0004ER-Jv
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 14:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753773Ab2AQNMZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jan 2012 08:12:25 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33952 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578Ab2AQNMY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 08:12:24 -0500
Received: by iagf6 with SMTP id f6so4242514iag.19
        for <git@vger.kernel.org>; Tue, 17 Jan 2012 05:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=MuJsRU01sPuEKB4b3f6W7dgkKI4bLYqyjmD5bxdIYyI=;
        b=bS3Gj1hNdO+DxM6QVylH2kDyu0NeYgYG4dtrgDgYwf5qqfLkA57gzTm5NCYM5nScC2
         DOF6U8gueBjtuuB+ZQKxW/kY7FMKtmjq0IWNFBMOg+JWyJPgCOorY+FXaiogTo6ZElyn
         /9S+PryfNtPkKNSioDBvX8jhYACxKiwsIVX1k=
Received: by 10.42.152.65 with SMTP id h1mr6257290icw.50.1326805942885;
        Tue, 17 Jan 2012 05:12:22 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.41.98])
        by mx.google.com with ESMTPS id uz5sm13597404igc.0.2012.01.17.05.12.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 17 Jan 2012 05:12:21 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 17 Jan 2012 20:11:52 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188705>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Some time ago, I posted a patch that added date sort to git-branch
 and Peff pointed me to for-each-ref. I did not look at it closely.
 Now it does not seem hard to lend some code from for-each-ref to
 git-branch. I can list 10 most recently touched branches with

  git branch --sort=3D-committerdate -v --count=3D10

 kind of cool. I don't think adding --format is necessary because
 git-branch already has its own formatting.

 Documentation/git-branch.txt |   13 +++++++++
 Makefile                     |    1 +
 builtin/branch.c             |   61 +++++++++++++++++++++++++++++++++-=
-------
 builtin/for-each-ref.c       |   33 +++-------------------
 builtin/for-each-ref.h       |   32 ++++++++++++++++++++++
 5 files changed, 100 insertions(+), 40 deletions(-)
 create mode 100644 builtin/for-each-ref.h

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index 0427e80..b6f2826 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git branch' [--color[=3D<when>] | --no-color] [-r | -a]
 	[--list] [-v [--abbrev=3D<length> | --no-abbrev]]
+	[--count=3D<count>] [(--sort=3D<key>)...]
 	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branch=
name> [<start-point>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
@@ -192,6 +193,18 @@ start-point is either a local or remote-tracking b=
ranch.
 	The new name for an existing branch. The same restrictions as for
 	<branchname> apply.
=20
+<count>::
+	By default the command shows all refs that match
+	`<pattern>`.  This option makes it stop after showing
+	that many refs.
+
+<key>::
+	A field name to sort on.  Prefix `-` to sort in descending
+	order of the value.  When unspecified, `refname` is used.  You
+	may use the --sort=3D<key> option multiple times, in which case
+	the last key becomes the primary key. See
+	linkgit:for-each-ref[1] for field name details.
+
=20
 Examples
 --------
diff --git a/Makefile b/Makefile
index a782409..daf3e46 100644
--- a/Makefile
+++ b/Makefile
@@ -2108,6 +2108,7 @@ builtin/log.o builtin/shortlog.o: shortlog.h
 builtin/prune.o builtin/reflog.o reachable.o: reachable.h
 builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
+builtin/branch.o builtin/for-each-ref.o: builtin/for-each-ref.h
 connect.o transport.o url.o http-backend.o: url.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.=
h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h ur=
l.h
diff --git a/builtin/branch.c b/builtin/branch.c
index 7095718..67bdbc7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -15,6 +15,7 @@
 #include "branch.h"
 #include "diff.h"
 #include "revision.h"
+#include "for-each-ref.h"
=20
 static const char * const builtin_branch_usage[] =3D {
 	"git branch [options] [-r | -a] [--merged | --no-merged]",
@@ -30,6 +31,9 @@ static const char * const builtin_branch_usage[] =3D =
{
 static const char *head;
 static unsigned char head_sha1[20];
=20
+static struct ref_sort *sort =3D NULL, **sort_tail =3D &sort;
+static int maxcount;
+
 static int branch_use_color =3D -1;
 static char branch_colors[][COLOR_MAXLEN] =3D {
 	GIT_COLOR_RESET,
@@ -312,7 +316,7 @@ static int append_ref(const char *refname, const un=
signed char *sha1, int flags,
 	if ((kind & ref_list->kinds) =3D=3D 0)
 		return 0;
=20
-	if (!match_patterns(cb->pattern, refname))
+	if (cb->pattern && !match_patterns(cb->pattern, refname))
 		return 0;
=20
 	commit =3D NULL;
@@ -510,10 +514,38 @@ static void show_detached(struct ref_list *ref_li=
st)
 	}
 }
=20
-static int print_ref_list(int kinds, int detached, int verbose, int ab=
brev, struct commit_list *with_commit, const char **pattern)
+static int fetch_branches(struct ref_list *ref_list,
+				 const char **pattern)
 {
-	int i;
 	struct append_ref_cb cb;
+	cb.ref_list =3D ref_list;
+	cb.pattern =3D pattern;
+	cb.ret =3D 0;
+	if (sort) {
+		struct grab_ref_cbdata cbdata;
+		int i;
+		memset(&cbdata, 0, sizeof(cbdata));
+		cbdata.grab_pattern =3D pattern;
+		for_each_rawref(grab_single_ref, &cbdata);
+		sort_refs(sort, cbdata.grab_array, cbdata.grab_cnt);
+		for (i =3D 0; i < cbdata.grab_cnt; i++) {
+			struct refinfo *ri =3D cbdata.grab_array[i];
+			append_ref(ri->refname, ri->objectname, ri->flag, &cb);
+		}
+	}
+	else {
+		for_each_rawref(append_ref, &cb);
+		qsort(ref_list->list, ref_list->index,
+		      sizeof(struct ref_item), ref_cmp);
+	}
+	return cb.ret;
+}
+
+static int print_ref_list(int kinds, int detached, int verbose, int ab=
brev,
+			  struct commit_list *with_commit,
+			  const char **pattern)
+{
+	int i, ret;
 	struct ref_list ref_list;
=20
 	memset(&ref_list, 0, sizeof(ref_list));
@@ -523,10 +555,7 @@ static int print_ref_list(int kinds, int detached,=
 int verbose, int abbrev, stru
 	ref_list.with_commit =3D with_commit;
 	if (merge_filter !=3D NO_FILTER)
 		init_revisions(&ref_list.revs, NULL);
-	cb.ref_list =3D &ref_list;
-	cb.pattern =3D pattern;
-	cb.ret =3D 0;
-	for_each_rawref(append_ref, &cb);
+	ret =3D fetch_branches(&ref_list, pattern);
 	if (merge_filter !=3D NO_FILTER) {
 		struct commit *filter;
 		filter =3D lookup_commit_reference_gently(merge_filter_ref, 0);
@@ -539,13 +568,13 @@ static int print_ref_list(int kinds, int detached=
, int verbose, int abbrev, stru
 			ref_list.maxwidth =3D calc_maxwidth(&ref_list);
 	}
=20
-	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp=
);
-
 	detached =3D (detached && (kinds & REF_LOCAL_BRANCH));
 	if (detached && match_patterns(pattern, "HEAD"))
 		show_detached(&ref_list);
=20
-	for (i =3D 0; i < ref_list.index; i++) {
+	if (!maxcount)
+		maxcount =3D ref_list.index;
+	for (i =3D 0; i < maxcount; i++) {
 		int current =3D !detached &&
 			(ref_list.list[i].kind =3D=3D REF_LOCAL_BRANCH) &&
 			!strcmp(ref_list.list[i].name, head);
@@ -558,10 +587,10 @@ static int print_ref_list(int kinds, int detached=
, int verbose, int abbrev, stru
=20
 	free_ref_list(&ref_list);
=20
-	if (cb.ret)
+	if (ret)
 		error(_("some refs could not be read"));
=20
-	return cb.ret;
+	return ret;
 }
=20
 static void rename_branch(const char *oldname, const char *newname, in=
t force)
@@ -702,6 +731,9 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 			parse_opt_with_commit, (intptr_t) "HEAD",
 		},
 		OPT__ABBREV(&abbrev),
+		OPT_CALLBACK(0 , "sort", sort_tail, "key",
+			     "field name to sort on", &opt_parse_sort),
+		OPT_INTEGER( 0 , "count", &maxcount, "show only <n> matched refs"),
=20
 		OPT_GROUP("Specific git-branch actions:"),
 		OPT_SET_INT('a', "all", &kinds, "list both remote-tracking and local=
 branches",
@@ -752,6 +784,11 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
 	argc =3D parse_options(argc, argv, prefix, options, builtin_branch_us=
age,
 			     0);
=20
+	if (maxcount < 0) {
+		error("invalid --count argument: `%d'", maxcount);
+		usage_with_options(builtin_branch_usage, options);
+	}
+
 	if (!delete && !rename && !edit_description && argc =3D=3D 0)
 		list =3D 1;
=20
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index b01d76a..7b25c54 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -9,6 +9,7 @@
 #include "quote.h"
 #include "parse-options.h"
 #include "remote.h"
+#include "for-each-ref.h"
=20
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -19,25 +20,6 @@
=20
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
=20
-struct atom_value {
-	const char *s;
-	unsigned long ul; /* used for sorting when not FIELD_STR */
-};
-
-struct ref_sort {
-	struct ref_sort *next;
-	int atom; /* index into used_atom array */
-	unsigned reverse : 1;
-};
-
-struct refinfo {
-	char *refname;
-	unsigned char objectname[20];
-	int flag;
-	const char *symref;
-	struct atom_value *value;
-};
-
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -765,17 +747,12 @@ static void get_value(struct refinfo *ref, int at=
om, struct atom_value **v)
 	*v =3D &ref->value[atom];
 }
=20
-struct grab_ref_cbdata {
-	struct refinfo **grab_array;
-	const char **grab_pattern;
-	int grab_cnt;
-};
-
 /*
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
  */
-static int grab_single_ref(const char *refname, const unsigned char *s=
ha1, int flag, void *cb_data)
+int grab_single_ref(const char *refname, const unsigned char *sha1,
+		    int flag, void *cb_data)
 {
 	struct grab_ref_cbdata *cb =3D cb_data;
 	struct refinfo *ref;
@@ -858,7 +835,7 @@ static int compare_refs(const void *a_, const void =
*b_)
 	return 0;
 }
=20
-static void sort_refs(struct ref_sort *sort, struct refinfo **refs, in=
t num_refs)
+void sort_refs(struct ref_sort *sort, struct refinfo **refs, int num_r=
efs)
 {
 	ref_sort =3D sort;
 	qsort(refs, num_refs, sizeof(struct refinfo *), compare_refs);
@@ -953,7 +930,7 @@ static struct ref_sort *default_sort(void)
 	return sort;
 }
=20
-static int opt_parse_sort(const struct option *opt, const char *arg, i=
nt unset)
+int opt_parse_sort(const struct option *opt, const char *arg, int unse=
t)
 {
 	struct ref_sort **sort_tail =3D opt->value;
 	struct ref_sort *s;
diff --git a/builtin/for-each-ref.h b/builtin/for-each-ref.h
new file mode 100644
index 0000000..8542d66
--- /dev/null
+++ b/builtin/for-each-ref.h
@@ -0,0 +1,32 @@
+struct atom_value {
+	const char *s;
+	unsigned long ul; /* used for sorting when not FIELD_STR */
+};
+
+struct ref_sort {
+	struct ref_sort *next;
+	int atom; /* index into used_atom array */
+	unsigned reverse : 1;
+};
+
+struct refinfo {
+	char *refname;
+	unsigned char objectname[20];
+	int flag;
+	const char *symref;
+	struct atom_value *value;
+};
+
+struct grab_ref_cbdata {
+	struct refinfo **grab_array;
+	const char **grab_pattern;
+	int grab_cnt;
+};
+
+extern int grab_single_ref(const char *refname,
+			   const unsigned char *sha1,
+			   int flag, void *cb_data);
+extern int opt_parse_sort(const struct option *opt,
+			  const char *arg, int unset);
+extern void sort_refs(struct ref_sort *sort,
+		      struct refinfo **refs, int num_refs);
--=20
1.7.8.36.g69ee2
