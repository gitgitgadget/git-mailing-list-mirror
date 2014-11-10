From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 2/2] Add a few more options for
 receive.denyCurrentBranch
Date: Mon, 10 Nov 2014 15:38:44 +0100 (CET)
Message-ID: <99cc2455d46c3188fb32356ab326aeb809cb863a.1415630072.git.johannes.schindelin@gmx.de>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <cover.1415630072.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-1851151577-1415630325=:13845"
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 10 15:38:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnq7J-0000H1-To
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 15:38:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbaKJOit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 09:38:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:56934 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728AbaKJOis (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 09:38:48 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MA91t-1XhXW01Yi1-00BIjl;
 Mon, 10 Nov 2014 15:38:45 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1415630072.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:r/gX8vYF0ckulItET2FbDBXVFzmhSt3tgDzPX5fDEzWGuJrkloc
 SlUcZ5DuM4k/kOHq/76eCTjO/1OqE4nfHFxbd/SF8pPqfjTpVTQcQ9iAs3SgSWz6kndSqMc
 dHDvnUa5AFAQmF1PvLWIwQFsKkGNt75TQYktL4Av4fPzUGHB7suM9P1boriPpn28xkLH/ga
 nB5r3rAPySDd/v8FmwREQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-1851151577-1415630325=:13845
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

When synchronizing between working directories, it can be handy to update
the current branch via 'push' rather than 'pull', e.g. when pushing a fix
from inside a VM, or when pushing a fix made on a user's machine (where
the developer is not at liberty to install an ssh daemon let alone know
the user's password).

The common workaround =E2=80=93 pushing into a temporary branch and then me=
rging
on the other machine =E2=80=93 is no longer necessary with this patch.

For developers who are uncomfortable with letting pushes update the
working directory, but who are equally uncomfortable with the idea of
pushing into a temporary ref that will be readily forgotten, there is now
also an option to detach the HEAD if a push wants to update the current
branch (no working directory update is required in such a case because the
branch is no longer current after detaching the HEAD).

The new options are:

'updateInstead':
=09Update the working tree accordingly, but refuse to do so if there
=09are any uncommitted changes.

'detachInstead':
=09Detach the HEAD, thereby keeping currently checked-out revision,
=09index and working directory unchanged.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |  9 +++++++
 builtin/receive-pack.c   | 61 ++++++++++++++++++++++++++++++++++++++++++++=
+---
 t/t5516-fetch-push.sh    | 36 ++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e8dd76d..fc9b8db 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2129,6 +2129,15 @@ receive.denyCurrentBranch::
 =09print a warning of such a push to stderr, but allow the push to
 =09proceed. If set to false or "ignore", allow such pushes with no
 =09message. Defaults to "refuse".
++
+Another option is "updateInstead" which will update the working
+directory (must be clean) if pushing into the current branch. This option =
is
+intended for synchronizing working directories when one side is not easily
+accessible via ssh (e.g. inside a VM).
++
+Yet another option is "detachInstead" which will detach the HEAD if update=
s
+are pushed into the current branch; That way, the current revision, the
+index and the working directory are always left untouched by pushes.
=20
 receive.denyNonFastForwards::
 =09If set to true, git-receive-pack will deny a ref update which is
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 32fc540..4534e88 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -26,7 +26,9 @@ enum deny_action {
 =09DENY_UNCONFIGURED,
 =09DENY_IGNORE,
 =09DENY_WARN,
-=09DENY_REFUSE
+=09DENY_REFUSE,
+=09DENY_UPDATE_INSTEAD,
+=09DENY_DETACH_INSTEAD
 };
=20
 static int deny_deletes;
@@ -120,7 +122,12 @@ static int receive_pack_config(const char *var, const =
char *value, void *cb)
 =09}
=20
 =09if (!strcmp(var, "receive.denycurrentbranch")) {
-=09=09deny_current_branch =3D parse_deny_action(var, value);
+=09=09if (value && !strcasecmp(value, "updateinstead"))
+=09=09=09deny_current_branch =3D DENY_UPDATE_INSTEAD;
+=09=09else if (value && !strcasecmp(value, "detachinstead"))
+=09=09=09deny_current_branch =3D DENY_DETACH_INSTEAD;
+=09=09else
+=09=09=09deny_current_branch =3D parse_deny_action(var, value);
 =09=09return 0;
 =09}
=20
@@ -730,11 +737,44 @@ static int update_shallow_ref(struct command *cmd, st=
ruct shallow_info *si)
 =09return 0;
 }
=20
+static const char *merge_worktree(unsigned char *sha1)
+{
+=09const char *update_refresh[] =3D {
+=09=09"update-index", "--ignore-submodules", "--refresh", NULL
+=09};
+=09const char *read_tree[] =3D {
+=09=09"read-tree", "-u", "-m", sha1_to_hex(sha1), NULL
+=09};
+=09struct child_process child =3D CHILD_PROCESS_INIT;
+
+=09if (is_bare_repository())
+=09=09return "denyCurrentBranch =3D updateInstead needs a worktree";
+
+=09argv_array_pushf(&child.env_array, "GIT_DIR=3D%s", absolute_path(get_gi=
t_dir()));
+=09child.argv =3D update_refresh;
+=09child.dir =3D git_work_tree_cfg ? git_work_tree_cfg : "..";
+=09child.stdout_to_stderr =3D 1;
+=09child.git_cmd =3D 1;
+=09if (run_command(&child))
+=09=09die("Could not refresh the index");
+
+=09/* finish_command cleared the environment; reinitialize */
+=09argv_array_pushf(&child.env_array, "GIT_DIR=3D%s", absolute_path(get_gi=
t_dir()));
+=09child.argv =3D read_tree;
+=09child.no_stdin =3D 1;
+=09child.no_stdout =3D 1;
+=09child.stdout_to_stderr =3D 0;
+=09if (run_command(&child))
+=09=09die("Could not merge working tree with new HEAD.");
+
+=09return NULL;
+}
+
 static const char *update(struct command *cmd, struct shallow_info *si)
 {
 =09const char *name =3D cmd->ref_name;
 =09struct strbuf namespaced_name_buf =3D STRBUF_INIT;
-=09const char *namespaced_name;
+=09const char *namespaced_name, *ret;
 =09unsigned char *old_sha1 =3D cmd->old_sha1;
 =09unsigned char *new_sha1 =3D cmd->new_sha1;
=20
@@ -760,6 +800,19 @@ static const char *update(struct command *cmd, struct =
shallow_info *si)
 =09=09=09if (deny_current_branch =3D=3D DENY_UNCONFIGURED)
 =09=09=09=09refuse_unconfigured_deny();
 =09=09=09return "branch is currently checked out";
+=09=09case DENY_UPDATE_INSTEAD:
+=09=09=09ret =3D merge_worktree(new_sha1);
+=09=09=09if (ret)
+=09=09=09=09return ret;
+=09=09=09break;
+=09=09case DENY_DETACH_INSTEAD:
+=09=09=09ret =3D update_ref("push into current branch (detach)",
+=09=09=09=09"HEAD", old_sha1, NULL, REF_NODEREF,
+=09=09=09=09UPDATE_REFS_DIE_ON_ERR) ?
+=09=09=09=09"Could not detach HEAD" : NULL;
+=09=09=09if (ret)
+=09=09=09=09return ret;
+=09=09=09break;
 =09=09}
 =09}
=20
@@ -788,6 +841,8 @@ static const char *update(struct command *cmd, struct s=
hallow_info *si)
 =09=09=09=09=09refuse_unconfigured_deny_delete_current();
 =09=09=09=09rp_error("refusing to delete the current branch: %s", name);
 =09=09=09=09return "deletion of the current branch prohibited";
+=09=09=09default:
+=09=09=09=09die ("Invalid denyDeleteCurrent setting");
 =09=09=09}
 =09=09}
 =09}
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index f4da20a..3981d1b 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1330,4 +1330,40 @@ test_expect_success 'fetch into bare respects core.l=
ogallrefupdates' '
 =09)
 '
=20
+test_expect_success 'receive.denyCurrentBranch =3D updateInstead' '
+=09git push testrepo master &&
+=09(cd testrepo &&
+=09=09git reset --hard &&
+=09=09git config receive.denyCurrentBranch updateInstead
+=09) &&
+=09test_commit third path2 &&
+=09git push testrepo master &&
+=09test $(git rev-parse HEAD) =3D $(cd testrepo && git rev-parse HEAD) &&
+=09test third =3D "$(cat testrepo/path2)" &&
+=09(cd testrepo &&
+=09=09git update-index --refresh &&
+=09=09git diff-files --quiet &&
+=09=09git diff-index --cached HEAD --
+=09)
+'
+
+test_expect_success 'receive.denyCurrentBranch =3D detachInstead' '
+=09(cd testrepo &&
+=09=09git reset --hard &&
+=09=09git config receive.denyCurrentBranch detachInstead
+=09) &&
+=09OLDHEAD=3D$(cd testrepo && git rev-parse HEAD) &&
+=09test_commit fourth path2 &&
+=09test fourth =3D "$(cat path2)" &&
+=09git push testrepo master &&
+=09test $OLDHEAD =3D $(cd testrepo && git rev-parse HEAD) &&
+=09test fourth !=3D "$(cat testrepo/path2)" &&
+=09(cd testrepo &&
+=09=09test_must_fail git symbolic-ref HEAD &&
+=09=09git update-index --refresh &&
+=09=09git diff-files --quiet &&
+=09=09git diff-index --cached HEAD --
+=09)
+'
+
 test_done
--=20
2.0.0.rc3.9669.g840d1f9
--1784107012-1851151577-1415630325=:13845--
