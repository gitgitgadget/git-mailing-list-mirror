Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E2DB1FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 16:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbdFMQRo (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 12:17:44 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:36136
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752253AbdFMQRk (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Jun 2017 12:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1497370658;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=bD30gihjeVSfp747NzibVEweH7KtdQAKP4WhhZxMlrk=;
        b=fUhiwIdrO1ey4DRyVuiM/pHZzkm6iYhnI0U/YF541J+zeq2oZmoIHiCQHfwLO6zu
        G7xRy+WKFSmRpeAWyxr2rWpHo7ltlPwref+ZlPVHi5oW4UYqEH8IHsuVQfRInxiHuwG
        eKdhrFMH7KBqqkNIhO/LQuRB0fJxy4np7Vk8npks=
From:   Sahil Dua <sahildua2305@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015ca23f054b-b7c281d9-c9e0-4691-bfa9-8c46fb77dfc7-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
References: <0102015ca23f0488-7423db93-b65f-4214-8221-af6a1bb4c2e5-000000@eu-west-1.amazonses.com>
Subject: [PATCH 3/3] branch: add a --copy (-c) option to go with --move (-m)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 13 Jun 2017 16:17:38 +0000
X-SES-Outgoing: 2017.06.13-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the ability to --copy a branch and its reflog and configuration,
this uses the same underlying machinery as the --move (-m) option
except the reflog and configuration is copied instead of being moved.

This is useful for e.g. copying a topic branch to a new version,
e.g. work to work-2 after submitting the work topic to the list, while
preserving all the tracking info and other configuration that goes
with the branch, and unlike --move keeping the other already-submitted
branch around for reference.

Like --move, when the source branch is the currently checked out
branch the HEAD is moved to the destination branch. In the case of
--move we don't really have a choice (other than remaining on a
detached HEAD), but it makes sense to do the same for --copy.

The most common usage of this feature is expected to be moving to a
new topic branch which is a copy of the current one, in that case
moving to the target branch is what the user wants, and doesn't
unexpectedly behave differently than --move would.

One outstanding caveat of this implementation is that:

    git checkout maint &&
    git checkout master &&
    git branch -c topic &&
    git checkout -

Will check out 'maint' instead of 'master'. This is because the @{-N}
feature (or its -1 shorthand "-") relies on HEAD reflogs created by
the checkout command, so in this case we'll checkout maint instead of
master, as the user might expect. What to do about that is left to a
future change.

Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
---
 Documentation/git-branch.txt |  14 ++-
 builtin/branch.c             |  67 ++++++++++----
 cache.h                      |   2 +
 config.c                     | 102 +++++++++++++++++----
 refs.c                       |  11 +++
 refs.h                       |   9 +-
 refs/files-backend.c         |  46 ++++++++--
 refs/refs-internal.h         |   4 +
 t/t3200-branch.sh            | 211 +++++++++++++++++++++++++++++++++++++++=
++++
 9 files changed, 420 insertions(+), 46 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 81bd0a7b7741f..94fd89ddc5ab9 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -18,6 +18,7 @@ SYNOPSIS
 'git branch' (--set-upstream-to=3D<upstream> | -u <upstream>) [<branchname=
>]
 'git branch' --unset-upstream [<branchname>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
+'git branch' (-c | -C) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
 'git branch' --edit-description [<branchname>]
=20
@@ -64,6 +65,10 @@ If <oldbranch> had a corresponding reflog, it is renamed=
 to match
 renaming. If <newbranch> exists, -M must be used to force the rename
 to happen.
=20
+The `-c` and `-C` options have the exact same semantics as `-m` and
+`-M`, except instead of the branch being renamed it along with its
+config and reflog will be copied to a new name.
+
 With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
 has a reflog then the reflog will also be deleted.
@@ -104,7 +109,7 @@ OPTIONS
 =09In combination with `-d` (or `--delete`), allow deleting the
 =09branch irrespective of its merged status. In combination with
 =09`-m` (or `--move`), allow renaming the branch even if the new
-=09branch name already exists.
+=09branch name already exists, the same applies for `-c` (or `--copy`).
=20
 -m::
 --move::
@@ -113,6 +118,13 @@ OPTIONS
 -M::
 =09Shortcut for `--move --force`.
=20
+-c::
+--copy::
+=09Copy a branch and the corresponding reflog.
+
+-C::
+=09Shortcut for `--copy --force`.
+
 --color[=3D<when>]::
 =09Color branches to highlight current, local, and
 =09remote-tracking branches.
diff --git a/builtin/branch.c b/builtin/branch.c
index 83fcda43dceec..89f64f4123a5e 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -27,6 +27,7 @@ static const char * const builtin_branch_usage[] =3D {
 =09N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
 =09N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
 =09N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
+=09N_("git branch [<options>] (-c | -C) [<old-branch>] <new-branch>"),
 =09N_("git branch [<options>] [-r | -a] [--points-at]"),
 =09N_("git branch [<options>] [-r | -a] [--format]"),
 =09NULL
@@ -449,15 +450,19 @@ static void reject_rebase_or_bisect_branch(const char=
 *target)
 =09free_worktrees(worktrees);
 }
=20
-static void rename_branch(const char *oldname, const char *newname, int fo=
rce)
+static void copy_or_rename_branch(const char *oldname, const char *newname=
, int copy, int force)
 {
 =09struct strbuf oldref =3D STRBUF_INIT, newref =3D STRBUF_INIT, logmsg =
=3D STRBUF_INIT;
 =09struct strbuf oldsection =3D STRBUF_INIT, newsection =3D STRBUF_INIT;
 =09int recovery =3D 0;
 =09int clobber_head_ok;
=20
-=09if (!oldname)
-=09=09die(_("cannot rename the current branch while not on any."));
+=09if (!oldname) {
+=09=09if (copy)
+=09=09=09die(_("cannot copy the current branch while not on any."));
+=09=09else
+=09=09=09die(_("cannot rename the current branch while not on any."));
+=09}
=20
 =09if (strbuf_check_branch_ref(&oldref, oldname)) {
 =09=09/*
@@ -480,17 +485,33 @@ static void rename_branch(const char *oldname, const =
char *newname, int force)
=20
 =09reject_rebase_or_bisect_branch(oldref.buf);
=20
-=09strbuf_addf(&logmsg, "Branch: renamed %s to %s",
-=09=09 oldref.buf, newref.buf);
+=09if (copy)
+=09=09strbuf_addf(&logmsg, "Branch: copied %s to %s",
+=09=09=09    oldref.buf, newref.buf);
+=09else
+=09=09strbuf_addf(&logmsg, "Branch: renamed %s to %s",
+=09=09=09    oldref.buf, newref.buf);
=20
-=09if (rename_ref(oldref.buf, newref.buf, logmsg.buf))
+=09if (!copy && rename_ref(oldref.buf, newref.buf, logmsg.buf))
 =09=09die(_("Branch rename failed"));
+=09if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
+=09=09die(_("Branch copy failed"));
=20
-=09if (recovery)
-=09=09warning(_("Renamed a misnamed branch '%s' away"), oldref.buf + 11);
+=09if (recovery) {
+=09=09if (copy)
+=09=09=09warning(_("Copied a misnamed branch '%s' away"),
+=09=09=09=09oldref.buf + 11);
+=09=09else
+=09=09=09warning(_("Renamed a misnamed branch '%s' away"),
+=09=09=09=09oldref.buf + 11);
+=09}
=20
-=09if (replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.bu=
f))
-=09=09die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
+=09if (replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.bu=
f)) {
+=09=09if (copy)
+=09=09=09die(_("Branch copied to %s, but HEAD is not updated!"), newname);
+=09=09else
+=09=09=09die(_("Branch renamed to %s, but HEAD is not updated!"), newname)=
;
+=09}
=20
 =09strbuf_release(&logmsg);
=20
@@ -498,8 +519,10 @@ static void rename_branch(const char *oldname, const c=
har *newname, int force)
 =09strbuf_release(&oldref);
 =09strbuf_addf(&newsection, "branch.%s", newref.buf + 11);
 =09strbuf_release(&newref);
-=09if (git_config_rename_section(oldsection.buf, newsection.buf) < 0)
+=09if (!copy && git_config_rename_section(oldsection.buf, newsection.buf) =
< 0)
 =09=09die(_("Branch is renamed, but update of config-file failed"));
+=09if (copy && strcmp(oldname, newname) && git_config_copy_section(oldsect=
ion.buf, newsection.buf) < 0)
+=09=09die(_("Branch is copied, but update of config-file failed"));
 =09strbuf_release(&oldsection);
 =09strbuf_release(&newsection);
 }
@@ -537,7 +560,7 @@ static int edit_branch_description(const char *branch_n=
ame)
=20
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-=09int delete =3D 0, rename =3D 0, force =3D 0, list =3D 0;
+=09int delete =3D 0, rename =3D 0, copy =3D 0, force =3D 0, list =3D 0;
 =09int reflog =3D 0, edit_description =3D 0;
 =09int quiet =3D 0, unset_upstream =3D 0;
 =09const char *new_upstream =3D NULL;
@@ -574,6 +597,8 @@ int cmd_branch(int argc, const char **argv, const char =
*prefix)
 =09=09OPT_BIT('D', NULL, &delete, N_("delete branch (even if not merged)")=
, 2),
 =09=09OPT_BIT('m', "move", &rename, N_("move/rename a branch and its reflo=
g"), 1),
 =09=09OPT_BIT('M', NULL, &rename, N_("move/rename a branch, even if target=
 exists"), 2),
+=09=09OPT_BIT('c', "copy", &copy, N_("copy a branch and its reflog"), 1),
+=09=09OPT_BIT('C', NULL, &copy, N_("copy a branch, even if target exists")=
, 2),
 =09=09OPT_BOOL(0, "list", &list, N_("list branch names")),
 =09=09OPT_BOOL('l', "create-reflog", &reflog, N_("create the branch's refl=
og")),
 =09=09OPT_BOOL(0, "edit-description", &edit_description,
@@ -617,14 +642,14 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
 =09argc =3D parse_options(argc, argv, prefix, options, builtin_branch_usag=
e,
 =09=09=09     0);
=20
-=09if (!delete && !rename && !edit_description && !new_upstream && !unset_=
upstream && argc =3D=3D 0)
+=09if (!delete && !rename && !copy && !edit_description && !new_upstream &=
& !unset_upstream && argc =3D=3D 0)
 =09=09list =3D 1;
=20
 =09if (filter.with_commit || filter.merge !=3D REF_FILTER_MERGED_NONE || f=
ilter.points_at.nr ||
 =09    filter.no_commit)
 =09=09list =3D 1;
=20
-=09if (!!delete + !!rename + !!new_upstream +
+=09if (!!delete + !!rename + !!copy + !!new_upstream +
 =09    list + unset_upstream > 1)
 =09=09usage_with_options(builtin_branch_usage, options);
=20
@@ -642,6 +667,7 @@ int cmd_branch(int argc, const char **argv, const char =
*prefix)
 =09if (force) {
 =09=09delete *=3D 2;
 =09=09rename *=3D 2;
+=09=09copy *=3D 2;
 =09}
=20
 =09if (delete) {
@@ -696,13 +722,22 @@ int cmd_branch(int argc, const char **argv, const cha=
r *prefix)
=20
 =09=09if (edit_branch_description(branch_name))
 =09=09=09return 1;
+=09} else if (copy) {
+=09=09if (!argc)
+=09=09=09die(_("branch name required"));
+=09=09else if (argc =3D=3D 1)
+=09=09=09copy_or_rename_branch(head, argv[0], 1, copy > 1);
+=09=09else if (argc =3D=3D 2)
+=09=09=09copy_or_rename_branch(argv[0], argv[1], 1, copy > 1);
+=09=09else
+=09=09=09die(_("too many branches for a copy operation"));
 =09} else if (rename) {
 =09=09if (!argc)
 =09=09=09die(_("branch name required"));
 =09=09else if (argc =3D=3D 1)
-=09=09=09rename_branch(head, argv[0], rename > 1);
+=09=09=09copy_or_rename_branch(head, argv[0], 0, rename > 1);
 =09=09else if (argc =3D=3D 2)
-=09=09=09rename_branch(argv[0], argv[1], rename > 1);
+=09=09=09copy_or_rename_branch(argv[0], argv[1], 0, rename > 1);
 =09=09else
 =09=09=09die(_("too many branches for a rename operation"));
 =09} else if (new_upstream) {
diff --git a/cache.h b/cache.h
index 4d92aae0e8180..290e39d44d816 100644
--- a/cache.h
+++ b/cache.h
@@ -1941,6 +1941,8 @@ extern int git_config_set_multivar_in_file_gently(con=
st char *, const char *, co
 extern void git_config_set_multivar_in_file(const char *, const char *, co=
nst char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
 extern int git_config_rename_section_in_file(const char *, const char *, c=
onst char *);
+extern int git_config_copy_section(const char *, const char *);
+extern int git_config_copy_section_in_file(const char *, const char *, con=
st char *);
 extern const char *git_etc_gitconfig(void);
 extern int git_env_bool(const char *, int);
 extern unsigned long git_env_ulong(const char *, unsigned long);
diff --git a/config.c b/config.c
index d5bb69e925dac..614e644389dc9 100644
--- a/config.c
+++ b/config.c
@@ -2638,8 +2638,8 @@ static int section_name_is_ok(const char *name)
 }
=20
 /* if new_name =3D=3D NULL, the section is removed instead */
-int git_config_rename_section_in_file(const char *config_filename,
-=09=09=09=09      const char *old_name, const char *new_name)
+static int git_config_copy_or_rename_section_in_file(const char *config_fi=
lename,
+=09=09=09=09      const char *old_name, const char *new_name, int copy)
 {
 =09int ret =3D 0, remove =3D 0;
 =09char *filename_buf =3D NULL;
@@ -2648,6 +2648,7 @@ int git_config_rename_section_in_file(const char *con=
fig_filename,
 =09char buf[1024];
 =09FILE *config_file =3D NULL;
 =09struct stat st;
+=09struct strbuf copystr =3D STRBUF_INIT;
=20
 =09if (new_name && !section_name_is_ok(new_name)) {
 =09=09ret =3D error("invalid section name: %s", new_name);
@@ -2683,12 +2684,30 @@ int git_config_rename_section_in_file(const char *c=
onfig_filename,
 =09while (fgets(buf, sizeof(buf), config_file)) {
 =09=09int i;
 =09=09int length;
+=09=09int is_section =3D 0;
 =09=09char *output =3D buf;
 =09=09for (i =3D 0; buf[i] && isspace(buf[i]); i++)
 =09=09=09; /* do nothing */
 =09=09if (buf[i] =3D=3D '[') {
 =09=09=09/* it's a section */
-=09=09=09int offset =3D section_name_match(&buf[i], old_name);
+=09=09=09int offset;
+=09=09=09is_section =3D 1;
+
+=09=09=09/*
+=09=09=09 * When encountering a new section under -c we
+=09=09=09 * need to flush out any section we're already
+=09=09=09 * coping and begin anew. There might be
+=09=09=09 * multiple [branch "$name"] sections.
+=09=09=09 */=20
+=09=09=09if (copystr.len > 0) {
+=09=09=09=09if (write_in_full(out_fd, copystr.buf, copystr.len) !=3D copys=
tr.len) {
+=09=09=09=09=09ret =3D write_error(get_lock_file_path(lock));
+=09=09=09=09=09goto out;
+=09=09=09=09}
+=09=09=09=09strbuf_reset(&copystr);
+=09=09=09}
+
+=09=09=09offset =3D section_name_match(&buf[i], old_name);
 =09=09=09if (offset > 0) {
 =09=09=09=09ret++;
 =09=09=09=09if (new_name =3D=3D NULL) {
@@ -2696,25 +2715,30 @@ int git_config_rename_section_in_file(const char *c=
onfig_filename,
 =09=09=09=09=09continue;
 =09=09=09=09}
 =09=09=09=09store.baselen =3D strlen(new_name);
-=09=09=09=09if (!store_write_section(out_fd, new_name)) {
-=09=09=09=09=09ret =3D write_error(get_lock_file_path(lock));
-=09=09=09=09=09goto out;
-=09=09=09=09}
-=09=09=09=09/*
-=09=09=09=09 * We wrote out the new section, with
-=09=09=09=09 * a newline, now skip the old
-=09=09=09=09 * section's length
-=09=09=09=09 */
-=09=09=09=09output +=3D offset + i;
-=09=09=09=09if (strlen(output) > 0) {
+=09=09=09=09if (!copy) {
+=09=09=09=09=09if (!store_write_section(out_fd, new_name)) {
+=09=09=09=09=09=09ret =3D write_error(get_lock_file_path(lock));
+=09=09=09=09=09=09goto out;
+=09=09=09=09=09}
+
 =09=09=09=09=09/*
-=09=09=09=09=09 * More content means there's
-=09=09=09=09=09 * a declaration to put on the
-=09=09=09=09=09 * next line; indent with a
-=09=09=09=09=09 * tab
+=09=09=09=09=09 * We wrote out the new section, with
+=09=09=09=09=09 * a newline, now skip the old
+=09=09=09=09=09 * section's length
 =09=09=09=09=09 */
-=09=09=09=09=09output -=3D 1;
-=09=09=09=09=09output[0] =3D '\t';
+=09=09=09=09=09output +=3D offset + i;
+=09=09=09=09=09if (strlen(output) > 0) {
+=09=09=09=09=09=09/*
+=09=09=09=09=09=09 * More content means there's
+=09=09=09=09=09=09 * a declaration to put on the
+=09=09=09=09=09=09 * next line; indent with a
+=09=09=09=09=09=09 * tab
+=09=09=09=09=09=09 */
+=09=09=09=09=09=09output -=3D 1;
+=09=09=09=09=09=09output[0] =3D '\t';
+=09=09=09=09=09}
+=09=09=09=09} else {
+=09=09=09=09=09copystr =3D store_create_section(new_name);
 =09=09=09=09}
 =09=09=09}
 =09=09=09remove =3D 0;
@@ -2722,11 +2746,30 @@ int git_config_rename_section_in_file(const char *c=
onfig_filename,
 =09=09if (remove)
 =09=09=09continue;
 =09=09length =3D strlen(output);
+
+=09=09if (!is_section && copystr.len > 0) {
+=09=09=09strbuf_add(&copystr, output, length);
+=09=09}
+
 =09=09if (write_in_full(out_fd, output, length) !=3D length) {
 =09=09=09ret =3D write_error(get_lock_file_path(lock));
 =09=09=09goto out;
 =09=09}
 =09}
+
+=09/*
+=09 * Copy a trailing section at the end of the config, won't be
+=09 * flushed by the usual "flush because we have a new section
+=09 * logic in the loop above.
+=09 */
+=09if (copystr.len > 0) {
+=09=09if (write_in_full(out_fd, copystr.buf, copystr.len) !=3D copystr.len=
) {
+=09=09=09ret =3D write_error(get_lock_file_path(lock));
+=09=09=09goto out;
+=09=09}
+=09=09strbuf_reset(&copystr);
+=09}
+
 =09fclose(config_file);
 =09config_file =3D NULL;
 commit_and_out:
@@ -2742,11 +2785,30 @@ int git_config_rename_section_in_file(const char *c=
onfig_filename,
 =09return ret;
 }
=20
+int git_config_rename_section_in_file(const char *config_filename,
+=09=09=09=09      const char *old_name, const char *new_name)
+{
+=09return git_config_copy_or_rename_section_in_file(config_filename,
+=09=09=09=09=09 old_name, new_name, 0);
+}
+
 int git_config_rename_section(const char *old_name, const char *new_name)
 {
 =09return git_config_rename_section_in_file(NULL, old_name, new_name);
 }
=20
+int git_config_copy_section_in_file(const char *config_filename,
+=09=09=09=09      const char *old_name, const char *new_name)
+{
+=09return git_config_copy_or_rename_section_in_file(config_filename,
+=09=09=09=09=09 old_name, new_name, 1);
+}
+
+int git_config_copy_section(const char *old_name, const char *new_name)
+{
+=09return git_config_copy_section_in_file(NULL, old_name, new_name);
+}
+
 /*
  * Call this to report error for your variable that should not
  * get a boolean value (i.e. "[my] var" means "true").
diff --git a/refs.c b/refs.c
index f0685c92513e3..d724cda58f890 100644
--- a/refs.c
+++ b/refs.c
@@ -2032,3 +2032,14 @@ int rename_ref(const char *oldref, const char *newre=
f, const char *logmsg)
 {
 =09return refs_rename_ref(get_main_ref_store(), oldref, newref, logmsg);
 }
+
+int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
+=09=09    const char *newref, const char *logmsg)
+{
+=09return refs->be->copy_ref(refs, oldref, newref, logmsg);
+}
+
+int copy_existing_ref(const char *oldref, const char *newref, const char *=
logmsg)
+{
+=09return refs_copy_existing_ref(get_main_ref_store(), oldref, newref, log=
msg);
+}
diff --git a/refs.h b/refs.h
index 4be14c4b3cc65..00fce93f55574 100644
--- a/refs.h
+++ b/refs.h
@@ -440,7 +440,14 @@ char *shorten_unambiguous_ref(const char *refname, int=
 strict);
 /** rename ref, return 0 on success **/
 int refs_rename_ref(struct ref_store *refs, const char *oldref,
 =09=09    const char *newref, const char *logmsg);
-int rename_ref(const char *oldref, const char *newref, const char *logmsg)=
;
+int rename_ref(const char *oldref, const char *newref,
+=09=09=09const char *logmsg);
+
+/** copy ref, return 0 on success **/
+int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
+=09=09    const char *newref, const char *logmsg);
+int copy_existing_ref(const char *oldref, const char *newref,
+=09=09=09const char *logmsg);
=20
 int refs_create_symref(struct ref_store *refs, const char *refname,
 =09=09       const char *target, const char *logmsg);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index d8b3f73147c8a..fcaf4f719136e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1733,9 +1733,9 @@ static int commit_ref_update(struct files_ref_store *=
refs,
 =09=09=09     const struct object_id *oid, const char *logmsg,
 =09=09=09     struct strbuf *err);
=20
-static int files_rename_ref(struct ref_store *ref_store,
+static int files_copy_or_rename_ref(struct ref_store *ref_store,
 =09=09=09    const char *oldrefname, const char *newrefname,
-=09=09=09    const char *logmsg)
+=09=09=09    const char *logmsg, int copy)
 {
 =09struct files_ref_store *refs =3D
 =09=09files_downcast(ref_store, REF_STORE_WRITE, "rename_ref");
@@ -1767,8 +1767,12 @@ static int files_rename_ref(struct ref_store *ref_st=
ore,
 =09}
=20
 =09if (flag & REF_ISSYMREF) {
-=09=09ret =3D error("refname %s is a symbolic ref, renaming it is not supp=
orted",
-=09=09=09    oldrefname);
+=09=09if (copy)
+=09=09=09ret =3D error("refname %s is a symbolic ref, copying it is not su=
pported",
+=09=09=09=09    oldrefname);
+=09=09else
+=09=09=09ret =3D error("refname %s is a symbolic ref, renaming it is not s=
upported",
+=09=09=09=09    oldrefname);
 =09=09goto out;
 =09}
 =09if (!refs_rename_ref_available(&refs->base, oldrefname, newrefname)) {
@@ -1776,13 +1780,19 @@ static int files_rename_ref(struct ref_store *ref_s=
tore,
 =09=09goto out;
 =09}
=20
-=09if (log && rename(sb_oldref.buf, tmp_renamed_log.buf)) {
+=09if (!copy && log && rename(sb_oldref.buf, tmp_renamed_log.buf)) {
 =09=09ret =3D error("unable to move logfile logs/%s to logs/"TMP_RENAMED_L=
OG": %s",
 =09=09=09    oldrefname, strerror(errno));
 =09=09goto out;
 =09}
=20
-=09if (refs_delete_ref(&refs->base, logmsg, oldrefname,
+=09if (copy && log && copy_file(tmp_renamed_log.buf, sb_oldref.buf, 0644))=
 {
+=09=09ret =3D error("unable to copy logfile logs/%s to logs/"TMP_RENAMED_L=
OG": %s",
+=09=09=09    oldrefname, strerror(errno));
+=09=09goto out;
+=09}
+
+=09if (!copy && refs_delete_ref(&refs->base, logmsg, oldrefname,
 =09=09=09    orig_oid.hash, REF_NODEREF)) {
 =09=09error("unable to delete old %s", oldrefname);
 =09=09goto rollback;
@@ -1795,7 +1805,7 @@ static int files_rename_ref(struct ref_store *ref_sto=
re,
 =09 * the safety anyway; we want to delete the reference whatever
 =09 * its current value.
 =09 */
-=09if (!refs_read_ref_full(&refs->base, newrefname,
+=09if (!copy && !refs_read_ref_full(&refs->base, newrefname,
 =09=09=09=09RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 =09=09=09=09oid.hash, NULL) &&
 =09    refs_delete_ref(&refs->base, NULL, newrefname,
@@ -1826,7 +1836,10 @@ static int files_rename_ref(struct ref_store *ref_st=
ore,
 =09lock =3D lock_ref_sha1_basic(refs, newrefname, NULL, NULL, NULL,
 =09=09=09=09   REF_NODEREF, NULL, &err);
 =09if (!lock) {
-=09=09error("unable to rename '%s' to '%s': %s", oldrefname, newrefname, e=
rr.buf);
+=09=09if (copy)
+=09=09=09error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, =
err.buf);
+=09=09else
+=09=09=09error("unable to rename '%s' to '%s': %s", oldrefname, newrefname=
, err.buf);
 =09=09strbuf_release(&err);
 =09=09goto rollback;
 =09}
@@ -1877,6 +1890,22 @@ static int files_rename_ref(struct ref_store *ref_st=
ore,
 =09return ret;
 }
=20
+static int files_rename_ref(struct ref_store *ref_store,
+=09=09=09    const char *oldrefname, const char *newrefname,
+=09=09=09    const char *logmsg)
+{
+=09return files_copy_or_rename_ref(ref_store, oldrefname,
+=09=09=09=09 newrefname, logmsg, 0);
+}
+
+static int files_copy_ref(struct ref_store *ref_store,
+=09=09=09    const char *oldrefname, const char *newrefname,
+=09=09=09    const char *logmsg)
+{
+=09return files_copy_or_rename_ref(ref_store, oldrefname,
+=09=09=09=09 newrefname, logmsg, 1);
+}
+
 static int close_ref(struct ref_lock *lock)
 {
 =09if (close_lock_file(lock->lk))
@@ -3383,6 +3412,7 @@ struct ref_storage_be refs_be_files =3D {
 =09files_create_symref,
 =09files_delete_refs,
 =09files_rename_ref,
+=09files_copy_ref,
=20
 =09files_ref_iterator_begin,
 =09files_read_raw_ref,
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 192f9f85c97c0..3c51194edb190 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -543,6 +543,9 @@ typedef int delete_refs_fn(struct ref_store *ref_store,=
 const char *msg,
 typedef int rename_ref_fn(struct ref_store *ref_store,
 =09=09=09  const char *oldref, const char *newref,
 =09=09=09  const char *logmsg);
+typedef int copy_ref_fn(struct ref_store *ref_store,
+=09=09=09  const char *oldref, const char *newref,
+=09=09=09  const char *logmsg);
=20
 /*
  * Iterate over the references in `ref_store` whose names start with
@@ -641,6 +644,7 @@ struct ref_storage_be {
 =09create_symref_fn *create_symref;
 =09delete_refs_fn *delete_refs;
 =09rename_ref_fn *rename_ref;
+=09copy_ref_fn *copy_ref;
=20
 =09ref_iterator_begin_fn *iterator_begin;
 =09read_raw_ref_fn *read_raw_ref;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 28c02ffeadb4f..23a773dc25e93 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -378,6 +378,217 @@ EOF
 =09test_cmp expect actual
 '
=20
+test_expect_success 'git branch -c dumps usage' '
+=09test_expect_code 128 git branch -c 2>err &&
+=09test_i18ngrep "branch name required" err
+'
+
+test_expect_success 'git branch --copy dumps usage' '
+=09test_expect_code 128 git branch --copy 2>err &&
+=09test_i18ngrep "branch name required" err
+'
+
+test_expect_success 'git branch -c d e should work' '
+=09git branch -l d &&
+=09git reflog exists refs/heads/d &&
+=09git config branch.d.dummy Hello &&
+=09git branch -c d e &&
+=09git reflog exists refs/heads/d &&
+=09git reflog exists refs/heads/e &&
+=09echo Hello >expect &&
+=09git config branch.e.dummy >actual &&
+=09test_cmp expect actual &&
+=09echo Hello >expect &&
+=09git config branch.d.dummy >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'git branch --copy is a synonym for -c' '
+=09git branch -l copy &&
+=09git reflog exists refs/heads/copy &&
+=09git config branch.copy.dummy Hello &&
+=09git branch --copy copy copy-to &&
+=09git reflog exists refs/heads/copy &&
+=09git reflog exists refs/heads/copy-to &&
+=09echo Hello >expect &&
+=09git config branch.copy.dummy >actual &&
+=09test_cmp expect actual &&
+=09echo Hello >expect &&
+=09git config branch.copy-to.dummy >actual &&
+=09test_cmp expect actual
+'
+
+test_expect_success 'git branch -c ee ef should copy and checkout branch e=
f' '
+=09git checkout -b ee &&
+=09git reflog exists refs/heads/ee &&
+=09git config branch.ee.dummy Hello &&
+=09git branch -c ee ef &&
+=09git reflog exists refs/heads/ee &&
+=09git reflog exists refs/heads/ef &&
+=09test $(git config branch.ee.dummy) =3D Hello &&
+=09test $(git config branch.ef.dummy) =3D Hello &&
+=09test $(git rev-parse --abbrev-ref HEAD) =3D ef
+'
+
+test_expect_success 'git branch -c f/f g/g should work' '
+=09git branch -l f/f &&
+=09git reflog exists refs/heads/f/f &&
+=09git config branch.f/f.dummy Hello &&
+=09git branch -c f/f g/g &&
+=09git reflog exists refs/heads/f/f &&
+=09git reflog exists refs/heads/g/g &&
+=09test $(git config branch.f/f.dummy) =3D Hello &&
+=09test $(git config branch.g/g.dummy) =3D Hello
+'
+
+test_expect_success 'git branch -c m2 m2 should work' '
+=09git branch -l m2 &&
+=09git reflog exists refs/heads/m2 &&
+=09git config branch.m2.dummy Hello &&
+=09git branch -c m2 m2 &&
+=09git reflog exists refs/heads/m2 &&
+=09test $(git config branch.m2.dummy) =3D Hello
+'
+
+test_expect_success 'git branch -c zz zz/zz should fail' '
+=09git branch -l zz &&
+=09git reflog exists refs/heads/zz &&
+=09test_must_fail git branch -c zz zz/zz
+'
+
+test_expect_success 'git branch -c b/b b should fail' '
+=09git branch -l b/b &&
+=09test_must_fail git branch -c b/b b
+'
+
+test_expect_success 'git branch -C o/q o/p should work when o/p exists' '
+=09git branch -l o/q &&
+=09git reflog exists refs/heads/o/q &&
+=09git reflog exists refs/heads/o/p &&
+=09git branch -C o/q o/p
+'
+
+test_expect_success 'git branch -c -f o/q o/p should work when o/p exists'=
 '
+=09git reflog exists refs/heads/o/q &&
+=09git reflog exists refs/heads/o/p &&
+=09git branch -c -f o/q o/p
+'
+
+test_expect_success 'git branch -c qq rr/qq should fail when r exists' '
+=09git branch qq &&
+=09git branch rr &&
+=09test_must_fail git branch -c qq rr/qq
+'
+
+test_expect_success 'git branch -C b1 b2 should fail when b2 is checked ou=
t' '
+=09git branch b1 &&
+=09git checkout -b b2 &&
+=09test_must_fail git branch -C b1 b2
+'
+
+test_expect_success 'git branch -C c1 c2 should succeed when c1 is checked=
 out' '
+=09git checkout -b c1 &&
+=09git branch c2 &&
+=09git branch -C c1 c2 &&
+=09test $(git rev-parse --abbrev-ref HEAD) =3D c2
+'
+
+test_expect_success 'git branch -C c1 c2 should add entries to .git/logs/H=
EAD' '
+=09msg=3D"Branch: copied refs/heads/c1 to refs/heads/c2" &&
+=09grep "$msg$" .git/logs/HEAD
+'
+
+test_expect_success 'git branch -C master should work when master is check=
ed out' '
+=09git checkout master &&
+=09git branch -C master
+'
+
+test_expect_success 'git branch -C master master should work when master i=
s checked out' '
+=09git checkout master &&
+=09git branch -C master master
+'
+
+test_expect_success 'git branch -C master5 master5 should work when master=
 is checked out' '
+=09git checkout master &&
+=09git branch master5 &&
+=09git branch -C master5 master5
+'
+
+test_expect_success 'git branch -C ab cd should overwrite existing config =
for cd' '
+=09git branch -l cd &&
+=09git reflog exists refs/heads/cd &&
+=09git config branch.cd.dummy CD &&
+=09git branch -l ab &&
+=09git reflog exists refs/heads/ab &&
+=09git config branch.ab.dummy AB &&
+=09git branch -C ab cd &&
+=09git reflog exists refs/heads/ab &&
+=09git reflog exists refs/heads/cd &&
+=09test $(git config branch.ab.dummy) =3D AB &&
+=09test $(git config branch.cd.dummy) =3D AB
+'
+
+test_expect_success 'git branch -c correctly copies multiple config sectio=
ns' '
+=09FOO=3D1 &&
+=09export FOO &&
+=09test_when_finished "git checkout master" &&
+=09git checkout -b source2 master &&
+
+=09# Assert that a config file with multiple config sections has
+=09# those sections preserved...
+=09cat >expect <<-\EOF &&
+=09branch.source2.key1=3Dvalue1
+=09branch.dest2.key1=3Dvalue1
+=09more.gar.b=3Dage
+=09branch.source2.key2=3Dvalue2
+=09branch.dest2.key2=3Dvalue2
+=09EOF
+=09cat >config.branch <<\EOF &&
+;; Comment for source2
+[branch "source2"]
+=09;; Comment for the source2 value
+=09key1 =3D value1
+;; Comment for more.gar
+[more "gar"]
+=09;; Comment for the more.gar value
+=09b =3D age
+=09;; Comment for source, again
+[branch "source2"]
+=09;; Comment for the source2 value, again
+=09key2 =3D value2
+EOF
+=09cat config.branch >>.git/config &&
+=09git branch -c source2 dest2 &&
+=09git config -f .git/config -l | grep -F -e source2 -e dest2 -e more.gar =
>actual &&
+=09test_cmp expect actual &&
+
+=09# ...and that the comments and formatting for those sections
+=09# is also preserved.
+=09cat >expect <<\EOF &&
+;; Comment for source2
+[branch "source2"]
+=09;; Comment for the source2 value
+=09key1 =3D value1
+;; Comment for more.gar
+[branch "dest2"]
+=09;; Comment for the source2 value
+=09key1 =3D value1
+;; Comment for more.gar
+[more "gar"]
+=09;; Comment for the more.gar value
+=09b =3D age
+=09;; Comment for source, again
+[branch "source2"]
+=09;; Comment for the source2 value, again
+=09key2 =3D value2
+[branch "dest2"]
+=09;; Comment for the source2 value, again
+=09key2 =3D value2
+EOF
+=09grep -A 9001 "Comment for source2" .git/config >actual &&
+=09test_cmp expect actual
+'
+
 test_expect_success 'deleting a symref' '
 =09git branch target &&
 =09git symbolic-ref refs/heads/symref refs/heads/target &&

--
https://github.com/git/git/pull/363
