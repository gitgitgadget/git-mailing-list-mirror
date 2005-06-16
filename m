From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] fix scalability problems with git-deltafy-script
Date: Wed, 15 Jun 2005 22:59:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0506152238210.1667@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 16 04:59:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DikaN-0005LG-2Z
	for gcvg-git@gmane.org; Thu, 16 Jun 2005 04:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVFPDCr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Jun 2005 23:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbVFPDAZ
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jun 2005 23:00:25 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9100 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261709AbVFPC7g
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2005 22:59:36 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0II500J0TPN740@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 15 Jun 2005 22:59:31 -0400 (EDT)
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Current version would spin forever  and exhaust memory while 
attempting to sort all files from all revisions at once, until it
dies before even doing any real work.  This is especially noticeable 
when used on a big repository like the imported  bkcvs repo for the
Linux kernel.

This patch allows for batching the sort to put a bound on needed 
resources and making progress early, as well as including some small
cleanups.

Signed-off-by: Nicolas Pitre <nico@cam.org>

diff --git a/git-deltafy-script b/git-deltafy-script
--- a/git-deltafy-script
+++ b/git-deltafy-script
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-# Example script to deltafy an entire GIT repository based on the commit list.
+# Example script to deltify an entire GIT repository based on the commit list.
 # The most recent version of a file is the reference and previous versions
 # are made delta against the best earlier version available. And so on for
 # successive versions going back in time.  This way the increasing delta
@@ -25,37 +25,51 @@
 
 set -e
 
-depth=
-[ "$1" == "-d" ] && depth="--max-depth=$2" && shift 2
+max_depth=
+[ "$1" == "-d" ] && max_depth="--max-depth=$2" && shift 2
+
+overlap=30
+max_behind="--max-behind=$overlap"
 
 function process_list() {
 	if [ "$list" ]; then
 		echo "Processing $curr_file"
-		echo "$head $list" | xargs git-mkdelta $depth --max-behind=30 -v
+		echo "$list" | xargs git-mkdelta $max_depth $max_behind -v
 	fi
 }
 
+rev_list=""
 curr_file=""
 
 git-rev-list HEAD |
-git-diff-tree -r -t --stdin |
-awk '/^:/ { if ($5 == "M" || $5 == "N") print $4, $6;
-            if ($5 == "M") print $3, $6 }' |
-LC_ALL=C sort -s -k 2 | uniq |
-while read sha1 file; do
-	if [ "$file" == "$curr_file" ]; then
-		list="$list $sha1"
-	else
-		process_list
-		curr_file="$file"
-		list=""
-		head="$sha1"
-	fi
+while true; do
+	# Let's batch revisions into groups of 1000 to give it a chance to
+	# scale with repositories containing long revision lists.  We also
+	# overlap with the previous batch the size of mkdelta's look behind
+	# value in order to account for the processing discontinuity.
+	rev_list="$(echo -e -n "$rev_list" | tail --lines=$overlap)"
+	for i in $(seq 1000); do
+		read rev || break
+		rev_list="$rev_list$rev\n"
+	done
+	echo -e -n "$rev_list" |
+	git-diff-tree -r -t --stdin |
+	awk '/^:/ { if ($5 == "M") printf "%s %s\n%s %s\n", $4, $6, $3, $6 }' |
+	LC_ALL=C sort -s -k 2 | uniq |
+	while read sha1 file; do
+		if [ "$file" == "$curr_file" ]; then
+			list="$list $sha1"
+		else
+			process_list
+			curr_file="$file"
+			list="$sha1"
+		fi
+	done
+	[ "$rev" ] || break
 done
 process_list
 
 curr_file="root directory"
-head=""
 list="$(
 	git-rev-list HEAD |
 	while read commit; do
