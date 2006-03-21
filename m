From: Junio C Hamano <junkio@cox.net>
Subject: Re: efficient cloning
Date: Tue, 21 Mar 2006 00:28:41 -0800
Message-ID: <7virq8gq12.fsf@assigned-by-dhcp.cox.net>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us>
	<7vbqw1nakz.fsf@assigned-by-dhcp.cox.net>
	<7vu09tjy38.fsf@assigned-by-dhcp.cox.net>
	<200603201730.19373.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Mar 21 09:29:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLcER-0003b4-Gs
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 09:28:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932334AbWCUI2o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 03:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWCUI2o
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 03:28:44 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:39366 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932334AbWCUI2o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 03:28:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060321082713.LFXW15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 21 Mar 2006 03:27:13 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200603201730.19373.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Mon, 20 Mar 2006 17:30:19 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17777>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> Shouldn't this be .git/refs/remotes/origin/?
> Ie. different namespaces for different remotes?

OK, here is a second try, that comes on top of the one from the
last night.

Together with another topic in the "next" branch, you can now do
this:

 $ git clone --use-separate-remote --reference git.git \
   git://git.kernel.org/pub/scm/git/git.git new.git
 $ cd new.git
 $ git branch
 * master
 $ git log --pretty=oneline master..origin/next | wc -l
 72

What the last one shows is that sha1_basic() lets you omit
refs/remotes; it does not let you say "origin" to mean
"refs/remotes/origin/master", although I agree that abbreviation
would be useful.  As I am still not yet convinced that using
what is in .git/remotes/origin is a good way to implement that
shorthand, and would rather avoid reading .git/remotes/origin
from the C level (even though sha1_basic() is not _that_ core
but a lot closer to the UI, compared to other C level routines),
I am leaving that part for later rounds.

-- >8 --
[PATCH] revamp git-clone (take #2).

This builds on top of the previous one.

 * --use-separate-remote uses .git/refs/remotes/$origin/
   directory to keep track of the upstream branches.

 * The $origin above defaults to "origin" as usual, but the
   existing "-o $origin" option can be used to override it.

I am not yet convinced if we should make "$origin" the synonym to
"refs/remotes/$origin/$name" where $name is the primary branch
name of $origin upstream, nor if so how we should decide which
upstream branch is the primary one, but that is more or less
orthogonal to what the clone does here.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-clone.sh |   50 +++++++++++++++++++++++++++++++-------------------
 1 files changed, 31 insertions(+), 19 deletions(-)

47874d6d9a7f49ade6388df049597f03365961ca
diff --git a/git-clone.sh b/git-clone.sh
index 9db678b..3b54753 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -9,7 +9,7 @@
 unset CDPATH
 
 usage() {
-	echo >&2 "Usage: $0 [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [-o <name>] [-n] <repo> [<dir>]"
+	echo >&2 "Usage: $0 [--use-separate-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [-o <name>] [-n] <repo> [<dir>]"
 	exit 1
 }
 
@@ -61,8 +61,9 @@ use File::Path qw(mkpath);
 use File::Basename qw(dirname);
 my $git_dir = $ARGV[0];
 my $use_separate_remote = $ARGV[1];
+my $origin = $ARGV[2];
 
-my $branch_top = ($use_separate_remote ? "remotes" : "heads");
+my $branch_top = ($use_separate_remote ? "remotes/$origin" : "heads");
 my $tag_top = "tags";
 
 sub store {
@@ -127,7 +128,12 @@ while
 	*,--reference=*)
 		reference=`expr "$1" : '--reference=\(.*\)'` ;;
 	*,-o)
-		git-check-ref-format "$2" || {
+		case "$2" in
+		*/*)
+		    echo >&2 "'$2' is not suitable for an origin name"
+		    exit 1
+		esac
+		git-check-ref-format "heads/$2" || {
 		    echo >&2 "'$2' is not suitable for a branch name"
 		    exit 1
 		}
@@ -165,14 +171,9 @@ then
 	no_checkout=yes
 fi
 
-if test -z "$origin_override$origin"
+if test -z "$origin"
 then
-	if test -n "$use_separate_remote"
-	then
-		origin=remotes/master
-	else
-		origin=heads/origin
-	fi
+	origin=origin
 fi
 
 # Turn the source into an absolute path if
@@ -317,7 +318,7 @@ test -d "$GIT_DIR/refs/reference-tmp" &&
 if test -f "$GIT_DIR/CLONE_HEAD"
 then
 	# Figure out where the remote HEAD points at.
-	perl -e "$copy_refs" "$GIT_DIR" "$use_separate_remote"
+	perl -e "$copy_refs" "$GIT_DIR" "$use_separate_remote" "$origin"
 fi
 
 cd "$D" || exit
@@ -328,8 +329,18 @@ then
 	# Figure out which remote branch HEAD points at.
 	case "$use_separate_remote" in
 	'')	remote_top=refs/heads ;;
-	*)	remote_top=refs/remotes ;;
+	*)	remote_top="refs/remotes/$origin" ;;
 	esac
+
+	# What to use to track the remote primary branch
+	if test -n "$use_separate_remote"
+	then
+		origin_tracking="remotes/$origin/master"
+	else
+		origin_tracking="heads/$origin"
+	fi
+
+	# The name under $remote_top the remote HEAD seems to point at
 	head_points_at=$(
 		(
 			echo "master"
@@ -349,25 +360,26 @@ then
 		done
 		)
 	)
+
+	# Write out remotes/$origin file.
 	case "$head_points_at" in
 	?*)
 		mkdir -p "$GIT_DIR/remotes" &&
-		echo >"$GIT_DIR/remotes/origin" \
+		echo >"$GIT_DIR/remotes/$origin" \
 		"URL: $repo
-Pull: refs/heads/$head_points_at:refs/$origin" &&
+Pull: refs/heads/$head_points_at:refs/$origin_tracking" &&
 		case "$use_separate_remote" in
 		t) git-update-ref HEAD "$head_sha1" ;;
 		*) git-update-ref "refs/$origin" $(git-rev-parse HEAD)
 		esac &&
-		(cd "$GIT_DIR" && find "$remote_top" -type f -print) |
-		while read ref
+		(cd "$GIT_DIR/$remote_top" && find . -type f -print) |
+		while read dotslref
 		do
-			head=`expr "$ref" : 'refs/\(.*\)'` &&
-			name=`expr "$ref" : 'refs/[^\/]*/\(.*\)'` &&
+			name=`expr "$dotslref" : './\(.*\)'` &&
 			test "$head_points_at" = "$name" ||
 			test "$origin" = "$head" ||
 			echo "Pull: refs/heads/${name}:$remote_top/${name}"
-		done >>"$GIT_DIR/remotes/origin"
+		done >>"$GIT_DIR/remotes/$origin"
 	esac
 
 	case "$no_checkout" in
-- 
1.2.4.ge2fc
