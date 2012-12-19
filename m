From: wking@tremily.us
Subject: [PATCH v8 2/3] submodule update: add --remote for submodule's upstream
 changes
Date: Wed, 19 Dec 2012 11:03:32 -0500
Message-ID: <6f5822c998ad01146727214941b4b52a5b3680dd.1355932282.git.wking@tremily.us>
References: <20121212230217.GB7729@odin.tremily.us>
 <cover.1355932282.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 19 17:04:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlM7y-0003Qa-96
	for gcvg-git-2@plane.gmane.org; Wed, 19 Dec 2012 17:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571Ab2LSQD7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2012 11:03:59 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:61124 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755605Ab2LSQDy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 11:03:54 -0500
Received: from odin.tremily.us ([unknown] [72.68.92.119])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MFA00KL2CLTO530@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 19 Dec 2012 10:03:36 -0600 (CST)
Received: from mjolnir (mjolnir.tremily.us [192.168.0.6])
	by odin.tremily.us (Postfix) with SMTP id F0F15737707; Wed,
 19 Dec 2012 11:03:27 -0500 (EST)
Received: by mjolnir (sSMTP sendmail emulation); Wed, 19 Dec 2012 11:03:41 -0500
X-Mailer: git-send-email 1.8.0
In-reply-to: <cover.1355932282.git.wking@tremily.us>
In-reply-to: <cover.1355932282.git.wking@tremily.us>
References: <cover.1355932282.git.wking@tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211831>

=46rom: "W. Trevor King" <wking@tremily.us>

The current `update` command incorporates the superproject's gitlinked
SHA-1 ($sha1) into the submodule HEAD ($subsha1).  Depending on the
options you use, it may checkout $sha1, rebase the $subsha1 onto
$sha1, or merge $sha1 into $subsha1.  This helps you keep up with
changes in the upstream superproject.

However, it's also useful to stay up to date with changes in the
upstream subproject.  Previous workflows for incorporating such
changes include the ungainly:

  $ git submodule foreach 'git checkout $(git config --file $toplevel/.=
gitmodules submodule.$name.branch) && git pull'

With this patch, all of the useful functionality for incorporating
superproject changes can be reused to incorporate upstream subproject
updates.  When you specify --remote, the target $sha1 is replaced with
a $sha1 of the submodule's origin/master tracking branch.  If you want
to merge a different tracking branch, you can configure the
`submodule.<name>.branch` option in `.gitmodules`.  You can override
the `.gitmodules` configuration setting for a particular superproject
by configuring the option in that superproject's default configuration
(using the usual configuration hierarchy, e.g. `.git/config`,
`~/.gitconfig`, etc.).

Previous use of submodule.<name>.branch
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Because we're adding a new configuration option, it's a good idea to
check if anyone else is already using the option.  The foreach-pull
example above was described by =C3=86var in

  commit f030c96d8643fa0a1a9b2bd9c2f36a77721fb61f
  Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
  Date:   Fri May 21 16:10:10 2010 +0000

    git-submodule foreach: Add $toplevel variable

Gerrit uses the same interpretation for the setting, but because
Gerrit has direct access to the subproject repositories, it updates
the superproject repositories automatically when a subproject changes.
Gerrit also accepts the special value '.', which it expands into the
superproject's branch name.

Although the --remote functionality is using `submodule.<name>.branch`
slightly differently, the effect is the same.  The foreach-pull
example uses the option to record the name of the local branch to
checkout before pulls.  The tracking branch to be pulled is recorded
in `.git/modules/<name>/config`, which was initialized by the module
clone during `submodule add` or `submodule init`.  Because the branch
name stored in `submodule.<name>.branch` was likely the same as the
branch name used during the initial `submodule add`, the same branch
will be pulled in each workflow.

Implementation details
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

In order to ensure a current tracking branch state, `update --remote`
fetches the submodule's remote repository before calculating the
SHA-1.  However, I didn't change the logic guarding the existing fetch:

  if test -z "$nofetch"
  then
    # Run fetch only if $sha1 isn't present or it
    # is not reachable from a ref.
    (clear_local_git_env; cd "$path" &&
      ( (rev=3D$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
       test -z "$rev") || git-fetch)) ||
    die "$(eval_gettext "Unable to fetch in submodule path '\$path'")"
  fi

There will not be a double-fetch, because the new $sha1 determined
after the `--remote` triggered fetch should always exist in the
repository.  If it doesn't, it's because some racy process removed it
from the submodule's repository and we *should* be re-fetching.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 Documentation/config.txt        |  6 ++++++
 Documentation/git-submodule.txt | 23 ++++++++++++++++++++++-
 Documentation/gitmodules.txt    |  5 +++++
 git-submodule.sh                | 21 ++++++++++++++++++++-
 t/t7406-submodule-update.sh     | 31 +++++++++++++++++++++++++++++++
 5 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf8f911..7976a6b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1995,6 +1995,12 @@ submodule.<name>.update::
 	URL and other values found in the `.gitmodules` file.  See
 	linkgit:git-submodule[1] and linkgit:gitmodules[5] for details.
=20
+submodule.<name>.branch::
+	The remote branch name for a submodule, used by `git submodule
+	update --remote`.  Set this option to override the value found in
+	the `.gitmodules` file.  See linkgit:git-submodule[1] and
+	linkgit:gitmodules[5] for details.
+
 submodule.<name>.fetchRecurseSubmodules::
 	This option can be used to control recursive fetching of this
 	submodule. It can be overridden by using the --[no-]recurse-submodule=
s
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submod=
ule.txt
index b1de3ba..8bf173a 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	      [--reference <repository>] [--] <repository> [<path>]
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>=
=2E..]
 'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
+'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch] [=
--rebase]
 	      [--reference <repository>] [--merge] [--recursive] [--] [<path>=
=2E..]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-li=
mit) <n>]
 	      [commit] [--] [<path>...]
@@ -236,6 +236,27 @@ OPTIONS
 	(the default). This limit only applies to modified submodules. The
 	size is always limited to 1 for added/deleted/typechanged submodules.
=20
+--remote::
+	This option is only valid for the update command.  Instead of using
+	the superproject's recorded SHA-1 to update the submodule, use the
+	status of the submodule's remote tracking branch.  The remote used
+	is branch's remote (`branch.<name>.remote`), defaulting to `origin`.
+	The remote branch used defaults to `master`, but the branch name may
+	be overridden by setting the `submodule.<name>.branch` option in
+	either `.gitmodules` or `.git/config` (with `.git/config` taking
+	precedence).
++
+This works for any of the supported update procedures (`--checkout`,
+`--rebase`, etc.).  The only change is the source of the target SHA-1.
+For example, `submodule update --remote --merge` will merge upstream
+submodule changes into the submodules, while `submodule update
+--merge` will merge superproject gitlink changes into the submodules.
++
+In order to ensure a current tracking branch state, `update --remote`
+fetches the submodule's remote repository before calculating the
+SHA-1.  If you don't want to fetch, you should use `submodule update
+--remote --no-fetch`.
+
 -N::
 --no-fetch::
 	This option is only valid for the update command.
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.tx=
t
index ab3e91c..52d7ae4 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -49,6 +49,11 @@ submodule.<name>.update::
 	This config option is overridden if 'git submodule update' is given
 	the '--merge', '--rebase' or '--checkout' options.
=20
+submodule.<name>.branch::
+	A remote branch name for tracking updates in the upstream submodule.
+	If the option is not specified, it defaults to 'master'.  See the
+	`--remote` documentation in linkgit:git-submodule[1] for details.
+
 submodule.<name>.fetchRecurseSubmodules::
 	This option can be used to control recursive fetching of this
 	submodule. If this option is also present in the submodules entry in
diff --git a/git-submodule.sh b/git-submodule.sh
index 263a60c..6ae51c6 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -8,7 +8,7 @@ dashless=3D$(basename "$0" | sed -e 's/-/ /')
 USAGE=3D"[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--r=
eference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path=
>...]
    or: $dashless [--quiet] init [--] [<path>...]
-   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force=
] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<=
path>...]
+   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] =
[-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursi=
ve] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit=
 <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
@@ -26,6 +26,7 @@ cached=3D
 recursive=3D
 init=3D
 files=3D
+remote=3D
 nofetch=3D
 update=3D
 prefix=3D
@@ -559,6 +560,9 @@ cmd_update()
 		-i|--init)
 			init=3D1
 			;;
+		--remote)
+			remote=3D1
+			;;
 		-N|--no-fetch)
 			nofetch=3D1
 			;;
@@ -619,6 +623,7 @@ cmd_update()
 		fi
 		name=3D$(module_name "$sm_path") || exit
 		url=3D$(git config submodule."$name".url)
+		branch=3D$(get_submodule_config "$name" branch master)
 		if ! test -z "$update"
 		then
 			update_module=3D$update
@@ -653,6 +658,20 @@ Maybe you want to use 'update --init'?")"
 			die "$(eval_gettext "Unable to find current revision in submodule p=
ath '\$sm_path'")"
 		fi
=20
+		if test -n "$remote"
+		then
+			if test -z "$nofetch"
+			then
+				# Fetch remote before determining tracking $sha1
+				(clear_local_git_env; cd "$sm_path" && git-fetch) ||
+				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'=
")"
+			fi
+			remote_name=3D$(clear_local_git_env; cd "$sm_path" && get_default_r=
emote)
+			sha1=3D$(clear_local_git_env; cd "$sm_path" &&
+				git rev-parse --verify "${remote_name}/${branch}") ||
+			die "$(eval_gettext "Unable to find current ${remote_name}/${branch=
} revision in submodule path '\$sm_path'")"
+		fi
+
 		if test "$subsha1" !=3D "$sha1" -o -n "$force"
 		then
 			subforce=3D$force
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index feaec6c..4975ec0 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -135,6 +135,37 @@ test_expect_success 'submodule update --force forc=
ibly checks out submodules' '
 	)
 '
=20
+test_expect_success 'submodule update --remote should fetch upstream c=
hanges' '
+	(cd submodule &&
+	 echo line4 >> file &&
+	 git add file &&
+	 test_tick &&
+	 git commit -m "upstream line4"
+	) &&
+	(cd super &&
+	 git submodule update --remote --force submodule &&
+	 cd submodule &&
+	 test "$(git log -1 --oneline)" =3D "$(GIT_DIR=3D../../submodule/.git=
 git log -1 --oneline)"
+	)
+'
+
+test_expect_success 'local config should override .gitmodules branch' =
'
+	(cd submodule &&
+	 git checkout -b test-branch &&
+	 echo line5 >> file &&
+	 git add file &&
+	 test_tick &&
+	 git commit -m "upstream line5" &&
+	 git checkout master
+	) &&
+	(cd super &&
+	 git config submodule.submodule.branch test-branch &&
+	 git submodule update --remote --force submodule &&
+	 cd submodule &&
+	 test "$(git log -1 --oneline)" =3D "$(GIT_DIR=3D../../submodule/.git=
 git log -1 --oneline test-branch)"
+	)
+'
+
 test_expect_success 'submodule update --rebase staying on master' '
 	(cd super/submodule &&
 	  git checkout master
--=20
1.8.0
