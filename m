From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 3/7] contrib/subtree: Add --unannotate
Date: Tue,  8 Jan 2013 06:09:53 -0600
Message-ID: <1357646997-28675-4-git-send-email-greened@obbligato.org>
References: <1357646997-28675-1-git-send-email-greened@obbligato.org>
Cc: James Nylen <jnylen@gmail.com>,
	"David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 13:11:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsY1u-0002Uz-UC
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 13:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984Ab3AHMLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 07:11:07 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:51753 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755857Ab3AHMLF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 07:11:05 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TsY8s-0003z5-I4; Tue, 08 Jan 2013 06:18:55 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1357646997-28675-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -2.9 (--)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: James Nylen <jnylen@gmail.com> Teach git-subtree about
    --unannotate. This option strips a prefix from a commit message when doing
    a subtree split. Signed-off-by: James Nylen <jnylen@gmail.com> [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212961>

From: James Nylen <jnylen@gmail.com>

Teach git-subtree about --unannotate.  This option strips a prefix
from a commit message when doing a subtree split.

Signed-off-by: James Nylen <jnylen@gmail.com>

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/git-subtree.sh     |   11 +++++++++--
 contrib/subtree/git-subtree.txt    |   15 +++++++++++++++
 contrib/subtree/t/t7900-subtree.sh |   12 ++++++++++--
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 5341b36..cac0680 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -21,6 +21,7 @@ P,prefix=     the name of the subdir to split out
 m,message=    use the given message as the commit message for the merge commit
  options for 'split'
 annotate=     add a prefix to commit message of new commits
+unannotate=   remove a prefix from new commit messages (supports bash globbing)
 b,branch=     create a new branch from the split subtree
 ignore-joins  ignore prior --rejoin commits
 onto=         try connecting new tree to an existing one
@@ -43,6 +44,7 @@ onto=
 rejoin=
 ignore_joins=
 annotate=
+unannotate=
 squash=
 message=
 
@@ -80,6 +82,8 @@ while [ $# -gt 0 ]; do
 		-d) debug=1 ;;
 		--annotate) annotate="$1"; shift ;;
 		--no-annotate) annotate= ;;
+		--unannotate) unannotate="$1"; shift ;;
+		--no-unannotate) unannotate= ;;
 		-b) branch="$1"; shift ;;
 		-P) prefix="$1"; shift ;;
 		-m) message="$1"; shift ;;
@@ -314,8 +318,11 @@ copy_commit()
 			GIT_COMMITTER_NAME \
 			GIT_COMMITTER_EMAIL \
 			GIT_COMMITTER_DATE
-		(echo -n "$annotate"; cat ) |
-		git commit-tree "$2" $3  # reads the rest of stdin
+		(
+			read FIRST_LINE
+			echo "$annotate${FIRST_LINE#$unannotate}"
+			cat  # reads the rest of stdin
+		) | git commit-tree "$2" $3
 	) || die "Can't copy commit $1"
 }
 
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index c5bce41..75aa690 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -198,6 +198,21 @@ OPTIONS FOR split
 	git subtree tries to make it work anyway, particularly
 	if you use --rejoin, but it may not always be effective.
 
+--unannotate=<annotation>::
+	This option is only valid for the split command.
+
+	When generating synthetic history, try to remove the prefix
+	<annotation> from each commit message (using bash's "strip
+	shortest match from beginning" command, which supports
+	globbing).  This makes sense if you format library commits
+	like "library: Change something or other" when you're working
+	in your project's repository, but you want to remove this
+	prefix when pushing back to the library's upstream repository.
+	(In this case --unannotate='*: ' would work well.)
+	
+	Like --annotate,  you need to use the same <annotation>
+	whenever you split, or you may run into problems.
+
 -b <branch>::
 --branch=<branch>::
 	This option is only valid for the split command.
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 3f17f55..de45e34 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -143,7 +143,7 @@ test_expect_success 'merge fetched subproj' '
 
 test_expect_success 'add main-sub5' '
         create subdir/main-sub5 &&
-        git commit -m "main-sub5"
+        git commit -m "subproj: main-sub5"
 '
 
 test_expect_success 'add main6' '
@@ -153,7 +153,7 @@ test_expect_success 'add main6' '
 
 test_expect_success 'add main-sub7' '
         create subdir/main-sub7 &&
-        git commit -m "main-sub7"
+        git commit -m "subproj: main-sub7"
 '
 
 test_expect_success 'fetch new subproj history' '
@@ -226,6 +226,14 @@ test_expect_success 'check hash of split' '
         check_equal ''"$new_hash"'' "$subdir_hash"
 '
 
+test_expect_success 'check --unannotate' '
+        spl1=$(git subtree split --unannotate='"subproj:"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin) &&
+        undo &&
+        git subtree split --unannotate='"subproj:"' --prefix subdir --onto FETCH_HEAD --branch splitunann &&
+        check_equal ''"$(git rev-parse splitunann)"'' "$spl1" &&
+        check_equal ''"$(git log splitunann | grep subproj)"'' ""
+'
+
 test_expect_success 'check split with --branch for an existing branch' '
         spl1=''"$(git subtree split --annotate='"'*'"' --prefix subdir --onto FETCH_HEAD --message "Split & rejoin" --rejoin)"'' &&
         undo &&
-- 
1.7.10.4
