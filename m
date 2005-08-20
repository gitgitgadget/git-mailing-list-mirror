From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Multi-head fetch.
Date: Sat, 20 Aug 2005 11:25:24 -0700
Message-ID: <7vmzncmpnv.fsf@assigned-by-dhcp.cox.net>
References: <7vvf20o4sp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 20 20:25:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6Y29-0003tv-VD
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 20:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbVHTSZ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Aug 2005 14:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932668AbVHTSZ0
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Aug 2005 14:25:26 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:48615 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932667AbVHTSZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2005 14:25:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050820182525.WXPS19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 20 Aug 2005 14:25:25 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Traditionally, fetch takes these forms:

    $ git fetch <remote>
    $ git fetch <remote> <head>
    $ git fetch <remote> tag <tag>

This patch updates it to take

    $ git fetch <remote> <refspec>...

where:

    - A <refspec> of form "<src>:<dst>" is to fetch the objects
      needed for the remote ref that matches <src>, and if <dst>
      is not empty, store it as a local <dst>.

    - "tag" followed by <next> is just an old way of saying
      "refs/tags/<next>:refs/tags/<next>"; this mimics the
      current behaviour of the third form above and means "fetch
      that tag and store it under the same name".

    - A single token <refspec> without colon is a shorthand for
      "<refspec>:"  That is, "fetch that ref but do not store
      anywhere".

    - when there is no <refspec> specified

      - if <remote> is the name of a file under $GIT_DIR/remotes/
	(i.e. a new-style shorthand), then it is the same as giving
	the <refspec>s listed on Pull: line in that file.

      - if <remote> is the name of a file under $GIT_DIR/branches/
	(i.e. an old-style shorthand, without trailing path), then it
	is the same as giving a single <refspec>
	"<remote-name>:refs/heads/<remote>" on the command line, where
	<remote-name> is the remote branch name (defaults to HEAD, but
	can be overridden by .git/branches/<remote> file having the
	URL fragment notation).  That is, "fetch that branch head and
	store it in refs/heads/<remote>".

      - otherwise, it is the same as giving a single <refspec>
        that is "HEAD:".

The SHA1 object names of fetched refs are stored in FETCH_HEAD,
one name per line, with a comment to describe where it came from.
This is later used by "git resolve" and "git octopus".

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-fetch-script |  193 ++++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 149 insertions(+), 44 deletions(-)

d947289005049c67f1dded517a1a6a8843fcf4a3
diff --git a/git-fetch-script b/git-fetch-script
--- a/git-fetch-script
+++ b/git-fetch-script
@@ -1,54 +1,159 @@
 #!/bin/sh
 #
 . git-sh-setup-script || die "Not a git archive"
-. git-parse-remote "$@"
-merge_repo="$_remote_repo"
-merge_head="$_remote_head"
-merge_store="$_remote_store"
-
-TMP_HEAD="$GIT_DIR/TMP_HEAD"
-
-case "$merge_repo" in
-http://* | https://*)
-        if [ -n "$GIT_SSL_NO_VERIFY" ]; then
-            curl_extra_args="-k"
-        fi
-	_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]' &&
-	_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40" &&
-	head=$(curl -nsf $curl_extra_args "$merge_repo/$merge_head") &&
-	expr "$head" : "$_x40\$" >/dev/null || {
-		echo >&2 "Failed to fetch $merge_head from $merge_repo"
-	        exit 1
-	}
-	echo Fetching "$merge_head" using http
-	git-http-pull -v -a "$head" "$merge_repo/" || exit
-	;;
-rsync://*)
-	rsync -L "$merge_repo/$merge_head" "$TMP_HEAD" || exit 1
-	head=$(git-rev-parse TMP_HEAD)
-	rm -f "$TMP_HEAD"
-	rsync -avz --ignore-existing "$merge_repo/objects/" "$GIT_OBJECT_DIRECTORY/"
-	;;
+. git-parse-remote-script
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+
+append=
+case "$#" in
+0)
+	die "Where do you want to fetch from?" ;;
 *)
-	head=$(git-fetch-pack "$merge_repo" "$merge_head")
-	if h=`expr "$head" : '\([^ ][^ ]*\) '`
+	case "$1" in
+	-a|--a|--ap|--app|--appe|--appen|--append)
+		append=t
+		shift ;;
+	esac
+esac
+remote_nick="$1"
+remote=$(get_remote_url "$@")
+refs=
+rref=
+rsync_slurped_objects=
+
+if test "" = "$append"
+then
+	: >$GIT_DIR/FETCH_HEAD
+fi
+
+append_fetch_head () {
+    head_="$1"
+    remote_="$2"
+    remote_name_="$3"
+    remote_nick_="$4"
+    local_name_="$5"
+
+    # 2.6.11-tree tag would not be happy to be fed to resolve.
+    if git-cat-file commit "$head_" >/dev/null 2>&1
+    then
+	head_=$(git-rev-parse --verify "$head_^0") || exit
+	note_="$head_	$remote_name_ from $remote_nick_"
+	echo "$note_" >>$GIT_DIR/FETCH_HEAD
+	echo >&2 "* committish: $note_"
+    else
+	echo >&2 "* non-commit: $note_"
+    fi
+    if test "$local_name_" != ""
+    then
+	# We are storing the head locally.  Make sure that it is
+	# a fast forward (aka "reverse push").
+	fast_forward_local "$local_name_" "$head_" "$remote_" "$remote_name_"
+    fi
+}
+
+fast_forward_local () {
+    case "$1" in
+    refs/tags/*)
+	# Tags need not be pointing at commits so there
+	# is no way to guarantee "fast-forward" anyway.
+	echo "$2" >"$GIT_DIR/$1" ;;
+    refs/heads/*)
+	# NEEDSWORK: use the same cmpxchg protocol here.
+	echo "$2" >"$GIT_DIR/$1.lock"
+	if test -f "$GIT_DIR/$1"
 	then
-	    head=$h
+	    local=$(git-rev-parse --verify "$1^0") &&
+	    mb=$(git-merge-base "$local" "$2") &&
+	    case "$2,$mb" in
+	    $local,*)
+		echo >&2 "* $1: same as $4"
+		echo >&2 "  from $3"
+		;;
+	    *,$local)
+		echo >&2 "* $1: fast forward to $4"
+		echo >&2 "  from $3"
+		;;
+	    *)
+		false
+		;;
+	    esac || {
+		mv "$GIT_DIR/$1.lock" "$GIT_DIR/$1.remote"
+		echo >&2 "* $1: does not fast forward to $4"
+		echo >&2 "  from $3; leaving it in '$1.remote'"
+	    }
+	else
+		echo >&2 "* $1: storing $4"
+		echo >&2 "  from $3."
 	fi
+	test -f "$GIT_DIR/$1.lock" &&
+	    mv "$GIT_DIR/$1.lock" "$GIT_DIR/$1"
 	;;
-esac || exit 1
-
-git-rev-parse --verify "$head" > /dev/null || exit 1
+    esac
+}
 
-case "$merge_store" in
-'')
+for ref in $(get_remote_refs_for_fetch "$@")
+do
+    refs="$refs $ref"
+
+    # These are relative path from $GIT_DIR, typically starting at refs/
+    # but may be HEAD
+    remote_name=$(expr "$ref" : '\([^:]*\):')
+    local_name=$(expr "$ref" : '[^:]*:\(.*\)')
+
+    rref="$rref $remote_name"
+
+    # There are transports that can fetch only one head at a time...
+    case "$remote" in
+    http://* | https://*)
+	if [ -n "$GIT_SSL_NO_VERIFY" ]; then
+	    curl_extra_args="-k"
+	fi
+	head=$(curl -nsf $curl_extra_args "$remote/$remote_name") &&
+	expr "$head" : "$_x40\$" >/dev/null ||
+	    die "Failed to fetch $remote_name from $remote"
+	echo Fetching "$remote_name from $remote" using http
+	git-http-pull -v -a "$head" "$remote/" || exit
 	;;
+    rsync://*)
+	TMP_HEAD="$GIT_DIR/TMP_HEAD"
+	rsync -L "$remote/$remote_name" "$TMP_HEAD" || exit 1
+	head=$(git-rev-parse TMP_HEAD)
+	rm -f "$TMP_HEAD"
+	test "$rsync_slurped_objects" || {
+	    rsync -avz --ignore-existing "$remote/objects/" \
+		"$GIT_OBJECT_DIRECTORY/" || exit
+	    rsync_slurped_objects=t
+	}
+	;;
+    *)
+	# We will do git native transport with just one call later.
+	continue ;;
+    esac
+
+    append_fetch_head "$head" "$remote" "$remote_name" "$remote_nick" "$local_name"
+
+done
+
+case "$remote" in
+http://* | https://* | rsync://* )
+    ;; # we are already done.
 *)
-	echo "$head" > "$GIT_DIR/$merge_store"
-esac &&
-
-# FETCH_HEAD is fed to git-resolve-script which will eventually be
-# passed to git-commit-tree as one of the parents.  Make sure we do
-# not give a tag object ID.
-
-git-rev-parse "$head^0" >"$GIT_DIR/FETCH_HEAD"
+    git-fetch-pack "$remote" $rref |
+    while read sha1 remote_name
+    do
+	found=
+	for ref in $refs
+	do
+	    case "$ref" in
+	    $remote_name:*)
+		found="$ref"
+		break ;;
+	    esac
+	done
+
+	local_name=$(expr "$found" : '[^:]*:\(.*\)')
+        append_fetch_head "$sha1" "$remote" "$remote_name" "$remote_nick" "$local_name"
+    done
+    ;;
+esac
