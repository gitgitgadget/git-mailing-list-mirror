From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] git-fetch: more terse fetch output
Date: Sat, 03 Nov 2007 01:32:48 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0711030101340.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 06:33:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoBdh-0000nm-3d
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 06:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755729AbXKCFcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 01:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755851AbXKCFcv
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 01:32:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20136 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755648AbXKCFcu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 01:32:50 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQX00IGN0QOQ8C0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 03 Nov 2007 01:32:49 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63205>


This makes the fetch output much more terse and prettier on a 80 column 
display, based on a consensus reached on the mailing list.  Here's an 
example output:

Receiving objects: 100% (5439/5439), 1.60 MiB | 636 KiB/s, done.
Resolving deltas: 100% (4604/4604), done.
From git://git.kernel.org/pub/scm/git/git
 ! [rejected]        html -> origin/html  (non fast forward)
   136e631..f45e867  maint -> origin/maint  (fast forward)
   9850e2e..44dd7e0  man -> origin/man  (fast forward)
   3e4bb08..e3d6d56  master -> origin/master  (fast forward)
   fa3665c..536f64a  next -> origin/next  (fast forward)
 + 4f6d9d6...768326f pu -> origin/pu  (forced update)
 * [new branch]      todo -> origin/todo

Some portions of this patch have been extracted from earlier proposals
by Jeff King and Shawn Pearce.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 003ed76..960b1da 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -131,12 +131,6 @@ static struct ref *get_ref_map(struct transport *transport,
 	return ref_map;
 }
 
-static void show_new(enum object_type type, unsigned char *sha1_new)
-{
-	fprintf(stderr, "  %s: %s\n", typename(type),
-		find_unique_abbrev(sha1_new, DEFAULT_ABBREV));
-}
-
 static int s_update_ref(const char *action,
 			struct ref *ref,
 			int check_old)
@@ -157,34 +151,38 @@ static int s_update_ref(const char *action,
 	return 0;
 }
 
+#define SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
+
 static int update_local_ref(struct ref *ref,
-			    const char *note,
-			    int verbose)
+			    const char *remote,
+			    int verbose,
+			    char *display)
 {
-	char oldh[41], newh[41];
 	struct commit *current = NULL, *updated;
 	enum object_type type;
 	struct branch *current_branch = branch_get(NULL);
+	const char *pretty_ref = ref->name + (
+		!prefixcmp(ref->name, "refs/heads/") ? 11 :
+		!prefixcmp(ref->name, "refs/tags/") ? 10 :
+		!prefixcmp(ref->name, "refs/remotes/") ? 13 :
+		0);
 
+	*display = 0;
 	type = sha1_object_info(ref->new_sha1, NULL);
 	if (type < 0)
 		die("object %s not found", sha1_to_hex(ref->new_sha1));
 
 	if (!*ref->name) {
 		/* Not storing */
-		if (verbose) {
-			fprintf(stderr, "* fetched %s\n", note);
-			show_new(type, ref->new_sha1);
-		}
+		if (verbose)
+			sprintf(display, "* branch %s -> FETCH_HEAD", remote);
 		return 0;
 	}
 
 	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
-		if (verbose) {
-			fprintf(stderr, "* %s: same as %s\n",
-				ref->name, note);
-			show_new(type, ref->new_sha1);
-		}
+		if (verbose)
+			sprintf(display, "= %-*s %s -> %s", SUMMARY_WIDTH,
+				"[up to date]", remote, pretty_ref);
 		return 0;
 	}
 
@@ -196,63 +194,65 @@ static int update_local_ref(struct ref *ref,
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
-		fprintf(stderr,
-			" * %s: Cannot fetch into the current branch.\n",
-			ref->name);
+		sprintf(display, "! %-*s %s -> %s  (can't  fetch in current branch)",
+			SUMMARY_WIDTH, "[rejected]", remote, pretty_ref);
 		return 1;
 	}
 
 	if (!is_null_sha1(ref->old_sha1) &&
 	    !prefixcmp(ref->name, "refs/tags/")) {
-		fprintf(stderr, "* %s: updating with %s\n",
-			ref->name, note);
-		show_new(type, ref->new_sha1);
+		sprintf(display, "- %-*s %s -> %s",
+			SUMMARY_WIDTH, "[tag update]", remote, pretty_ref);
 		return s_update_ref("updating tag", ref, 0);
 	}
 
 	current = lookup_commit_reference_gently(ref->old_sha1, 1);
 	updated = lookup_commit_reference_gently(ref->new_sha1, 1);
 	if (!current || !updated) {
-		char *msg;
-		if (!strncmp(ref->name, "refs/tags/", 10))
+		const char *msg;
+		const char *what;
+		if (!strncmp(ref->name, "refs/tags/", 10)) {
 			msg = "storing tag";
-		else
+			what = "[new tag]";
+		}
+		else {
 			msg = "storing head";
-		fprintf(stderr, "* %s: storing %s\n",
-			ref->name, note);
-		show_new(type, ref->new_sha1);
+			what = "[new branch]";
+		}
+
+		sprintf(display, "* %-*s %s -> %s",
+			SUMMARY_WIDTH, what, remote, pretty_ref);
 		return s_update_ref(msg, ref, 0);
 	}
 
-	strcpy(oldh, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
-	strcpy(newh, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
-
 	if (in_merge_bases(current, &updated, 1)) {
-		fprintf(stderr, "* %s: fast forward to %s\n",
-			ref->name, note);
-		fprintf(stderr, "  old..new: %s..%s\n", oldh, newh);
+		char quickref[83];
+		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
+		strcat(quickref, "..");
+		strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
+		sprintf(display, "  %-*s %s -> %s  (fast forward)",
+			SUMMARY_WIDTH, quickref, remote, pretty_ref);
 		return s_update_ref("fast forward", ref, 1);
-	}
-	if (!force && !ref->force) {
-		fprintf(stderr,
-			"* %s: not updating to non-fast forward %s\n",
-			ref->name, note);
-		fprintf(stderr,
-			"  old...new: %s...%s\n", oldh, newh);
+	} else if (force || ref->force) {
+		char quickref[84];
+		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
+		strcat(quickref, "...");
+		strcat(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
+		sprintf(display, "+ %-*s %s -> %s  (forced update)",
+			SUMMARY_WIDTH, quickref, remote, pretty_ref);
+		return s_update_ref("forced-update", ref, 1);
+	} else {
+		sprintf(display, "! %-*s %s -> %s  (non fast forward)",
+			SUMMARY_WIDTH, "[rejected]", remote, pretty_ref);
 		return 1;
 	}
-	fprintf(stderr,
-		"* %s: forcing update to non-fast forward %s\n",
-		ref->name, note);
-	fprintf(stderr, "  old...new: %s...%s\n", oldh, newh);
-	return s_update_ref("forced-update", ref, 1);
 }
 
 static void store_updated_refs(const char *url, struct ref *ref_map)
 {
 	FILE *fp;
 	struct commit *commit;
-	int url_len, i, note_len;
+	int url_len, i, note_len, shown_url = 0;
 	char note[1024];
 	const char *what, *kind;
 	struct ref *rm;
@@ -315,8 +315,17 @@ static void store_updated_refs(const char *url, struct ref *ref_map)
 			rm->merge ? "" : "not-for-merge",
 			note);
 
-		if (ref)
-			update_local_ref(ref, note, verbose);
+		if (ref) {
+			update_local_ref(ref, what, verbose, note);
+			if (*note) {
+				if (!shown_url) {
+					fprintf(stderr, "From %.*s\n",
+							url_len, url);
+					shown_url = 1;
+				}
+				fprintf(stderr, " %s\n", note);
+			}
+		}
 	}
 	fclose(fp);
 }
@@ -376,9 +385,6 @@ static struct ref *find_non_local_tags(struct transport *transport,
 		if (!path_list_has_path(&existing_refs, ref_name) &&
 		    !path_list_has_path(&new_refs, ref_name) &&
 		    lookup_object(ref->old_sha1)) {
-			fprintf(stderr, "Auto-following %s\n",
-				ref_name);
-
 			path_list_insert(ref_name, &new_refs);
 
 			rm = alloc_ref(strlen(ref_name) + 1);
