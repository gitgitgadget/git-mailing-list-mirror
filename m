From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 02:22:19 -0400
Message-ID: <20071019062219.GA28499@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 19 08:22:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IilFk-0006EK-3i
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 08:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755786AbXJSGWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 02:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755267AbXJSGWZ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 02:22:25 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4408 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753921AbXJSGWY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 02:22:24 -0400
Received: (qmail 9671 invoked by uid 111); 19 Oct 2007 06:22:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 19 Oct 2007 02:22:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2007 02:22:19 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61657>

This makes the fetch output much more terse. It is likely to
be very controversial. Here's an example of the new output:

Indexing objects: 100% (1061/1061), done.
Resolving deltas: 100% (638/638), done.
==> git://repo.or.cz/git/spearce.git
 * branch gitk -> origin/gitk
 * branch maint -> origin/maint (fast forward)
 * branch master -> origin/master (fast forward)
 * branch next -> origin/next (fast forward)
 - branch pu -> origin/pu (non-fast forward, refused)
 * branch todo -> origin/todo (fast forward)
==> git://repo.or.cz/git/spearce.git
 * tag v1.5.3.2 -> v1.5.3.2

Particular changes include:
  - rather than each updated ref stating the remote url, the
    url is printed once before any refs
  - refs which did not update get a '-' rather than a '*'
  - the order is changed from "$to: storing $from" to
    "$from -> $to"
  - we abbreviate the local refs (chopping refs/heads,
    refs/tags, refs/remotes). This means we're losing
    information, but hopefully it is obvious when storing
    "origin/master" that it is in refs/remotes.
  - fast forward information goes at the end
  - cut out "Auto-following ..." text

What do people think? Some changes? All?

Other questions:
  - Is the "==>" too ugly? It needs to be short (many urls
    are almost 80 characters already), and it needs to stand
    out from the "resolving deltas" line, so I think some
    symbol is reasonable.
  - Should we omit "(fast forward)" since it is the usual
    case?
  - Should refs/remotes/* keep the "remotes/" part?
  - If you read the patch, there are a few cases covered
    that I don't show in the example. Are they ugly or
    better? I can't even figure out how to
    get the '==' case to show up.
  - Should tags always just say "tag $foo". Do we ever
    actually map the tags when following?
  - How annoying is the doubled '==> $url' line? It comes
    from the fact that we fetch the tags separately.

Somebody mentioned colorization on irc. I think that is reasonable but
should definitely wait for another patch.

---
 builtin-fetch.c |   73 +++++++++++++++++++++++++------------------------------
 1 files changed, 33 insertions(+), 40 deletions(-)

It drops more lines than it adds, so it _must_ be good!

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 3442f3d..4440521 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -123,12 +123,6 @@ static struct ref *get_ref_map(struct transport *transport,
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
@@ -157,6 +151,11 @@ static int update_local_ref(struct ref *ref,
 	struct commit *current = NULL, *updated;
 	enum object_type type;
 	struct branch *current_branch = branch_get(NULL);
+	const char *pretty_ref = ref->name + (
+		!prefixcmp(ref->name, "refs/heads/") ? 11 :
+		!prefixcmp(ref->name, "refs/tags/") ? 10 :
+		!prefixcmp(ref->name, "refs/remotes/") ? 13 :
+		0);
 
 	type = sha1_object_info(ref->new_sha1, NULL);
 	if (type < 0)
@@ -164,19 +163,15 @@ static int update_local_ref(struct ref *ref,
 
 	if (!*ref->name) {
 		/* Not storing */
-		if (verbose) {
-			fprintf(stderr, "* fetched %s\n", note);
-			show_new(type, ref->new_sha1);
-		}
+		if (verbose)
+			fprintf(stderr, " * branch %s -> FETCH_HEAD\n", note);
 		return 0;
 	}
 
 	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
-		if (verbose) {
-			fprintf(stderr, "* %s: same as %s\n",
-				ref->name, note);
-			show_new(type, ref->new_sha1);
-		}
+		if (verbose)
+			fprintf(stderr, " - %s == %s\n",
+				note, pretty_ref);
 		return 0;
 	}
 
@@ -189,30 +184,33 @@ static int update_local_ref(struct ref *ref,
 		 * the head, and the old value of the head isn't empty...
 		 */
 		fprintf(stderr,
-			" * %s: Cannot fetch into the current branch.\n",
-			ref->name);
+			" - %s: Cannot fetch into the current branch.\n",
+			pretty_ref);
 		return 1;
 	}
 
 	if (!is_null_sha1(ref->old_sha1) &&
 	    !prefixcmp(ref->name, "refs/tags/")) {
-		fprintf(stderr, "* %s: updating with %s\n",
-			ref->name, note);
-		show_new(type, ref->new_sha1);
+		fprintf(stderr, " * tag %s -> %s\n",
+			note, pretty_ref);
 		return s_update_ref("updating tag", ref, 0);
 	}
 
 	current = lookup_commit_reference(ref->old_sha1);
 	updated = lookup_commit_reference(ref->new_sha1);
 	if (!current || !updated) {
-		char *msg;
-		if (!strncmp(ref->name, "refs/tags/", 10))
+		const char *msg;
+		const char *what;
+		if (!strncmp(ref->name, "refs/tags/", 10)) {
 			msg = "storing tag";
-		else
+			what = "tag";
+		}
+		else {
 			msg = "storing head";
-		fprintf(stderr, "* %s: storing %s\n",
-			ref->name, note);
-		show_new(type, ref->new_sha1);
+			what = "branch";
+		}
+		fprintf(stderr, " * %s %s -> %s\n",
+			what, note, pretty_ref);
 		return s_update_ref(msg, ref, 0);
 	}
 
@@ -220,23 +218,19 @@ static int update_local_ref(struct ref *ref,
 	strcpy(newh, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
 
 	if (in_merge_bases(current, &updated, 1)) {
-		fprintf(stderr, "* %s: fast forward to %s\n",
-			ref->name, note);
-		fprintf(stderr, "  old..new: %s..%s\n", oldh, newh);
+		fprintf(stderr, " * branch %s -> %s (fast forward)\n",
+			note, pretty_ref);
 		return s_update_ref("fast forward", ref, 1);
 	}
 	if (!force && !ref->force) {
 		fprintf(stderr,
-			"* %s: not updating to non-fast forward %s\n",
-			ref->name, note);
-		fprintf(stderr,
-			"  old...new: %s...%s\n", oldh, newh);
+			" - branch %s -> %s (non-fast forward, refused)\n",
+			note, pretty_ref);
 		return 1;
 	}
 	fprintf(stderr,
-		"* %s: forcing update to non-fast forward %s\n",
-		ref->name, note);
-	fprintf(stderr, "  old...new: %s...%s\n", oldh, newh);
+		" * branch %s -> %s (non-fast forward)\n",
+		note, pretty_ref);
 	return s_update_ref("forced-update", ref, 1);
 }
 
@@ -249,6 +243,8 @@ static void store_updated_refs(const char *url, struct ref *ref_map)
 	const char *what, *kind;
 	struct ref *rm;
 
+	fprintf(stderr, "==> %s\n", url);
+
 	fp = fopen(git_path("FETCH_HEAD"), "a");
 	for (rm = ref_map; rm; rm = rm->next) {
 		struct ref *ref = NULL;
@@ -308,7 +304,7 @@ static void store_updated_refs(const char *url, struct ref *ref_map)
 			note);
 
 		if (ref)
-			update_local_ref(ref, note, verbose);
+			update_local_ref(ref, what, verbose);
 	}
 	fclose(fp);
 }
@@ -368,9 +364,6 @@ static struct ref *find_non_local_tags(struct transport *transport,
 		if (!path_list_has_path(&existing_refs, ref_name) &&
 		    !path_list_has_path(&new_refs, ref_name) &&
 		    lookup_object(ref->old_sha1)) {
-			fprintf(stderr, "Auto-following %s\n",
-				ref_name);
-
 			path_list_insert(ref_name, &new_refs);
 
 			rm = alloc_ref(strlen(ref_name) + 1);
-- 
1.5.3.4.1252.g21baf-dirty
