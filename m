From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-fetch: auto-following tags.
Date: Sat, 07 Jan 2006 02:34:56 -0800
Message-ID: <7v3bk0l41b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 07 11:35:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvBPY-0005xe-JJ
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 11:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030403AbWAGKe6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 05:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWAGKe6
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 05:34:58 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:49536 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030403AbWAGKe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jan 2006 05:34:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107103311.UYIF17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 Jan 2006 05:33:11 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14256>

I added things to ls-remote so that Cogito can auto-follow tags
easily and correctly a while ago, but git-fetch did not use the
facility.  Recently added git-describe command relies on
repository keeping up-to-date set of tags, which made it much
more attractive to automatically follow tags, so we do that as
well.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 * This is not 1.0.X material rather for 1.1.0

 Documentation/fetch-options.txt |   18 ++
 git-fetch.sh                    |  283 ++++++++++++++++++++++-----------------
 2 files changed, 173 insertions(+), 128 deletions(-)

6f3ccd3bdb2e2b2187c93bfa0c6f957b44a2e206
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 200c9b2..1fe8423 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -10,15 +10,23 @@
 	fetches is a descendant of `<lbranch>`.  This option
 	overrides that check.
 
+\--no-tags::
+	By default, `git-fetch` fetches tags that point at
+	objects that are downloaded from the remote repository
+	and stores them locally.  This option disables this
+	automatic tag following.
+
 -t, \--tags::
-	By default, the git core utilities will not fetch and store
-	tags under the same name as the remote repository;  ask it
-	to do so using `--tags`.  Using this option will bound the
-	list of objects pulled to the remote tags.  Commits in branches
-	beyond the tags will be ignored.
+	Most of the tags are fetched automatically as branch
+	heads are downloaded, but tags that do not point at
+	objects reachable from the branch heads that are being
+	tracked will not be fetched by this mechanism.  This
+	flag lets all tags and their associated objects be
+	downloaded.
 
 -u, \--update-head-ok::
 	By default `git-fetch` refuses to update the head which
 	corresponds to the current branch.  This flag disables the
 	check.  Note that fetching into the current branch will not
 	update the index and working directory, so use it with care.
+
diff --git a/git-fetch.sh b/git-fetch.sh
index b46b3e5..73e57bd 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -11,6 +11,7 @@ LF='
 '
 IFS="$LF"
 
+no_tags=
 tags=
 append=
 force=
@@ -28,6 +29,9 @@ do
 	-t|--t|--ta|--tag|--tags)
 		tags=t
 		;;
+	-n|--n|--no|--no-|--no-t|--no-ta|--no-tag|--no-tags)
+		no_tags=t
+		;;
 	-u|--u|--up|--upd|--upda|--updat|--update|--update-|--update-h|\
 	--update-he|--update-hea|--update-head|--update-head-|\
 	--update-head-o|--update-head-ok)
@@ -212,133 +216,166 @@ then
 	fi
 fi
 
-for ref in $reflist
-do
-    refs="$refs$LF$ref"
-
-    # These are relative path from $GIT_DIR, typically starting at refs/
-    # but may be HEAD
-    if expr "$ref" : '\.' >/dev/null
-    then
-	not_for_merge=t
-	ref=$(expr "$ref" : '\.\(.*\)')
-    else
-	not_for_merge=
-    fi
-    if expr "$ref" : '\+' >/dev/null
-    then
-	single_force=t
-	ref=$(expr "$ref" : '\+\(.*\)')
-    else
-	single_force=
-    fi
-    remote_name=$(expr "$ref" : '\([^:]*\):')
-    local_name=$(expr "$ref" : '[^:]*:\(.*\)')
-
-    rref="$rref$LF$remote_name"
-
-    # There are transports that can fetch only one head at a time...
-    case "$remote" in
-    http://* | https://*)
-	if [ -n "$GIT_SSL_NO_VERIFY" ]; then
-	    curl_extra_args="-k"
-	fi
-	remote_name_quoted=$(perl -e '
-	    my $u = $ARGV[0];
-	    $u =~ s{([^-a-zA-Z0-9/.])}{sprintf"%%%02x",ord($1)}eg;
-	    print "$u";
-	' "$remote_name")
-	head=$(curl -nsfL $curl_extra_args "$remote/$remote_name_quoted") &&
-	expr "$head" : "$_x40\$" >/dev/null ||
-		die "Failed to fetch $remote_name from $remote"
-	echo >&2 Fetching "$remote_name from $remote" using http
-	git-http-fetch -v -a "$head" "$remote/" || exit
-	;;
-    rsync://*)
-	TMP_HEAD="$GIT_DIR/TMP_HEAD"
-	rsync -L -q "$remote/$remote_name" "$TMP_HEAD" || exit 1
-	head=$(git-rev-parse --verify TMP_HEAD)
-	rm -f "$TMP_HEAD"
-	test "$rsync_slurped_objects" || {
-	    rsync -av --ignore-existing --exclude info \
-		"$remote/objects/" "$GIT_OBJECT_DIRECTORY/" || exit
-
-	    # Look at objects/info/alternates for rsync -- http will
-	    # support it natively and git native ones will do it on the remote
-	    # end.  Not having that file is not a crime.
-	    rsync -q "$remote/objects/info/alternates" \
-		"$GIT_DIR/TMP_ALT" 2>/dev/null ||
-		rm -f "$GIT_DIR/TMP_ALT"
-	    if test -f "$GIT_DIR/TMP_ALT"
-	    then
-		resolve_alternates "$remote" <"$GIT_DIR/TMP_ALT" |
-		while read alt
-		do
-		    case "$alt" in 'bad alternate: '*) die "$alt";; esac
-		    echo >&2 "Getting alternate: $alt"
-		    rsync -av --ignore-existing --exclude info \
-		    "$alt" "$GIT_OBJECT_DIRECTORY/" || exit
-		done
-		rm -f "$GIT_DIR/TMP_ALT"
-	    fi
-	    rsync_slurped_objects=t
-	}
-	;;
-    *)
-	# We will do git native transport with just one call later.
-	continue ;;
-    esac
+fetch_main () {
+  reflist="$1"
+  refs=
+
+  for ref in $reflist
+  do
+      refs="$refs$LF$ref"
+
+      # These are relative path from $GIT_DIR, typically starting at refs/
+      # but may be HEAD
+      if expr "$ref" : '\.' >/dev/null
+      then
+	  not_for_merge=t
+	  ref=$(expr "$ref" : '\.\(.*\)')
+      else
+	  not_for_merge=
+      fi
+      if expr "$ref" : '\+' >/dev/null
+      then
+	  single_force=t
+	  ref=$(expr "$ref" : '\+\(.*\)')
+      else
+	  single_force=
+      fi
+      remote_name=$(expr "$ref" : '\([^:]*\):')
+      local_name=$(expr "$ref" : '[^:]*:\(.*\)')
+
+      rref="$rref$LF$remote_name"
+
+      # There are transports that can fetch only one head at a time...
+      case "$remote" in
+      http://* | https://*)
+	  if [ -n "$GIT_SSL_NO_VERIFY" ]; then
+	      curl_extra_args="-k"
+	  fi
+	  remote_name_quoted=$(perl -e '
+	      my $u = $ARGV[0];
+	      $u =~ s{([^-a-zA-Z0-9/.])}{sprintf"%%%02x",ord($1)}eg;
+	      print "$u";
+	  ' "$remote_name")
+	  head=$(curl -nsfL $curl_extra_args "$remote/$remote_name_quoted") &&
+	  expr "$head" : "$_x40\$" >/dev/null ||
+		  die "Failed to fetch $remote_name from $remote"
+	  echo >&2 Fetching "$remote_name from $remote" using http
+	  git-http-fetch -v -a "$head" "$remote/" || exit
+	  ;;
+      rsync://*)
+	  TMP_HEAD="$GIT_DIR/TMP_HEAD"
+	  rsync -L -q "$remote/$remote_name" "$TMP_HEAD" || exit 1
+	  head=$(git-rev-parse --verify TMP_HEAD)
+	  rm -f "$TMP_HEAD"
+	  test "$rsync_slurped_objects" || {
+	      rsync -av --ignore-existing --exclude info \
+		  "$remote/objects/" "$GIT_OBJECT_DIRECTORY/" || exit
+
+	      # Look at objects/info/alternates for rsync -- http will
+	      # support it natively and git native ones will do it on
+	      # the remote end.  Not having that file is not a crime.
+	      rsync -q "$remote/objects/info/alternates" \
+		  "$GIT_DIR/TMP_ALT" 2>/dev/null ||
+		  rm -f "$GIT_DIR/TMP_ALT"
+	      if test -f "$GIT_DIR/TMP_ALT"
+	      then
+		  resolve_alternates "$remote" <"$GIT_DIR/TMP_ALT" |
+		  while read alt
+		  do
+		      case "$alt" in 'bad alternate: '*) die "$alt";; esac
+		      echo >&2 "Getting alternate: $alt"
+		      rsync -av --ignore-existing --exclude info \
+		      "$alt" "$GIT_OBJECT_DIRECTORY/" || exit
+		  done
+		  rm -f "$GIT_DIR/TMP_ALT"
+	      fi
+	      rsync_slurped_objects=t
+	  }
+	  ;;
+      *)
+	  # We will do git native transport with just one call later.
+	  continue ;;
+      esac
+
+      append_fetch_head "$head" "$remote" \
+	  "$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
+
+  done
+
+  case "$remote" in
+  http://* | https://* | rsync://* )
+      ;; # we are already done.
+  *)
+    ( : subshell because we muck with IFS
+      IFS=" 	$LF"
+      (
+	  git-fetch-pack "$remote" $rref || echo failed "$remote"
+      ) |
+      while read sha1 remote_name
+      do
+	  case "$sha1" in
+	  failed)
+		  echo >&2 "Fetch failure: $remote"
+		  exit 1 ;;
+	  esac
+	  found=
+	  single_force=
+	  for ref in $refs
+	  do
+	      case "$ref" in
+	      +$remote_name:*)
+		  single_force=t
+		  not_for_merge=
+		  found="$ref"
+		  break ;;
+	      .+$remote_name:*)
+		  single_force=t
+		  not_for_merge=t
+		  found="$ref"
+		  break ;;
+	      .$remote_name:*)
+		  not_for_merge=t
+		  found="$ref"
+		  break ;;
+	      $remote_name:*)
+		  not_for_merge=
+		  found="$ref"
+		  break ;;
+	      esac
+	  done
+	  local_name=$(expr "$found" : '[^:]*:\(.*\)')
+	  append_fetch_head "$sha1" "$remote" \
+		  "$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
+      done
+    ) || exit ;;
+  esac
 
-    append_fetch_head "$head" "$remote" \
-    	"$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
+}
 
-done
+fetch_main "$reflist"
 
-case "$remote" in
-http://* | https://* | rsync://* )
-    ;; # we are already done.
-*)
-    IFS=" 	$LF"
-    (
-	git-fetch-pack "$remote" $rref || echo failed "$remote"
-    ) |
-    while read sha1 remote_name
-    do
-	case "$sha1" in
-	failed)
-		echo >&2 "Fetch failure: $remote"
-		exit 1 ;;
-	esac
-	found=
-	single_force=
-	for ref in $refs
+# automated tag following
+case "$no_tags$tags" in
+'')
+	taglist=$(IFS=" " &&
+    	git-ls-remote --tags "$remote" |
+	sed -ne 's|^\([0-9a-f]*\)[ 	]\(refs/tags/.*\)^{}$|\1 \2|p' |
+	while read sha1 name
 	do
-	    case "$ref" in
-	    +$remote_name:*)
-		single_force=t
-		not_for_merge=
-		found="$ref"
-		break ;;
-	    .+$remote_name:*)
-		single_force=t
-		not_for_merge=t
-		found="$ref"
-		break ;;
-	    .$remote_name:*)
-	        not_for_merge=t
-		found="$ref"
-		break ;;
-	    $remote_name:*)
-	    	not_for_merge=
-		found="$ref"
-		break ;;
-	    esac
-	done
-	local_name=$(expr "$found" : '[^:]*:\(.*\)')
-	append_fetch_head "$sha1" "$remote" \
-		"$remote_name" "$remote_nick" "$local_name" "$not_for_merge"
-    done || exit
-    ;;
+		test -f "$GIT_DIR/$name" && continue
+	  	git-check-ref-format "$name" || {
+			echo >&2 "warning: tag ${name} ignored"
+			continue
+		}
+		git-cat-file -t "$sha1" >/dev/null 2>&1 || continue
+		echo >&2 "Auto-following $name"
+		echo ".${name}:${name}"
+	done)
+	case "$taglist" in
+	'') ;;
+	?*)
+		fetch_main "$taglist" ;;
+	esac
 esac
 
 # If the original head was empty (i.e. no "master" yet), or
-- 
1.0.7-g0263
