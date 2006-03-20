From: Junio C Hamano <junkio@cox.net>
Subject: Re: efficient cloning
Date: Mon, 20 Mar 2006 00:54:03 -0800
Message-ID: <7vu09tjy38.fsf@assigned-by-dhcp.cox.net>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us>
	<7vu09um3ae.fsf@assigned-by-dhcp.cox.net>
	<m3wteqj6qx.fsf@lugabout.cloos.reno.nv.us>
	<7vbqw1nakz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 09:54:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLG9n-0003jP-T5
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 09:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWCTIyK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 03:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWCTIyK
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 03:54:10 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:15019 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932245AbWCTIyI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Mar 2006 03:54:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060320085412.KJPQ25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Mar 2006 03:54:12 -0500
To: James Cloos <cloos@jhcloos.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17744>

Junio C Hamano <junkio@cox.net> writes:

> So in case you are really in a rush, and in a mood to build on
> top of my WIP, here is one.

And this is an replacement, which actually has seen some
testing.  I'll place this in the "next" branch tonight.  Further
testing is appreciated.

-- >8 --
[PATCH] revamp git-clone.

This does two things.

 * A new flag --reference can be used to name a local repository
   that is to be used as an alternate.  This is in response to
   an inquiry by James Cloos in the message on the list
   <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us>.

 * A new flag --use-separate-remote stops contaminating local
   branch namespace by upstream branch names.  The upstream
   branch heads are copied in .git/refs/remotes/ instead of
   .git/refs/heads/ and .git/remotes/origin file is set up to
   reflect this as well.  It requires to have fetch/pull update
   to understand .git/refs/remotes by Eric Wong to further
   update the repository cloned this way.

For the former change, git-fetch-pack is taught a new flag --all
to fetch from all the remote heads.  Nobody uses the git-clone-pack
with this change, so we could deprecate the command, but removal
of the command will be left to a separate round.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 fetch-pack.c |   18 ++++--
 git-clone.sh |  184 ++++++++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 166 insertions(+), 36 deletions(-)

dfeff66ed9a3931d60f3cd600ad8c14b5cc3d9e5
diff --git a/fetch-pack.c b/fetch-pack.c
index 535de10..a3bcad0 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -7,8 +7,9 @@
 static int keep_pack;
 static int quiet;
 static int verbose;
+static int fetch_all;
 static const char fetch_pack_usage[] =
-"git-fetch-pack [-q] [-v] [-k] [--thin] [--exec=upload-pack] [host:]directory <refs>...";
+"git-fetch-pack [--all] [-q] [-v] [-k] [--thin] [--exec=upload-pack] [host:]directory <refs>...";
 static const char *exec = "git-upload-pack";
 
 #define COMPLETE	(1U << 0)
@@ -266,8 +267,9 @@ static void filter_refs(struct ref **ref
 	for (prev = NULL, current = *refs; current; current = next) {
 		next = current->next;
 		if ((!memcmp(current->name, "refs/", 5) &&
-					check_ref_format(current->name + 5)) ||
-				!path_match(current->name, nr_match, match)) {
+		     check_ref_format(current->name + 5)) ||
+		    (!fetch_all &&
+		     !path_match(current->name, nr_match, match))) {
 			if (prev == NULL)
 				*refs = next;
 			else
@@ -376,7 +378,11 @@ static int fetch_pack(int fd[2], int nr_
 		goto all_done;
 	}
 	if (find_common(fd, sha1, ref) < 0)
-		fprintf(stderr, "warning: no common commits\n");
+		if (!keep_pack)
+			/* When cloning, it is not unusual to have
+			 * no common commit.
+			 */
+			fprintf(stderr, "warning: no common commits\n");
 
 	if (keep_pack)
 		status = receive_keep_pack(fd, "git-fetch-pack", quiet);
@@ -426,6 +432,10 @@ int main(int argc, char **argv)
 				use_thin_pack = 1;
 				continue;
 			}
+			if (!strcmp("--all", arg)) {
+				fetch_all = 1;
+				continue;
+			}
 			if (!strcmp("-v", arg)) {
 				verbose = 1;
 				continue;
diff --git a/git-clone.sh b/git-clone.sh
index 4ed861d..9db678b 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -9,7 +9,7 @@
 unset CDPATH
 
 usage() {
-	echo >&2 "Usage: $0 [--bare] [-l [-s]] [-q] [-u <upload-pack>] [-o <name>] [-n] <repo> [<dir>]"
+	echo >&2 "Usage: $0 [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [-o <name>] [-n] <repo> [<dir>]"
 	exit 1
 }
 
@@ -40,13 +40,61 @@ Perhaps git-update-server-info needs to 
 	do
 		name=`expr "$refname" : 'refs/\(.*\)'` &&
 		case "$name" in
-		*^*)	;;
-		*)
-			git-http-fetch -v -a -w "$name" "$name" "$1/" || exit 1
+		*^*)	continue;;
 		esac
+		if test -n "$use_separate_remote" &&
+		   branch_name=`expr "$name" : 'heads/\(.*\)'`
+		then
+			tname="remotes/$branch_name"
+		else
+			tname=$name
+		fi
+		git-http-fetch -v -a -w "$tname" "$name" "$1/" || exit 1
 	done <"$clone_tmp/refs"
 	rm -fr "$clone_tmp"
+	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD"
+}
+
+# Read git-fetch-pack -k output and store the remote branches.
+copy_refs='
+use File::Path qw(mkpath);
+use File::Basename qw(dirname);
+my $git_dir = $ARGV[0];
+my $use_separate_remote = $ARGV[1];
+
+my $branch_top = ($use_separate_remote ? "remotes" : "heads");
+my $tag_top = "tags";
+
+sub store {
+	my ($sha1, $name, $top) = @_;
+	$name = "$git_dir/refs/$top/$name";
+	mkpath(dirname($name));
+	open O, ">", "$name";
+	print O "$sha1\n";
+	close O;
+}
+
+open FH, "<", "$git_dir/CLONE_HEAD";
+while (<FH>) {
+	my ($sha1, $name) = /^([0-9a-f]{40})\s(.*)$/;
+	next if ($name =~ /\^\173/);
+	if ($name eq "HEAD") {
+		open O, ">", "$git_dir/REMOTE_HEAD";
+		print O "$sha1\n";
+		close O;
+		next;
+	}
+	if ($name =~ s/^refs\/heads\///) {
+		store($sha1, $name, $branch_top);
+		next;
+	}
+	if ($name =~ s/^refs\/tags\///) {
+		store($sha1, $name, $tag_top);
+		next;
+	}
 }
+close FH;
+'
 
 quiet=
 use_local=no
@@ -54,8 +102,10 @@ local_shared=no
 no_checkout=
 upload_pack=
 bare=
-origin=origin
+reference=
+origin=
 origin_override=
+use_separate_remote=
 while
 	case "$#,$1" in
 	0,*) break ;;
@@ -68,7 +118,14 @@ while
         *,-s|*,--s|*,--sh|*,--sha|*,--shar|*,--share|*,--shared) 
           local_shared=yes; use_local=yes ;;
 	*,-q|*,--quiet) quiet=-q ;;
+	*,--use-separate-remote)
+		use_separate_remote=t ;;
 	1,-o) usage;;
+	1,--reference) usage ;;
+	*,--reference)
+		shift; reference="$1" ;;
+	*,--reference=*)
+		reference=`expr "$1" : '--reference=\(.*\)'` ;;
 	*,-o)
 		git-check-ref-format "$2" || {
 		    echo >&2 "'$2' is not suitable for a branch name"
@@ -100,9 +157,24 @@ then
 		echo >&2 '--bare and -o $origin options are incompatible.'
 		exit 1
 	fi
+	if test t = "$use_separate_remote"
+	then
+		echo >&2 '--bare and --use-separate-remote options are incompatible.'
+		exit 1
+	fi
 	no_checkout=yes
 fi
 
+if test -z "$origin_override$origin"
+then
+	if test -n "$use_separate_remote"
+	then
+		origin=remotes/master
+	else
+		origin=heads/origin
+	fi
+fi
+
 # Turn the source into an absolute path if
 # it is local
 repo="$1"
@@ -130,6 +202,28 @@ yes)
 	GIT_DIR="$D/.git" ;;
 esac
 
+if test -n "$reference"
+then
+	if test -d "$reference"
+	then
+		if test -d "$reference/.git/objects"
+		then
+			reference="$reference/.git"
+		fi
+		reference=$(cd "$reference" && pwd)
+		echo "$reference/objects" >"$GIT_DIR/objects/info/alternates"
+		(cd "$reference" && tar cf - refs) |
+		(cd "$GIT_DIR/refs" &&
+		 mkdir reference-tmp &&
+		 cd reference-tmp &&
+		 tar xf -)
+	else
+		echo >&2 "$reference: not a local directory." && usage
+	fi
+fi
+
+rm -f "$GIT_DIR/CLONE_HEAD"
+
 # We do local magic only when the user tells us to.
 case "$local,$use_local" in
 yes,yes)
@@ -165,24 +259,14 @@ yes,yes)
 	    } >"$GIT_DIR/objects/info/alternates"
 	    ;;
 	esac
-
-	# Make a duplicate of refs and HEAD pointer
-	HEAD=
-	if test -f "$repo/HEAD"
-	then
-		HEAD=HEAD
-	fi
-	(cd "$repo" && tar cf - refs $HEAD) |
-	(cd "$GIT_DIR" && tar xf -) || exit 1
+	git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD"
 	;;
 *)
 	case "$repo" in
 	rsync://*)
 		rsync $quiet -av --ignore-existing  \
-			--exclude info "$repo/objects/" "$GIT_DIR/objects/" &&
-		rsync $quiet -av --ignore-existing  \
-			--exclude info "$repo/refs/" "$GIT_DIR/refs/" || exit
-
+			--exclude info "$repo/objects/" "$GIT_DIR/objects/" ||
+		exit
 		# Look at objects/info/alternates for rsync -- http will
 		# support it natively and git native ones will do it on the
 		# remote end.  Not having that file is not a crime.
@@ -205,6 +289,7 @@ yes,yes)
 		    done
 		    rm -f "$GIT_DIR/TMP_ALT"
 		fi
+		git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD"
 		;;
 	http://*)
 		if test -z "@@NO_CURL@@"
@@ -217,37 +302,71 @@ yes,yes)
 		;;
 	*)
 		cd "$D" && case "$upload_pack" in
-		'') git-clone-pack $quiet "$repo" ;;
-		*) git-clone-pack $quiet "$upload_pack" "$repo" ;;
-		esac || {
-			echo >&2 "clone-pack from '$repo' failed."
+		'') git-fetch-pack --all -k $quiet "$repo" ;;
+		*) git-fetch-pack --all -k $quiet "$upload_pack" "$repo" ;;
+		esac >"$GIT_DIR/CLONE_HEAD" || {
+			echo >&2 "fetch-pack from '$repo' failed."
 			exit 1
 		}
 		;;
 	esac
 	;;
 esac
+test -d "$GIT_DIR/refs/reference-tmp" && rm -fr "$GIT_DIR/refs/reference-tmp"
+
+if test -f "$GIT_DIR/CLONE_HEAD"
+then
+	# Figure out where the remote HEAD points at.
+	perl -e "$copy_refs" "$GIT_DIR" "$use_separate_remote"
+fi
 
 cd "$D" || exit
 
-if test -f "$GIT_DIR/HEAD" && test -z "$bare"
+if test -z "$bare" && test -f "$GIT_DIR/REMOTE_HEAD"
 then
-	head_points_at=`git-symbolic-ref HEAD`
+	head_sha1=`cat "$GIT_DIR/REMOTE_HEAD"`
+	# Figure out which remote branch HEAD points at.
+	case "$use_separate_remote" in
+	'')	remote_top=refs/heads ;;
+	*)	remote_top=refs/remotes ;;
+	esac
+	head_points_at=$(
+		(
+			echo "master"
+			cd "$GIT_DIR/$remote_top" &&
+			find . -type f -print | sed -e 's/^\.\///'
+		) | (
+		done=f
+		while read name
+		do
+			test t = $done && continue
+			branch_tip=`cat "$GIT_DIR/$remote_top/$name"`
+			if test "$head_sha1" = "$branch_tip"
+			then
+				echo "$name"
+				done=t
+			fi
+		done
+		)
+	)
 	case "$head_points_at" in
-	refs/heads/*)
-		head_points_at=`expr "$head_points_at" : 'refs/heads/\(.*\)'`
+	?*)
 		mkdir -p "$GIT_DIR/remotes" &&
 		echo >"$GIT_DIR/remotes/origin" \
 		"URL: $repo
-Pull: $head_points_at:$origin" &&
-		git-update-ref "refs/heads/$origin" $(git-rev-parse HEAD) &&
-		(cd "$GIT_DIR" && find "refs/heads" -type f -print) |
+Pull: refs/heads/$head_points_at:refs/$origin" &&
+		case "$use_separate_remote" in
+		t) git-update-ref HEAD "$head_sha1" ;;
+		*) git-update-ref "refs/$origin" $(git-rev-parse HEAD)
+		esac &&
+		(cd "$GIT_DIR" && find "$remote_top" -type f -print) |
 		while read ref
 		do
-			head=`expr "$ref" : 'refs/heads/\(.*\)'` &&
-			test "$head_points_at" = "$head" ||
+			head=`expr "$ref" : 'refs/\(.*\)'` &&
+			name=`expr "$ref" : 'refs/[^\/]*/\(.*\)'` &&
+			test "$head_points_at" = "$name" ||
 			test "$origin" = "$head" ||
-			echo "Pull: ${head}:${head}"
+			echo "Pull: refs/heads/${name}:$remote_top/${name}"
 		done >>"$GIT_DIR/remotes/origin"
 	esac
 
@@ -256,6 +375,7 @@ Pull: $head_points_at:$origin" &&
 		git-read-tree -m -u -v HEAD HEAD
 	esac
 fi
+rm -f "$GIT_DIR/CLONE_HEAD" "$GIT_DIR/REMOTE_HEAD"
 
 trap - exit
 
-- 
1.2.4.gb7986
