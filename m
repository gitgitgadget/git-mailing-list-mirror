From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Move parse-options's skip_prefix() to git-compat-util.h
Date: Sat,  7 Jun 2008 01:42:04 +0200
Message-ID: <1212795724-24749-1-git-send-email-vmiklos@frugalware.org>
References: <7vtzg7zew0.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 01:43:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4laI-0005Zs-HC
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 01:43:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbYFFXmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 19:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758206AbYFFXmG
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 19:42:06 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:34906 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756951AbYFFXmF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 19:42:05 -0400
Received: from vmobile.example.net (catv-5062e605.catv.broadband.hu [80.98.230.5])
	by yugo.frugalware.org (Postfix) with ESMTP id 76AF11DDC5B;
	Sat,  7 Jun 2008 01:42:01 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 52ACA18E2A7; Sat,  7 Jun 2008 01:42:04 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
In-Reply-To: <7vtzg7zew0.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84145>

builtin-remote.c and parse-options.c both have a skip_prefix() function,
for the same purpose. Move parse-options's one to git-compat-util.h and
let builtin-remote use it as well.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Thu, Jun 05, 2008 at 03:38:23PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Somehow you seemed to have picked the one whose semantics is defined
> much
> less clearly.  For one thing, it takes more effort (and unnatural way
> to
> check) for the caller to detect the case where prefix did not match
> than
> the one that returns NULL.  Worse, I think this one is less efficient,
> doing strlen(prefix) twice.

Here is what I pushed to my working branch.

 builtin-remote.c  |   39 ++++++++++++++++++++++++++-------------
 git-compat-util.h |    6 ++++++
 parse-options.c   |    6 ------
 3 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index c49f00f..2bf0593 100644
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
 
@@ -504,10 +512,15 @@ static int show_or_prune(int argc, const char **argv, int prune)
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
index 01c4045..67a0b81 100644
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
1.5.6.rc0.dirty
