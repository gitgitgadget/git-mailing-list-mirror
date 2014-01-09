From: "W. Trevor King" <wking@tremily.us>
Subject: [RFC v3 1/4] submodule: Add helpers for configurable local branches
Date: Wed,  8 Jan 2014 22:17:52 -0800
Message-ID: <684f061e58bd16e617f438be9d6ed7b8d913463b.1389247320.git.wking@tremily.us>
References: <20140108040627.GD29954@odin.tremily.us>
 <cover.1389247320.git.wking@tremily.us>
Cc: Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 09 07:19:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W18xJ-00061U-2C
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 07:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbaAIGSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 01:18:49 -0500
Received: from qmta08.westchester.pa.mail.comcast.net ([76.96.62.80]:33731
	"EHLO qmta08.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751040AbaAIGSU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jan 2014 01:18:20 -0500
Received: from omta16.westchester.pa.mail.comcast.net ([76.96.62.88])
	by qmta08.westchester.pa.mail.comcast.net with comcast
	id BiGy1n0011uE5Es58iJJUS; Thu, 09 Jan 2014 06:18:18 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta16.westchester.pa.mail.comcast.net with comcast
	id BiJH1n002152l3L3ciJHZ9; Thu, 09 Jan 2014 06:18:18 +0000
Received: by odin.tremily.us (Postfix, from userid 1000)
	id 93542EB6888; Wed,  8 Jan 2014 22:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1389248294; bh=GtjMnW+gfsBTGueOhVM0ntsTJmBfnLraztV9wyLCaUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References;
	b=mzLe6SmI5O9Fd4++r1mqyI34TmzeK6Or7kdT6vkEGSw4tVK3hl8+gAA1Cwt5ZRnqq
	 rypiKJw9YZOI+hG4fCPedATTU2jfuvrxRdx+fTYBY+ST4kRqdx1QpC4+IvGU8eAr4R
	 oUMP+WIBHv+UbQyNJY8OpS86kJ9L0gCDPWJWe6Zg=
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <cover.1389247320.git.wking@tremily.us>
In-Reply-To: <cover.1389247320.git.wking@tremily.us>
References: <cover.1389247320.git.wking@tremily.us>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389248298;
	bh=KabwnS0Ns4jrTFjsRbelQAsP88YzihBfQjZw1zNe4Vg=;
	h=Received:Received:Received:From:To:Subject:Date:Message-Id;
	b=Aq60e0jVb8Wxq9w8GweYA/Qhv+ll+MlOPWjSPEeMiDBhjDr1asWGoG1zl5T6zgUO6
	 Ib67t+HlpThB8kxV1j7Gdsk6rqMZvDj5SYTHe8YpL6zT1UnraewieuhVlT+v6APlNT
	 Gb6l/ZUIKdpiIyUAAQ/6NaOkipDHALbTqcP8uh0qwiGOB9kUbMzJ4zPtQoa2i/eJAo
	 rw3UbOPY9CrJf8yfxYDwOZkLw+dws7crRCaEV1MjUqlmwqgcMq8X93Wi+EkvfTFej8
	 dLiAr0yJnOChoieGjxIpjFQEXOU9qD+ifu58RRYW0FQXGLz2cFGOY26ZoZVmHe6KC3
	 H1VXEtpsri06g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240251>

From: "W. Trevor King" <wking@tremily.us>

There are three branches that submodule folks usually care about:

1. The linked $sha1 in the superproject (set explicitly for every
   superproject commit, and thus for every superproject branch).
2. The remote-tracking submodule.<name>.branch that tracks a branch in
   upstream submodule.<name>.url repository.
3. The submodule's locally checked out branch, which we currently let
   the developer setup by hand, which is integrated with one of the
   other two branches by non-checkout update modes.

Git is currently a bit weak on conveniently handling branch #3.  "Just
use what the developer has setup" works well for many basic workflows,
but falls short for:

* Cloning-updates, where we currently always setup a detached HEAD.
  This is easy to fix if you accept submodule.<name>.branch or the
  branch pointed to by the cloned repository's HEAD as a guess, but
  this conflates branch #2 and branch #3, which may confuse users.

* Workflows where the preferred #3 branch depends on the superproject
  branch.  For example, if the remote subproject has only a master
  branch, but the local superproject needs to develop several
  submodule feature branches simultaneously, you can have a situation
  like this:

    Superproject branch  Submodule branch  Subproject branch
    ===================  ================  =================
    master               master            master
    feature-1            feature-1         master
    feature-2            feature-2         master
    feature-3            feature-2         master

In order to checkout the appropriate submodule branch for a given
superproject branch, we need a way to specify the preferred submodule
branch for a given superproject branch.  This commit adds two helper
functions:

* get_current_branch, to determine which superproject branch you're
  on, and
* get_local_branch, to determine the preferred submodule branch for
  that superproject branch.

The lookup chain for the local-branch is:

1. superproject.<superproject-branch>.local-branch in the submodule's
   config (superproject/.git/modules/<submodule-name>/config).  This
   is where the developer can store local per-superproject-branch
   overrides (e.g. if they wanted to use submodule branch feature-1
   with superproject branch feature-3).
2. submodule.<submodule-name>.local-branch in the superproject's
   config.  This is where the developer can store local
   cross-superproject-branch overrides (e.g. if they wanted to use
   submodule branch master for any superproject branch that didn't
   have a per-superproject-branch override).
3. submodule.<submodule-name>.local-branch in the superproject's
   .gitmodules file.  Because the gitmodules file is stored in the
   superproject's versioned tree, it is automatically
   superproject-branch-specific.  For example:

     $ git cat-file -p feature-1:.gitmodules
     ...
     [submodule "submod"]
         ...
         local-branch = feature-1
     $ git cat-file -p feature-3:.gitmodules
     ...
     [submodule "submod"]
         ...
         local-branch = feature-2

   this is where the project-wide defaults are setup and shared
   between developers.
4. The default local-branch is 'master'.

The new get_local_branch function handles the first step in this
chain.  The next two steps are already covered by the existing
get_submodule_config.
---
 git-submodule.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2677f2e..56fc3f1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -220,6 +220,39 @@ get_submodule_config () {
 	printf '%s' "${value:-$default}"
 }
 
+#
+# Print a submodule's configured local branch name
+#
+# $1 = superproject branch
+# $2 = default (from the superproject's .gitmodules)
+#
+# To be called from the submodule root directory.
+#
+get_local_branch ()
+{
+	superproject_branch="$1"
+	default="${2:-master}"
+	if test -z "${superproject_branch}"
+	then
+		value=""
+	else
+		value=$(git config superproject."$superproject_branch".local-branch)
+	fi
+	printf '%s' "${value:-$default}"
+}
+
+#
+# Print the currently checked out branch of the current repository
+#
+# $1 = default
+#
+get_current_branch ()
+{
+	default="$1"
+	branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) ||
+	branch=""
+	printf '%s' "${branch:-$default}"
+}
 
 #
 # Map submodule path to submodule name
-- 
1.8.5.2.237.g01c62c6
