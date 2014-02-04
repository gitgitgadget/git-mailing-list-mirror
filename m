From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] reset: support "--mixed --intent-to-add" mode
Date: Tue, 04 Feb 2014 14:25:25 -0800
Message-ID: <xmqqeh3i7bxm.fsf@gitster.dls.corp.google.com>
References: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
	<1391480409-25727-1-git-send-email-pclouds@gmail.com>
	<1391480409-25727-2-git-send-email-pclouds@gmail.com>
	<xmqqvbwu8zjx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 23:25:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAoR7-0005cL-5i
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934269AbaBDWZf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Feb 2014 17:25:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50106 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933892AbaBDWZa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Feb 2014 17:25:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1D1069E81;
	Tue,  4 Feb 2014 17:25:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IIFUZYGgQL/Z
	0iBAJ0iwJ79paP0=; b=K9y2aco9bFdoEojd1XvaWBWlcxoFZxtWao30UuN+Qokg
	fQupr3h7sfKEmTIXg5O6zw0sE8yqadJWiLyyPLmR7x2QYPpF2W5DBeu4r7DHZd3z
	xqzZzk92RsYqvYD1RRIv/ko8puOjeEnbU0f/DJ2JIkAIgK22dlBKQnKfnjNFROQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MFg0UO
	wpqoPykou8PT5Sweq/G67n6h4qVdC/F8JHuBCsDsDHd3jeLwYanknmAWlCAaQVTR
	m4m3rSzl1aloLGXAaNWHrmUow0Ku6mebva29qhxQACorxLW2XQWTz6fbCwLnFj+P
	uP8WX2m8kMutpxv1Cp7++6/oKgp4EkHCyhxUo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7431869E80;
	Tue,  4 Feb 2014 17:25:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8BE0B69E7F;
	Tue,  4 Feb 2014 17:25:28 -0500 (EST)
In-Reply-To: <xmqqvbwu8zjx.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 04 Feb 2014 11:09:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 403CCD5C-8DEB-11E3-8A24-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241577>

Junio C Hamano <gitster@pobox.com> writes:

> While I do not have any problem with adding an optional "keep lost
> paths as intent-to-add entries" feature, I am not sure why this has
> to be so different from the usual add-cache-entry codepath.  The
> if/elseif chain you are touching inside this loop does:
>
>  - If the tree you are resetting to has something at the path
>    (which is different from the current index, obviously), create
>    a cache entry to represent that state from the tree and stuff
>    it in the index;
>
>  - Otherwise, the tree you are resetting to does not have that
>    path.  We used to say "remove it from the index", but now we have
>    an option to instead add it as an intent-to-add entry.
>
> So, why doesn't the new codepath do exactly the same thing as the
> first branch of the if/else chain and call add_cache_entry but with
> a ce marked with CE_INTENT_TO_ADD?  That would parallel what happens
> in "git add -N" better, I would think, no?

In other words, something along this line, perhaps?

-- >8 --
=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date: Tue, 4 Feb 2014 09:20:09 +0700

When --mixed is used, entries could be removed from index if the
target ref does not have them. When "reset" is used in preparation for
commit spliting (in a dirty worktree), it could be hard to track what
files to be added back. The new option --intent-to-add simplifies it
by marking all removed files intent-to-add.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-reset.txt |  5 ++++-
 builtin/reset.c             | 38 ++++++++++++++++++++++++++-----------=
-
 cache.h                     |  1 +
 read-cache.c                |  4 ++--
 t/t7102-reset.sh            |  9 +++++++++
 5 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index f445cb3..a077ba0 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git reset' [-q] [<tree-ish>] [--] <paths>...
 'git reset' (--patch | -p) [<tree-ish>] [--] [<paths>...]
-'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<comm=
it>]
+'git reset' [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [=
<commit>]
=20
 DESCRIPTION
 -----------
@@ -60,6 +60,9 @@ section of linkgit:git-add[1] to learn how to operate=
 the `--patch` mode.
 	Resets the index but not the working tree (i.e., the changed files
 	are preserved but not marked for commit) and reports what has not
 	been updated. This is the default action.
++
+If `-N` is specified, removed paths are marked as intent-to-add (see
+linkgit:git-add[1]).
=20
 --hard::
 	Resets the index and working tree. Any changes to tracked files in th=
e
diff --git a/builtin/reset.c b/builtin/reset.c
index 6004803..d363bc5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -116,25 +116,32 @@ static void update_index_from_diff(struct diff_qu=
eue_struct *q,
 		struct diff_options *opt, void *data)
 {
 	int i;
+	int intent_to_add =3D *(int *)data;
=20
 	for (i =3D 0; i < q->nr; i++) {
 		struct diff_filespec *one =3D q->queue[i]->one;
-		if (one->mode && !is_null_sha1(one->sha1)) {
-			struct cache_entry *ce;
-			ce =3D make_cache_entry(one->mode, one->sha1, one->path,
-				0, 0);
-			if (!ce)
-				die(_("make_cache_entry failed for path '%s'"),
-				    one->path);
-			add_cache_entry(ce, ADD_CACHE_OK_TO_ADD |
-				ADD_CACHE_OK_TO_REPLACE);
-		} else
+		int is_missing =3D !(one->mode && !is_null_sha1(one->sha1));
+		struct cache_entry *ce;
+
+		if (is_missing && !intent_to_add) {
 			remove_file_from_cache(one->path);
+			continue;
+		}
+
+		ce =3D make_cache_entry(one->mode, one->sha1, one->path,
+				      0, 0);
+		if (!ce)
+			die(_("make_cache_entry failed for path '%s'"),
+			    one->path);
+		if (is_missing)
+			mark_intent_to_add(ce);
+		add_cache_entry(ce, ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 	}
 }
=20
 static int read_from_tree(const struct pathspec *pathspec,
-			  unsigned char *tree_sha1)
+			  unsigned char *tree_sha1,
+			  int intent_to_add)
 {
 	struct diff_options opt;
=20
@@ -142,6 +149,7 @@ static int read_from_tree(const struct pathspec *pa=
thspec,
 	copy_pathspec(&opt.pathspec, pathspec);
 	opt.output_format =3D DIFF_FORMAT_CALLBACK;
 	opt.format_callback =3D update_index_from_diff;
+	opt.format_callback_data =3D &intent_to_add;
=20
 	if (do_diff_cache(tree_sha1, &opt))
 		return 1;
@@ -258,6 +266,7 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 	const char *rev;
 	unsigned char sha1[20];
 	struct pathspec pathspec;
+	int intent_to_add =3D 0;
 	const struct option options[] =3D {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_SET_INT(0, "mixed", &reset_type,
@@ -270,6 +279,8 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 		OPT_SET_INT(0, "keep", &reset_type,
 				N_("reset HEAD but keep local changes"), KEEP),
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")=
),
+		OPT_BOOL('N', "intent-to-add", &intent_to_add,
+				N_("record only the fact that removed paths will be added later"))=
,
 		OPT_END()
 	};
=20
@@ -327,6 +338,9 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 		die(_("%s reset is not allowed in a bare repository"),
 		    _(reset_type_names[reset_type]));
=20
+	if (intent_to_add && reset_type !=3D MIXED)
+		die(_("-N can only be used with --mixed"));
+
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
 	 * the index file to the tree object we are switching to. */
@@ -338,7 +352,7 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 		int newfd =3D hold_locked_index(lock, 1);
 		if (reset_type =3D=3D MIXED) {
 			int flags =3D quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN;
-			if (read_from_tree(&pathspec, sha1))
+			if (read_from_tree(&pathspec, sha1, intent_to_add))
 				return 1;
 			refresh_index(&the_index, flags, NULL, NULL,
 				      _("Unstaged changes after reset:"));
diff --git a/cache.h b/cache.h
index dc040fb..20aa73f 100644
--- a/cache.h
+++ b/cache.h
@@ -489,6 +489,7 @@ extern int add_to_index(struct index_state *, const=
 char *path, struct stat *, i
 extern int add_file_to_index(struct index_state *, const char *path, i=
nt flags);
 extern struct cache_entry *make_cache_entry(unsigned int mode, const u=
nsigned char *sha1, const char *path, int stage, int refresh);
 extern int ce_same_name(const struct cache_entry *a, const struct cach=
e_entry *b);
+extern void mark_intent_to_add(struct cache_entry *ce);
 extern int index_name_is_other(const struct index_state *, const char =
*, int);
 extern void *read_blob_data_from_index(struct index_state *, const cha=
r *, unsigned long *);
=20
diff --git a/read-cache.c b/read-cache.c
index 33dd676..325d193 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -579,7 +579,7 @@ static struct cache_entry *create_alias_ce(struct c=
ache_entry *ce, struct cache_
 	return new;
 }
=20
-static void record_intent_to_add(struct cache_entry *ce)
+void mark_intent_to_add(struct cache_entry *ce)
 {
 	unsigned char sha1[20];
 	if (write_sha1_file("", 0, blob_type, sha1))
@@ -665,7 +665,7 @@ int add_to_index(struct index_state *istate, const =
char *path, struct stat *st,
 		if (index_path(ce->sha1, path, st, HASH_WRITE_OBJECT))
 			return error("unable to index file %s", path);
 	} else
-		record_intent_to_add(ce);
+		mark_intent_to_add(ce);
=20
 	if (ignore_case && alias && different_name(ce, alias))
 		ce =3D create_alias_ce(ce, alias);
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 8d4b50d..642920a 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -535,4 +535,13 @@ test_expect_success 'reset with paths accepts tree=
' '
 	git diff HEAD --exit-code
 '
=20
+test_expect_success 'reset -N keeps removed files as intent-to-add' '
+	echo new-file >new-file &&
+	git add new-file &&
+	git reset -N HEAD &&
+	git diff --name-only >actual &&
+	echo new-file >expect &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.9-rc2-217-g24a8b2e
