From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [TopGit PATCH] supply template argument to mktemp
Date: Tue, 12 Aug 2008 19:17:22 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808121911340.1112@harper.uchicago.edu>
References: <Pine.GSO.4.62.0808121309000.18832@harper.uchicago.edu>
 <20080812204433.GM10151@machine.or.cz> <Pine.GSO.4.62.0808121557290.24244@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 13 02:18:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT44P-0001CX-Hw
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 02:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbYHMARY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 20:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752165AbYHMARY
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 20:17:24 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:38700 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbYHMARY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 20:17:24 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7D0HMHv004583
	for <git@vger.kernel.org>; Tue, 12 Aug 2008 19:17:22 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7D0HMNG001324;
	Tue, 12 Aug 2008 19:17:22 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0808121557290.24244@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92158>

mktemp versions before 1.5 did not allow omitting the template
(prefix.XXXXXX) argument.  Thus on Mac OS X,

	$ mktemp -d
	usage: mktemp [-d] [-q] [-t prefix] [-u] template ...
	       mktemp [-d] [-q] [-u] -t prefix

So supply a filename template.  To maintain the intended
behavior, we have to add -t, too.  It was implied before.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
	Jonathan Nieder wrote:

	> So thinking it through, perhaps we should do the following:
	>  - provide a simple mini-mktemp for users to install themselves
	>    on old systems
	>  - always provide the template argument to mktemp

	Here's the second part.  With this change, plus a sed
	portability fix I will send separately, topgit on Mac OS X
	works.  Thanks for the help.

 tg-export.sh |    2 +-
 tg-info.sh   |    2 +-
 tg-patch.sh  |    2 +-
 tg-update.sh |    2 +-
 tg.sh        |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tg-export.sh b/tg-export.sh
index 62361dd..62ea4f9 100644
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -32,7 +32,7 @@ base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)"
 	die "not on a TopGit-controlled branch"
 
 
-playground="$(mktemp -d)"
+playground="$(mktemp -d -t tg-export.XXXXXX)"
 trap 'rm -rf "$playground"' EXIT
 
 
diff --git a/tg-info.sh b/tg-info.sh
index 43589f9..f2b6365 100644
--- a/tg-info.sh
+++ b/tg-info.sh
@@ -41,7 +41,7 @@ branch_contains "$name" "$base_rev" ||
 git cat-file blob "$name:.topdeps" |
 	sed '1{s/^/Depends: /;n}; s/^/         /;'
 
-depcheck="$(mktemp)"
+depcheck="$(mktemp -t tg-depcheck.XXXXXX)"
 missing_deps=
 needs_update "$name" >"$depcheck" || :
 if [ -n "$missing_deps" ]; then
diff --git a/tg-patch.sh b/tg-patch.sh
index 04023c0..48f4d77 100644
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -29,7 +29,7 @@ echo
 [ -n "$(git grep '^[-]--' "$name" -- ".topmsg")" ] || echo '---'
 
 # Evil obnoxious hack to work around the lack of git diff --exclude
-git_is_stupid="$(mktemp)"
+git_is_stupid="$(mktemp -t tg-patch-changes.XXXXXX)"
 git diff-tree --name-only "$base_rev" "$name" |
 	fgrep -vx ".topdeps" |
 	fgrep -vx ".topmsg" >"$git_is_stupid" || : # fgrep likes to fail randomly?
diff --git a/tg-update.sh b/tg-update.sh
index 27a8e81..50b29b4 100644
--- a/tg-update.sh
+++ b/tg-update.sh
@@ -21,7 +21,7 @@ base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)"
 
 ## First, take care of our base
 
-depcheck="$(mktemp)"
+depcheck="$(mktemp -t tg-depcheck.XXXXXX)"
 missing_deps=
 needs_update "$name" >"$depcheck" || :
 [ -z "$missing_deps" ] || die "some dependencies are missing: $missing_deps"
diff --git a/tg.sh b/tg.sh
index e5766fe..1bc886a 100644
--- a/tg.sh
+++ b/tg.sh
@@ -95,7 +95,7 @@ recurse_deps()
 	_cmd="$1"; shift
 	_name="$1"; # no shift
 	_depchain="$*"
-	_depsfile="$(mktemp)"
+	_depsfile="$(mktemp -t tg-depsfile.XXXXXX)"
 	git cat-file blob "$_name:.topdeps" >"$_depsfile"
 	_ret=0
 	while read _dep; do
-- 
tg: (f27e693..) t/topgit/mktemp-template (depends on: )
