From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 2/2] Rename suffixcmp() to ends_with() and invert its result
Date: Sun, 17 Nov 2013 09:39:29 +0100
Message-ID: <20131117083930.4177.79411.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>,
	Andreas Ericsson <ae@op5.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 17 09:57:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhyAP-0005qP-By
	for gcvg-git-2@plane.gmane.org; Sun, 17 Nov 2013 09:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392Ab3KQI5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 03:57:10 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:57208 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794Ab3KQI5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 03:57:07 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 0324454;
	Sun, 17 Nov 2013 09:57:04 +0100 (CET)
X-git-sha1: 12affcaeaaf5b326a5a37f3b03269e38135c15cb 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237955>

Now ends_with() returns 1 when the suffix is present and 0 otherwise.

The old name followed the pattern anything-cmp(), which suggests
a general comparison function suitable for e.g. sorting objects.
But this was not the case for suffixcmp().

Some popular programming languages have functions or methods
called using "end" and "with" that are doing what we want.
Therefore it makes sense to use ends_with() as a function
name to replace suffixcmp().

And in vcs-svn/fast_export.c there was already an ends_with()
function that did the same thing. Let's used the renamed one
while at it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/clone.c           |  2 +-
 builtin/fetch.c           |  2 +-
 builtin/merge-recursive.c |  2 +-
 builtin/remote.c          |  6 +++---
 builtin/repack.c          |  2 +-
 connected.c               |  2 +-
 git-compat-util.h         |  2 +-
 strbuf.c                  |  6 +++---
 vcs-svn/fast_export.c     | 11 +----------
 9 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 874e0fd..7c0c5cf 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -510,7 +510,7 @@ static void write_followtags(const struct ref *refs, const char *msg)
 	for (ref = refs; ref; ref = ref->next) {
 		if (prefixcmp(ref->name, "refs/tags/"))
 			continue;
-		if (!suffixcmp(ref->name, "^{}"))
+		if (ends_with(ref->name, "^{}"))
 			continue;
 		if (!has_sha1_file(ref->old_sha1))
 			continue;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index bd7a101..0db2631 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -653,7 +653,7 @@ static void find_non_local_tags(struct transport *transport,
 		 * to fetch then we can mark the ref entry in the list
 		 * as one to ignore by setting util to NULL.
 		 */
-		if (!suffixcmp(ref->name, "^{}")) {
+		if (ends_with(ref->name, "^{}")) {
 			if (item && !has_sha1_file(ref->old_sha1) &&
 			    !will_fetch(head, ref->old_sha1) &&
 			    !has_sha1_file(item->util) &&
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 3a64f5d..4111b98 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -29,7 +29,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	struct commit *result;
 
 	init_merge_options(&o);
-	if (argv[0] && !suffixcmp(argv[0], "-subtree"))
+	if (argv[0] && ends_with(argv[0], "-subtree"))
 		o.subtree_shift = "";
 
 	if (argc < 4)
diff --git a/builtin/remote.c b/builtin/remote.c
index 9b3a98e..cd56542 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -269,13 +269,13 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		enum { REMOTE, MERGE, REBASE } type;
 
 		key += 7;
-		if (!suffixcmp(key, ".remote")) {
+		if (ends_with(key, ".remote")) {
 			name = xstrndup(key, strlen(key) - 7);
 			type = REMOTE;
-		} else if (!suffixcmp(key, ".merge")) {
+		} else if (ends_with(key, ".merge")) {
 			name = xstrndup(key, strlen(key) - 6);
 			type = MERGE;
-		} else if (!suffixcmp(key, ".rebase")) {
+		} else if (ends_with(key, ".rebase")) {
 			name = xstrndup(key, strlen(key) - 7);
 			type = REBASE;
 		} else
diff --git a/builtin/repack.c b/builtin/repack.c
index a0ff5c7..938bc75 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -78,7 +78,7 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list)
 		return;
 
 	while ((e = readdir(dir)) != NULL) {
-		if (suffixcmp(e->d_name, ".pack"))
+		if (!ends_with(e->d_name, ".pack"))
 			continue;
 
 		len = strlen(e->d_name) - strlen(".pack");
diff --git a/connected.c b/connected.c
index fae8d64..51d8ba4 100644
--- a/connected.c
+++ b/connected.c
@@ -38,7 +38,7 @@ int check_everything_connected_with_transport(sha1_iterate_fn fn,
 	if (transport && transport->smart_options &&
 	    transport->smart_options->self_contained_and_connected &&
 	    transport->pack_lockfile &&
-	    !suffixcmp(transport->pack_lockfile, ".keep")) {
+	    ends_with(transport->pack_lockfile, ".keep")) {
 		struct strbuf idx_file = STRBUF_INIT;
 		strbuf_addstr(&idx_file, transport->pack_lockfile);
 		strbuf_setlen(&idx_file, idx_file.len - 5); /* ".keep" */
diff --git a/git-compat-util.h b/git-compat-util.h
index 7776f12..37f0ba0 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -351,7 +351,7 @@ extern void set_error_routine(void (*routine)(const char *err, va_list params));
 extern void set_die_is_recursing_routine(int (*routine)(void));
 
 extern int prefixcmp(const char *str, const char *prefix);
-extern int suffixcmp(const char *str, const char *suffix);
+extern int ends_with(const char *str, const char *suffix);
 
 static inline const char *skip_prefix(const char *str, const char *prefix)
 {
diff --git a/strbuf.c b/strbuf.c
index 1170d01..2a14fdb 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -10,13 +10,13 @@ int prefixcmp(const char *str, const char *prefix)
 			return (unsigned char)*prefix - (unsigned char)*str;
 }
 
-int suffixcmp(const char *str, const char *suffix)
+int ends_with(const char *str, const char *suffix)
 {
 	int len = strlen(str), suflen = strlen(suffix);
 	if (len < suflen)
-		return -1;
+		return 0;
 	else
-		return strcmp(str + len - suflen, suffix);
+		return !strcmp(str + len - suflen, suffix);
 }
 
 /*
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index f2b23c8..bd0f2c2 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -162,22 +162,13 @@ static void die_short_read(struct line_buffer *input)
 	die("invalid dump: unexpected end of file");
 }
 
-static int ends_with(const char *s, size_t len, const char *suffix)
-{
-	const size_t suffixlen = strlen(suffix);
-	if (len < suffixlen)
-		return 0;
-	return !memcmp(s + len - suffixlen, suffix, suffixlen);
-}
-
 static int parse_cat_response_line(const char *header, off_t *len)
 {
-	size_t headerlen = strlen(header);
 	uintmax_t n;
 	const char *type;
 	const char *end;
 
-	if (ends_with(header, headerlen, " missing"))
+	if (ends_with(header, " missing"))
 		return error("cat-blob reports missing blob: %s", header);
 	type = strstr(header, " blob ");
 	if (!type)
-- 
1.8.4.1.561.g12affca
