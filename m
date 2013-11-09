From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 26/86] refs: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:19 +0100
Message-ID: <20131109070720.18178.64556.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2hO-0005D8-P9
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933363Ab3KIHLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:11:10 -0500
Received: from mail-1y.bbox.fr ([194.158.98.14]:65415 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933262Ab3KIHIc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:32 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 9183690;
	Sat,  9 Nov 2013 08:08:30 +0100 (CET)
X-git-sha1: 447ad76169d9fcd8798b36e1aa54f7248fb949c1 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237529>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 refs.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/refs.c b/refs.c
index 3710748..3dc38df 100644
--- a/refs.c
+++ b/refs.c
@@ -637,7 +637,7 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
 	struct ref_entry *old_current_ref;
 	int retval;
 
-	if (prefixcmp(entry->name, data->base))
+	if (!has_prefix(entry->name, data->base))
 		return 0;
 
 	if (!(data->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
@@ -1049,7 +1049,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 		if (refname) {
 			last = create_ref_entry(refname, sha1, REF_ISPACKED, 1);
 			if (peeled == PEELED_FULLY ||
-			    (peeled == PEELED_TAGS && !prefixcmp(refname, "refs/tags/")))
+			    (peeled == PEELED_TAGS && has_prefix(refname, "refs/tags/")))
 				last->flag |= REF_KNOWS_PEELED;
 			add_ref(dir, last);
 			continue;
@@ -1383,7 +1383,7 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 					return NULL;
 			}
 			buffer[len] = 0;
-			if (!prefixcmp(buffer, "refs/") &&
+			if (has_prefix(buffer, "refs/") &&
 					!check_refname_format(buffer, 0)) {
 				strcpy(refname_buffer, buffer);
 				refname = refname_buffer;
@@ -1422,7 +1422,7 @@ const char *resolve_ref_unsafe(const char *refname, unsigned char *sha1, int rea
 		/*
 		 * Is it a symbolic ref?
 		 */
-		if (prefixcmp(buffer, "ref:")) {
+		if (!has_prefix(buffer, "ref:")) {
 			/*
 			 * Please note that FETCH_HEAD has a second
 			 * line containing other data.
@@ -1844,7 +1844,7 @@ int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 	struct ref_filter filter;
 	int ret;
 
-	if (!prefix && prefixcmp(pattern, "refs/"))
+	if (!prefix && !has_prefix(pattern, "refs/"))
 		strbuf_addstr(&real_pattern, "refs/");
 	else if (prefix)
 		strbuf_addstr(&real_pattern, prefix);
@@ -1881,9 +1881,9 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
 const char *prettify_refname(const char *name)
 {
 	return name + (
-		!prefixcmp(name, "refs/heads/") ? 11 :
-		!prefixcmp(name, "refs/tags/") ? 10 :
-		!prefixcmp(name, "refs/remotes/") ? 13 :
+		has_prefix(name, "refs/heads/") ? 11 :
+		has_prefix(name, "refs/tags/") ? 10 :
+		has_prefix(name, "refs/remotes/") ? 13 :
 		0);
 }
 
@@ -2251,7 +2251,7 @@ static int pack_if_possible_fn(struct ref_entry *entry, void *cb_data)
 	struct pack_refs_cb_data *cb = cb_data;
 	enum peel_status peel_status;
 	struct ref_entry *packed_entry;
-	int is_tag_ref = !prefixcmp(entry->name, "refs/tags/");
+	int is_tag_ref = has_prefix(entry->name, "refs/tags/");
 
 	/* ALWAYS pack tags */
 	if (!(cb->flags & PACK_REFS_ALL) && !is_tag_ref)
@@ -2686,9 +2686,9 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
 
 	git_snpath(logfile, bufsize, "logs/%s", refname);
 	if (log_all_ref_updates &&
-	    (!prefixcmp(refname, "refs/heads/") ||
-	     !prefixcmp(refname, "refs/remotes/") ||
-	     !prefixcmp(refname, "refs/notes/") ||
+	    (has_prefix(refname, "refs/heads/") ||
+	     has_prefix(refname, "refs/remotes/") ||
+	     has_prefix(refname, "refs/notes/") ||
 	     !strcmp(refname, "HEAD"))) {
 		if (safe_create_leading_directories(logfile) < 0)
 			return error("unable to create directory for %s",
@@ -2758,7 +2758,7 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 
 static int is_branch(const char *refname)
 {
-	return !strcmp(refname, "HEAD") || !prefixcmp(refname, "refs/heads/");
+	return !strcmp(refname, "HEAD") || has_prefix(refname, "refs/heads/");
 }
 
 int write_ref_sha1(struct ref_lock *lock,
@@ -3457,7 +3457,7 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 {
 	if (!strcmp("transfer.hiderefs", var) ||
 	    /* NEEDSWORK: use parse_config_key() once both are merged */
-	    (!prefixcmp(var, section) && var[strlen(section)] == '.' &&
+	    (has_prefix(var, section) && var[strlen(section)] == '.' &&
 	     !strcmp(var + strlen(section), ".hiderefs"))) {
 		char *ref;
 		int len;
@@ -3485,7 +3485,7 @@ int ref_is_hidden(const char *refname)
 		return 0;
 	for_each_string_list_item(item, hide_refs) {
 		int len;
-		if (prefixcmp(refname, item->string))
+		if (!has_prefix(refname, item->string))
 			continue;
 		len = strlen(item->string);
 		if (!refname[len] || refname[len] == '/')
-- 
1.8.4.1.566.geca833c
