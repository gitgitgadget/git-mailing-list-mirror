Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D58C433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 09:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345873AbhLBJKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 04:10:25 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58014 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231655AbhLBJKY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 04:10:24 -0500
Received: from localhost (SCRUBBING-BUBBLES.MIT.EDU [18.9.64.11])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B296chF010778;
        Thu, 2 Dec 2021 04:06:38 -0500
Date:   Thu, 2 Dec 2021 04:06:37 -0500 (EST)
From:   Anders Kaseorg <andersk@mit.edu>
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v7 4/8] worktree: simplify find_shared_symref() memory
 ownership model
In-Reply-To: <CAPig+cRX94vMLkW=dAKncPTuuk0Opaj+8-Yqe-qFD1b7mrZ89A@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.999.2112020357510.14727@scrubbing-bubbles.mit.edu>
References: <20211201221547.1796213-1-andersk@mit.edu> <20211201221547.1796213-5-andersk@mit.edu> <CAPig+cSNP-RBmsWWfT690-shFUCZ3J0X+FBiNjCqg=AkoBMBqQ@mail.gmail.com> <f8262c3b-2ca5-4920-1379-41ff29b37d9f@mit.edu>
 <CAPig+cRX94vMLkW=dAKncPTuuk0Opaj+8-Yqe-qFD1b7mrZ89A@mail.gmail.com>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="152177472-1777032467-1638435858=:14727"
Content-ID: <alpine.DEB.2.21.999.2112020404220.14727@scrubbing-bubbles.mit.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--152177472-1777032467-1638435858=:14727
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.21.999.2112020404221.14727@scrubbing-bubbles.mit.edu>

On Wed, 1 Dec 2021, Eric Sunshine wrote:
> If we instead hoist ownership of `worktrees` up to execute_commands()
> -- which calls execute_commands_atomic() or
> execute_commands_non_atomic() -- then we can get by with retrieving
> the worktrees just once, and all those noise changes in update() can
> be dropped since it will no longer be responsible for allocating or
> freeing `worktrees`.

Seems reasonable to me.  It=E2=80=99s a smaller textual change, potentially=
 a=20
larger conceptual change, but the efficiency improvement is probably=20
worthwhile.

That would modify patch 4 to the below.  Patches 5 through 8 cleanly=20
rebase past this modification.

Anders

-- >8 --
Subject: [PATCH v7=C2=BD 4/8] worktree: simplify find_shared_symref() memor=
y ownership model

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
 branch.c               | 14 ++++++++------
 builtin/branch.c       |  7 ++++++-
 builtin/notes.c        |  6 +++++-
 builtin/receive-pack.c | 29 ++++++++++++++++++++---------
 worktree.c             |  8 ++------
 worktree.h             |  5 +++--
 6 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/branch.c b/branch.c
index 85777b939b..c66b222abd 100644
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
index ddda27c184..925ce7f32d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1477,7 +1477,8 @@ static const char *update_worktree(unsigned char *sha=
1, const struct worktree *w
 =09return retval;
 }
=20
-static const char *update(struct command *cmd, struct shallow_info *si)
+static const char *update(struct command *cmd, struct shallow_info *si,
+=09=09=09  struct worktree **worktrees)
 {
 =09const char *name =3D cmd->ref_name;
 =09struct strbuf namespaced_name_buf =3D STRBUF_INIT;
@@ -1486,7 +1487,10 @@ static const char *update(struct command *cmd, struc=
t shallow_info *si)
 =09struct object_id *old_oid =3D &cmd->old_oid;
 =09struct object_id *new_oid =3D &cmd->new_oid;
 =09int do_update_worktree =3D 0;
-=09const struct worktree *worktree =3D is_bare_repository() ? NULL : find_=
shared_symref("HEAD", name);
+=09const struct worktree *worktree =3D
+=09=09is_bare_repository() ?
+=09=09=09NULL :
+=09=09=09find_shared_symref(worktrees, "HEAD", name);
=20
 =09/* only refs/... are allowed */
 =09if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
@@ -1579,7 +1583,9 @@ static const char *update(struct command *cmd, struct=
 shallow_info *si)
 =09}
=20
 =09if (do_update_worktree) {
-=09=09ret =3D update_worktree(new_oid->hash, find_shared_symref("HEAD", na=
me));
+=09=09ret =3D update_worktree(new_oid->hash,
+=09=09=09=09      find_shared_symref(worktrees, "HEAD",
+=09=09=09=09=09=09=09 name));
 =09=09if (ret)
 =09=09=09return ret;
 =09}
@@ -1842,7 +1848,8 @@ static void warn_if_skipped_connectivity_check(struct=
 command *commands,
 }
=20
 static void execute_commands_non_atomic(struct command *commands,
-=09=09=09=09=09struct shallow_info *si)
+=09=09=09=09=09struct shallow_info *si,
+=09=09=09=09=09struct worktree **worktrees)
 {
 =09struct command *cmd;
 =09struct strbuf err =3D STRBUF_INIT;
@@ -1859,7 +1866,7 @@ static void execute_commands_non_atomic(struct comman=
d *commands,
 =09=09=09continue;
 =09=09}
=20
-=09=09cmd->error_string =3D update(cmd, si);
+=09=09cmd->error_string =3D update(cmd, si, worktrees);
=20
 =09=09if (!cmd->error_string
 =09=09    && ref_transaction_commit(transaction, &err)) {
@@ -1873,7 +1880,8 @@ static void execute_commands_non_atomic(struct comman=
d *commands,
 }
=20
 static void execute_commands_atomic(struct command *commands,
-=09=09=09=09=09struct shallow_info *si)
+=09=09=09=09    struct shallow_info *si,
+=09=09=09=09    struct worktree **worktrees)
 {
 =09struct command *cmd;
 =09struct strbuf err =3D STRBUF_INIT;
@@ -1891,7 +1899,7 @@ static void execute_commands_atomic(struct command *c=
ommands,
 =09=09if (!should_process_cmd(cmd) || cmd->run_proc_receive)
 =09=09=09continue;
=20
-=09=09cmd->error_string =3D update(cmd, si);
+=09=09cmd->error_string =3D update(cmd, si, worktrees);
=20
 =09=09if (cmd->error_string)
 =09=09=09goto failure;
@@ -1925,6 +1933,7 @@ static void execute_commands(struct command *commands=
,
 =09struct async muxer;
 =09int err_fd =3D 0;
 =09int run_proc_receive =3D 0;
+=09struct worktree **worktrees;
=20
 =09if (unpacker_error) {
 =09=09for (cmd =3D commands; cmd; cmd =3D cmd->next)
@@ -2004,10 +2013,12 @@ static void execute_commands(struct command *comman=
ds,
 =09=09=09    (cmd->run_proc_receive || use_atomic))
 =09=09=09=09cmd->error_string =3D "fail to run proc-receive hook";
=20
+=09worktrees =3D get_worktrees();
 =09if (use_atomic)
-=09=09execute_commands_atomic(commands, si);
+=09=09execute_commands_atomic(commands, si, worktrees);
 =09else
-=09=09execute_commands_non_atomic(commands, si);
+=09=09execute_commands_non_atomic(commands, si, worktrees);
+=09free_worktrees(worktrees);
=20
 =09if (shallow_update)
 =09=09warn_if_skipped_connectivity_check(commands, si);
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
2.34.1
--152177472-1777032467-1638435858=:14727--
