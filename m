From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] Add git-bundle - pack objects and references for disconnected
 transfer
Date: Thu, 15 Feb 2007 19:19:52 -0500
Message-ID: <11715851972838-git-send-email-mdl123@verizon.net>
References: <11715851974102-git-send-email-mdl123@verizon.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 01:20:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHqpk-0000rW-TX
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 01:20:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422835AbXBPAUI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 19:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422840AbXBPAUH
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 19:20:07 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:32505 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422835AbXBPAUD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 19:20:03 -0500
Received: from fal-l07294-lp.us.ray.com ([71.246.235.75])
 by vms048.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JDJ00EPL4X9ZPQ6@vms048.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 15 Feb 2007 18:19:58 -0600 (CST)
In-reply-to: <11715851974102-git-send-email-mdl123@verizon.net>
X-Mailer: git-send-email 1.5.0.rc4.375.gd0938-dirty
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39867>

Some workflows require coordinated development between repositories on
machines that can never be connected. This utility creates a bundle
containing a pack of objects and associated references (heads or tags)
that can be independently transferred to another machine, effectively
supporting git-push like operations between disconnected systems.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 git-bundle.sh |  103 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 103 insertions(+), 0 deletions(-)
 create mode 100755 git-bundle.sh

diff --git a/git-bundle.sh b/git-bundle.sh
new file mode 100755
index 0000000..c431b52
--- /dev/null
+++ b/git-bundle.sh
@@ -0,0 +1,103 @@
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
+USAGE='git-bundle [--output=file] <git-rev-list arguments>'
+SUBDIRECTORY_OK=1
+. git-sh-setup
+
+# pull out rev-list args vs program args, parse the latter
+gitrevargs=$(git-rev-parse --symbolic --revs-only $*) || exit 1
+myargs=$(git-rev-parse --no-revs $*) || exit 1
+
+bfile=bundle.tar
+nextisoutput=
+for arg in $myargs ; do
+	case "$arg" in
+		-h|--h|--he|--hel|--help)
+			echo "$USAGE"
+			exit;;
+		--output=*)
+			bfile=${arg##--output=};;
+		*)
+			die "unknown option: $arg";;
+	esac
+done
+
+# find the refs to carry along and get sha1s for each.
+refs=
+fullrevargs=
+for arg in $gitrevargs ; do
+	#ignore options and basis refs, get unambiguous ref name for things
+	# we will transport (e.g., user gives master, have heads/master and
+	# remotes/origin/master, we keep the former).
+	case "$arg" in
+		-*) fullrevargs="$fullrevargs $arg";;
+		^*) fullrevargs="$fullrevargs $arg";;
+		*)	ref=$(git-show-ref "$arg" | head -n1)
+			[ -z "$ref" ] && die "unknown reference: $arg"
+			fullrevargs="$fullrevargs ${ref#* }"
+			refs="$refs $ref"
+			;;
+	esac
+done
+[ -z "$refs" ] && die "No references specified, I don't know what to bundle."
+
+# git-rev-list cannot determine edge objects if a date restriction is given...
+# we do things a slow way if max-age or min-age are given
+fast=
+[ "${fullrevargs##*--max-age}" == "$fullrevargs" ] && \
+[ "${fullrevargs##*--min-age}" == "$fullrevargs" ] && fast=1
+
+if [ -z "$fast" ] ; then
+	# get a list of all commits that will be packed along with parents of each.
+	# A fixed git-rev-list --boundary should replace all of this.
+	echo "Finding prerequisites and commits to bundle..."
+	commits=$(git-rev-list $fullrevargs)
+	
+	# get immediate parents of each commit to include
+	parents=
+	for c in $commits ; do
+		parents="$parents $(git-rev-list --parents $c | head -1 | cut -b42-)"
+	done
+	parents=$(printf "%s\n" $parents | sort | uniq)
+	
+	# factor out what will be in this bundle, the remainder are the bundle's pre-requisites.
+	# double up commits in this as we only want things that are only in parents to appear once
+	prereqs=$(printf "%s\n" $parents $commits $commits | \
+		sort | \
+		uniq -c | \
+		grep ' 1 ' \
+		| sed 's/ *1 //')
+else
+	prereqs=$(git-rev-list --objects-edge $fullrevargs | \
+		grep '^-' | sed 's/-//')
+fi
+
+# create refs and pack
+[ -e "$bfile" ] && rm -f "$bfile" 2>/dev/null
+printf "%s\n" $prereqs > .gitBundleReferences
+echo "-" >> .gitBundleReferences
+git-show-ref $refs >> .gitBundleReferences
+(git-rev-list --objects $fullrevargs | \
+	cut -b-40 | \
+	git pack-objects --all-progress --stdout >.gitBundlePack) \
+	|| (rm -f "$bfile" ; exit)
+tar cf "$bfile"  .gitBundleReferences .gitBundlePack
+tar cf "$bfile"  .gitBundleReferences .gitBundlePack
+rm .gitBundleReferences .gitBundlePack
+
+# done
+echo "Created $bfile"
-- 
1.5.0.34.g6afaa
