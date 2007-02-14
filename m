From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] git-bundle - bundle objects and references for disconnected
 transfer.
Date: Wed, 14 Feb 2007 09:10:26 -0500
Message-ID: <11714622292295-git-send-email-mdl123@verizon.net>
References: <11714622292110-git-send-email-mdl123@verizon.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 15:10:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHKq6-0002c9-7x
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 15:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbXBNOK1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 09:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbXBNOK1
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 09:10:27 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:10657 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbXBNOK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 09:10:26 -0500
Received: from fal-l07294-lp.us.ray.com ([71.246.235.75])
 by vms040.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JDG001KKI1C1R20@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 14 Feb 2007 08:10:25 -0600 (CST)
In-reply-to: <11714622292110-git-send-email-mdl123@verizon.net>
X-Mailer: git-send-email 1.5.0.rc3.24.g0c5e
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39645>

Some workflows require coordinated development between repositories on
machines that can never be connected. This utility creates a bundle
containing a pack of objects and associated references (heads or tags)
that can be independently transferred to another machine, effectively
supporting git-push like operations between disconnected systems.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 git-bundle |   85 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 85 insertions(+), 0 deletions(-)
 create mode 100755 git-bundle

diff --git a/git-bundle b/git-bundle
new file mode 100755
index 0000000..1341885
--- /dev/null
+++ b/git-bundle
@@ -0,0 +1,85 @@
+#!/bin/sh
+# Create a bundle to carry from one git repo to another (e.g., "sneaker-net" based push)
+# git-bundle <git-rev-list args>
+# git-bundle --bare <git-rev-list args>
+# creates bundle.zip in current directory (can rename of course)
+#
+# The bundle includes all refs given (--all selects every ref in the repo).
+# and all of the commit objects needed subject to the list given.
+#
+# Objects to be packed are limited by specifying one or more of
+#   ^commit-ish    - indicated commits already at the target (can have more than one ^commit-ish)
+#   --since=xxx    - Assume target repo has all relevant commits earlier than xxx
+
+USAGE='git-bundle <options> <git-rev-list arguments>
+
+Creates a bundle of objects to be carried to a disconnected repository, bringing the target
+repository''s definition of one or more references up to date as selected by the
+<git-rev-list arguments>
+
+Options:
+    -h, --help        Print this help screen
+        --bare        Work in a bare repository
+    --output=f        Output to file f (default is bundle.zip)
+
+    examples
+        git-bundle master~10..master
+        git-bundle master next pu ^master~30 --output=mybundle.zip --bare'
+
+die() {
+	echo >&2 "$@"
+	exit 1
+}
+
+# pull out rev-list args vs program args, parse the latter
+gitrevargs=$(git-rev-parse --symbolic --revs-only $*) || exit 1
+myargs=$(git-rev-parse --no-revs $*) || exit 1
+
+bfile=bundle.zip
+for arg in $myargs ; do
+	case "$arg" in
+		--bare)
+			export GIT_DIR=.;;
+		-h|--h|--he|--hel|--help)
+			echo "$USAGE"
+			exit;;
+		--output=*)
+			bfile=${arg##--output=};;
+		-*)
+			die "unknown option: $arg";;
+		*)
+	esac
+done
+
+GIT_DIR=$(git-rev-parse --git-dir) || die "Not in a git directory"
+
+# find the refs to carry along and get sha1s for each.
+refs=
+for arg in $gitrevargs ; do
+	#ignore options and basis refs
+	case "$arg" in
+		^*) ;;
+		-*) ;;
+		*)
+			n=$(git-show-ref "$arg" | wc -l)
+			[ $n -eq 1 ] || die "ambiguous reference: $arg"
+			refs="$refs $arg"
+			;;
+	esac
+done
+[ -z "$refs" ] && die "No references specified, I don't know what to bundle."
+
+# put the refs into the bundle file
+[ -e "$bfile" ] && rm -f "$bfile" 2>/dev/null
+git-show-ref $refs > .gitBundleReferences
+zip -m "$bfile" .gitBundleReferences
+
+# add the pack file
+(git-rev-list --objects $gitrevargs | \
+	cut -b -40 | \
+	git pack-objects --all-progress --progress --stdout >.gitBundlePack) \
+	|| (rm -f "$bfile" ; exit)
+zip -m "$bfile" .gitBundlePack
+
+# done
+echo "Created $bfile"
-- 
1.5.0.rc3.24.g0c5e
