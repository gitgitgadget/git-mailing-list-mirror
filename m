From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 03/15] Move parse-options's skip_prefix() to git-compat-util.h
Date: Fri, 27 Jun 2008 18:21:56 +0200
Message-ID: <876e733753999f116bfd975d9a262a5c1b3855a1.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
 <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org>
 <4a9a3a34d8c42b60f002acb20083cb9e187c262f.1214581610.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 18:24:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCGk4-0004E3-1b
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 18:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209AbYF0QWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 12:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755128AbYF0QWS
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 12:22:18 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:45323 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759744AbYF0QWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 12:22:09 -0400
Received: from vmobile.example.net (dsl5401C209.pool.t-online.hu [84.1.194.9])
	by yugo.frugalware.org (Postfix) with ESMTP id BE6561DDC5B;
	Fri, 27 Jun 2008 18:22:05 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id B3E9818E825; Fri, 27 Jun 2008 18:22:08 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <4a9a3a34d8c42b60f002acb20083cb9e187c262f.1214581610.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1214581610.git.vmiklos@frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86582>

builtin-remote.c and parse-options.c both have a skip_prefix() function,
for the same purpose. Move parse-options's one to git-compat-util.h and
let builtin-remote use it as well.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 6f94a81..31edc98 100644
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
index b8bde2b..bbc3ca4 100644
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
