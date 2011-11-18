From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 8/8] Enable GIT_DEBUG_MEMCHECK on git_pathname()
Date: Thu, 17 Nov 2011 19:27:46 -0600
Message-ID: <20111118012746.GA22485@elie.hsd1.il.comcast.net>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
 <1321522335-24193-9-git-send-email-pclouds@gmail.com>
 <CALkWK0ndE1Q_jNSV7CBB5W2NyVhcy7kgNO5woWWOw6CXx3cxcA@mail.gmail.com>
 <20111117134201.GA30718@sigill.intra.peff.net>
 <CACsJy8A25SyLVKv8GwkYaHBJwU5tHqgdJK6L-upF9HWseFzCtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 02:28:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRDFM-0002If-Ln
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 02:28:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755103Ab1KRB2A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 20:28:00 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40769 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007Ab1KRB16 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2011 20:27:58 -0500
Received: by ggnb2 with SMTP id b2so1886530ggn.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 17:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ho7Uv6KQ6u3EI8Rbb291ThbETv8aGSzJUlZiTTqGGXo=;
        b=d9XsOuVaDsc08imsQfYADNQSOfr4lPs9Buh/YD9/S9OWIzwA1S3oql6Fl3Tvo1cFNM
         Sf6nP3iUlSRQNE13UAtYt0eTqZdw4fwxLnsLJu03JDxqOwW4PBKtrN3SOAcoGsj1FO/i
         Pow9+PDN86JXN+NtJPCRxmcDxX/eyaP/ulTEk=
Received: by 10.236.78.129 with SMTP id g1mr1522452yhe.52.1321579678304;
        Thu, 17 Nov 2011 17:27:58 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id m29sm8636891yhi.20.2011.11.17.17.27.56
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 17:27:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8A25SyLVKv8GwkYaHBJwU5tHqgdJK6L-upF9HWseFzCtQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185618>

Nguyen Thai Ngoc Duy wrote:

> Anyway to detect if __VA_ARGS__ is supported at compile time? I guess
> #ifdef __GNUC__ is the last resort.

Why would one want to do that?  Either your feature requires C99 (so th=
e
build can error out if __VA_ARGS__ support is missing) or it doesn't.

> notes-merge.c introduces __VA_ARGS__ since v1.7.4 so we may want to d=
o
> something there too.

Good catch.  How about this patch?  It seems I forgot to send it out
last May and it has been rotting in my local tree ever since.

-- >8 --
Subject: notes merge: eliminate OUTPUT macro

The macro is variadic, which breaks support for pre-C99 compilers,
and it hides an "if", which can make code hard to understand on
first reading if some arguments have side-effects.

The OUTPUT macro seems to have been inspired by the "output" function
from merge-recursive.  But that function in merge-recursive exists to
indent output based on the level of recursion and there is no similar
justification for such a function in "notes merge".

Noticed with 'make CC=3D"gcc -std=3Dc89 -pedantic"':

 notes-merge.c:24:22: warning: anonymous variadic macros were introduce=
d in C99 [-Wvariadic-macros]

Encouraged-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 notes-merge.c |  104 +++++++++++++++++++++++++++++++++----------------=
-------
 1 files changed, 61 insertions(+), 43 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index baaf31f4..d0e5034d 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -21,14 +21,6 @@ void init_notes_merge_options(struct notes_merge_opt=
ions *o)
 	o->verbosity =3D NOTES_MERGE_VERBOSITY_DEFAULT;
 }
=20
-#define OUTPUT(o, v, ...) \
-	do { \
-		if ((o)->verbosity >=3D (v)) { \
-			printf(__VA_ARGS__); \
-			puts(""); \
-		} \
-	} while (0)
-
 static int path_to_sha1(const char *path, unsigned char *sha1)
 {
 	char hex_sha1[40];
@@ -392,21 +384,26 @@ static int merge_one_change_manual(struct notes_m=
erge_options *o,
=20
 	strbuf_addf(&(o->commit_msg), "\t%s\n", sha1_to_hex(p->obj));
=20
-	OUTPUT(o, 2, "Auto-merging notes for %s", sha1_to_hex(p->obj));
+	if (o->verbosity >=3D 2)
+		printf("Auto-merging notes for %s\n", sha1_to_hex(p->obj));
 	check_notes_merge_worktree(o);
 	if (is_null_sha1(p->local)) {
 		/* D/F conflict, checkout p->remote */
 		assert(!is_null_sha1(p->remote));
-		OUTPUT(o, 1, "CONFLICT (delete/modify): Notes for object %s "
-		       "deleted in %s and modified in %s. Version from %s "
-		       "left in tree.", sha1_to_hex(p->obj), lref, rref, rref);
+		if (o->verbosity >=3D 1)
+			printf("CONFLICT (delete/modify): Notes for object %s "
+				"deleted in %s and modified in %s. Version from %s "
+				"left in tree.\n",
+				sha1_to_hex(p->obj), lref, rref, rref);
 		write_note_to_worktree(p->obj, p->remote);
 	} else if (is_null_sha1(p->remote)) {
 		/* D/F conflict, checkout p->local */
 		assert(!is_null_sha1(p->local));
-		OUTPUT(o, 1, "CONFLICT (delete/modify): Notes for object %s "
-		       "deleted in %s and modified in %s. Version from %s "
-		       "left in tree.", sha1_to_hex(p->obj), rref, lref, lref);
+		if (o->verbosity >=3D 1)
+			printf("CONFLICT (delete/modify): Notes for object %s "
+				"deleted in %s and modified in %s. Version from %s "
+				"left in tree.\n",
+				sha1_to_hex(p->obj), rref, lref, lref);
 		write_note_to_worktree(p->obj, p->local);
 	} else {
 		/* "regular" conflict, checkout result of ll_merge() */
@@ -415,8 +412,9 @@ static int merge_one_change_manual(struct notes_mer=
ge_options *o,
 			reason =3D "add/add";
 		assert(!is_null_sha1(p->local));
 		assert(!is_null_sha1(p->remote));
-		OUTPUT(o, 1, "CONFLICT (%s): Merge conflict in notes for "
-		       "object %s", reason, sha1_to_hex(p->obj));
+		if (o->verbosity >=3D 1)
+			printf("CONFLICT (%s): Merge conflict in notes for "
+				"object %s\n", reason, sha1_to_hex(p->obj));
 		ll_merge_in_worktree(o, p);
 	}
=20
@@ -438,24 +436,30 @@ static int merge_one_change(struct notes_merge_op=
tions *o,
 	case NOTES_MERGE_RESOLVE_MANUAL:
 		return merge_one_change_manual(o, p, t);
 	case NOTES_MERGE_RESOLVE_OURS:
-		OUTPUT(o, 2, "Using local notes for %s", sha1_to_hex(p->obj));
+		if (o->verbosity >=3D 2)
+			printf("Using local notes for %s\n",
+						sha1_to_hex(p->obj));
 		/* nothing to do */
 		return 0;
 	case NOTES_MERGE_RESOLVE_THEIRS:
-		OUTPUT(o, 2, "Using remote notes for %s", sha1_to_hex(p->obj));
+		if (o->verbosity >=3D 2)
+			printf("Using remote notes for %s\n",
+						sha1_to_hex(p->obj));
 		if (add_note(t, p->obj, p->remote, combine_notes_overwrite))
 			die("BUG: combine_notes_overwrite failed");
 		return 0;
 	case NOTES_MERGE_RESOLVE_UNION:
-		OUTPUT(o, 2, "Concatenating local and remote notes for %s",
-		       sha1_to_hex(p->obj));
+		if (o->verbosity >=3D 2)
+			printf("Concatenating local and remote notes for %s\n",
+							sha1_to_hex(p->obj));
 		if (add_note(t, p->obj, p->remote, combine_notes_concatenate))
 			die("failed to concatenate notes "
 			    "(combine_notes_concatenate)");
 		return 0;
 	case NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ:
-		OUTPUT(o, 2, "Concatenating unique lines in local and remote "
-		       "notes for %s", sha1_to_hex(p->obj));
+		if (o->verbosity >=3D 2)
+			printf("Concatenating unique lines in local and remote "
+				"notes for %s\n", sha1_to_hex(p->obj));
 		if (add_note(t, p->obj, p->remote, combine_notes_cat_sort_uniq))
 			die("failed to concatenate notes "
 			    "(combine_notes_cat_sort_uniq)");
@@ -518,8 +522,9 @@ static int merge_from_diffs(struct notes_merge_opti=
ons *o,
 	conflicts =3D merge_changes(o, changes, &num_changes, t);
 	free(changes);
=20
-	OUTPUT(o, 4, "Merge result: %i unmerged notes and a %s notes tree",
-	       conflicts, t->dirty ? "dirty" : "clean");
+	if (o->verbosity >=3D 4)
+		printf("Merge result: %i unmerged notes and a %s notes tree\n",
+			conflicts, t->dirty ? "dirty" : "clean");
=20
 	return conflicts ? -1 : 1;
 }
@@ -616,33 +621,40 @@ int notes_merge(struct notes_merge_options *o,
 	if (!bases) {
 		base_sha1 =3D null_sha1;
 		base_tree_sha1 =3D EMPTY_TREE_SHA1_BIN;
-		OUTPUT(o, 4, "No merge base found; doing history-less merge");
+		if (o->verbosity >=3D 4)
+			printf("No merge base found; doing history-less merge\n");
 	} else if (!bases->next) {
 		base_sha1 =3D bases->item->object.sha1;
 		base_tree_sha1 =3D bases->item->tree->object.sha1;
-		OUTPUT(o, 4, "One merge base found (%.7s)",
-		       sha1_to_hex(base_sha1));
+		if (o->verbosity >=3D 4)
+			printf("One merge base found (%.7s)\n",
+				sha1_to_hex(base_sha1));
 	} else {
 		/* TODO: How to handle multiple merge-bases? */
 		base_sha1 =3D bases->item->object.sha1;
 		base_tree_sha1 =3D bases->item->tree->object.sha1;
-		OUTPUT(o, 3, "Multiple merge bases found. Using the first "
-		       "(%.7s)", sha1_to_hex(base_sha1));
+		if (o->verbosity >=3D 3)
+			printf("Multiple merge bases found. Using the first "
+				"(%.7s)\n", sha1_to_hex(base_sha1));
 	}
=20
-	OUTPUT(o, 4, "Merging remote commit %.7s into local commit %.7s with =
"
-	       "merge-base %.7s", sha1_to_hex(remote->object.sha1),
-	       sha1_to_hex(local->object.sha1), sha1_to_hex(base_sha1));
+	if (o->verbosity >=3D 4)
+		printf("Merging remote commit %.7s into local commit %.7s with "
+			"merge-base %.7s\n", sha1_to_hex(remote->object.sha1),
+			sha1_to_hex(local->object.sha1),
+			sha1_to_hex(base_sha1));
=20
 	if (!hashcmp(remote->object.sha1, base_sha1)) {
 		/* Already merged; result =3D=3D local commit */
-		OUTPUT(o, 2, "Already up-to-date!");
+		if (o->verbosity >=3D 2)
+			printf("Already up-to-date!\n");
 		hashcpy(result_sha1, local->object.sha1);
 		goto found_result;
 	}
 	if (!hashcmp(local->object.sha1, base_sha1)) {
 		/* Fast-forward; result =3D=3D remote commit */
-		OUTPUT(o, 2, "Fast-forward");
+		if (o->verbosity >=3D 2)
+			printf("Fast-forward\n");
 		hashcpy(result_sha1, remote->object.sha1);
 		goto found_result;
 	}
@@ -684,8 +696,9 @@ int notes_merge_commit(struct notes_merge_options *=
o,
 	int path_len =3D strlen(path), i;
 	const char *msg =3D strstr(partial_commit->buffer, "\n\n");
=20
-	OUTPUT(o, 3, "Committing notes in notes merge worktree at %.*s",
-	       path_len - 1, path);
+	if (o->verbosity >=3D 3)
+		printf("Committing notes in notes merge worktree at %.*s\n",
+			path_len - 1, path);
=20
 	if (!msg || msg[2] =3D=3D '\0')
 		die("partial notes commit has empty message");
@@ -700,7 +713,9 @@ int notes_merge_commit(struct notes_merge_options *=
o,
 		unsigned char obj_sha1[20], blob_sha1[20];
=20
 		if (ent->len - path_len !=3D 40 || get_sha1_hex(relpath, obj_sha1)) =
{
-			OUTPUT(o, 3, "Skipping non-SHA1 entry '%s'", ent->name);
+			if (o->verbosity >=3D 3)
+				printf("Skipping non-SHA1 entry '%s'\n",
+								ent->name);
 			continue;
 		}
=20
@@ -712,14 +727,16 @@ int notes_merge_commit(struct notes_merge_options=
 *o,
 		if (add_note(partial_tree, obj_sha1, blob_sha1, NULL))
 			die("Failed to add resolved note '%s' to notes tree",
 			    ent->name);
-		OUTPUT(o, 4, "Added resolved note for object %s: %s",
-		       sha1_to_hex(obj_sha1), sha1_to_hex(blob_sha1));
+		if (o->verbosity >=3D 4)
+			printf("Added resolved note for object %s: %s\n",
+				sha1_to_hex(obj_sha1), sha1_to_hex(blob_sha1));
 	}
=20
 	create_notes_commit(partial_tree, partial_commit->parents, msg,
 			    result_sha1);
-	OUTPUT(o, 4, "Finalized notes merge commit: %s",
-	       sha1_to_hex(result_sha1));
+	if (o->verbosity >=3D 4)
+		printf("Finalized notes merge commit: %s\n",
+			sha1_to_hex(result_sha1));
 	free(path);
 	return 0;
 }
@@ -731,7 +748,8 @@ int notes_merge_abort(struct notes_merge_options *o=
)
 	int ret;
=20
 	strbuf_addstr(&buf, git_path(NOTES_MERGE_WORKTREE));
-	OUTPUT(o, 3, "Removing notes merge worktree at %s", buf.buf);
+	if (o->verbosity >=3D 3)
+		printf("Removing notes merge worktree at %s\n", buf.buf);
 	ret =3D remove_dir_recursively(&buf, 0);
 	strbuf_release(&buf);
 	return ret;
--=20
1.7.8.rc2
