From: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
Subject: [TopGit PATCH] tg-create.sh: Introduce --add option to add a
 dependency.
Date: Wed, 13 Aug 2008 16:25:14 +0200
Organization: lilypond-design.org
Message-ID: <1218637514.7561.30.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jan Holesovsky <kendy@suse.cz>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 13 16:26:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTHIt-0007vP-At
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 16:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbYHMOZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 10:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbYHMOZS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 10:25:18 -0400
Received: from edu-smtp-02.edutel.nl ([88.159.1.222]:45073 "EHLO
	edu-smtp-02.edutel.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbYHMOZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 10:25:16 -0400
Received: from heerbeest (unknown [88.159.206.46])
	by edu-smtp-02.edutel.nl (Postfix) with ESMTP id 7489911E6D5;
	Wed, 13 Aug 2008 16:25:15 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by heerbeest (Postfix) with ESMTP id D5B33DC07F;
	Wed, 13 Aug 2008 16:25:14 +0200 (CEST)
X-Mailer: Evolution 2.23.6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92219>

This implements 

    tg create --add DEP

to add dependency DEP to an already existing topgit branch.

The bad thing is that this does not play well with tg undepend;
it won't work to re-add a previously removed dependency.  This
--add is implemented as a merge, and all merge commits are
already present; it is only that lateron they are reverted.

Any ideas on how to fix that?

Signed-off-by: Jan Nieuwenhuizen <janneke@gnu.org>
---
 README       |    6 +++++-
 tg-create.sh |   44 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/README b/README
index 096b9ec..a9957f2 100644
--- a/README
+++ b/README
@@ -215,6 +215,9 @@ tg create
 	it will detect that you are on a topic branch base ref and
 	resume the topic branch creation operation.
 
+	With the --add option, all given arguments are added as
+	dependencies to current topic branch.
+
 tg delete
 ~~~~~~~~~
 	Remove a TopGit-controlled topic branch of given name
@@ -333,7 +336,8 @@ tg export
 tg undepend
 ~~~~~~~~~~~
 	Update the current topic branch by removing the given
-	branch (required argument) from the list of dependencies.
+	branch (required argument) from the list of dependencies
+	and reverting all its commits.
 
 tg update
 ~~~~~~~~~
diff --git a/tg-create.sh b/tg-create.sh
index 939af33..c5bc5fb 100644
--- a/tg-create.sh
+++ b/tg-create.sh
@@ -3,9 +3,11 @@
 # (c) Petr Baudis <pasky@suse.cz>  2008
 # GPLv2
 
+add= # Set to 1 when adding dependencies to existing topgit branch
 deps= # List of dependent branches
 restarted= # Set to 1 if we are picking up in the middle of base setup
 merge= # List of branches to be merged; subset of $deps
+merged= # List branches actually merged
 name=
 
 
@@ -14,8 +16,12 @@ name=
 while [ -n "$1" ]; do
 	arg="$1"; shift
 	case "$arg" in
+	--add)
+		add=1
+		name=$(git symbolic-ref HEAD | cut -b 12-)
+		;;
 	-*)
-		echo "Usage: tg create NAME [DEPS...]" >&2
+		echo "Usage: tg create --add|NAME [DEPENDENCY]..." >&2
 		exit 1;;
 	*)
 		if [ -z "$name" ]; then
@@ -50,12 +56,22 @@ fi
 
 [ -n "$merge" -o -n "$restarted" ] || merge="$deps "
 
+if [ -z "$add" ]; then
+	! git rev-parse --verify "$name" >/dev/null 2>&1 \
+		|| die "branch '$name' already exists"
+else
+	dupes=$(grep -E "^${merge// /|}/\$" .topdeps | tr '\n' ' ')
+	[ -z "$dupes" ] || die "already depend on: $dupes"
+	deps=$(echo "$merge" | cat .topdeps - | tr '\n' ' ' | sed -e 's/ \+$//')
+	merged="$merge"
+	merge="$name $merge"
+fi
+
+
 for d in $deps; do
 	git rev-parse --verify "$d" >/dev/null 2>&1 ||
 		die "unknown branch dependency '$d'"
 done
-! git rev-parse --verify "$name" >/dev/null 2>&1 ||
-	die "branch '$name' already exists"
 
 # Clean up any stale stuff
 rm -f "$git_dir/top-name" "$git_dir/top-deps" "$git_dir/top-merge"
@@ -96,7 +112,13 @@ done
 
 ## Set up the topic branch
 
-git update-ref "refs/top-bases/$name" "HEAD" ""
+if [ -z "$add" ]; then
+	git update-ref "refs/top-bases/$name" "HEAD" ""
+else
+	#[ -n "$add" ] && git -D "$name"
+	git branch -D save/"$name" || :
+	git branch -m "$name" save/$name
+fi
 git checkout -b "$name"
 
 echo "$deps" | sed 's/ /\n/g' >"$root_dir/.topdeps"
@@ -104,7 +126,7 @@ git add "$root_dir/.topdeps"
 
 author="$(git var GIT_AUTHOR_IDENT)"
 author_addr="${author%> *}>"
-{
+[ -z "$add" ] && {
 	echo "From: $author_addr"
 	! header="$(git config topgit.to)" || echo "To: $header"
 	! header="$(git config topgit.cc)" || echo "Cc: $header"
@@ -120,7 +142,13 @@ EOT
 } >"$root_dir/.topmsg"
 git add "$root_dir/.topmsg"
 
+if [ -z "$add" ]; then
+	info "Topic branch $name set up. Please fill .topmsg now and make initial commit."
+	info "To abort: git rm -f .top* && git checkout ${deps%% *} && tg delete $name"
+else
+	git commit -am "Add dependency: $merged"
+fi
 
-
-info "Topic branch $name set up. Please fill .topmsg now and make initial commit."
-info "To abort: git rm -f .top* && git checkout ${deps%% *} && tg delete $name"
+# Local Variables:
+# sh-basic-offset:8
+# End:
-- 
1.6.0.rc0.44.g67270


-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
