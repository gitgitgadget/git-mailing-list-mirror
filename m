From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Subject: [PATCH 2/4] Fix cg-{diff,mkpatch} with HEAD^
Date: Fri, 02 Sep 2005 12:31:30 +0200
Message-ID: <20050902103128.24918.77004.stgit@zion.home.lan>
References: <20050902103125.24918.905.stgit@zion.home.lan>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 12:36:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EB8tQ-00024D-MD
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 12:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbVIBKfZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Sep 2005 06:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbVIBKfX
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Sep 2005 06:35:23 -0400
Received: from [151.97.230.9] ([151.97.230.9]:45282 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S1030396AbVIBKfS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Sep 2005 06:35:18 -0400
Received: (qmail 12154 invoked by uid 508); 2 Sep 2005 12:35:16 +0200
Received: from unknown (HELO ssc.unict.it) (151.97.230.9)
  by ssc.unict.it with SMTP; 2 Sep 2005 12:35:16 +0200
Received: from zion.home.lan (localhost [127.0.0.1])
	by zion.home.lan (Postfix) with ESMTP id 6866021D943;
	Fri,  2 Sep 2005 12:31:30 +0200 (CEST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050902103125.24918.905.stgit@zion.home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8016>

Supplying "HEAD^" to commit-id gives a failure; I saw this with the failure of:

$ cg-mkpatch -r HEAD^:HEAD

I wonder whether we should remove commit-id and switch to git-rev-parse
entirely, but in the meanwhile, fix it.

The problems are two ones:
*) there's an extra space at the end of the return string of cg-Xnormid.

Verify by running the command:
echo "\"$normid\""

*) the space remotion in commit-id can remove only one space, and forgets
that when calling git-cat-file -t.

Fixing either one is sufficient, but I've decided to fix both.

Also, when doing cg-diff -r HEAD^:HEAD, I've noticed that tree-id has the
same problems, and fixed it too.
I checked parent-id, and it's safe.

FIXME: I didn't add a testcase in the t/ directory.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 cg-Xnormid |    4 +++-
 commit-id  |   13 +++++++++++--
 tree-id    |   13 +++++++++++--
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/cg-Xnormid b/cg-Xnormid
--- a/cg-Xnormid
+++ b/cg-Xnormid
@@ -11,6 +11,8 @@
 # 	short SHA1 (4 or more hex digits)
 #
 # Takes the ID to normalize and returns the normalized ID.
+# Output format:
+# 40 hex digits ID, followed by _one_ space, followed by the optional ID type.
 
 . ${COGITO_LIB}cg-Xlib || exit 1
 
@@ -19,7 +21,7 @@ id="$1"
 if [ "${id:(-1):1}" = "^" ]; then
 	# parent-id
 	id=$(commit-id "${id%^}") || exit 1
-	git-cat-file commit "$id" | awk '/^parent/{print $2," "};/^$/{exit}' || exit 1
+	git-cat-file commit "$id" | awk '/^parent/{print $2 " "};/^$/{exit}' || exit 1
 	exit
 fi
 
diff --git a/commit-id b/commit-id
--- a/commit-id
+++ b/commit-id
@@ -9,8 +9,17 @@
 
 id="$1"
 normid=$(. ${COGITO_LIB}cg-Xnormid "$id") || exit 1
-type=${normid#* }; [ "$type" ] || type=$(git-cat-file -t "$normid")
-normid=${normid% *}
+# Trim beginning space; leave end one because it means we must get the type
+# ourselves.
+normid=${normid# }
+type=${normid#* }
+#Trim type.
+type=${type# }
+type=${type% }
+# Trim end space (and everything after the space) when passing to
+# git-cat-file
+normid=${normid%% *}
+[ "$type" ] || type=$(git-cat-file -t "$normid")
 
 if [ "$type" != "commit" ]; then
 	echo "Invalid commit id: $normid" >&2
diff --git a/tree-id b/tree-id
--- a/tree-id
+++ b/tree-id
@@ -7,8 +7,17 @@
 
 id="$1"
 normid=$(. ${COGITO_LIB}cg-Xnormid "$id") || exit 1
-type=${normid#* }; [ "$type" ] || type=$(git-cat-file -t "$normid")
-normid=${normid% *}
+# Trim beginning space; leave end one because it means we must get the type
+# ourselves.
+normid=${normid# }
+type=${normid#* }
+#Trim type.
+type=${type# }
+type=${type% }
+# Trim end space (and everything after the space) when passing to
+# git-cat-file
+normid=${normid%% *}
+[ "$type" ] || type=$(git-cat-file -t "$normid")
 
 if [ "$type" = "commit" ]; then
 	normid=$(git-cat-file commit "$normid" | sed -e 's/tree //;q')
