From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v6 4/4] submodule update: add submodule.<name>.remote config
 option
Date: Sat, 01 Dec 2012 22:17:04 -0500
Message-ID: <b9635b844051e681af1c80447fedac5ee77280f7.1354417619.git.wking@tremily.us>
References: <20121130032719.GE29257@odin.tremily.us>
 <cover.1354417618.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 02 04:18:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tf04l-00067R-KQ
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 04:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542Ab2LBDSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 22:18:25 -0500
Received: from vms173019pub.verizon.net ([206.46.173.19]:58984 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab2LBDSU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 22:18:20 -0500
Received: from odin.tremily.us ([unknown] [72.68.87.250])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MED00KGOVTZOT90@vms173019.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 01 Dec 2012 21:18:04 -0600 (CST)
Received: from localhost (tyr.tremily.us [192.168.0.5])
	by odin.tremily.us (Postfix) with ESMTP id A394E6E403D; Sat,
 01 Dec 2012 22:17:59 -0500 (EST)
X-Mailer: git-send-email 1.8.0.4.gf74b0fc.dirty
In-reply-to: <cover.1354417618.git.wking@tremily.us>
In-reply-to: <cover.1354417618.git.wking@tremily.us>
References: <cover.1354417618.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210996>

From: "W. Trevor King" <wking@tremily.us>

Don't force the user to clone from the tracked repository
(branch.<name>.remote) or `origin`.  By setting
submodule.<name>.remote in .gitmodules or the usual git config files,
you can easily point a submodule at a different remote when using
`submodule update --remote`.

The configured remote name is also used in `submodule sync` to
determine which remote.<name>.url is updated with the submodule's
origin URL.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/config.txt        |  7 ++++---
 Documentation/git-submodule.txt | 10 +++++-----
 git-submodule.sh                | 27 +++++++++++++++++++++------
 t/t7406-submodule-update.sh     | 18 ++++++++++++++++++
 4 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6f4663c..c54b9b4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1999,10 +1999,11 @@ submodule.<name>.update::
 	by 'git submodule init'; edit them to override the
 	URL and other values found in the `.gitmodules` file.  See
 
+submodule.<name>.remote::
 submodule.<name>.branch::
-	The remote branch name for a submodule, used by `git submodule
-	update --remote`.  Set this option to override the value found in
-	the `.gitmodules` file.  See linkgit:git-submodule[1] and
+	The remote repository and branch names for a submodule, used by `git
+	submodule update --remote`.  Set these options to override the value
+	found in the `.gitmodules` file.  See linkgit:git-submodule[1] and
 	linkgit:gitmodules[5] for details.
 
 submodule.<name>.fetchRecurseSubmodules::
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 988bba9..1d8d5f1 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -242,11 +242,11 @@ OPTIONS
 	This option is only valid for the update command.  Instead of using
 	the superproject's recorded SHA-1 to update the submodule, use the
 	status of the submodule's remote tracking branch.  The remote used
-	is branch's remote (`branch.<name>.remote`), defaulting to `origin`.
-	The remote branch used defaults to `master`, but the branch name may
-	be overridden by setting the `submodule.<name>.branch` option in
-	either `.gitmodules` or `.git/config` (with `.git/config` taking
-	precedence).
+	is branch's remote (`branch.<name>.remote`, defaulting to `origin`),
+	and the remote branch used defaults to `master`, but either may be
+	overridden by setting the `submodule.<name>.remote` or
+	`submodule.<name>.branch` option in `.gitmodules` or `.git/config`
+	(with `.git/config` taking precedence).
 +
 This works for any of the supported update procedures (`--checkout`,
 `--rebase`, etc.).  The only change is the source of the target SHA-1.
diff --git a/git-submodule.sh b/git-submodule.sh
index 27b02fe..3e39e29 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -179,6 +179,21 @@ get_submodule_config()
 	printf '%s' "${value:-$default}"
 }
 
+#
+# Print the name of a submodule's configured remote
+#
+# $1 = submodule name
+#
+get_submodule_remote()
+{
+	name="$1"
+	remote=$(get_submodule_config "$name" remote)
+	if test -z "$remote"
+	then
+		remote=$(get_default_remote)
+	fi
+	printf '%s' "${remote}"
+}
 
 #
 # Map submodule path to submodule name
@@ -605,6 +620,7 @@ cmd_update()
 		fi
 		name=$(module_name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
+		remote_name=$(get_submodule_remote "$name")
 		branch=$(get_submodule_config "$name" branch master)
 		if ! test -z "$update"
 		then
@@ -645,10 +661,9 @@ Maybe you want to use 'update --init'?")"
 			if test -z "$nofetch"
 			then
 				# Fetch remote before determining tracking $sha1
-				(clear_local_git_env; cd "$sm_path" && git-fetch) ||
-				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
+				(clear_local_git_env; cd "$sm_path" && git-fetch "$remote_name") ||
+				die "$(eval_gettext "Unable to fetch '\$remote_name' in submodule path '\$sm_path'")"
 			fi
-			remote_name=$(get_default_remote)
 			sha1=$(clear_local_git_env; cd "$sm_path" &&
 				git rev-parse --verify "${remote_name}/${branch}") ||
 			die "$(eval_gettext "Unable to find current ${remote_name}/${branch} revision in submodule path '\$sm_path'")"
@@ -669,8 +684,8 @@ Maybe you want to use 'update --init'?")"
 				# is not reachable from a ref.
 				(clear_local_git_env; cd "$sm_path" &&
 					( (rev=$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
-					 test -z "$rev") || git-fetch)) ||
-				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
+					 test -z "$rev") || git-fetch "$remote_name")) ||
+				die "$(eval_gettext "Unable to fetch '\$remote_name' in submodule path '\$sm_path'")"
 			fi
 
 			# Is this something we just cloned?
@@ -1110,7 +1125,7 @@ cmd_sync()
 			(
 				clear_local_git_env
 				cd "$sm_path"
-				remote=$(get_default_remote)
+				remote=$(get_submodule_remote "$name")
 				git config remote."$remote".url "$sub_origin_url"
 			)
 			fi
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index a567834..86c85f8 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -149,6 +149,24 @@ test_expect_success 'submodule update --remote should fetch upstream changes' '
 	)
 '
 
+test_expect_success 'local config should override .gitmodules remote' '
+	(cd submodule &&
+	 echo line5-master >> file &&
+	 git add file &&
+	 test_tick &&
+	 git commit -m "upstream line5-master"
+	) &&
+	(cd super/submodule &&
+	 git remote rename origin test-remote
+	) &&
+	(cd super &&
+	 git config submodule.submodule.remote test-remote &&
+	 git submodule update --remote --force submodule &&
+	 cd submodule &&
+	 test "$(git log -1 --oneline)" = "$(GIT_DIR=../../submodule/.git git log -1 --oneline)"
+	)
+'
+
 test_expect_success 'local config should override .gitmodules branch' '
 	(cd submodule &&
 	 git checkout -b test-branch &&
-- 
1.8.0.4.gf74b0fc.dirty
