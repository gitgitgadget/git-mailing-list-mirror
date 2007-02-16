From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] Add git-bundle - pack objects and references for disconnected
 transfer
Date: Fri, 16 Feb 2007 01:39:44 -0500
Message-ID: <11716079843500-git-send-email-mdl123@verizon.net>
References: <7vodnuc0me.fsf@assigned-by-dhcp.cox.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 07:40:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHwlD-00037g-6R
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 07:39:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423347AbXBPGj4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 01:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423350AbXBPGj4
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 01:39:56 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:41219 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423347AbXBPGjz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 01:39:55 -0500
Received: from fal-l07294-lp.us.ray.com ([71.246.235.75])
 by vms044.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JDJ00AW2MI7P1V7@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 16 Feb 2007 00:39:45 -0600 (CST)
In-reply-to: <7vodnuc0me.fsf@assigned-by-dhcp.cox.net>
X-Mailer: git-send-email 1.5.0.rc4.375.gd0938-dirty
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39891>

Some workflows require coordinated development between repositories on
machines that can never be connected. This utility creates a bundle
containing a pack of objects and associated references (heads or tags)
that can be independently transferred to another machine, effectively
supporting git-push like operations between disconnected systems.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 git-bundle.sh |  112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 112 insertions(+), 0 deletions(-)
 create mode 100755 git-bundle.sh

diff --git a/git-bundle.sh b/git-bundle.sh
new file mode 100755
index 0000000..f56f499
--- /dev/null
+++ b/git-bundle.sh
@@ -0,0 +1,112 @@
+#!/bin/sh
+# Create a bundle to carry from one git repo to another
+# (e.g., "sneaker-net" based push)
+# git-bundle <git-rev-list args>
+# git-bundle --bare <git-rev-list args>
+# creates bundle.tar in current directory (can rename of course)
+#
+# The bundle includes all refs given (--all selects every ref in the repo).
+# and all of the commit objects needed subject to the list given.
+#
+# Objects to be packed are limited by specifying one or more of
+#   ^commit-ish    - indicated commits already at the target
+#                    (can have more than one ^commit-ish)
+#   --since=xxx    - Assume target repo has all relevant commits
+#                    earlier than xxx
+
+USAGE='git-bundle [-o file | --output=file] <git-rev-list arguments>'
+SUBDIRECTORY_OK=1
+. git-sh-setup
+
+bfile=bundle.tar
+args=
+while test -n "$1" ; do
+    case $1 in
+        -h|--h|--he|--hel|--help)
+            echo "$USAGE"
+            exit;;
+        --output=*)
+            bfile=${1##--output=};;
+        -o|--output)
+            shift
+            bfile=$1;;
+        *)
+            args="$args $1"
+    esac
+    shift
+done
+
+unknown=$(git-rev-parse --no-revs $args)
+test -z "$unknown" || die "unknown option: $unknown"
+gitrevargs=$(git-rev-parse --symbolic --revs-only $args) || exit 1
+
+# find the refs to carry along and get sha1s for each.
+refs=
+fullrevargs=
+for arg in $gitrevargs ; do
+    #ignore options and basis refs, get unambiguous ref name for things
+    # we will transport (e.g., user gives master, have heads/master and
+    # remotes/origin/master, we keep the former).
+    case "$arg" in
+        -*) fullrevargs="$fullrevargs $arg";;
+        ^*) fullrevargs="$fullrevargs $arg";;
+        *)  ref=$(git-show-ref "$arg")
+            test "$(echo $ref | wc -w)" = "2" || die "Ambigous reference: $arg
+$ref"
+            fullrevargs="$fullrevargs ${ref#* }"
+            refs="$refs $ref"
+            ;;
+    esac
+done
+test -z "$refs" && die "No references specified, I don't know what to bundle."
+
+# git-rev-list cannot determine edge objects if a date restriction is
+# given...  we do things a slow way if max-age or min-age are given
+case "$fullrevargs" in
+    *--max-age* | *--min-age*)
+    # get a list of all commits that will be packed along with
+    # parents of each.  A fixed git-rev-list --boundary should
+    # replace all of this.
+    echo "Finding prerequisites and commits to bundle..."
+    commits=$(git-rev-list $fullrevargs)
+
+    # get immediate parents of each commit to include
+    parents=
+    for c in $commits ; do
+        parents="$parents $(git-rev-list --parents --max-count=1 $c | cut -b42-)"
+    done
+    parents=$(printf "%s\n" $parents | sort | uniq)
+
+    # factor out what will be in this bundle, the remainder are the
+    # bundle's prerequisites.  double up commits in this as we only
+    # want things that are only in parents to appear once
+    prereqs=$(printf "%s\n" $parents $commits $commits | \
+        sort | uniq -c | sed -ne 's/^ *1 //p');;
+    *)
+        prereqs=$(git-rev-list --objects-edge $fullrevargs | sed -ne 's/^-//p');;
+esac
+
+# create refs and pack
+tmp=$GIT_DIR/bundle_tmp$$
+references="$tmp-references"
+pack="$tmp-pack"
+trap 'rm -f "$references" "$pack"' 0 1 2 3 15
+
+echo "v1" > "$references" &&
+echo "prerequisites" >> "$references" &&
+printf "%s\n" $prereqs >> "$references" &&
+echo "references" >> "$references" &&
+git-show-ref $refs >> "$references" &&
+(git-rev-list --objects $fullrevargs | \
+    cut -b-40 | \
+    git pack-objects --all-progress --stdout >> "$pack" ) \
+    || exit
+
+# create the tar file, clean up
+tar cf "$bfile" --absolute-names --transform="s,$tmp-,," \
+    --verbose --show-transformed-names \
+    "$references" "$pack"
+rm -f "$pack" "$references"
+
+# done
+echo "Created $bfile"
-- 
1.5.0.rc4.375.gd0938-dirty
