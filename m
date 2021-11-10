Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9A6C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 23:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3DFB61038
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 23:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhKJXg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 18:36:26 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56246 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233948AbhKJXgZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 18:36:25 -0500
Received: from localhost (TARDIS-ON-THE-DOME.MIT.EDU [18.9.64.28])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1AANXMuP004630;
        Wed, 10 Nov 2021 18:33:22 -0500
Date:   Wed, 10 Nov 2021 18:33:22 -0500 (EST)
From:   Anders Kaseorg <andersk@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org,
        Andreas Heiduk <andreas.heiduk@mathema.de>
Subject: Re: [PATCH v5 1/4] fetch: Protect branches checked out in all
 worktrees
In-Reply-To: <xmqqr1bnwtln.fsf@gitster.g>
Message-ID: <alpine.DEB.2.21.999.2111101828580.104475@tardis-on-the-dome.mit.edu>
References: <2f983e36-532f-ac87-9ade-fba4c6b9d276@mit.edu> <20211109230941.2518143-1-andersk@mit.edu> <xmqqr1bnwtln.fsf@gitster.g>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="152181824-2065831297-1636587202=:104475"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--152181824-2065831297-1636587202=:104475
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 10 Nov 2021, Junio C Hamano wrote:
> The find_shared_symref() function is handy (and more correct than
> dereferencing HEAD in the current worktree alone, of course), but
> its memory ownership model may need to be rethought.

I wasn=E2=80=99t sure if we wanted to expand the scope of this series, but =
I do=20
agree.  How about moving worktrees from the static variable to a parameter=
=20
of find_shared_symref()?  Would you like me to rebase the series onto this=
=20
patch?

Anders

-- >8 --
Subject: [PATCH] worktree: simplify find_shared_symref() memory ownership m=
odel

Storing the worktrees list in a static variable meant that
find_shared_symref() had to rebuild the list on each call (which is
inefficient when the call site is in a loop), and also that each call
invalidated the pointer returned by the previous call (which is
confusing).

Instead, make it the caller=E2=80=99s responsibility to pass in the worktre=
es
list and manage its lifetime.

Signed-off-by: Anders Kaseorg <andersk@mit.edu>
---
 branch.c               | 14 ++++++----
 builtin/branch.c       |  7 ++++-
 builtin/notes.c        |  6 +++-
 builtin/receive-pack.c | 63 +++++++++++++++++++++++++++---------------
 worktree.c             |  8 ++----
 worktree.h             |  5 ++--
 6 files changed, 65 insertions(+), 38 deletions(-)

diff --git a/branch.c b/branch.c
index 07a46430b3..302cc5a04d 100644
--- a/branch.c
+++ b/branch.c
@@ -357,14 +357,16 @@ void remove_branch_state(struct repository *r, int ve=
rbose)
=20
 void die_if_checked_out(const char *branch, int ignore_current_worktree)
 {
+=09struct worktree **worktrees =3D get_worktrees();
 =09const struct worktree *wt;
=20
-=09wt =3D find_shared_symref("HEAD", branch);
-=09if (!wt || (ignore_current_worktree && wt->is_current))
-=09=09return;
-=09skip_prefix(branch, "refs/heads/", &branch);
-=09die(_("'%s' is already checked out at '%s'"),
-=09    branch, wt->path);
+=09wt =3D find_shared_symref(worktrees, "HEAD", branch);
+=09if (wt && (!ignore_current_worktree || !wt->is_current)) {
+=09=09skip_prefix(branch, "refs/heads/", &branch);
+=09=09die(_("'%s' is already checked out at '%s'"), branch, wt->path);
+=09}
+
+=09free_worktrees(worktrees);
 }
=20
 int replace_each_worktree_head_symref(const char *oldref, const char *newr=
ef,
diff --git a/builtin/branch.c b/builtin/branch.c
index 7a1d1eeb07..d8f2164cd7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -193,6 +193,7 @@ static void delete_branch_config(const char *branchname=
)
 static int delete_branches(int argc, const char **argv, int force, int kin=
ds,
 =09=09=09   int quiet)
 {
+=09struct worktree **worktrees;
 =09struct commit *head_rev =3D NULL;
 =09struct object_id oid;
 =09char *name =3D NULL;
@@ -229,6 +230,9 @@ static int delete_branches(int argc, const char **argv,=
 int force, int kinds,
 =09=09if (!head_rev)
 =09=09=09die(_("Couldn't look up commit object for HEAD"));
 =09}
+
+=09worktrees =3D get_worktrees();
+
 =09for (i =3D 0; i < argc; i++, strbuf_reset(&bname)) {
 =09=09char *target =3D NULL;
 =09=09int flags =3D 0;
@@ -239,7 +243,7 @@ static int delete_branches(int argc, const char **argv,=
 int force, int kinds,
=20
 =09=09if (kinds =3D=3D FILTER_REFS_BRANCHES) {
 =09=09=09const struct worktree *wt =3D
-=09=09=09=09find_shared_symref("HEAD", name);
+=09=09=09=09find_shared_symref(worktrees, "HEAD", name);
 =09=09=09if (wt) {
 =09=09=09=09error(_("Cannot delete branch '%s' "
 =09=09=09=09=09"checked out at '%s'"),
@@ -300,6 +304,7 @@ static int delete_branches(int argc, const char **argv,=
 int force, int kinds,
=20
 =09free(name);
 =09strbuf_release(&bname);
+=09free_worktrees(worktrees);
=20
 =09return ret;
 }
diff --git a/builtin/notes.c b/builtin/notes.c
index 71c59583a1..7f60408dbb 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -861,15 +861,19 @@ static int merge(int argc, const char **argv, const c=
har *prefix)
 =09=09update_ref(msg.buf, default_notes_ref(), &result_oid, NULL, 0,
 =09=09=09   UPDATE_REFS_DIE_ON_ERR);
 =09else { /* Merge has unresolved conflicts */
+=09=09struct worktree **worktrees;
 =09=09const struct worktree *wt;
 =09=09/* Update .git/NOTES_MERGE_PARTIAL with partial merge result */
 =09=09update_ref(msg.buf, "NOTES_MERGE_PARTIAL", &result_oid, NULL,
 =09=09=09   0, UPDATE_REFS_DIE_ON_ERR);
 =09=09/* Store ref-to-be-updated into .git/NOTES_MERGE_REF */
-=09=09wt =3D find_shared_symref("NOTES_MERGE_REF", default_notes_ref());
+=09=09worktrees =3D get_worktrees();
+=09=09wt =3D find_shared_symref(worktrees, "NOTES_MERGE_REF",
+=09=09=09=09=09default_notes_ref());
 =09=09if (wt)
 =09=09=09die(_("a notes merge into %s is already in-progress at %s"),
 =09=09=09    default_notes_ref(), wt->path);
+=09=09free_worktrees(worktrees);
 =09=09if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
 =09=09=09die(_("failed to store link to current notes ref (%s)"),
 =09=09=09    default_notes_ref());
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 49b846d960..017c365298 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1486,12 +1486,17 @@ static const char *update(struct command *cmd, stru=
ct shallow_info *si)
 =09struct object_id *old_oid =3D &cmd->old_oid;
 =09struct object_id *new_oid =3D &cmd->new_oid;
 =09int do_update_worktree =3D 0;
-=09const struct worktree *worktree =3D is_bare_repository() ? NULL : find_=
shared_symref("HEAD", name);
+=09struct worktree **worktrees =3D get_worktrees();
+=09const struct worktree *worktree =3D
+=09=09is_bare_repository() ?
+=09=09=09NULL :
+=09=09=09find_shared_symref(worktrees, "HEAD", name);
=20
 =09/* only refs/... are allowed */
 =09if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
 =09=09rp_error("refusing to create funny ref '%s' remotely", name);
-=09=09return "funny refname";
+=09=09ret =3D "funny refname";
+=09=09goto out;
 =09}
=20
 =09strbuf_addf(&namespaced_name_buf, "%s%s", get_git_namespace(), name);
@@ -1510,7 +1515,8 @@ static const char *update(struct command *cmd, struct=
 shallow_info *si)
 =09=09=09rp_error("refusing to update checked out branch: %s", name);
 =09=09=09if (deny_current_branch =3D=3D DENY_UNCONFIGURED)
 =09=09=09=09refuse_unconfigured_deny();
-=09=09=09return "branch is currently checked out";
+=09=09=09ret =3D "branch is currently checked out";
+=09=09=09goto out;
 =09=09case DENY_UPDATE_INSTEAD:
 =09=09=09/* pass -- let other checks intervene first */
 =09=09=09do_update_worktree =3D 1;
@@ -1521,13 +1527,15 @@ static const char *update(struct command *cmd, stru=
ct shallow_info *si)
 =09if (!is_null_oid(new_oid) && !has_object_file(new_oid)) {
 =09=09error("unpack should have generated %s, "
 =09=09      "but I can't find it!", oid_to_hex(new_oid));
-=09=09return "bad pack";
+=09=09ret =3D "bad pack";
+=09=09goto out;
 =09}
=20
 =09if (!is_null_oid(old_oid) && is_null_oid(new_oid)) {
 =09=09if (deny_deletes && starts_with(name, "refs/heads/")) {
 =09=09=09rp_error("denying ref deletion for %s", name);
-=09=09=09return "deletion prohibited";
+=09=09=09ret =3D "deletion prohibited";
+=09=09=09goto out;
 =09=09}
=20
 =09=09if (worktree || (head_name && !strcmp(namespaced_name, head_name))) =
{
@@ -1543,9 +1551,11 @@ static const char *update(struct command *cmd, struc=
t shallow_info *si)
 =09=09=09=09if (deny_delete_current =3D=3D DENY_UNCONFIGURED)
 =09=09=09=09=09refuse_unconfigured_deny_delete_current();
 =09=09=09=09rp_error("refusing to delete the current branch: %s", name);
-=09=09=09=09return "deletion of the current branch prohibited";
+=09=09=09=09ret =3D "deletion of the current branch prohibited";
+=09=09=09=09goto out;
 =09=09=09default:
-=09=09=09=09return "Invalid denyDeleteCurrent setting";
+=09=09=09=09ret =3D "Invalid denyDeleteCurrent setting";
+=09=09=09=09goto out;
 =09=09=09}
 =09=09}
 =09}
@@ -1563,25 +1573,30 @@ static const char *update(struct command *cmd, stru=
ct shallow_info *si)
 =09=09    old_object->type !=3D OBJ_COMMIT ||
 =09=09    new_object->type !=3D OBJ_COMMIT) {
 =09=09=09error("bad sha1 objects for %s", name);
-=09=09=09return "bad ref";
+=09=09=09ret =3D "bad ref";
+=09=09=09goto out;
 =09=09}
 =09=09old_commit =3D (struct commit *)old_object;
 =09=09new_commit =3D (struct commit *)new_object;
 =09=09if (!in_merge_bases(old_commit, new_commit)) {
 =09=09=09rp_error("denying non-fast-forward %s"
 =09=09=09=09 " (you should pull first)", name);
-=09=09=09return "non-fast-forward";
+=09=09=09ret =3D "non-fast-forward";
+=09=09=09goto out;
 =09=09}
 =09}
 =09if (run_update_hook(cmd)) {
 =09=09rp_error("hook declined to update %s", name);
-=09=09return "hook declined";
+=09=09ret =3D "hook declined";
+=09=09goto out;
 =09}
=20
 =09if (do_update_worktree) {
-=09=09ret =3D update_worktree(new_oid->hash, find_shared_symref("HEAD", na=
me));
+=09=09ret =3D update_worktree(new_oid->hash,
+=09=09=09=09      find_shared_symref(worktrees, "HEAD",
+=09=09=09=09=09=09=09 name));
 =09=09if (ret)
-=09=09=09return ret;
+=09=09=09goto out;
 =09}
=20
 =09if (is_null_oid(new_oid)) {
@@ -1600,17 +1615,19 @@ static const char *update(struct command *cmd, stru=
ct shallow_info *si)
 =09=09=09=09=09   old_oid,
 =09=09=09=09=09   0, "push", &err)) {
 =09=09=09rp_error("%s", err.buf);
-=09=09=09strbuf_release(&err);
-=09=09=09return "failed to delete";
+=09=09=09ret =3D "failed to delete";
+=09=09} else {
+=09=09=09ret =3D NULL; /* good */
 =09=09}
 =09=09strbuf_release(&err);
-=09=09return NULL; /* good */
 =09}
 =09else {
 =09=09struct strbuf err =3D STRBUF_INIT;
 =09=09if (shallow_update && si->shallow_ref[cmd->index] &&
-=09=09    update_shallow_ref(cmd, si))
-=09=09=09return "shallow error";
+=09=09    update_shallow_ref(cmd, si)) {
+=09=09=09ret =3D "shallow error";
+=09=09=09goto out;
+=09=09}
=20
 =09=09if (ref_transaction_update(transaction,
 =09=09=09=09=09   namespaced_name,
@@ -1618,14 +1635,16 @@ static const char *update(struct command *cmd, stru=
ct shallow_info *si)
 =09=09=09=09=09   0, "push",
 =09=09=09=09=09   &err)) {
 =09=09=09rp_error("%s", err.buf);
-=09=09=09strbuf_release(&err);
-
-=09=09=09return "failed to update ref";
+=09=09=09ret =3D "failed to update ref";
+=09=09} else {
+=09=09=09ret =3D NULL; /* good */
 =09=09}
 =09=09strbuf_release(&err);
-
-=09=09return NULL; /* good */
 =09}
+
+out:
+=09free_worktrees(worktrees);
+=09return ret;
 }
=20
 static void run_update_post_hook(struct command *commands)
diff --git a/worktree.c b/worktree.c
index 092a4f92ad..cf13d63845 100644
--- a/worktree.c
+++ b/worktree.c
@@ -402,17 +402,13 @@ int is_worktree_being_bisected(const struct worktree =
*wt,
  * bisect). New commands that do similar things should update this
  * function as well.
  */
-const struct worktree *find_shared_symref(const char *symref,
+const struct worktree *find_shared_symref(struct worktree **worktrees,
+=09=09=09=09=09  const char *symref,
 =09=09=09=09=09  const char *target)
 {
 =09const struct worktree *existing =3D NULL;
-=09static struct worktree **worktrees;
 =09int i =3D 0;
=20
-=09if (worktrees)
-=09=09free_worktrees(worktrees);
-=09worktrees =3D get_worktrees();
-
 =09for (i =3D 0; worktrees[i]; i++) {
 =09=09struct worktree *wt =3D worktrees[i];
 =09=09const char *symref_target;
diff --git a/worktree.h b/worktree.h
index 8b7c408132..9e06fcbdf3 100644
--- a/worktree.h
+++ b/worktree.h
@@ -143,9 +143,10 @@ void free_worktrees(struct worktree **);
 /*
  * Check if a per-worktree symref points to a ref in the main worktree
  * or any linked worktree, and return the worktree that holds the ref,
- * or NULL otherwise. The result may be destroyed by the next call.
+ * or NULL otherwise.
  */
-const struct worktree *find_shared_symref(const char *symref,
+const struct worktree *find_shared_symref(struct worktree **worktrees,
+=09=09=09=09=09  const char *symref,
 =09=09=09=09=09  const char *target);
=20
 /*
--=20
2.33.1

--152181824-2065831297-1636587202=:104475--
