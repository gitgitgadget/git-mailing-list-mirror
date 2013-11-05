From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] Rename suffixcmp() to has_suffix() and inverse its result
Date: Tue, 05 Nov 2013 05:57:21 +0100
Message-ID: <20131105045722.20276.20853.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 05 06:03:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdYo2-0006GT-EU
	for gcvg-git-2@plane.gmane.org; Tue, 05 Nov 2013 06:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074Ab3KEFDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Nov 2013 00:03:54 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:60154 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751014Ab3KEFDx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Nov 2013 00:03:53 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 861EE46;
	Tue,  5 Nov 2013 06:03:31 +0100 (CET)
X-git-sha1: 00761cc20b862f6ccd6097cb87b9ab017ac6fd11 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237321>

As suffixcmp() should not be used as an ordering comparison function,
and anything-cmp() ought to be usable as an ordering comparison function,
suffixcmp() should be renamed to something that doesn't end with "cmp".

has_suffix() is a straightforward name for such a function, except
that with such a name callers will expect that it will return 1
when the suffix is present and 0 otherwise.

So we need to also inverse the value returned by this function to
match what the callers will expect, because suffixcmp() like all
anything-cmp() returns 0 when the suffix is present and 1 or -1
otherwise.

As we inverse the value returned by the function, we also have
to inverse the ways its callers are using its returned value.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
Hi Junio and Peff,

So here is a new version of the patch to rename
suffixcmp() into has_suffix(). We now inverse the
result of the function as we rename it.

This patch should be added to or squashed into the
patch series that removes postfixcmp().

Thanks,
Christian.

 builtin/clone.c           | 2 +-
 builtin/fetch.c           | 2 +-
 builtin/merge-recursive.c | 2 +-
 builtin/remote.c          | 6 +++---
 builtin/repack.c          | 2 +-
 connected.c               | 2 +-
 git-compat-util.h         | 2 +-
 strbuf.c                  | 6 +++---
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 874e0fd..84fb1bd 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -510,7 +510,7 @@ static void write_followtags(const struct ref *refs, const char *msg)
 	for (ref = refs; ref; ref = ref->next) {
 		if (prefixcmp(ref->name, "refs/tags/"))
 			continue;
-		if (!suffixcmp(ref->name, "^{}"))
+		if (has_suffix(ref->name, "^{}"))
 			continue;
 		if (!has_sha1_file(ref->old_sha1))
 			continue;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index bd7a101..8eb6cd0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -653,7 +653,7 @@ static void find_non_local_tags(struct transport *transport,
 		 * to fetch then we can mark the ref entry in the list
 		 * as one to ignore by setting util to NULL.
 		 */
-		if (!suffixcmp(ref->name, "^{}")) {
+		if (has_suffix(ref->name, "^{}")) {
 			if (item && !has_sha1_file(ref->old_sha1) &&
 			    !will_fetch(head, ref->old_sha1) &&
 			    !has_sha1_file(item->util) &&
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 3a64f5d..e7f1a39 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -29,7 +29,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	struct commit *result;
 
 	init_merge_options(&o);
-	if (argv[0] && !suffixcmp(argv[0], "-subtree"))
+	if (argv[0] && has_suffix(argv[0], "-subtree"))
 		o.subtree_shift = "";
 
 	if (argc < 4)
diff --git a/builtin/remote.c b/builtin/remote.c
index 9b3a98e..b9a1024 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -269,13 +269,13 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		enum { REMOTE, MERGE, REBASE } type;
 
 		key += 7;
-		if (!suffixcmp(key, ".remote")) {
+		if (has_suffix(key, ".remote")) {
 			name = xstrndup(key, strlen(key) - 7);
 			type = REMOTE;
-		} else if (!suffixcmp(key, ".merge")) {
+		} else if (has_suffix(key, ".merge")) {
 			name = xstrndup(key, strlen(key) - 6);
 			type = MERGE;
-		} else if (!suffixcmp(key, ".rebase")) {
+		} else if (has_suffix(key, ".rebase")) {
 			name = xstrndup(key, strlen(key) - 7);
 			type = REBASE;
 		} else
diff --git a/builtin/repack.c b/builtin/repack.c
index a0ff5c7..9ef518d 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -78,7 +78,7 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list)
 		return;
 
 	while ((e = readdir(dir)) != NULL) {
-		if (suffixcmp(e->d_name, ".pack"))
+		if (!has_suffix(e->d_name, ".pack"))
 			continue;
 
 		len = strlen(e->d_name) - strlen(".pack");
diff --git a/connected.c b/connected.c
index fae8d64..be9304e 100644
--- a/connected.c
+++ b/connected.c
@@ -38,7 +38,7 @@ int check_everything_connected_with_transport(sha1_iterate_fn fn,
 	if (transport && transport->smart_options &&
 	    transport->smart_options->self_contained_and_connected &&
 	    transport->pack_lockfile &&
-	    !suffixcmp(transport->pack_lockfile, ".keep")) {
+	    has_suffix(transport->pack_lockfile, ".keep")) {
 		struct strbuf idx_file = STRBUF_INIT;
 		strbuf_addstr(&idx_file, transport->pack_lockfile);
 		strbuf_setlen(&idx_file, idx_file.len - 5); /* ".keep" */
diff --git a/git-compat-util.h b/git-compat-util.h
index 7776f12..0f6a31e 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -351,7 +351,7 @@ extern void set_error_routine(void (*routine)(const char *err, va_list params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
 
 extern int prefixcmp(const char *str, const char *prefix);
-extern int suffixcmp(const char *str, const char *suffix);
+extern int has_suffix(const char *str, const char *suffix);
 
 static inline const char *skip_prefix(const char *str, const char *prefix)
 {
diff --git a/strbuf.c b/strbuf.c
index 9ba50de..0d784b5 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -10,13 +10,13 @@ int prefixcmp(const char *str, const char *prefix)
 			return (unsigned char)*prefix - (unsigned char)*str;
 }
 
-int suffixcmp(const char *str, const char *suffix)
+int has_suffix(const char *str, const char *suffix)
 {
 	int len = strlen(str), suflen = strlen(suffix);
 	if (len < suflen)
-		return -1;
+		return 0;
 	else
-		return !!strcmp(str + len - suflen, suffix);
+		return !strcmp(str + len - suflen, suffix);
 }
 
 /*
-- 
1.8.4.1.561.g186b3da.dirty
