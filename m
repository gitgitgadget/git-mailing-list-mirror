From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] Multi-head fetch.
Date: Thu, 18 Aug 2005 00:39:30 -0700
Message-ID: <11243507702006-git-send-email-junkio@cox.net>
References: <7vek8rlnbn.fsf@assigned-by-dhcp.cox.net>
Reply-To: Junio C Hamano <junkio@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Aug 18 09:43:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5ezy-0006DM-Un
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 09:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVHRHjc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 03:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVHRHjb
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 03:39:31 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:47281 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932121AbVHRHjb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 03:39:31 -0400
Received: from siamese ([68.4.9.127]) by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with SMTP
          id <20050818073931.VGJT25443.fed1rmmtao07.cox.net@siamese>;
          Thu, 18 Aug 2005 03:39:31 -0400
In-Reply-To: <7vek8rlnbn.fsf@assigned-by-dhcp.cox.net>
X-Mailer: git-send-email-script
To: GIT mailing list <git@vger.kernel.org>
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
one name per line.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-fetch-script |  154 ++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 108 insertions(+), 46 deletions(-)

7dbfeb149dfc049015f27f15dd9135fd15d5f99f
diff --git a/git-fetch-script b/git-fetch-script
--- a/git-fetch-script
+++ b/git-fetch-script
@@ -1,54 +1,116 @@
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
-*)
-	head=$(git-fetch-pack "$merge_repo" "$merge_head")
-	if h=`expr "$head" : '\([^ ][^ ]*\) '`
+. git-parse-remote-script
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+
+remote_nick="$1"
+remote=$(get_remote_url "$@")
+refs=
+rref=
+prev_was_literal_tag=
+rsync_slurped_objects=
+: >$GIT_DIR/FETCH_HEAD
+
+fast_forward_local () {
+
+	# NEEDSWORK: probably use the same cmpxchg protocol here...
+	echo "$2" >"$GIT_DIR/$1.lock"
+	if test -f "$GIT_DIR/$1"
 	then
-	    head=$h
+		local=$(git-rev-parse --verify "$1^0") &&
+		mb=$(git-merge-base "$local" "$2") &&
+		test "$mb" = "$local" || {
+			rm -f "$GIT_DIR/$1.lock"
+			die "$1 does not fast forward to $4 from $3.";
+		}
 	fi
-	;;
-esac || exit 1
-
-git-rev-parse --verify "$head" > /dev/null || exit 1
+	mv "$GIT_DIR/$1.lock" "$GIT_DIR/$1"
+}
 
-case "$merge_store" in
-'')
-	;;
-*)
-	echo "$head" > "$GIT_DIR/$merge_store"
-esac &&
+for ref in $(get_remote_refs_for_fetch "$@")
+do
+	if test "$prev_was_literal_tag"
+	then
+		ref="refs/tags/${ref}:refs/tags/${ref}"
+		prev_was_literal_tag=
+	else
+		case "$ref" in
+		tag)
+			prev_was_literal_tag=yes
+			continue
+			;;
+		esac
+	fi
 
-# FETCH_HEAD is fed to git-resolve-script which will eventually be
-# passed to git-commit-tree as one of the parents.  Make sure we do
-# not give a tag object ID.
+	refs="$refs $ref"
 
-git-rev-parse "$head^0" >"$GIT_DIR/FETCH_HEAD"
+	# These are relative path from $GIT_DIR, typically starting at refs/
+	# but may be HEAD
+	remote_name=$(expr "$ref" : '\([^:]*\):')
+	local_name=$(expr "$ref" : '[^:]*:\(.*\)')
+
+	rref="$rref $remote_name"
+
+	# There are transports that can fetch only one head at a time...
+	case "$remote" in
+	http://* | https://*)
+		if [ -n "$GIT_SSL_NO_VERIFY" ]; then
+		    curl_extra_args="-k"
+		fi
+		head=$(curl -nsf $curl_extra_args "$remote/$remote_name") &&
+		expr "$head" : "$_x40\$" >/dev/null ||
+			die "Failed to fetch $remote_name from $remote"
+		echo Fetching "$remote_name from $remote" using http
+		git-http-pull -v -a "$head" "$remote/" || exit
+		;;
+	rsync://*)
+		TMP_HEAD="$GIT_DIR/TMP_HEAD"
+		rsync -L "$remote/$remote_name" "$TMP_HEAD" || exit 1
+		head=$(git-rev-parse TMP_HEAD)
+		rm -f "$TMP_HEAD"
+		test "$rsync_slurped_objects" || {
+			rsync -avz --ignore-existing "$remote/objects/" \
+				"$GIT_OBJECT_DIRECTORY/" || exit
+			rsync_slurped_objects=t
+		}
+		;;
+	*)
+		# We will do git native transport at one go.
+		continue ;;
+	esac
+	head=$(git-rev-parse --verify "$head^0") || exit
+	echo "$head	$remote_name from $remote_nick" >>$GIT_DIR/FETCH_HEAD
+	case "$local_name" in '') continue ;; esac
+
+	# We are storing the head locally.  Make sure that it is
+	# a fast forward (aka "reverse push").
+	fast_forward_local "$local_name" "$head" "$remote" "$remote_name"
+
+done
+
+case "$remote" in
+http://* | https://* | rsync://* )
+	;; # we are already done.
+*)
+	git-fetch-pack "$remote" $rref |
+	while read sha1 remote_name
+	do
+		found=
+		for ref in $refs
+		do
+			case "$ref" in
+			$remote_name:*)
+				found="$ref"
+				break ;;
+			esac
+		done
+		head=$(git-rev-parse --verify "$sha1^0") || exit
+		echo "$head	$remote_name from $remote_nick" >>$GIT_DIR/FETCH_HEAD
+		case "$found" in '' | *:) continue ;; esac
+		local=$(expr "$found" : '[^:]*:\(.*\)')
+		fast_forward_local "$local" "$sha1" "$remote" "$remote_name"
+	done
+	;;
+esac
