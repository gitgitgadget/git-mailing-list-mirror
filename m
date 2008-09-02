From: David Aguilar <davvid@gmail.com>
Subject: [RFC/PATCH] git-mergetool: allow using merge tools for staging changes
Date: Tue,  2 Sep 2008 00:25:49 -0700
Message-ID: <ca72cec5020d847ac7d1577c586772ae22810bef.1220339887.git.davvid@gmail.com>
Cc: git@vger.kernel.org, tytso@mit.edu,
	David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 02 09:34:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaQP9-0000bd-Vs
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 09:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbYIBHdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 03:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752359AbYIBHdR
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 03:33:17 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:40257 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbYIBHdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 03:33:16 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2135161rvb.1
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 00:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=aDwc0WveG2NSpce3Z/i7Q4p0r440DKMhqluptTRXkCg=;
        b=O8dnZWLtZYruvD1X3S6s1W3xdlNq/+op+l/mliFw93TKQnyF0f0HZg03K+uBIDEcqd
         qGZwdeeDVVPNiYwU4TJ6crPo2LdfRPweCL32nJxzMF0y+r0b9tiVis+ldOXSWb5Hx252
         DTG0d2Fo/MalPVTrdgKLIWexHlrJf4EwObflc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Zd8DiXwfpQUjwTt71NK+MMGZgLv01Z0Cx4Eo8IaPGyygyla64qT7qUbx9Xyy6iYZqB
         sobx8wkny7A2BS27BCebvc4xLOPHgcnV7Mg7PZWpCHIAtGLEcWKX0EBa3JcNC0pMYAOw
         EX67BRE8qPjX+11N9e1nSlk3QHyYXVFxPoSlM=
Received: by 10.141.78.14 with SMTP id f14mr3974386rvl.76.1220340795625;
        Tue, 02 Sep 2008 00:33:15 -0700 (PDT)
Received: from localhost ( [208.106.56.2])
        by mx.google.com with ESMTPS id b8sm12167495rvf.4.2008.09.02.00.33.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Sep 2008 00:33:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.1.161.g7f314
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94660>

git-mergetool contains a lot of useful code for interfacing
with arbitrary diff/merge tools.  This code is only ever used
when merge conflicts occur, though.

This change allows git-mergetool to be used for the common
task of comparing unstaged changes against the latest commit.
Being able to see side-by-side diffs in your favorite $mergetool
is the benefit of these changes.

When additional changes are staged in the index, those changes
are provided as the $BASE merge file.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Notes:

I am aware that git-citool is a viable alternative in such a
scenario, but being able to see a side-by-side diff is one of
the first things that CVS-using co-workers asked me about
when using git.

This only affects the "git mergetool -t <tool> <file(s)>"
scenario.  The behavior of the no-argument "git mergetool"
invocation is unchanged.

Style note:

This patch mixes tabs and spaces (indent: 4) to be consistent
with the rest of git-mergetool.sh.

 git-mergetool.sh |   32 ++++++++++++++++++++++++++------
 1 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 94187c3..9e5cc68 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -131,6 +131,13 @@ merge_file () {
     MERGED="$1"
 
     f=`git ls-files -u -- "$MERGED"`
+
+    if test -z "$f" ; then
+	f=$(git ls-files --modified -- "$MERGED")
+	test -z "$f" && f=$(git diff --name-only --cached -- "$MERGED")
+	test -f "$f" && worktree_mode=1
+    fi
+
     if test -z "$f" ; then
 	if test ! -f "$MERGED" ; then
 	    echo "$MERGED: file not found"
@@ -149,13 +156,26 @@ merge_file () {
     mv -- "$MERGED" "$BACKUP"
     cp -- "$BACKUP" "$MERGED"
 
-    base_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}'`
-    local_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}'`
-    remote_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}'`
+    if test -n "$worktree_mode" ; then
+	base_mode=$(git diff --name-only --cached -- "$MERGED")
+	local_mode=1
+	remote_mode=1
+	cp "$MERGED" "$LOCAL"
+	git show HEAD:"$MERGED" > "$REMOTE"
+	if base_present ; then
+	    # If changes are present in the index use them as $BASE
+	    git checkout-index --prefix=.remote- "$MERGED"
+	    mv .remote-"$MERGED" "$BASE"
+	fi
+    else
+	base_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}'`
+	local_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}'`
+	remote_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}'`
 
-    base_present   && git cat-file blob ":1:$prefix$MERGED" >"$BASE" 2>/dev/null
-    local_present  && git cat-file blob ":2:$prefix$MERGED" >"$LOCAL" 2>/dev/null
-    remote_present && git cat-file blob ":3:$prefix$MERGED" >"$REMOTE" 2>/dev/null
+	base_present   && git cat-file blob ":1:$prefix$MERGED" >"$BASE" 2>/dev/null
+	local_present  && git cat-file blob ":2:$prefix$MERGED" >"$LOCAL" 2>/dev/null
+	remote_present && git cat-file blob ":3:$prefix$MERGED" >"$REMOTE" 2>/dev/null
+    fi
 
     if test -z "$local_mode" -o -z "$remote_mode"; then
 	echo "Deleted merge conflict for '$MERGED':"
-- 
1.6.0.1.161.g7f314
