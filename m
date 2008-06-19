From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 03/11] Move parse-options's skip_prefix() to git-compat-util.h
Date: Fri, 20 Jun 2008 01:22:28 +0200
Message-ID: <f41fbf4630e6341ae89eacad52c465cecc605e42.1213917600.git.vmiklos@frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
 <b9fc7f1cc6c36ba197ed2c0394a6b89ed33c4b96.1213917600.git.vmiklos@frugalware.org>
 <45f73cd0355a5375dcd8a123dd0facf5cad99061.1213917600.git.vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 20 01:24:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9TUR-0006Vg-M6
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 01:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbYFSXWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 19:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753732AbYFSXWw
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 19:22:52 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46951 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346AbYFSXWp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 19:22:45 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 4405C1DDC62
	for <git@vger.kernel.org>; Fri, 20 Jun 2008 01:22:40 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 8AA8E18E0E5; Fri, 20 Jun 2008 01:22:36 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <45f73cd0355a5375dcd8a123dd0facf5cad99061.1213917600.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1213917600.git.vmiklos@frugalware.org>
References: <cover.1213917600.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85567>

builtin-remote.c and parse-options.c both have a skip_prefix() function,
for the same purpose. Move parse-options's one to git-compat-util.h and
let builtin-remote use it as well.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-remote.c  |   39 ++++++++++++++++++++++++++-------------
 git-compat-util.h |    6 ++++++
 parse-options.c   |    6 ------
 3 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 145dd85..1491354 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -29,12 +29,6 @@ static inline int postfixcmp(const char *string, const char *postfix)
 	return strcmp(string + len1 - len2, postfix);
 }
 
-static inline const char *skip_prefix(const char *name, const char *prefix)
-{
-	return !name ? "" :
-		prefixcmp(name, prefix) ?  name : name + strlen(prefix);
-}
-
 static int opt_parse_track(const struct option *opt, const char *arg, int not)
 {
 	struct path_list *list = opt->value;
@@ -182,12 +176,18 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 			info->remote = xstrdup(value);
 		} else {
 			char *space = strchr(value, ' ');
-			value = skip_prefix(value, "refs/heads/");
+			const char *ptr = skip_prefix(value, "refs/heads/");
+			if (ptr)
+				value = ptr;
 			while (space) {
 				char *merge;
 				merge = xstrndup(value, space - value);
 				path_list_append(merge, &info->merge);
-				value = skip_prefix(space + 1, "refs/heads/");
+				ptr = skip_prefix(space + 1, "refs/heads/");
+				if (ptr)
+					value = ptr;
+				else
+					value = space + 1;
 				space = strchr(value, ' ');
 			}
 			path_list_append(xstrdup(value), &info->merge);
@@ -219,7 +219,12 @@ static int handle_one_branch(const char *refname,
 	refspec.dst = (char *)refname;
 	if (!remote_find_tracking(states->remote, &refspec)) {
 		struct path_list_item *item;
-		const char *name = skip_prefix(refspec.src, "refs/heads/");
+		const char *name, *ptr;
+		ptr = skip_prefix(refspec.src, "refs/heads/");
+		if (ptr)
+			name = ptr;
+		else
+			name = refspec.src;
 		/* symbolic refs pointing nowhere were handled already */
 		if ((flags & REF_ISSYMREF) ||
 				unsorted_path_list_has_path(&states->tracked,
@@ -248,6 +253,7 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
 		struct path_list *target = &states->tracked;
 		unsigned char sha1[20];
 		void *util = NULL;
+		const char *ptr;
 
 		if (!ref->peer_ref || read_ref(ref->peer_ref->name, sha1))
 			target = &states->new;
@@ -256,8 +262,10 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
 			if (hashcmp(sha1, ref->new_sha1))
 				util = &states;
 		}
-		path_list_append(skip_prefix(ref->name, "refs/heads/"),
-				target)->util = util;
+		ptr = skip_prefix(ref->name, "refs/heads/");
+		if (!ptr)
+			ptr = ref->name;
+		path_list_append(ptr, target)->util = util;
 	}
 	free_refs(fetch_map);
 
@@ -522,10 +530,15 @@ static int show(int argc, const char **argv)
 					"es" : "");
 			for (i = 0; i < states.remote->push_refspec_nr; i++) {
 				struct refspec *spec = states.remote->push + i;
+				const char *p = "", *q = "";
+				if (spec->src)
+					p = skip_prefix(spec->src, "refs/heads/");
+				if (spec->dst)
+					q = skip_prefix(spec->dst, "refs/heads/");
 				printf(" %s%s%s%s", spec->force ? "+" : "",
-					skip_prefix(spec->src, "refs/heads/"),
+					p ? p : spec->src,
 					spec->dst ? ":" : "",
-					skip_prefix(spec->dst, "refs/heads/"));
+					q ? q : spec->dst);
 			}
 			printf("\n");
 		}
diff --git a/git-compat-util.h b/git-compat-util.h
index c04e8ba..6470d6c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -127,6 +127,12 @@ extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
 
 extern int prefixcmp(const char *str, const char *prefix);
 
+static inline const char *skip_prefix(const char *str, const char *prefix)
+{
+	size_t len = strlen(prefix);
+	return strncmp(str, prefix, len) ? NULL : str + len;
+}
+
 #ifdef NO_MMAP
 
 #ifndef PROT_READ
diff --git a/parse-options.c b/parse-options.c
index acf3fe3..b98833c 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -22,12 +22,6 @@ static inline const char *get_arg(struct optparse_t *p)
 	return *++p->argv;
 }
 
-static inline const char *skip_prefix(const char *str, const char *prefix)
-{
-	size_t len = strlen(prefix);
-	return strncmp(str, prefix, len) ? NULL : str + len;
-}
-
 static int opterror(const struct option *opt, const char *reason, int flags)
 {
 	if (flags & OPT_SHORT)
-- 
1.5.6
