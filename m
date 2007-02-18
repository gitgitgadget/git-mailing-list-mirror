From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] Add git-bundle: move objects and references by archive.
Date: Sun, 18 Feb 2007 17:47:32 -0500
Message-ID: <1171838852534-git-send-email-mdl123@verizon.net>
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Feb 18 23:48:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIup5-0000ZJ-M4
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 23:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752365AbXBRWry (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 17:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbXBRWry
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 17:47:54 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:22348 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbXBRWrx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 17:47:53 -0500
Received: from fal-l07294-lp.us.ray.com ([71.246.235.75])
 by vms048.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JDO00A98KN6CJF5@vms048.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 18 Feb 2007 16:47:31 -0600 (CST)
X-Mailer: git-send-email 1.5.0.rc4.375.gd0938-dirty
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40087>

Some workflows require use of repositories on machines that cannot be
connected, preventing use of git-fetch / git-push to transport objects
and references between the repositories.

git-bundle provides an alternate transport mechanism, effectively allowing
git-fetch and git-pull to operate using sneakernet transport. git-bundle
--create allows the user to create a bundle containing one or more branches
or tags, but with specified basis assumed to exist on the target repository.
At the receiving end, git-bundle acts like git-fetch-pack, allowing the
user to invoke git-fetch or git-pull using the bundle file as the URL.
git-fetch and git-ls-remote determine they have a bundle URL by checking
that the URL points to a file, but are otherwise unchanged in operation
with bundles.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 Documentation/cmd-list.perl  |    1 +
 Documentation/git-bundle.txt |  146 +++++++++++++++++++++++++++++++++++
 Makefile                     |    3 +-
 git-bundle.sh                |  174 ++++++++++++++++++++++++++++++++++++++++++
 git-fetch.sh                 |   11 ++-
 git-ls-remote.sh             |    7 ++-
 6 files changed, 338 insertions(+), 4 deletions(-)
 mode change 100755 => 100644 Documentation/cmd-list.perl
 create mode 100644 Documentation/git-bundle.txt
 create mode 100755 git-bundle.sh

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
old mode 100755
new mode 100644
index a2d6268..f61c77a
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -70,6 +70,7 @@ git-archive                             mainporcelain
 git-bisect                              mainporcelain
 git-blame                               ancillaryinterrogators
 git-branch                              mainporcelain
+git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-checkout-index                      plumbingmanipulators
 git-checkout                            mainporcelain
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
new file mode 100644
index 0000000..27db785
--- /dev/null
+++ b/Documentation/git-bundle.txt
@@ -0,0 +1,146 @@
+git-bundle(1)
+=============
+
+NAME
+----
+git-bundle - Move objects and refs by archive
+
+
+SYNOPSIS
+--------
+'git-bundle' --create file <git-rev-list args> <--tar tarspec>
+'git-bundle' --verify file  <--tar tarspec>
+'git-bundle' --list-heads file <reflist> <--tar tarspec>
+'git-bundle' --unbundle file <reflist> <--tar tarspec>
+
+DESCRIPTION
+-----------
+
+Some workflows require that one or more branches of development on one
+machine be replicated on another machine, but the two machines cannot
+be directly connected so the interactive git protocols (git, ssh,
+rsync, http) cannot be used.  This command provides suport for
+git-fetch and git-pull to operate by packaging objects and references
+in an archive at the originating machine, then importing those into
+another repository using gitlink:git-fetch[1] and gitlink:git-pull[1]
+after moving the archive by some means (i.e., by sneakernet).  As no
+direct connection between repositories exists, the user must specify a
+basis for the bundle that is held by the destination repository: the
+bundle assumes that all objects in the basis are already in the
+destination repository.
+
+OPTIONS
+-------
+
+--create file::
+       Used to create a bundle named 'file'.  This requires the
+       git-rev-list arguments to define the bundle contents.
+
+--verify file::
+       Used to check that a bundle file is valid and will apply
+       cleanly to the current repository.  This includes checks on the
+       bundle format itself as well as checking that the prerequisite
+       commits exist and are fully linked in the current repository.
+       git-bundle prints a list of missing commits, if any, and exits
+       with non-zero status.
+
+--list-heads file::
+       Lists the references defined in the bundle.  If followed by a
+       list of references, only references matching those given are
+       printed out.
+
+--unbundle file::
+       Passes the objects in the bundle to gitlink:git-index-pack[1]
+       for storage in the repository, then prints the names of all
+       defined references. If a reflist is given, only references
+       matching those in the given list are printed. This command is
+       really plumbing, intended to be called only by
+       gitlink:git-fetch[1].
+
+git-rev-list args::
+       A list of arguments, accepatble to git-rev-parse and
+       git-rev-list, that specify the specific objects and references
+       to transport.  For example, "master~10..master" causes the
+       current master reference to be packaged along with all objects
+       added since its 10th ancestor commit.  There is no explicit
+       limit to the number of references and objects that may be
+       packaged.
+
+
+reflist::
+       A list of references used to limit the references reported as
+       available. This is principally of use to git-fetch, which
+       expects to recieve only those references asked for and not
+       necessarily everything in the pack (in this case, git-bundle is
+       acting like gitlink:git-fetch-pack[1]).
+
+tar tarspec::
+
+       git-bundle uses tar, and requires a tar supporting c, f, and
+       -O. By default, git-bundle looks for gtar on the path, then for
+       tar if gtar is not found. This can be overridden by explicitly
+       defining tarspec, or by defining TAR in the environment.
+
+SPECIFYING REFERENCES
+---------------------
+
+git-bundle will only package references that are shown by
+git-show-ref: this includes heads, tags, and remote heads.  References
+such as master~1 cannot be packaged, but are perfectly suitable for
+defining the basis.  More than one reference may be packaged, and more
+than one basis can be specified.  The objects packaged are those not
+contained in the union of the given bases.  Each basis can be
+specified explicitly (e.g., ^master~10), or implicitly (e.g.,
+master~10..master, master --since=10.days.ago).
+
+It is very important that the basis used be held by the destination.
+It is ok to err on the side of conservatism, causing the bundle file
+to contain objects already in the destination as these are ignored
+when unpacking at the destination.
+
+EXAMPLE
+-------
+
+Assume two repositories exist as R1 on machine A, and R2 on machine B.
+For whatever reason, direct connection between A and B is not allowed,
+but we can move data from A to B via some mechanism (CD, email, etc).
+We want to update R2 with developments made on branch master in R1.
+We set a tag in R1 (lastR2bundle) after the previous such transport,
+and move it afterwards to help build the bundle.
+
+in R1 on A:
+$ git-bundle --create mybundle master ^lastR2bundle
+$ git tag -f lastR2bundle master
+
+(move mybundle from A to B by some mechanism)
+
+in R2 on B:
+$ git-bundle --verify mybundle
+$ git-fetch mybundle  refspec
+
+where refspec is refInBundle:localRef
+
+
+Also, with something like this in your config:
+
+[remote "bundle"]
+    url = /home/me/tmp/file.bdl
+    fetch = refs/heads/*:refs/remotes/origin/*
+
+You can first sneakernet the bundle file to ~/tmp/file.bdl and
+then these commands:
+
+$ git ls-remote bundle
+$ git fetch bundle
+$ git pull bundle
+
+would treat it as if it is talking with a remote side over the
+network.
+
+Author
+------
+Written by Mark Levedahl <mdl123@verizon.net>
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index ebecbbd..c6d540e 100644
--- a/Makefile
+++ b/Makefile
@@ -177,7 +177,8 @@ SCRIPT_SH = \
 	git-applymbox.sh git-applypatch.sh git-am.sh \
 	git-merge.sh git-merge-stupid.sh git-merge-octopus.sh \
 	git-merge-resolve.sh git-merge-ours.sh \
-	git-lost-found.sh git-quiltimport.sh
+	git-lost-found.sh git-quiltimport.sh \
+	git-bundle.sh
 
 SCRIPT_PERL = \
 	git-add--interactive.perl \
diff --git a/git-bundle.sh b/git-bundle.sh
new file mode 100755
index 0000000..19ac137
--- /dev/null
+++ b/git-bundle.sh
@@ -0,0 +1,174 @@
+#!/bin/sh
+# Basic handler for bundle files to connect repositories via sneakernet.
+# Invocation must include action.
+# This function can create a bundle or provide information on an existing bundle
+# supporting git-fetch, git-pull, and git-ls-remote
+
+USAGE='[--create bundle <git-rev-list args>] |
+[--verify|--list-heads|--unbundle bundle] <--tar tarspec>
+     where bundle is the name of the bundle file.'
+
+verify() {
+    # Check bundle version
+    test -f "$bfile" || die "cannot find $bfile"
+    test "$($TAR -xf ""$bfile"" -O version)" = "v1 git-bundle" ||
+        die "$bfile doesn't look like a v1 bundle file."
+
+	# do fast check, then if any prereqs are missing then go line by line
+	# to be verbose about the errors
+    prereqs=$($TAR xf "$bfile" -O prerequisites)
+	test -z "$prereqs" && return 0
+	bad=$(echo "$prereqs" | cut -b-40 | git-rev-list --stdin --not --all 2>&1)
+    if test -n "$bad" ; then
+		test "$1" = "--silent" && return 1
+        echo "error: $bfile requires the following commits you lack:"
+		echo "$prereqs" |
+		while read sha1 comment ; do
+            missing=$(git-rev-list $sha1 --not --all 2>&1)
+            test -n "$missing" && echo "$sha1 $comment"
+		done
+        exit 1
+    fi
+    return 0
+}
+
+# list all or just a subset
+list_heads() {
+	if test -z "$*" ; then
+		$TAR -xf "$bfile" -O references 2>/dev/null || exit 1
+	else
+		($TAR -xf "$bfile" -O references 2>/dev/null || exit 1) |
+		while read sha1 ref ; do
+			for arg in $* ; do
+				if test "${ref%$arg}" != "$ref" ; then
+					echo "$sha1 $ref"
+					break
+				fi
+			done
+		done
+	fi
+}
+
+SUBDIRECTORY_OK=1
+. git-sh-setup
+
+args=
+action=
+while test -n "$1" ; do
+    case $1 in
+        --create|--list-heads|--unbundle|--verify)
+            action=${1#--}
+            shift
+            bfile=$1
+            test -z "$bfile" && die "$action requires filename";;
+        --tar=*)
+            TAR=${1##--tar=};;
+        --tar)
+			shift
+            TAR=$1;;
+        *)
+            args="$args $1";;
+    esac
+    shift
+done
+test -z "$action" && die "No action given, what should I do?"
+
+# what tar to use, prefer gtar, then tar.
+if test -z "$TAR" ; then
+    GTAR=$(which gtar 2>/dev/null)
+    TAR=${GTAR:-tar}
+fi
+
+case $action in
+create)
+    unknown=$(git-rev-parse --no-revs $args)
+    test -z "$unknown" || die "unknown option: $unknown"
+    gitrevargs=$(git-rev-parse --symbolic --revs-only $args) || exit 1
+
+    # find the refs to carry along and get sha1s for each.
+    refs=
+    fullrevargs=
+    for arg in $gitrevargs ; do
+        #ignore options and basis refs, get full ref name for things
+		# we will transport rejecting anything ambiguous (e.g., user
+		# gives master, have heads/master and remotes/origin/master, we
+		# keep the former).
+        case "$arg" in
+            -* | ^*) fullrevargs="$fullrevargs $arg";;
+            *)  ref=$(git-show-ref "$arg")
+                test "$(echo $ref | wc -w)" = "2" || die "Ambigous reference: $arg
+$ref"
+                fullrevargs="$fullrevargs ${ref#* }"
+                refs="$refs $ref";;
+        esac
+    done
+    test -z "$refs" && die "No references specified, I don't know what to bundle."
+
+    # git-rev-list cannot determine edge objects if a date restriction is
+    # given...  we do things a slow way if max-age or min-age are given
+    case "$fullrevargs" in
+        *--max-age* | *--min-age*)
+            # get a list of all commits that will be packed along with
+            # parents of each.  A fixed git-rev-list --boundary should
+            # replace all of this.
+            echo "Finding prerequisites and commits to bundle..."
+            commits=$(git-rev-list $fullrevargs)
+
+            # get immediate parents of each commit to include
+            parents=
+            for c in $commits ; do
+                parents="$parents $(git-rev-list --parents --max-count=1 $c | cut -b42-)"
+            done
+            parents=$(printf "%s\n" $parents | sort | uniq)
+
+            # factor out what will be in this bundle, the remainder are the
+            # bundle's prerequisites.  double up commits in this as we only
+            # want things that are only in parents to appear once
+            prereqs=$(printf "%s\n" $parents $commits $commits | \
+                sort | uniq -c | sed -ne 's/^ *1 //p');;
+        *)
+            prereqs=$(git-rev-list --objects-edge $fullrevargs | sed -ne 's/^-//p');;
+    esac
+
+	# replace prereqs with annotated version of same
+
+    # create refs and pack
+    tmp="$GIT_DIR/bundle_tmp$$"
+    prerequisites="$tmp/prerequisites"
+    references="$tmp/references"
+    version="$tmp/version"
+    pack="$tmp/pack"
+    trap 'rm -rf "$tmp"' 0 1 2 3 15
+
+    mkdir "$tmp" &&
+    echo "v1 git-bundle" > "$version" &&
+	touch "$prerequisites" &&
+	(for p in $prereqs ; do
+		git-rev-list --pretty=one --max-count=1 $p
+	done) > "$prerequisites" &&
+    git-show-ref $refs > "$references" &&
+    git-rev-list --objects $fullrevargs | cut -b-40 |
+        git pack-objects --all-progress --stdout > "$pack" &&
+
+    # create the tar file, clean up
+    cd "$tmp" &&
+    tar cf bundle prerequisites references version pack &&
+    cd - &&
+    mv "$tmp/bundle" "$bfile" &&
+    rm -rf "$tmp"
+
+    # done
+    echo "Created $bfile";;
+
+verify)
+    verify && echo "$bfile is ok";;
+
+list-heads)
+    list_heads $args;;
+
+unbundle)
+    verify --silent || exit 1
+    $TAR -xf "$bfile" -O pack | git-index-pack --stdin ||
+        die "error: $bfile has a corrupted pack file"
+    list_heads $args;;
+esac
diff --git a/git-fetch.sh b/git-fetch.sh
index ca984e7..42cc62f 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -377,8 +377,15 @@ fetch_main () {
     ( : subshell because we muck with IFS
       IFS=" 	$LF"
       (
-	  git-fetch-pack --thin $exec $keep $shallow_depth "$remote" $rref ||
-	  echo failed "$remote"
+	if test -f "$remote" ; then
+	    test -n "$shallow_depth" &&
+		die "shallow clone with bundle is not supported"
+	    git-bundle --unbundle "$remote" $rref ||
+	    echo failed "$remote"
+	else
+	    git-fetch-pack --thin $exec $keep $shallow_depth "$remote" $rref ||
+	    echo failed "$remote"
+	fi
       ) |
       (
 	trap '
diff --git a/git-ls-remote.sh b/git-ls-remote.sh
index 8ea5c5e..28bb9b8 100755
--- a/git-ls-remote.sh
+++ b/git-ls-remote.sh
@@ -89,8 +89,13 @@ rsync://* )
 	;;
 
 * )
-	git-peek-remote $exec "$peek_repo" ||
+	if test -f "$peek_repo" ; then
+		git bundle --list-heads "$peek_repo" ||
 		echo "failed	slurping"
+	else
+		git-peek-remote $exec "$peek_repo" ||
+		echo "failed	slurping"
+	fi
 	;;
 esac |
 sort -t '	' -k 2 |
-- 
1.5.0.rc4.375.gd0938-dirty
