From: Petr Baudis <pasky@suse.cz>
Subject: [RFC][PATCH] for_each_ref() returning heads in wrong order
Date: Sat, 23 Sep 2006 18:36:21 +0200
Message-ID: <20060923160712.5890.73139.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 18:36:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRAUO-0007q0-EG
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 18:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWIWQgY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 12:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWIWQgY
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 12:36:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47021 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751270AbWIWQgX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 12:36:23 -0400
Received: (qmail 14653 invoked by uid 2001); 23 Sep 2006 18:36:21 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27597>

Using the #next branch I've now hit a problem with git-fetch-pack
master choosing refs/bases/master (I geuss created by StGIT) instead
of refs/heads/master. The old upload-pack returned the refs in the order
heads-tags-everything_else but the new one just goes for whatever order
readdir() returns them in (modulo merging with packed refs). I actually
can't see the difference that caused this right now, though.

This is a _really ugly_ patch to fix that.  I wonder if there's a more
elegant solution to this.

If you have your refs already packed, you should somehow unpack them
and then pack them again.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 I send the patch with the hope that someone will be so irritated by it
that he'll create a nicer one. ;-)

 refs.c |   39 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 2cef2b4..9b3986a 100644
--- a/refs.c
+++ b/refs.c
@@ -91,7 +91,8 @@ static struct ref_list *get_packed_refs(
 	return refs;
 }
 
-static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
+static struct ref_list *get_ref_dir(const char *base, struct ref_list *list,
+                                    char **except)
 {
 	DIR *dir = opendir(git_path("%s", base));
 
@@ -121,7 +122,13 @@ static struct ref_list *get_ref_dir(cons
 			if (stat(git_path("%s", ref), &st) < 0)
 				continue;
 			if (S_ISDIR(st.st_mode)) {
-				list = get_ref_dir(ref, list);
+				if (except) {
+					char **e;
+					for (e = except; *e; e++)
+						if (!strcmp(*e, ref))
+							goto nextitem;
+				}
+				list = get_ref_dir(ref, list, except);
 				continue;
 			}
 			if (!resolve_ref(ref, sha1, 1, &flag)) {
@@ -129,6 +136,7 @@ static struct ref_list *get_ref_dir(cons
 				continue;
 			}
 			list = add_ref(ref, sha1, flag, list);
+nextitem:;
 		}
 		free(ref);
 		closedir(dir);
@@ -142,7 +150,23 @@ static struct ref_list *get_loose_refs(v
 	static struct ref_list *refs = NULL;
 
 	if (!did_refs) {
-		refs = get_ref_dir("refs", NULL);
+		/* We need to make sure refs/heads and refs/tags always
+		 * go before everything else. */
+		char *except[] = {"refs/heads", "refs/tags", NULL};
+		struct ref_list *other_refs = NULL, *r;
+
+		refs = get_ref_dir("refs/heads", NULL, NULL);
+		refs = get_ref_dir("refs/tags", refs, NULL);
+
+		other_refs = get_ref_dir("refs", NULL, except);
+		if (refs) {
+			for (r = refs; r->next; r = r->next)
+				;
+			r->next = other_refs;
+		} else {
+			refs = other_refs;
+		}
+
 		did_refs = 1;
 	}
 	return refs;
@@ -298,10 +322,19 @@ static int do_for_each_ref(const char *b
 	while (packed && loose) {
 		struct ref_list *entry;
 		int cmp = strcmp(packed->name, loose->name);
+		int packed_is_ht, loose_is_ht;
 		if (!cmp) {
 			packed = packed->next;
 			continue;
 		}
+		/* We need to make sure refs/heads and refs/tags always
+		 * go before everything else. */
+		packed_is_ht = !strncmp(packed->name, "refs/heads", 10)
+		               || !strncmp(packed->name, "refs/tags", 9);
+		loose_is_ht = !strncmp(loose->name, "refs/heads", 10)
+		              || !strncmp(loose->name, "refs/tags", 9);
+		if (packed_is_ht != loose_is_ht)
+			cmp = loose_is_ht - packed_is_ht;
 		if (cmp > 0) {
 			entry = loose;
 			loose = loose->next;
