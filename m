From: Ben Walton <bdwalton@gmail.com>
Subject: [PATCH] Use wc instead of awk to count subtrees in t0090-cache-tree
Date: Mon, 22 Dec 2014 17:52:24 +0000
Message-ID: <1419270744-1408-1-git-send-email-bdwalton@gmail.com>
Cc: git@vger.kernel.org, Ben Walton <bdwalton@gmail.com>
To: gitster@pobox.com, dturner@twopensource.com
X-From: git-owner@vger.kernel.org Mon Dec 22 19:51:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3857-0005gK-15
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 19:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbaLVSvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 13:51:44 -0500
Received: from jimi.chass.utoronto.ca ([128.100.160.32]:40976 "EHLO
	jimi.chass.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134AbaLVSvo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 13:51:44 -0500
X-Greylist: delayed 3574 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Dec 2014 13:51:44 EST
Received: from hendrix.chass.utoronto.ca ([128.100.160.33]:34790 ident=93)
	  by jimi.chass.utoronto.ca with esmtp  (Exim 4.76)
	 (envelope-from <bdwalton@benandwen.net>)
	 id 1Y379N-0001Dj-4k ; Mon, 22 Dec 2014 12:52:09 -0500
Received: from 86-42-148-151-dynamic.b-ras1.bbh.dublin.eircom.net ([86.42.148.151]:57385 helo=neilyoung)
	 (auth info: dovecot_plain:bwalton@chass.utoronto.ca) by hendrix.chass.utoronto.ca with esmtpsa (TLSv1:AES128-SHA:128)
	 (Exim 4.76)
	 (envelope-from <bdwalton@benandwen.net>)
	 id 1Y379K-0006Kb-Ey ; Mon, 22 Dec 2014 12:52:06 -0500
Received: from bdwalton by neilyoung with local (Exim 4.82)
	(envelope-from <bdwalton@benandwen.net>)
	id 1Y379e-0000NJ-0H; Mon, 22 Dec 2014 17:52:26 +0000
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261666>

The awk statements previously used in this test weren't compatible
with the native versions of awk on Solaris:

echo "dir" | /bin/awk -v c=0 '$1 {++c} END {print c}'
awk: syntax error near line 1
awk: bailing out near line 1

echo "dir" | /usr/xpg4/bin/awk -v c=0 '$1 {++c} END {print c}'
0

And with GNU awk for comparison:
echo "dir" | /opt/csw/gnu/awk -v c=0 '$1 {++c} END {print c}'
1

Instead of modifying the awk code to work, use wc -w instead as that
is both adequate and simpler.

Signed-off-by: Ben Walton <bdwalton@gmail.com>
---
 t/t0090-cache-tree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index 067f4c6..f2b1c9c 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -22,7 +22,7 @@ generate_expected_cache_tree_rec () {
 	# ls-files might have foo/bar, foo/bar/baz, and foo/bar/quux
 	# We want to count only foo because it's the only direct child
 	subtrees=$(git ls-files|grep /|cut -d / -f 1|uniq) &&
-	subtree_count=$(echo "$subtrees"|awk -v c=0 '$1 {++c} END {print c}') &&
+	subtree_count=$(echo "$subtrees"|wc -w) &&
 	entries=$(git ls-files|wc -l) &&
 	printf "SHA $dir (%d entries, %d subtrees)\n" "$entries" "$subtree_count" &&
 	for subtree in $subtrees
-- 
1.9.1
