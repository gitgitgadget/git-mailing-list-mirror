From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 09/13] exclude: filter out patterns not applicable to the current directory
Date: Tue, 12 Mar 2013 20:04:56 +0700
Message-ID: <1363093500-16796-10-git-send-email-pclouds@gmail.com>
References: <1362896070-17456-1-git-send-email-pclouds@gmail.com>
 <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 12 14:06:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFOus-0007s4-6M
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 14:06:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755388Ab3CLNGW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Mar 2013 09:06:22 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:62563 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872Ab3CLNGV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 09:06:21 -0400
Received: by mail-pb0-f49.google.com with SMTP id xa12so5002766pbc.36
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 06:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=rMCJcpcqXKCYe45qQinWFlRIAnQm12EN0BBrX99YLrQ=;
        b=yYw+TY/zpqAAyY84V6zhxYS7VuUrosXJxApg28tikxzZpGH898zPJjzwTEQIXl7vx3
         Uj60rBBFatLntfsMaRA4R+zR71HWuy+s6tHuxgZ0+6NK1MxvH7Yeh7X19OWsCLZqMJ21
         P+0gdyjBi2Uxae63oEZSJyr8RbPTt7XPKbXRtc3LBWanpCXVuCNj7wvlwIU8n/goGkEe
         ouDgVOCGGtjpDOV7+Vsm5GAh78IjhK64+veFhQ0VcEAVJqJLK5ZoiHLkfFu5j+D5BfPv
         vTfOXA0XbDb/8r7OeD3DK28T0y60utuYKFIcBTnaoVDRTQwYFtto07wp+prAl0cT4T7E
         f5mA==
X-Received: by 10.68.251.169 with SMTP id zl9mr18697890pbc.17.1363093580736;
        Tue, 12 Mar 2013 06:06:20 -0700 (PDT)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id ti8sm25002404pbc.12.2013.03.12.06.06.17
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 12 Mar 2013 06:06:19 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 12 Mar 2013 20:06:14 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
In-Reply-To: <1363093500-16796-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217958>

=2Egitignore files are spread over directories (*) so that when we chec=
k
for ignored files at foo, we are not bothered by foo/bar/.gitignore,
which contains ignore rules for foo/bar only.

This is not enough. foo/.gitignore can contain the pattern
"foo/bar/*.c". When we stay at foo, we know that the pattern cannot
match anything. Similarly, the pattern "/autom4te.cache" at root
directory cannot match anything in foo. This patch attempts to filter
out such patterns to drive down matching cost.

The algorithm implemented here is a naive one. Patterns can be either
active or passive:

 - When we enter a new directory (e.g. from root to foo), currently
   active patterns may no longer be applicable and can be turned to
   passive.

 - On the opposite, when we leave a directory (foo back to roo),
   passive patterns may come alive again.

We could do smarter things. But this implementation cuts a big portion
of cost already (and solves the "root .gitignore is evil" problem).
There's probably no need to be smart.

(*) this design forces us to try to find .gitignore at every
directory. On webkit.git that equals to 6k open syscalls. It feels
like ".svn on every directory" again. I suggest we add
~/.gitignore.master, containing the list .gitignore files in
worktree. If this file exists, we don't poke at every directory for
=2Egitignore.

treat_leading_path:   0.000  0.000
read_directory:       3.455  2.879
+treat_one_path:      2.203  1.620
++is_excluded:        2.000  1.416
+++prep_exclude:      0.171  0.198
+++matching:          1.509  0.904
++dir_exist:          0.036  0.035
++index_name_exists:  0.292  0.289
lazy_init_name_hash:  0.257  0.257
+simplify_away:       0.084  0.085
+dir_add_name:        0.446  0.446

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 dir.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 dir.h |  1 +
 2 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 932fd2f..c57bf06 100644
--- a/dir.c
+++ b/dir.c
@@ -458,7 +458,7 @@ void add_exclude(const char *string, const char *ba=
se,
 	x->base =3D base;
 	x->baselen =3D baselen;
 	x->pattern_baselen =3D pattern_baselen;
-	x->flags =3D flags;
+	x->flags =3D flags | EXC_FLAG_ACTIVE;
 	x->srcpos =3D srcpos;
 	ALLOC_GROW(el->excludes, el->nr + 1, el->alloc);
 	el->excludes[el->nr++] =3D x;
@@ -591,6 +591,87 @@ void add_excludes_from_file(struct dir_struct *dir=
, const char *fname)
 		die("cannot use %s as an exclude file", fname);
 }
=20
+static int pattern_match_base(struct dir_struct *dir,
+			      const char *base, int baselen,
+			      const struct exclude *exc)
+{
+	const char *pattern;
+
+	/*
+	 * TODO: if a patterns come from a .gitignore, exc->base would
+	 * be the same for all of them. We could compare once and
+	 * reuse the result, instead of perform the comparison per
+	 * pattern like this.
+	 */
+	if (exc->baselen) {
+		if (baselen < exc->baselen + 1)
+			return 0;
+
+		if (base[exc->baselen] !=3D '/' ||
+		    memcmp(base, exc->base, exc->baselen))
+			return 0;
+
+		base +=3D exc->baselen + 1;
+		baselen -=3D exc->baselen + 1;
+	}
+
+	if (baselen !=3D exc->pattern_baselen)
+		return 0;
+
+	if (exc->pattern_baselen) {
+		pattern =3D exc->pattern;
+		if (*pattern =3D=3D '/')
+			pattern++;
+		if (memcmp(base, pattern, exc->pattern_baselen))
+			return 0;
+	}
+
+	return 1;
+}
+
+/*
+ * If pushed is non-zero, we have entered a new directory. Some
+ * pathname patterns may no longer applicable. Go over all active
+ * patterns and disable them if so.
+ *
+ * If popped is non-zero, we have left a directory. Inactive patterns
+ * may be applicable again. Go over them and re-enable if so.
+ */
+static void scan_patterns(struct dir_struct *dir,
+			  const char *base, int baselen,
+			  int pushed, int popped)
+{
+	int i, j, k;
+
+	for (i =3D EXC_CMDL; i <=3D EXC_FILE; i++) {
+		struct exclude_list_group *group =3D &dir->exclude_list_group[i];
+		for (j =3D group->nr - 1; j >=3D 0; j--) {
+			struct exclude_list *list =3D &group->el[j];
+			for (k =3D 0; k < list->nr; k++) {
+				struct exclude *exc =3D list->excludes[k];
+
+				/*
+				 * No base (i.e. EXC_FLAG_NODIR) or
+				 * applicable to many bases ("**"
+				 * patterns)
+				 */
+				if (exc->pattern_baselen =3D=3D -1)
+					continue;
+
+				if (exc->flags & EXC_FLAG_ACTIVE) {
+					if (pushed &&
+					    !pattern_match_base(dir, base, baselen, exc))
+						exc->flags &=3D ~EXC_FLAG_ACTIVE;
+				} else {
+					if (popped &&
+					    pattern_match_base(dir, base, baselen, exc))
+						exc->flags |=3D EXC_FLAG_ACTIVE;
+				}
+			}
+		}
+	}
+}
+
 /*
  * Loads the per-directory exclude list for the substring of base
  * which has a char length of baselen.
@@ -600,7 +681,7 @@ static void prep_exclude(struct dir_struct *dir, co=
nst char *base, int baselen)
 	struct exclude_list_group *group;
 	struct exclude_list *el;
 	struct exclude_stack *stk =3D NULL;
-	int current;
+	int current, popped =3D 0, pushed =3D 0;
=20
 	if ((!dir->exclude_per_dir) ||
 	    (baselen + strlen(dir->exclude_per_dir) >=3D PATH_MAX))
@@ -621,6 +702,7 @@ static void prep_exclude(struct dir_struct *dir, co=
nst char *base, int baselen)
 		clear_exclude_list(el);
 		free(stk);
 		group->nr--;
+		popped++;
 	}
=20
 	/* Read from the parent directories and push them down. */
@@ -659,8 +741,12 @@ static void prep_exclude(struct dir_struct *dir, c=
onst char *base, int baselen)
 					       el, 1);
 		dir->exclude_stack =3D stk;
 		current =3D stk->baselen;
+		pushed++;
 	}
 	dir->basebuf[baselen] =3D '\0';
+
+	if (pushed | popped)
+		scan_patterns(dir, base, baselen, pushed, popped);
 }
=20
 int match_basename(const char *basename, int basenamelen,
@@ -755,6 +841,9 @@ static struct exclude *last_exclude_matching_from_l=
ist(const char *pathname,
 		const char *exclude =3D x->pattern;
 		int prefix =3D x->nowildcardlen;
=20
+		if (!(x->flags & EXC_FLAG_ACTIVE))
+			continue;
+
 		if (x->flags & EXC_FLAG_MUSTBEDIR) {
 			if (*dtype =3D=3D DT_UNKNOWN)
 				*dtype =3D get_dtype(NULL, pathname, pathlen);
diff --git a/dir.h b/dir.h
index cb50a85..247bfda 100644
--- a/dir.h
+++ b/dir.h
@@ -14,6 +14,7 @@ struct dir_entry {
 #define EXC_FLAG_ENDSWITH 4
 #define EXC_FLAG_MUSTBEDIR 8
 #define EXC_FLAG_NEGATIVE 16
+#define EXC_FLAG_ACTIVE 32
=20
 /*
  * Each excludes file will be parsed into a fresh exclude_list which
--=20
1.8.1.2.536.gf441e6d
