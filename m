From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 1/1] Add another option for receive.denyCurrentBranch
Date: Thu, 13 Nov 2014 12:03:46 +0100 (CET)
Message-ID: <7bd583cb3c7097811cff81cada9720eb30c3585e.1415876330.git.johannes.schindelin@gmx.de>
References: <cover.1415629053.git.johannes.schindelin@gmx.de> <cover.1415876330.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-1456990219-1415876626=:13845"
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 13 12:04:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XosC3-0006jF-4q
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 12:04:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933002AbaKMLDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 06:03:54 -0500
Received: from mout.gmx.net ([212.227.17.20]:50172 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932581AbaKMLDw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 06:03:52 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MDm4o-1Xm9hk2ihq-00HABk;
 Thu, 13 Nov 2014 12:03:46 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <cover.1415876330.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:N3UJpSOtZXs0Obp7gh8+nDPLr6/l9+MHLlEH73N9t2NQWEVDkTk
 uTeFAmHsAwOU72RfsA1XvsVmE07DCHHY5Pj7daX+S2YXYRO2MiUrEsUG3NRsMycURv4KfXE
 KHuJRKWJOxOUSToNSICxYotTG4iiLpchPQiwEwLSoZDpyniKFJGIjG48abaPOzRKY/ZXWMv
 I5qOL2CuggplNK+20mU0w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-1456990219-1415876626=:13845
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

The new option is:

'updateInstead':
=09Update the working tree accordingly, but refuse to do so if there
=09are any uncommitted changes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |  5 ++++
 builtin/receive-pack.c   | 78 ++++++++++++++++++++++++++++++++++++++++++++=
++--
 t/t5516-fetch-push.sh    | 17 +++++++++++
 3 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9220725..c384515 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2129,6 +2129,11 @@ receive.denyCurrentBranch::
 =09print a warning of such a push to stderr, but allow the push to
 =09proceed. If set to false or "ignore", allow such pushes with no
 =09message. Defaults to "refuse".
++
+Another option is "updateInstead" which will update the working
+directory (must be clean) if pushing into the current branch. This option =
is
+intended for synchronizing working directories when one side is not easily
+accessible via ssh (e.g. inside a VM).
=20
 receive.denyNonFastForwards::
 =09If set to true, git-receive-pack will deny a ref update which is
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 32fc540..836720f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -26,7 +26,8 @@ enum deny_action {
 =09DENY_UNCONFIGURED,
 =09DENY_IGNORE,
 =09DENY_WARN,
-=09DENY_REFUSE
+=09DENY_REFUSE,
+=09DENY_UPDATE_INSTEAD
 };
=20
 static int deny_deletes;
@@ -76,6 +77,8 @@ static enum deny_action parse_deny_action(const char *var=
, const char *value)
 =09=09=09return DENY_WARN;
 =09=09if (!strcasecmp(value, "refuse"))
 =09=09=09return DENY_REFUSE;
+=09=09if (!strcasecmp(value, "updateinstead"))
+=09=09=09return DENY_UPDATE_INSTEAD;
 =09}
 =09if (git_config_bool(var, value))
 =09=09return DENY_REFUSE;
@@ -730,11 +733,74 @@ static int update_shallow_ref(struct command *cmd, st=
ruct shallow_info *si)
 =09return 0;
 }
=20
+static const char *update_worktree(unsigned char *sha1)
+{
+=09const char *update_refresh[] =3D {
+=09=09"update-index", "--ignore-submodules", "--refresh", NULL
+=09};
+=09const char *diff_index[] =3D {
+=09=09"diff-index", "--quiet", "--cached", "--ignore-submodules",
+=09=09"HEAD", "--", NULL
+=09};
+=09const char *read_tree[] =3D {
+=09=09"read-tree", "-u", "-m", sha1_to_hex(sha1), NULL
+=09};
+=09const char *work_tree =3D git_work_tree_cfg ? git_work_tree_cfg : "..";
+=09struct argv_array env =3D ARGV_ARRAY_INIT;
+=09struct child_process child =3D CHILD_PROCESS_INIT;
+
+=09if (is_bare_repository())
+=09=09return "denyCurrentBranch =3D updateInstead needs a worktree";
+
+=09argv_array_pushf(&env, "GIT_DIR=3D%s", absolute_path(get_git_dir()));
+
+=09child.argv =3D update_refresh;
+=09child.env =3D env.argv;
+=09child.dir =3D work_tree;
+=09child.no_stdin =3D 1;
+=09child.stdout_to_stderr =3D 1;
+=09child.git_cmd =3D 1;
+=09if (run_command(&child)) {
+=09=09argv_array_clear(&env);
+=09=09return "Up-to-date check failed";
+=09}
+
+=09/* run_command() does not clean up completely; reinitialize */
+=09child_process_init(&child);
+=09child.argv =3D diff_index;
+=09child.env =3D env.argv;
+=09child.no_stdin =3D 1;
+=09child.no_stdout =3D 1;
+=09child.stdout_to_stderr =3D 0;
+=09child.git_cmd =3D 1;
+=09if (run_command(&child)) {
+=09=09argv_array_clear(&env);
+=09=09return "Working directory not clean";
+=09}
+
+=09/* run_command() does not clean up completely; reinitialize */
+=09child_process_init(&child);
+=09child.argv =3D read_tree;
+=09child.env =3D env.argv;
+=09child.dir =3D work_tree;
+=09child.no_stdin =3D 1;
+=09child.no_stdout =3D 1;
+=09child.stdout_to_stderr =3D 0;
+=09child.git_cmd =3D 1;
+=09if (run_command(&child)) {
+=09=09argv_array_clear(&env);
+=09=09return "Could not update working tree to new HEAD";
+=09}
+
+=09argv_array_clear(&env);
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
@@ -760,6 +826,11 @@ static const char *update(struct command *cmd, struct =
shallow_info *si)
 =09=09=09if (deny_current_branch =3D=3D DENY_UNCONFIGURED)
 =09=09=09=09refuse_unconfigured_deny();
 =09=09=09return "branch is currently checked out";
+=09=09case DENY_UPDATE_INSTEAD:
+=09=09=09ret =3D update_worktree(new_sha1);
+=09=09=09if (ret)
+=09=09=09=09return ret;
+=09=09=09break;
 =09=09}
 =09}
=20
@@ -784,10 +855,13 @@ static const char *update(struct command *cmd, struct=
 shallow_info *si)
 =09=09=09=09break;
 =09=09=09case DENY_REFUSE:
 =09=09=09case DENY_UNCONFIGURED:
+=09=09=09case DENY_UPDATE_INSTEAD:
 =09=09=09=09if (deny_delete_current =3D=3D DENY_UNCONFIGURED)
 =09=09=09=09=09refuse_unconfigured_deny_delete_current();
 =09=09=09=09rp_error("refusing to delete the current branch: %s", name);
 =09=09=09=09return "deletion of the current branch prohibited";
+=09=09=09default:
+=09=09=09=09return "Invalid denyDeleteCurrent setting";
 =09=09=09}
 =09=09}
 =09}
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index f4da20a..ba002a9 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1330,4 +1330,21 @@ test_expect_success 'fetch into bare respects core.l=
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
 test_done
--=20
2.0.0.rc3.9669.g840d1f9
--1784107012-1456990219-1415876626=:13845--
