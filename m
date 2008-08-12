From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [TopGit PATCH/RFC] Do not use mktemp
Date: Tue, 12 Aug 2008 13:14:27 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808121309000.18832@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: pasky@suse.cz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 20:15:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSyPA-0005C6-NJ
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 20:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbYHLSOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 14:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYHLSOe
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 14:14:34 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:37294 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbYHLSOd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 14:14:33 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m7CIESIM014267;
	Tue, 12 Aug 2008 13:14:28 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m7CIES8p019115;
	Tue, 12 Aug 2008 13:14:28 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92124>

Old operating systems may not even have mktemp; less old
operating systems may have a mktemp which is not compatible with
the usual post-1.5 version.  Let's try to do without.

This patch makes us use /tmp/meaningful-prefix.$$ and
$git_dir/prefix.$$ as temporary filenames when they are
needed.  But there are two exceptions:

 - The needs_update function in tg.sh requires more than one
   temporary file, so we imitate mktemp semantics for it

 - A temporary file is used in tg-patch for some hack I do not
   want to put effort into preserving.  I reused the mktemp
   imitation as a band-aid there.

One word of warning: for needs_update there is a 'trap' to
destroy the temporary directory used, but this overrides any
other traps that the caller might have set before.  Luckily, the
only other use of 'trap' is in tg-export, which never calls
needs_update.  But it leaves me uncomfortable.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
	On my computer, mktemp requires its template argument;
	on a computer I often ssh into, there is no mktemp at
	all.  So I would rather that topgit didn't use it.  This
	patch has a number of problems, but I thought I would
	send it out anyway to see what people say.

	The biggest issue is that this slows needs_update down,
	since awk 'srand(); rand()' comes up with the same random
	numbers again and again.  This is because the random
	number generator is seeded with the current time *in
	seconds*.  I hope there is some other way...

	Comments welcome.  Thanks,

	Jonathan

 tg-export.sh |    5 +++--
 tg-info.sh   |    4 +++-
 tg-patch.sh  |    3 ++-
 tg-update.sh |    4 +++-
 tg.sh        |   31 ++++++++++++++++++++++++++++++-
 5 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/tg-export.sh b/tg-export.sh
index 73ad2ef..9a232d3 100644
--- a/tg-export.sh
+++ b/tg-export.sh
@@ -31,8 +31,9 @@ name="$(git symbolic-ref HEAD | sed 's#^refs/heads/##')"
 base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
 	die "not on a TopGit-controlled branch"
 
-
-playground="$(mktemp -d)"
+playground=${TMPDIR:-/tmp}/tg-export-playground.$$
+( umask 077 && mkdir "$playground" ) ||
+	die "cannot make temporary directory: $!"
 trap 'rm -rf "$playground"' EXIT
 
 
diff --git a/tg-info.sh b/tg-info.sh
index 43589f9..c50c9b7 100644
--- a/tg-info.sh
+++ b/tg-info.sh
@@ -41,7 +41,9 @@ branch_contains "$name" "$base_rev" ||
 git cat-file blob "$name:.topdeps" |
 	sed '1{s/^/Depends: /;n}; s/^/         /;'
 
-depcheck="$(mktemp)"
+depcheck=$git_dir/tg-depcheck.$$
+( set -C && umask 077 && : >"$depcheck" ) ||
+	die "cannot make temporary file: $!"
 missing_deps=
 needs_update "$name" >"$depcheck" || :
 if [ -n "$missing_deps" ]; then
diff --git a/tg-patch.sh b/tg-patch.sh
index 04023c0..7517f0f 100644
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -29,7 +29,8 @@ echo
 [ -n "$(git grep '^[-]--' "$name" -- ".topmsg")" ] || echo '---'
 
 # Evil obnoxious hack to work around the lack of git diff --exclude
-git_is_stupid="$(mktemp)"
+git_is_stupid=$(temp_filename "$git_dir/tg-patch-tmp.") ||
+	die "$git_is_stupid"
 git diff-tree --name-only "$base_rev" "$name" |
 	fgrep -vx ".topdeps" |
 	fgrep -vx ".topmsg" >"$git_is_stupid" || : # fgrep likes to fail randomly?
diff --git a/tg-update.sh b/tg-update.sh
index 27a8e81..7125f02 100644
--- a/tg-update.sh
+++ b/tg-update.sh
@@ -21,7 +21,9 @@ base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)"
 
 ## First, take care of our base
 
-depcheck="$(mktemp)"
+depcheck=$git_dir/tg-depcheck.$$
+( set -C && umask 077 && : >"$depcheck" ) ||
+	die "cannot make temporary file: $!"
 missing_deps=
 needs_update "$name" >"$depcheck" || :
 [ -z "$missing_deps" ] || die "some dependencies are missing: $missing_deps"
diff --git a/tg.sh b/tg.sh
index e5766fe..c31256f 100644
--- a/tg.sh
+++ b/tg.sh
@@ -80,6 +80,27 @@ branch_contains()
 	[ -z "$(git rev-list ^"$1" "$2")" ]
 }
 
+# temp_filename PREFIX
+# Prints an error message *to standard output* and exits with
+# nonzero status on failure
+temp_filename()
+{
+	set -C && umask 077
+	prefix=$1
+	i=0
+	suffix=$(awk 'BEGIN { srand(); rand(); print int(rand()*99999) }')
+	while test $i -lt 256
+	do
+		tmp=$prefix$suffix
+		: >"$tmp" && break
+		i=$(($i+1))
+		suffix=$(($suffix+1))
+	done
+	test $i -gt 255 &&
+		die "cannot create temporary file: $!"
+	echo $tmp
+}
+
 # recurse_deps CMD NAME [BRANCHPATH...]
 # Recursively eval CMD on all dependencies of NAME.
 # CMD can refer to $_name for queried branch name,
@@ -90,12 +111,15 @@ branch_contains()
 # of the whole function.
 # If recurse_deps() hits missing dependencies, it will append
 # them to space-separated $missing_deps list and skip them.
+# Uses a $recurse_deps_tmp directory, which should be
+# set in advance
 recurse_deps()
 {
 	_cmd="$1"; shift
 	_name="$1"; # no shift
 	_depchain="$*"
-	_depsfile="$(mktemp)"
+	_depsfile=$(temp_filename "$recurse_deps_tmp/") ||
+		die "$_depsfile"
 	git cat-file blob "$_name:.topdeps" >"$_depsfile"
 	_ret=0
 	while read _dep; do
@@ -156,7 +180,12 @@ branch_needs_update()
 # them to space-separated $missing_deps list and skip them.
 needs_update()
 {
+	recurse_deps_tmp=$git_dir/tg-depcheck-tmpdir.$$
+	( umask 077 && mkdir "$recurse_deps_tmp" ) ||
+		die "cannot make temporary directory: $!"
+	trap 'rm -rf "$recurse_deps_tmp"' EXIT
 	recurse_deps branch_needs_update "$@"
+	rm -rf "$recurse_deps_tmp"
 }
 
 # branch_empty NAME
-- 
1.6.0.rc2.531.g79a96
