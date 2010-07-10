From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH 2/2] rebase -i: Preserve whitespace at beginning of commit header in $GIT_EDITOR
Date: Sat, 10 Jul 2010 20:27:01 +0800
Message-ID: <1278764821-32647-2-git-send-email-ayiehere@gmail.com>
References: <1278764821-32647-1-git-send-email-ayiehere@gmail.com>
Cc: Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de
X-From: git-owner@vger.kernel.org Sat Jul 10 14:27:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXZ9P-0002ak-Fp
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 14:27:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754637Ab0GJM1R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jul 2010 08:27:17 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:42145 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058Ab0GJM1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jul 2010 08:27:16 -0400
Received: by pvc7 with SMTP id 7so1227151pvc.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 05:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XNo/CELDOaN23amnY1ZgQMiKubOsQY6W6QzWvcMAZVo=;
        b=QVGUa21lFebGrySC7BwVgpGIDv+7T6dhorlZvEOqs3dRfmGWYP3TlCvQVFoLQLFOsk
         yseXGhCBnW6WxuZqDCuclpWOLzqFlKQ8q95L9s6U55Of1a97GNCNNipfcEASZUjkuDjy
         yTtsNJ4FOAZykrjFNq+wX220eY71WYq9eyhR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MwS61sft3QvdcBrcJDmoLlQ6KkxwJnig/xCCD2a1x531ZSLa25whb09fm5emnIVL6+
         1Ok5V7Z/R8BNKUaXSEd4j1fiVjwaNZ4Y1Tp9blk6YGb6jLyS28Mjmuo3ohIEO8VG0TWJ
         MjaXzIacksklfMujH42GMI2bY4nXKltFXV3tM=
Received: by 10.142.158.13 with SMTP id g13mr6982296wfe.348.1278764835991;
        Sat, 10 Jul 2010 05:27:15 -0700 (PDT)
Received: from localhost.localdomain ([115.135.170.72])
        by mx.google.com with ESMTPS id l29sm2024013rvb.19.2010.07.10.05.27.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 05:27:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2
In-Reply-To: <1278764821-32647-1-git-send-email-ayiehere@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150724>

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
	   identical to actual commit header
	2. Add a test for it

Signed-off-by: Nazri Ramliy <ayiehere@gmail.com>
---
 git-rebase--interactive.sh    |   14 ++++++--------
 t/t3404-rebase-interactive.sh |   12 ++++++++++++
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 31e6860..b13f42e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -887,17 +887,15 @@ first and then run 'git rebase --continue' again."
 			REVISIONS=$ONTO...$HEAD
 			SHORTREVISIONS=$SHORTHEAD
 		fi
-		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
-			--abbrev=7 --reverse --left-right --topo-order \
-			$REVISIONS | \
-			sed -n "s/^>//p" |
-		while read -r shortsha1 rest
+
+		git rev-list $MERGES_OPTION  --reverse --left-right --topo-order \
+			$REVISIONS | sed -n "s/^>//p" |
+		while read sha1
 		do
 			if test t != "$PRESERVE_MERGES"
 			then
-				echo "pick $shortsha1 $rest" >> "$TODO"
+				git log -1 --abbrev-commit --abbrev=7 --format="pick %h %s" $sha1 > "$TODO"
 			else
-				sha1=$(git rev-parse $shortsha1)
 				if test -z "$REBASE_ROOT"
 				then
 					preserve=t
@@ -914,7 +912,7 @@ first and then run 'git rebase --continue' again."
 				if test f = "$preserve"
 				then
 					touch "$REWRITTEN"/$sha1
-					echo "pick $shortsha1 $rest" >> "$TODO"
+					git log -1 --abbrev-commit --abbrev=7 --format="pick %h %s" $sha1 > "$TODO"
 				fi
 			fi
 		done
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 47ca88f..78d0041 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -648,4 +648,16 @@ test_expect_success 'rebase-i history with funny messages' '
 	test_cmp expect actual
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
