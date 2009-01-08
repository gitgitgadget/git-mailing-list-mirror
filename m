From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [PATCH (topgit)] tg-patch: add support for generating patches
	against worktree and index
Date: Fri, 9 Jan 2009 00:11:49 +0300
Organization: St.Petersburg State University
Message-ID: <20090108211149.GA19983@roro3>
References: <1231438975-13624-1-git-send-email-kirr@landau.phys.spbu.ru> <20090108195356.GA14644@lapse.rw.madduck.net> <20090108201614.GA4185@roro3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Jan 08 22:23:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL2Ab-0007aG-Iy
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 22:12:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757619AbZAHVKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 16:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757514AbZAHVKg
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 16:10:36 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:4525 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162AbZAHVKf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 16:10:35 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id CE5A317B65E; Fri,  9 Jan 2009 00:10:33 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3>)
	id 1LL2AP-0006Mw-Gr; Fri, 09 Jan 2009 00:11:49 +0300
Content-Disposition: inline
In-Reply-To: <20090108201614.GA4185@roro3>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104963>

I'm sorry, but I've found a mistake in my code for case:

diff --git a/tg-patch.sh b/tg-patch.sh
index db1ad09..d701c54 100644
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -17,8 +17,8 @@ while [ -n "$1" ]; do
        case "$arg" in
        -i)
                topic='(i)'
-               diff_opts="$diff_opts --cached";;
-               diff_committed_only=;
+               diff_opts="$diff_opts --cached";
+               diff_committed_only=;;
        -w)
                topic='(w)'
                diff_committed_only=;;


So here is corrected patch:


From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
To: Petr Baudis <pasky@suse.cz>
Cc: martin f krafft <madduck@madduck.net>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: [PATCH (topgit)] tg-patch: add support for generating patches against worktree and index

This implements `tg patch -i` and `tg patch -w` to see current patch as
generated against not-yet-committed index and worktree.


NOTE: unfortunately `git cat-file blob <file>` does not provide an option
to cat file from worktree (only from an object or from index), so I had to
unroll my own `cat file topic:file` with special support for '(i)' and
'(w)' topics.

Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>

---
 README                     |    5 +++--
 contrib/tg-completion.bash |    6 ++++++
 tg-patch.sh                |   31 +++++++++++++++++++++++++------
 tg.sh                      |   21 +++++++++++++++++++++
 4 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/README b/README
index 1d38365..5796112 100644
--- a/README
+++ b/README
@@ -284,8 +284,9 @@ tg patch
 	tg patch will be able to automatically send the patches by mail
 	or save them to files. (TODO)
 
-	TODO: tg patch -i to base at index instead of branch,
-		-w for working tree
+	Options:
+	  -i		base patch generation on index instead of branch
+	  -w		base patch generation on working tree instead of branch
 
 tg mail
 ~~~~~~~
diff --git a/contrib/tg-completion.bash b/contrib/tg-completion.bash
index 9641d04..de8a7b5 100755
--- a/contrib/tg-completion.bash
+++ b/contrib/tg-completion.bash
@@ -359,6 +359,12 @@ _tg_patch ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 
 	case "$cur" in
+	-*)
+		__tgcomp "
+			-i
+			-w
+		"
+		;;
 	*)
 		__tgcomp "$(__tg_topics)"
 	esac
diff --git a/tg-patch.sh b/tg-patch.sh
index dc699d2..d701c54 100644
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -5,14 +5,25 @@
 
 name=
 
+topic=
+diff_opts=
+diff_committed_only=yes	# will be unset for index/worktree
+
 
 ## Parse options
 
 while [ -n "$1" ]; do
 	arg="$1"; shift
 	case "$arg" in
+	-i)
+		topic='(i)'
+		diff_opts="$diff_opts --cached";
+		diff_committed_only=;;
+	-w)
+		topic='(w)'
+		diff_committed_only=;;
 	-*)
-		echo "Usage: tg [...] patch [NAME]" >&2
+		echo "Usage: tg [...] patch [-i | -w] [NAME]" >&2
 		exit 1;;
 	*)
 		[ -z "$name" ] || die "name already specified ($name)"
@@ -20,31 +31,39 @@ while [ -n "$1" ]; do
 	esac
 done
 
+
+[ -n "$name"  -a  -z "$diff_committed_only" ]  &&
+	die "-i/-w are mutually exclusive with NAME"
+
 [ -n "$name" ] || name="$(git symbolic-ref HEAD | sed 's#^refs/\(heads\|top-bases\)/##')"
 base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)" ||
 	die "not a TopGit-controlled branch"
 
+# if not index/worktree, topic is current branch
+[ -z "$topic" ] && topic="$name"
+
+
 
 setup_pager
 
-git cat-file blob "$name:.topmsg"
+cat_file "$topic:.topmsg"
 echo
-[ -n "$(git grep '^[-]--' "$name" -- ".topmsg")" ] || echo '---'
+[ -n "$(git grep $diff_opts '^[-]--' ${diff_committed_only:+"$name"} -- ".topmsg")" ] || echo '---'
 
 # Evil obnoxious hack to work around the lack of git diff --exclude
 git_is_stupid="$(mktemp -t tg-patch-changes.XXXXXX)"
-git diff-tree --name-only "$base_rev" "$name" |
+git diff --name-only $diff_opts "$base_rev" ${diff_committed_only:+"$name"} -- |
 	fgrep -vx ".topdeps" |
 	fgrep -vx ".topmsg" >"$git_is_stupid" || : # fgrep likes to fail randomly?
 if [ -s "$git_is_stupid" ]; then
-	cat "$git_is_stupid" | xargs git diff --patch-with-stat "$base_rev" "$name" --
+	cat "$git_is_stupid" | xargs git diff --patch-with-stat $diff_opts "$base_rev" ${diff_committed_only:+"$name"} --
 else
 	echo "No changes."
 fi
 rm "$git_is_stupid"
 
 echo '-- '
-echo "tg: ($base_rev..) $name (depends on: $(git cat-file blob "$name:.topdeps" | paste -s -d' '))"
+echo "tg: ($base_rev..) $name (depends on: $(cat_file "$topic:.topdeps" | paste -s -d' '))"
 branch_contains "$name" "$base_rev" ||
 	echo "tg: The patch is out-of-date wrt. the base! Run \`$tg update\`."
 
diff --git a/tg.sh b/tg.sh
index b64fc3a..1762f03 100644
--- a/tg.sh
+++ b/tg.sh
@@ -17,6 +17,27 @@ die()
 	exit 1
 }
 
+# cat_file "topic:file"
+# Like `git cat-file blob $1`, but topics '(i)' and '(w)' means index and worktree
+cat_file()
+{
+	arg="$1"
+	case "$arg" in
+	'(w):'*)
+		arg=$(echo "$arg" | tail --bytes=+5)
+		cat "$arg"
+		return
+		;;
+	'(i):'*)
+		# ':file' means cat from index
+		arg=$(echo "$arg" | tail --bytes=+5)
+		git cat-file blob ":$arg"
+		;;
+	*)
+		git cat-file blob "$arg"
+	esac
+}
+
 # setup_hook NAME
 setup_hook()
 {
-- 
tg: (a3a5be1..) t/tg-patch-worktree (depends on: t/tg-patch-setup-pager)
