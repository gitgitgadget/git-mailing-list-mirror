From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH 2/2] rebase -i: Preserve whitespace at beginning of commit header in $GIT_EDITOR
Date: Mon, 12 Jul 2010 09:04:23 +0800
Message-ID: <1278896663-3922-2-git-send-email-ayiehere@gmail.com>
References: <1278896663-3922-1-git-send-email-ayiehere@gmail.com>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de
X-From: git-owner@vger.kernel.org Mon Jul 12 03:04:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OY7Ru-0005V3-QM
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 03:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400Ab0GLBEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 21:04:42 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:55338 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab0GLBEe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 21:04:34 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so1565028pwi.19
        for <git@vger.kernel.org>; Sun, 11 Jul 2010 18:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ccae2os13m2mvfv+2il3z3fVIF0bJp88Ho+W6sK2I8U=;
        b=nKmPznC+Svn2T1ooBeH9C+lRwM0OtsemYWnxWRdR0U7KYUwQrhLu+tP6h2ni92DJA1
         fyn1j6PNGERtSGbXpL4QsHfkV5k21f1fM3wNgUqzVVhu1wiNG/MkVlPr2TFv4mifQSqx
         n8OsTGIstYB3vt2rnykukTAQm0PQs/bjGKY7I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cHKbiPsojilt+QBrHq1DaHOL5xiBSlRwpU9gUsycjIyrj/4xTvk+heRtAD/b2B7UhQ
         /Ysb5tt6voW+SE5bQ28is2sS+U5Z4/Wfqu3BtUuXUla92q1xNiqadeaU4FUK2LfVfPPE
         BXFji6JqiIKFW9z0GPH4qmzEeAbQhIjAEXiR8=
Received: by 10.142.141.20 with SMTP id o20mr15163209wfd.204.1278896674392;
        Sun, 11 Jul 2010 18:04:34 -0700 (PDT)
Received: from localhost.localdomain ([115.134.249.89])
        by mx.google.com with ESMTPS id f20sm3854387rvb.20.2010.07.11.18.04.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jul 2010 18:04:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2
In-Reply-To: <1278896663-3922-1-git-send-email-ayiehere@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150788>

During "git rebase -i", when the commit headers are shown in the editor
for action (pick/squash/etc), the whitespace (if any) at the beginning
of commit headers are stripped out due to the use of "read shortsha1 rest"
for reading the output of "git rev-list".

The missing beginning whitespace do not pose any harm but this could be
annoying when you want to identify these commits to perform actions on,
for example, rewording them to remove the beginning whitespace.

Not having the whitespace makes them hard to spot, and you have to rely
on something like "git log --oneline" to identify them.

This patch:

	1. Ensures that the commit header shown in $GIT_EDITOR is
	   identical to the actual commit header
	2. Add a test for it

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
This series is based on maint.

Running all test shows no breakage. 

 git-rebase--interactive.sh    |   17 ++++++++++-------
 t/t3404-rebase-interactive.sh |   12 ++++++++++++
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6b86abc..80991a8 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -683,6 +683,10 @@ parse_onto () {
 	git rev-parse --verify "$1^0"
 }
 
+pick () {
+	git log -1 --abbrev-commit --abbrev=7 --format="pick %h %s" $sha1
+}
+
 while test $# != 0
 do
 	case "$1" in
@@ -887,16 +891,15 @@ first and then run 'git rebase --continue' again."
 			REVISIONS=$ONTO...$HEAD
 			SHORTREVISIONS=$SHORTHEAD
 		fi
-		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
-			--abbrev=7 --reverse --left-right --topo-order \
-			$REVISIONS | \
-			sed -n "s/^>//p" | while read shortsha1 rest
+
+		git rev-list $MERGES_OPTION --reverse --left-right \
+			--topo-order $REVISIONS | sed -n "s/^>//p" |
+		while read sha1
 		do
 			if test t != "$PRESERVE_MERGES"
 			then
-				echo "pick $shortsha1 $rest" >> "$TODO"
+				pick $sha1 >> "$TODO"
 			else
-				sha1=$(git rev-parse $shortsha1)
 				if test -z "$REBASE_ROOT"
 				then
 					preserve=t
@@ -913,7 +916,7 @@ first and then run 'git rebase --continue' again."
 				if test f = "$preserve"
 				then
 					touch "$REWRITTEN"/$sha1
-					echo "pick $shortsha1 $rest" >> "$TODO"
+					pick $sha1 >> "$TODO"
 				fi
 			fi
 		done
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ee9a1b2..e346174 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -630,4 +630,16 @@ test_expect_success 'always cherry-pick with --no-ff' '
 	test_cmp empty out
 '
 
+cat >expect_header <<EOF
+  Commit header with beginning whitespace
+EOF
+
+test_expect_success 'preserve whitespace in commit summary' '
+	git checkout -b preserve-whitespace master &&
+	echo a >whitespace_test &&
+	git add whitespace_test &&
+	git commit -m"  Commit header with beginning whitespace" &&
+	EXPECT_HEADER="expect_header" git rebase -i HEAD~1
+'
+
 test_done
-- 
1.7.2.rc2
