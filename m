From: "W. Trevor King" <wking@tremily.us>
Subject: [RFC v3 4/4] submodule: Add a new 'checkout' command
Date: Wed,  8 Jan 2014 22:17:55 -0800
Message-ID: <01c62c6fea978bc7938601ed3b00746c479a00f7.1389247320.git.wking@tremily.us>
References: <20140108040627.GD29954@odin.tremily.us>
 <cover.1389247320.git.wking@tremily.us>
Cc: Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 09 07:18:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W18x7-0005a6-Nj
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 07:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbaAIGSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 01:18:23 -0500
Received: from qmta12.westchester.pa.mail.comcast.net ([76.96.59.227]:46271
	"EHLO qmta12.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750832AbaAIGSU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jan 2014 01:18:20 -0500
Received: from omta13.westchester.pa.mail.comcast.net ([76.96.62.52])
	by qmta12.westchester.pa.mail.comcast.net with comcast
	id BiJJ1n00117dt5G5CiJJoo; Thu, 09 Jan 2014 06:18:18 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta13.westchester.pa.mail.comcast.net with comcast
	id BiJH1n002152l3L3ZiJHpp; Thu, 09 Jan 2014 06:18:18 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id C1750EB6894; Wed,  8 Jan 2014 22:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389248295; bh=hUUABVYn3mBvjnCmnxUSvylxlKbzfxWmzc/sZn0MRg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References;
	b=qtIyWCcS8MCNSUzdfTeMtLsF+TQ9lxwUWJt+vKKG8qAJ2MNV1oiQVAH/GqA1MA5X3
	 xAyK7WcMTbfdOXLwcHTT2nSqsNcZi+CqhrEBFg0vJmz6I1ovkpbKDTng+PhjW9bGI3
	 J/n2nYFHBM/v0LZaFqlLPTJUte2/MZvHKkWNyjh0=
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <cover.1389247320.git.wking@tremily.us>
In-Reply-To: <cover.1389247320.git.wking@tremily.us>
References: <cover.1389247320.git.wking@tremily.us>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389248298;
	bh=p8bcuT2iFCShyCDfi/ssz2eOiQbgfRGnXnPUnW/PR08=;
	h=Received:Received:Received:From:To:Subject:Date:Message-Id;
	b=fwWQY5rbT+QgE2JNPHsatThJ/+U1JviObH1fFXGbCqHF2NVEIeTu1yyRVAR/HtGgs
	 fvzYmB78qy+7dDAsv9Pcvm/7/dvXSF6r8Z+eder5vvYn32b98pGBU/KES3d33WOQQC
	 Svsa3FJToC+H9qxw/7IaQM9vJXAOeoupEekqEFQdPxSK4poOjZkZPMB/FyXGeRnFvr
	 z3TiKoiTHAs9Qr9zOEPg5MEGT/efKR9YtSzeZDCvlgyyraJuIhqEUQdGPPzv7DfwRa
	 cE0rr8wqF7wrjXU5vgMjrW7relzmtT/PYBlgx0YE4Ce2D9wQ05s0FjeQHx5CB93IOG
	 Gquv2zAuFLtVg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240249>

From: "W. Trevor King" <wking@tremily.us>

This borrows a good deal of the cmd_foreach logic to iterate through
submodules (potentially recursively), checking out the preferred local
branch for each submodule (as appropriate for the current superproject
branch).  Ideally, this logic would be bundled into the forthcoming:

  $ git checkout --recurse-submodules

logic that Jens Lehmann and Jonathan Nieder are working up in C.
Until that happens, you can simulate that checkout behaviour with:

  $ git checkout some-branch
  $ git submodule checkout --recursive

The relevant superproject branch used to determine the preferred
submodule branch is the submodules immediate parent, not the top-level
superproject.  For example, with the following submodule inheritance:

  superproject (branch super-1)
  `-- midproject (branch mid-1)
      `-- subproject (branch sub-1)

The .gitmodules configs should look like (assuming there are no local
overrides):

  $ git cat-file -p super-1:.gitmodules
  ...
  [submodule "midproject"]
       ...
       local-branch = mid-1
  $ cd midproject
  $ git cat-file -p mid-1:.gitmodules
  ...
  [submodule "subproject"]
       ...
       local-branch = sub-1

The super-1 branch need not even exist in the midproject repository.

This commit handles branch switches inside existing submodules.
Handling (or even detecting) submodules that are created and destroyed
or moving submodules that change path between the initial and final
superproject branch is put off to future patches.

I also added minimal support for initial branch creation.  Create your
initial branch with:

  $ git checkout -b my-feature
  $ git submodule checkout --recursive -b --gitmodules

which will create new 'my-feature' branches in each submodule (or die
trying).  It will also save 'my-feature' to the superproject's
.gitmodules' submodule.<name>.local-branch for future checkouts.
After setting up a branch like this, future checkouts (from some other
branch) will look like:

  $ git checkout my-feature
  $ git submodule checkout --recursive
---
 git-submodule.sh | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 7cee0bf..16cebb1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -6,6 +6,7 @@
 
 dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]
+   or: $dashless [--quiet] checkout [--recursive] [-b|-B] [--gitmodules] [--] [<path>...]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
    or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
@@ -36,6 +37,10 @@ update=
 prefix=
 custom_name=
 depth=
+create_new_branch=
+checkout_options=
+save_in_gitmodules=
+default_local_branch="master"
 
 # The function takes at most 2 arguments. The first argument is the
 # URL that navigates to the submodule origin repo. When relative, this URL
@@ -532,6 +537,89 @@ Use -f if you really want to add it." >&2
 }
 
 #
+# Checkout the appropriate local branch for each submodule
+#
+cmd_checkout()
+{
+	# parse $args after "submodule ... checkout".
+	while test $# -ne 0
+	do
+		case "$1" in
+		-q|--quiet)
+			GIT_QUIET=1
+			;;
+		--recursive)
+			recursive=1
+			;;
+		-b|-B)
+			checkout_options="${checkout_options} $1"
+			create_new_branch=1
+			;;
+		--gitmodules)
+			save_in_gitmodules=1
+			;;
+		--)
+			shift
+			break
+			;;
+		-*)
+			usage
+			;;
+		*)
+			break
+			;;
+		esac
+		shift
+	done
+
+	toplevel=$(pwd)
+
+	superproject_branch=$(get_current_branch)
+	if test -n "$create_new_branch"
+	then
+		default_local_branch="${superproject_branch}"
+	fi
+
+	# dup stdin so that it can be restored when running the external
+	# command in the subshell (and a recursive call to this function)
+	exec 3<&0
+
+	module_list "$@" |
+	while read mode sha1 stage sm_path
+	do
+		die_if_unmatched "$mode"
+		name=$(module_name "$sm_path") || exit
+		displaypath=$(relative_path "$prefix$sm_path")
+		if test -e "$sm_path"/.git
+		then
+			say "$(eval_gettext "Entering '\$displaypath'")"
+			name=$(module_name "$sm_path")
+			super_local_branch=$(get_submodule_config "$name" local-branch "${default_local_branch}")
+			(
+				prefix="$prefix$sm_path/"
+				clear_local_git_env
+				cd "$sm_path" &&
+				local_branch=$(get_local_branch "${superproject_branch}" "${super_local_branch}") &&
+				git checkout ${checkout_options} "${local_branch}" &&
+				if test -n "$recursive"
+				then
+					cmd_checkout
+				fi
+			) <&3 3<&- ||
+			die "$(eval_gettext "Stopping at '\$displaypath'; script returned non-zero status.")"
+			if test -n "${save_in_gitmodules}"
+			then
+				(
+					local_branch=$(clear_local_git_env && cd "$sm_path" && get_current_branch) &&
+					git config -f .gitmodules submodule."${name}".local-branch "${local_branch}"
+				) ||
+				die "$(eval_gettext "Could not save local-branch for '\$displaypath'")"
+			fi
+		fi
+	done
+}
+
+#
 # Execute an arbitrary command sequence in each checked out
 # submodule
 #
@@ -1378,7 +1466,7 @@ cmd_sync()
 while test $# != 0 && test -z "$command"
 do
 	case "$1" in
-	add | foreach | init | deinit | update | status | summary | sync)
+	add | checkout | foreach | init | deinit | update | status | summary | sync)
 		command=$1
 		;;
 	-q|--quiet)
-- 
1.8.5.2.237.g01c62c6
