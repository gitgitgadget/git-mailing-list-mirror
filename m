From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 03/12] Introduce sparse prefix
Date: Wed, 23 Jul 2008 21:56:03 +0700
Message-ID: <20080723145603.GA29079@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 16:57:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLfmS-0002RA-B8
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 16:57:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbYGWO40 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2008 10:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbYGWO40
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 10:56:26 -0400
Received: from ti-out-0910.google.com ([209.85.142.187]:42933 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbYGWO4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 10:56:25 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1202339tic.23
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 07:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition
         :content-transfer-encoding:user-agent;
        bh=7CKsc6t7oiRykGPxdv+/iaiW2ZUFzV3kO9rWVQUZOnk=;
        b=IAO1KDEtugBWYFkuYqtXBcf1TiHo0/1gDqVfWO8XjHMtO4/LRUzCN7IC79Z04LExlA
         upDfgP8yWgfIZcTxvkm8QhiE1t4rNPxLo77iF6f2xASBb3BmbZAdvSpZCE/Bc0COwebZ
         9iFAex1h0HvjT0Ffide74H3cSWouV+S4Z6+wg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        b=dJQqAQTCIkd7VAZK6IkJirOTOCf0qtbaPts4/85gCa3r8ndNNRHGVG6O/v/vAtxYfR
         2tZtfm/poAQ4MPYaedq9X3UaqB94fUG4Z8YlYQzd3ac5Z5f+2iWtbfebWx1/xxr0CIhP
         HzGdHfQUHBd47in3R92kVTQ3xhZdOn/3WkJUE=
Received: by 10.110.69.5 with SMTP id r5mr125625tia.17.1216824983454;
        Wed, 23 Jul 2008 07:56:23 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.5.7])
        by mx.google.com with ESMTPS id d4sm14703649tib.13.2008.07.23.07.56.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 07:56:21 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 23 Jul 2008 21:56:03 +0700
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89672>

Sparse prefix is actually a list of prefixes separated by colons,
that will limit worktree usage within it.

This patch adds core.sparsecheckout and
"git rev-parse --show-sparse-prefix". This also adds manipulation
functions that will get used later.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-rev-parse.c |    4 +
 cache.h             |   13 +++
 config.c            |    7 ++
 environment.c       |  221 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 245 insertions(+), 0 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index aa71f4a..4200f14 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -499,6 +499,10 @@ int cmd_rev_parse(int argc, const char **argv, con=
st char *prefix)
 					puts(prefix);
 				continue;
 			}
+			if (!strcmp(arg, "--show-sparse-prefix")) {
+				puts(get_sparse_prefix_str());
+				continue;
+			}
 			if (!strcmp(arg, "--show-cdup")) {
 				const char *pfx =3D prefix;
 				if (!is_inside_work_tree()) {
diff --git a/cache.h b/cache.h
index 38985aa..4687096 100644
--- a/cache.h
+++ b/cache.h
@@ -319,6 +319,19 @@ extern const char *get_git_work_tree(void);
 extern const char *read_gitfile_gently(const char *path);
 extern void set_git_work_tree(const char *tree);
=20
+extern int sparse_checkout_enabled();
+extern char **get_sparse_prefix(void);
+extern const char *get_sparse_prefix_str(void);
+extern char **save_sparse_prefix();
+extern char **restore_sparse_prefix(char **prefix);
+extern int outside_sparse_prefix(const char *prefix);
+extern int index_outside_sparse_prefix(const char *prefix);
+extern void set_sparse_prefix(const char *prefix);
+extern char **split_prefix(const char *env);
+extern char **combine_prefix_list(char **p1, char **p2);
+extern void free_prefix_list(char **prefix_list);
+extern int outside_prefix_list(char **iprefix, const char *prefix);
+
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
=20
 extern const char **get_pathspec(const char *prefix, const char **path=
spec);
diff --git a/config.c b/config.c
index 1e066c7..e7b457b 100644
--- a/config.c
+++ b/config.c
@@ -467,6 +467,13 @@ static int git_default_core_config(const char *var=
, const char *value)
 		return 0;
 	}
=20
+	if (!strcmp(var, "core.sparsecheckout")) {
+		if (!value)
+			return config_error_nonbool(var);
+		set_sparse_prefix(value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. *=
/
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 4a88a17..94e39b8 100644
--- a/environment.c
+++ b/environment.c
@@ -46,9 +46,132 @@ enum rebase_setup_type autorebase =3D AUTOREBASE_NE=
VER;
 char *git_work_tree_cfg;
 static char *work_tree;
=20
+static char **sparse_prefix;
+
 static const char *git_dir;
 static char *git_object_dir, *git_index_file, *git_refs_dir, *git_graf=
t_file;
=20
+static char *append_slash(const char *prefix, int len)
+{
+	char *new_prefix;
+
+	if (!*prefix)
+		return NULL;
+
+	if (prefix[len-1] =3D=3D '/')
+		return xstrndup(prefix, len);
+
+	new_prefix =3D xmalloc(len+2);
+	memcpy(new_prefix, prefix, len);
+	new_prefix[len] =3D '/';
+	new_prefix[len+1] =3D '\0';
+	return new_prefix;
+}
+
+/* this should be sorted as same order as index */
+static int prefix_compare(const void *prefix1_, const void *prefix2_)
+{
+	const char *prefix1 =3D *(const char**)prefix1_;
+	const char *prefix2 =3D *(const char**)prefix2_;
+	int len1 =3D strlen(prefix1);
+	int len2 =3D strlen(prefix2);
+	int len =3D len1 < len2 ? len1 : len2;
+	int cmp =3D memcmp(prefix1, prefix2, len);
+	if (cmp)
+		return cmp;
+	if (len1 < len2)
+		return -1;
+	if (len1 > len2)
+		return 1;
+	return 0;
+}
+
+void free_prefix_list(char **prefix_list)
+{
+	char **prefix =3D prefix_list;
+
+	if (!prefix)
+		return;
+
+	while (*prefix) {
+		free(*prefix);
+		prefix++;
+	}
+	free(prefix_list);
+}
+
+char **split_prefix(const char *env)
+{
+	int prefix_nr =3D 0;
+	int prefix_alloc =3D 0;
+	char **prefix_list =3D NULL;
+
+	if (!env)
+		return NULL;
+
+	do {
+		const char *sep =3D strchr(env, ':');
+		int len =3D sep ? sep - env : strlen(env);
+		if (prefix_alloc <=3D prefix_nr+1) {
+			prefix_alloc =3D alloc_nr(prefix_alloc);
+			prefix_list =3D xrealloc(prefix_list,
+						prefix_alloc * sizeof(*prefix_list));
+		}
+		prefix_list[prefix_nr++] =3D append_slash(env, len);
+		env +=3D sep ? len+1 : len;
+	} while (*env);
+	prefix_list[prefix_nr] =3D NULL;
+	qsort(prefix_list, prefix_nr, sizeof(*prefix_list), prefix_compare);
+	return prefix_list;
+}
+
+char **combine_prefix_list(char **p1, char **p2)
+{
+	int len1 =3D 0, len2 =3D 0;
+	char **p, **p12, *last_prefix;
+	char **result, **result_p;
+
+	/*
+	 * if either of them is null, full access,
+	 * combining them would give full access as well
+	 */
+	if (!p1 || !p2)
+		return NULL;
+
+	for (p =3D p1; *p; p++)
+		len1++;
+	for (p =3D p2; *p; p++)
+		len2++;
+
+	p12 =3D xmalloc((len1+len2+1)*sizeof(*p12));
+	result =3D xmalloc((len1+len2+1)*sizeof(*result));
+	memcpy(p12, p1, len1*sizeof(*p12));
+	memcpy(p12+len1, p2, (len2+1)*sizeof(*p12));
+	qsort(p12, len1+len2, sizeof(*p12), prefix_compare);
+
+	p =3D p12;
+	last_prefix =3D *p;
+	p++;
+	result_p =3D result;
+	*result_p =3D xstrdup(last_prefix);
+	result_p++;
+	while (*p) {
+		if (!strcmp(*p, last_prefix)) {
+			p++;
+			continue;
+		}
+		if (!prefixcmp(*p, last_prefix)) {
+			p++;
+			continue;
+		}
+		*result_p =3D xstrdup(*p);
+		result_p++;
+		p++;
+	}
+	*result_p =3D NULL;
+	return result;
+}
+
 static void setup_git_env(void)
 {
 	git_dir =3D getenv(GIT_DIR_ENVIRONMENT);
@@ -122,6 +245,104 @@ const char *get_git_work_tree(void)
 	return work_tree;
 }
=20
+void set_sparse_prefix(const char *flat_sparse_prefix)
+{
+	free_prefix_list(sparse_prefix);
+	sparse_prefix =3D split_prefix(flat_sparse_prefix);
+}
+
+char **get_sparse_prefix()
+{
+	return sparse_prefix;
+}
+
+const char *get_sparse_prefix_str()
+{
+	static char **sparse_prefix =3D NULL;
+	static char *sparse_prefix_str =3D NULL;
+	int len;
+	char **prefix;
+
+	if (sparse_prefix =3D=3D get_sparse_prefix())
+		return sparse_prefix ? sparse_prefix_str : "";
+
+	sparse_prefix =3D get_sparse_prefix();
+
+	if (!sparse_prefix)
+		return "";
+
+	len =3D 0;
+	for (prefix =3D sparse_prefix; *prefix; prefix++)
+		len +=3D strlen(*prefix)+1;
+	if (sparse_prefix_str)
+		free(sparse_prefix_str);
+	sparse_prefix_str =3D xmalloc(len);
+
+	prefix =3D sparse_prefix;
+	len =3D strlen(*prefix);
+	if ((*prefix)[len-1] =3D=3D '/')
+		len--;
+	memcpy(sparse_prefix_str, *prefix, len);
+	prefix++;
+	while (*prefix) {
+		int len2 =3D strlen(*prefix);
+		sparse_prefix_str[len++] =3D ':';
+		if ((*prefix)[len2-1] =3D=3D '/')
+			len2--;
+		memcpy(sparse_prefix_str+len, *prefix, len2);
+		len +=3D len2;
+		prefix++;
+	}
+	sparse_prefix_str[len] =3D 0;
+	return sparse_prefix_str;
+}
+
+char **save_sparse_prefix()
+{
+	char **prefix =3D sparse_prefix;
+	sparse_prefix =3D NULL;
+	return prefix;
+}
+
+char **restore_sparse_prefix(char **prefix)
+{
+	char **old_prefix =3D sparse_prefix;
+	sparse_prefix =3D prefix;
+	return old_prefix;
+}
+
+int outside_prefix_list(char **iprefix, const char *prefix)
+{
+	if (!iprefix)
+		return 0;
+
+	while (*iprefix) {
+		if (!prefixcmp(prefix, *iprefix))
+			return 0;
+		iprefix++;
+	}
+	return 1;
+}
+
+int sparse_checkout_enabled()
+{
+	static int disable_sparse_checkout =3D -1;
+	if (disable_sparse_checkout =3D=3D -1)
+		disable_sparse_checkout =3D getenv("GIT_SPARSE_CHECKOUT_INDEX_ONLY")=
 !=3D NULL;
+	return !disable_sparse_checkout && get_sparse_prefix();
+}
+
+
+int outside_sparse_prefix(const char *prefix)
+{
+	return sparse_checkout_enabled() && outside_prefix_list(sparse_prefix=
, prefix);
+}
+
+int index_outside_sparse_prefix(const char *prefix)
+{
+	return outside_prefix_list(sparse_prefix, prefix);
+}
+
 char *get_object_directory(void)
 {
 	if (!git_object_dir)
--=20
1.5.5.GIT
