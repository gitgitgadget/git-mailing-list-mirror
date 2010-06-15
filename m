From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] am: gather GIT_AUTHOR_* from original commit when rebasing
Date: Tue, 15 Jun 2010 18:18:12 -0400
Message-ID: <1276640292-78522-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 16 00:18:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOeSs-0008B4-QM
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 00:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943Ab0FOWS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 18:18:28 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61513 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab0FOWS1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 18:18:27 -0400
Received: by gye5 with SMTP id 5so3634352gye.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=x3DhoDEaFOgn9omFmg2v0LHIFLzBm6u68a+hSTpU+2Q=;
        b=BBFT5WdYIr13PBaDeK7IzGCD+ppXE3ZCHex7d/wEqbtcAFfgsUT3VLNZFy0H15TR8G
         a1hVO/I/qIclLP5tM7z5QMuI72CPpEK75BgLbIcUlDjaJ7UVJTmtcS6+BC5rKGOF4ZON
         CUyGRB/FGmQ2JQhMn6xgvJ3utvHn2baqU0k4A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=C+AxMtqCW6SyJkBTDjYxUpJkpbghCwVJEBYhOiPrzGMxoJdvfZ7M27nSlkNe/PIExk
         f2QA9C+mFN4t5JV1cOrYbAtlD6nv5ZhuwsT8xavcTNSm5dY8LHYc6mYPEnJBy9UYvGWi
         kf4BQMVNAXm8xCG0kfcia1iuJulU0O87UD7w0=
Received: by 10.150.132.2 with SMTP id f2mr9273720ybd.74.1276640306313;
        Tue, 15 Jun 2010 15:18:26 -0700 (PDT)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id j3sm42236455ybe.19.2010.06.15.15.18.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Jun 2010 15:18:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149231>

In certain situations, commit authorship can contain an invalid
e-mail address. For example, this is the case when working with git
svn repos where the author email has the svn repo UUID appended such
as:

 author@example.com <author@example.com@deadbeef-dead-beef-dead-beefdeadbeef>

In such situations, mailinfo extracts the authorship incorrectly
as it assumes a valid email address.

Regardless, when rebasing the original authorship should be
preserved irrespective of its validity as an email address.

This commit teaches am to gather the GIT_AUTHOR_* variables
from the original commit, bypassing any of mailinfo's assumptions.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 git-am.sh         |   10 ++++++----
 t/t3400-rebase.sh |    9 +++++++--
 2 files changed, 13 insertions(+), 6 deletions(-)

This is a second take at 
http://article.gmane.org/gmane.comp.version-control.git/148568

diff --git a/git-am.sh b/git-am.sh
index 87ffae2..d009d84 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -602,6 +602,9 @@ do
 			git cat-file commit "$commit" |
 			sed -e '1,/^$/d' >"$dotest/msg-clean"
 			echo "$commit" > "$dotest/original-commit"
+			GIT_AUTHOR_NAME="$(GIT_PAGER='' git log --format=%an -1 "$commit")"
+			GIT_AUTHOR_EMAIL="$(GIT_PAGER='' git log --format=%ae -1 "$commit")"
+			GIT_AUTHOR_DATE="$(GIT_PAGER='' git log --format=%aD -1 "$commit")"
 		else
 			{
 				sed -n '/^Subject/ s/Subject: //p' "$dotest/info"
@@ -609,14 +612,13 @@ do
 				cat "$dotest/msg"
 			} |
 			git stripspace > "$dotest/msg-clean"
+			GIT_AUTHOR_NAME="$(sed -n '/^Author/ s/Author: //p' "$dotest/info")"
+			GIT_AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' "$dotest/info")"
+			GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
 		fi
 		;;
 	esac
 
-	GIT_AUTHOR_NAME="$(sed -n '/^Author/ s/Author: //p' "$dotest/info")"
-	GIT_AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' "$dotest/info")"
-	GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
-
 	if test -z "$GIT_AUTHOR_EMAIL"
 	then
 		echo "Patch does not have a valid e-mail address."
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index dbf7dfb..c41bcc7 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -10,8 +10,9 @@ among other things.
 '
 . ./test-lib.sh
 
-GIT_AUTHOR_EMAIL=bogus_email_address
-export GIT_AUTHOR_EMAIL
+GIT_AUTHOR_NAME=author@name
+GIT_AUTHOR_EMAIL=bogus@email@address
+export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
 
 test_expect_success \
     'prepare repository with topic branches' \
@@ -80,6 +81,10 @@ test_expect_success \
     'the rebase operation should not have destroyed author information' \
     '! (git log | grep "Author:" | grep "<>")'
 
+test_expect_success \
+    'the rebase operation should not have destroyed author information (2)' \
+    "git log -1 | grep 'Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>'"
+
 test_expect_success 'HEAD was detached during rebase' '
      test $(git rev-parse HEAD@{1}) != $(git rev-parse my-topic-branch@{1})
 '
-- 
1.7.1
