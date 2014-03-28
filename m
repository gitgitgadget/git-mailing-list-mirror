From: "W. Trevor King" <wking@tremily.us>
Subject: [RFC] submodule: change submodule.<name>.branch default from master to HEAD
Date: Thu, 27 Mar 2014 20:36:59 -0700
Message-ID: <c66d89d854407469b6fd223213a09e5d60eeec0a.1395977055.git.wking@tremily.us>
References: <20140328030556.GD25485@odin.tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johan Herland <johan@herland.net>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 28 04:39:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTNdu-0006kN-4u
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 04:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757369AbaC1Dji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 23:39:38 -0400
Received: from qmta14.westchester.pa.mail.comcast.net ([76.96.59.212]:60764
	"EHLO qmta14.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757221AbaC1Dji (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Mar 2014 23:39:38 -0400
Received: from omta01.westchester.pa.mail.comcast.net ([76.96.62.11])
	by qmta14.westchester.pa.mail.comcast.net with comcast
	id irUU1n0010EZKEL5Erfdpk; Fri, 28 Mar 2014 03:39:37 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta01.westchester.pa.mail.comcast.net with comcast
	id irfb1n00E152l3L3Mrfcxp; Fri, 28 Mar 2014 03:39:37 +0000
Received: from mjolnir.tremily.us (unknown [192.168.0.140])
	by odin.tremily.us (Postfix) with ESMTPS id 17F7C10DE283;
	Thu, 27 Mar 2014 20:39:35 -0700 (PDT)
Received: (nullmailer pid 11222 invoked by uid 1000);
	Fri, 28 Mar 2014 03:37:15 -0000
X-Mailer: git-send-email 1.9.1.353.gc66d89d
In-Reply-To: <20140328030556.GD25485@odin.tremily.us>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20140121; t=1395977977;
	bh=NYzaRXrZ8XlcB9p2bazHlOE0iiCHTEf619z3AnbuaQE=;
	h=Received:Received:Received:Received:From:To:Subject:Date:
	 Message-Id;
	b=XCsMx9zVTAE+P603lfBFh7UlgXs5UPso0x1/ZTKw0Th09KhGL/PLv+DxICAIVJeMe
	 0rR8Syf+Wr04guEjlJFNuhuAz7biwtEG/YQ7VvwjAvJtKFOrK924GYG6XLui6FsWbH
	 0jCxnlE47AsssmvnmZ8/lniolMVtfppUynGpFq4IHoxWjHX0ly276oy9Yt6HeSqiFO
	 2KsPLQiHxMkNw8yza+co/8KFEdRzfJFeWAt3LcdvVHYn1wvgccJABQFekMoTNb4gi6
	 qpQi/IXIm7deT8KCrN5dHriH2/WWrc9qX8JVqCkMVW5pim0hNmC0urKpApOgqDE1FQ
	 FlYhgDW8Rvyjg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245357>

gitmodule(5) mentioned 'master' as the default remote branch, but
folks using checkout-style updates are unlikely to care which upstream
branch their commit comes from (they only care that the clone fetches
that commit).  If they haven't set submodule.<name>.branch, it makes
more sense to mirror 'git clone' and use the subproject's HEAD than to
default to 'master' (which may not even exist).

After the initial clone, subsequent updates may be local or remote.
Local updates (integrating gitlink changes) have no need to fetch a
specific remote branch, and get along just fine without
submodule.<name>.branch.  Remote updates do need a remote branch, but
HEAD works as well here as it did for the initial clone.

Reported-by: Johan Herland <johan@herland.net>
Signed-off-by: W. Trevor King <wking@tremily.us>
---
This still needs tests, but it gets through the following fine:

  rm -rf superproject subproject &&
  mkdir subproject &&
  (cd subproject &&
   git init &&
   echo 'Subproject' > README &&
   git add README &&
   git commit -m 'Subproject commit' &&
   git branch -m master next
  ) &&
  mkdir superproject &&
  (cd superproject &&
   git init &&
   git submodule add ../subproject submod &&
   git commit -am 'Add submod'
  )
  (cd subproject &&
   echo 'work work work' >> README &&
   git commit -am 'Subproject commit 2'
  ) &&
  (cd superproject &&
   git submodule update --remote &&
   git commit -am 'Add submod'
  )

The main drawback to this approach is that we're changing a default,
but I agree with John's:

On Fri, Mar 28, 2014 at 12:21:23AM +0100, Johan Herland wrote:
> I expect in most cases where "origin/master" happens to be the Right
> Answer, using the submodule's upstream's HEAD will yield the same
> result.

so the default-change may not be particularly intrusive.

Cheers,
Trevor

 Documentation/git-submodule.txt |  2 +-
 Documentation/gitmodules.txt    |  5 +++--
 git-submodule.sh                | 11 ++++++++---
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 46c1eeb..c485a17 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -284,7 +284,7 @@ OPTIONS
 	the superproject's recorded SHA-1 to update the submodule, use the
 	status of the submodule's remote-tracking branch.  The remote used
 	is branch's remote (`branch.<name>.remote`), defaulting to `origin`.
-	The remote branch used defaults to `master`, but the branch name may
+	The remote branch used defaults to `HEAD`, but the branch name may
 	be overridden by setting the `submodule.<name>.branch` option in
 	either `.gitmodules` or `.git/config` (with `.git/config` taking
 	precedence).
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index f539e3f..1aecce9 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -53,8 +53,9 @@ submodule.<name>.update::
 
 submodule.<name>.branch::
 	A remote branch name for tracking updates in the upstream submodule.
-	If the option is not specified, it defaults to 'master'.  See the
-	`--remote` documentation in linkgit:git-submodule[1] for details.
+	If the option is not specified, it defaults to the subproject's
+	HEAD.  See the `--remote` documentation in linkgit:git-submodule[1]
+	for details.
 +
 This branch name is also used for the local branch created by
 non-checkout cloning updates.  See the `update` documentation in
diff --git a/git-submodule.sh b/git-submodule.sh
index 6135cfa..5f08e6c 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -819,8 +819,8 @@ cmd_update()
 		name=$(module_name "$sm_path") || exit
 		url=$(git config submodule."$name".url)
 		config_branch=$(get_submodule_config "$name" branch)
-		branch="${config_branch:-master}"
-		local_branch="$branch"
+		branch="${config_branch:-HEAD}"
+		local_branch="$config_branch"
 		if ! test -z "$update"
 		then
 			update_module=$update
@@ -860,7 +860,12 @@ Maybe you want to use 'update --init'?")"
 
 		if ! test -d "$sm_path"/.git -o -f "$sm_path"/.git
 		then
-			start_point="origin/${branch}"
+			if test -n "$config_branch"
+			then
+				start_point="origin/$branch"
+			else
+				start_point=""
+			fi
 			module_clone "$sm_path" "$name" "$url" "$reference" "$depth" "$start_point" "$local_branch" || exit
 			cloned_modules="$cloned_modules;$name"
 			subsha1=
-- 
1.9.1.352.gd393d14.dirty
