From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH 3/4] Head reduction before selecting merge strategy
Date: Tue, 25 Mar 2008 19:58:26 -0800
Message-ID: <402c10cd0803252058k2f35b33fr99ec7446235eeb6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 04:59:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeMn9-0006PR-4n
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 04:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbYCZD63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 23:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753146AbYCZD63
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 23:58:29 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:37912 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbYCZD62 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 23:58:28 -0400
Received: by fg-out-1718.google.com with SMTP id l27so3826710fgb.17
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 20:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=7YUuG9msdIdoCa8rnuVTWqn2KjB5TQtdY8F8CtkbNc0=;
        b=bBlk4BwGsnhFRwb0QdLGasnMIMZhVojvwxQbVGFRaKmhmcVyeqchmkPTlGiuS26vSDUGEPqDwlHjLZeZhgT663vOZ2vDgSWipIDsSH4M2oKBuxSdAHAZyInFAZKJqrMEESvR/uoh7wjGtjWLJNq0UGKNRjhs18ei1a6cQHNcVKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HN+cOvHEjnx2PYXpjYNUGmjyRJgTMeL81yAtMTo43ML4j1WdY2xWLbkBadLtzB1HuLuz+l6KF6EDf8t+YIMC2JW+OgiyhkD0eq2EnGezfR844p1DmxQkK6yLmR4pt3E8j7NUIKs4ikBCbPV3eUsqTjZSBhlhZ5DVR7JyN6lxOro=
Received: by 10.82.121.15 with SMTP id t15mr22971796buc.31.1206503906461;
        Tue, 25 Mar 2008 20:58:26 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Tue, 25 Mar 2008 20:58:26 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78253>

See the documentation for an explanation of this feature.

Signed-off-by: Sverre Hvammen Johansen <hvammen@gmail.com>
---
 Documentation/git-merge.txt |   43 +++++++++++++++++++++++-
 git-merge.sh                |   76 +++++++++++++++++++++++++++++--------------
 2 files changed, 93 insertions(+), 26 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 2af33d8..e94d26b 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -36,7 +36,7 @@ include::merge-options.txt[]
 <remote>::
        Other branch head merged into our branch.  You need at
        least one <remote>.  Specifying more than one <remote>
-       obviously means you are trying an Octopus.
+       usually means you are trying an Octopus.


 include::fast-forward-options.txt[]
@@ -133,6 +133,47 @@ merge (which is typically a fraction of the whole
tree), you can
 have local modifications in your working tree as long as they do
 not overlap with what the merge updates.

+If more than one commit are specified for the merge, git will try to
+reduce the number of commits (real parents) by eliminating commits
+than can be reached from other commits.  The commit message will
+reflect the actual commits specified but the merge strategy will be
+selected based on the real parents, but always including `HEAD`.  The
+real parents (only including `HEAD` if it is real) are the parents
+recorded in the merge commit object.
+
+The following shows master and three topic branches.  topicB is based
+on topicA, topicA is previously branched off from master, and topicC
+is based on the current `HEAD` of master:
+
+------------
+                    o---o---o  topicB
+                   /
+          o---o---o  topicA
+         /
+    o---o---o---o---o---o  master
+                         \
+                          o---o  topicC
+------------
+
+A merger of master with topicA, topicB, and topicC will select the
+merge strategy based on the three branches master, topicB, and topicC
+(topicA is eliminated since it can be reached from topicB).  topicB
+and topicC are the only real parents and are therefore the only
+parents recorded in the merge commit object:
+
+------------
+         % git checkout master
+         % git merge topicA topicB topicC
+
+                    o---o---o  topicB
+                   /         \
+          o---o---o  topicA   \
+         /                     \
+    o---o---o---o---o---o       o  master
+                         \     /
+                          o---o  topicC
+------------
+
 When there are conflicts, these things happen:

 1. `HEAD` stays the same.
diff --git a/git-merge.sh b/git-merge.sh
index 2acd2cc..5398606 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -209,24 +209,41 @@ parse_config () {

 # Find real parents
 # Set the following variables as followd:
-#   real_parents: The parents specified on the command line
+#   real_parents: The real parents except fast forward of head
 #   common:       All common ancestors or not_queried
 #   ff_head:      Fast forward of head
 find_real_parents () {
-       real_parents=$(git rev-parse "$@")
-       real_parents=${real_parents#$LF}
-       if test $# = 1
+       if test $fast_forward = never
        then
-               common=$(git merge-base --all $head "$@")
-               if test "$common" = $head
+               real_parents=$(git rev-parse "$@")
+               ff_head=$head
+               common=not_queried
+       else
+               if test $# = 1
                then
-                       ff_head=$1
+                       common=$(git merge-base --all $head "$1")
+                       if test "$common" = $head
+                       then
+                               real_parents=
+                               ff_head=$1
+                       elif test "$common" = "$1"
+                       then
+                               real_parents=
+                               ff_head=$head
+                       else
+                               real_parents=$1
+                               ff_head=$head
+
+                       fi
                else
-                       ff_head=$head
+                       real_parents=$(git show-branch --independent $head "$@")
+                       # Here we may actually lie about which bransh
is ff of head.
+                       # This will preserve the order the user gave.
+                       ff_head=${real_parents%%$LF*}
+                       real_parents=${real_parents#$ff_head}
+                       real_parents=${real_parents#$LF}
+                       common=not_queried
                fi
-       else
-               common=not_queried
-               ff_head=$head
        fi
 }

@@ -319,6 +336,12 @@ set x $remoteheads ; shift

 find_real_parents "$@"

+if test -n "$real_parents"
+then
+       test $head = $ff_head ||
+               real_parents="$ff_head$LF$real_parents"
+fi
+
 case "$use_strategies" in
 '')
        case "$real_parents" in
@@ -366,13 +389,13 @@ done

 echo "$head" >"$GIT_DIR/ORIG_HEAD"

-if true
+if test -z "$real_parents"
 then
-       if test $head = $ff_head -a "$common" = "$real_parents"
+       if test $head = $ff_head
        then
                finish_up_to_date "Already up-to-date."
                exit 0
-       elif test $fast_forward != never -a $ff_head = "$real_parents"
+       elif test $fast_forward != never
        then
                echo "Updating $(git rev-parse --short $head)..$(git
rev-parse --short $ff_head)"
                git update-index --refresh 2>/dev/null
@@ -386,6 +409,14 @@ then
                finish "$new_head" "$msg" || exit
                dropsave
                exit 0
+       else
+               real_parents="$ff_head"
+               ff_head=$head
+       fi
+else
+       if test $head != $ff_head -a $fast_forward = never
+       then
+               real_parents="$ff_head$LF$real_parents"
        fi
 fi

@@ -500,17 +531,12 @@ done
 # auto resolved the merge cleanly.
 if test '' != "$result_tree"
 then
-    if test $fast_forward = allow
-    then
-        parents=$(git show-branch --independent "$head" "$@")
-    else
-        parents=$(git rev-parse "$head" "$@")
-    fi
-    parents=$(echo "$parents" | sed -e 's/^/-p /')
-    result_commit=$(printf '%s\n' "$merge_msg" | git commit-tree
$result_tree $parents) || exit
-    finish "$result_commit" "Merge made by $wt_strategy."
-    dropsave
-    exit 0
+       test $head = $ff_head && real_parents="$head$LF$real_parents"
+       parents=$(echo "$real_parents" | sed -e 's/^/-p /')
+       result_commit=$(printf '%s\n' "$merge_msg" | git commit-tree
$result_tree $parents) || exit
+       finish "$result_commit" "Merge made by $wt_strategy."
+       dropsave
+       exit 0
 fi

 # Pick the result from the best strategy and have the user fix it up.

-- 
Sverre Hvammen Johansen
