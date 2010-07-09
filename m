From: Nazri Ramliy <ayiehere@gmail.com>
Subject: [PATCH 2/2] rebase -i: Preserve whitespace at beginning of commit header in $GIT_EDITOR
Date: Fri,  9 Jul 2010 13:20:43 +0800
Message-ID: <1278652843-30872-2-git-send-email-ayiehere@gmail.com>
References: <1278652843-30872-1-git-send-email-ayiehere@gmail.com>
Cc: johannes.schindelin@gmx.de, Nazri Ramliy <ayiehere@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 09 07:21:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX61j-0007Rb-6i
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 07:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202Ab0GIFV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 01:21:26 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:42756 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120Ab0GIFVX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 01:21:23 -0400
Received: by pxi14 with SMTP id 14so628571pxi.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 22:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7U3GuBIRHUX8JmLKZCl5iqP9WvH+xgIPz8TITG/GHnY=;
        b=wT+wiPBW4OHpO0fdK7ZFmulC3WLjH3F/WG0iTKInpjaL/3FGvE++7KtIbGU5B2wJy6
         TwHY8CpqdfceiJzyAbSw85/9OZn00k4dc/vBLfkKr+ZgVvZGNUWCXEY3EpbxZRGOxGHX
         1Kq8yQ2MtHuOAVuE9hHMJ2m5ifxFopk9CYqbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EAnKCAFos+rjibEeO2phw/m/uYP87mA0WibUu5FJTJMzAYY+pMLFAdYXj7JX8dwMwd
         4VnSGUj05LIIEb3JhKt8tDmqj1T8TPXQSgmcpDABfHN2KI/y8Pp3R0feqAw0O199lk7N
         hA5ezF0ZfmLEUcSqzRXxQtsn8POMfqaWteq5Q=
Received: by 10.114.103.13 with SMTP id a13mr10696796wac.151.1278652882358;
        Thu, 08 Jul 2010 22:21:22 -0700 (PDT)
Received: from localhost.localdomain ([115.134.57.99])
        by mx.google.com with ESMTPS id 33sm7732585wad.18.2010.07.08.22.21.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 22:21:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc2
In-Reply-To: <1278652843-30872-1-git-send-email-ayiehere@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150642>

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
 git-rebase--interactive.sh    |   25 ++++++++++++++-----------
 t/t3404-rebase-interactive.sh |   13 +++++++++++++
 2 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 31e6860..726cb6a 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -889,14 +889,15 @@ first and then run 'git rebase --continue' again."
 		fi
 		git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
 			--abbrev=7 --reverse --left-right --topo-order \
-			$REVISIONS | \
-			sed -n "s/^>//p" |
-		while read -r shortsha1 rest
-		do
-			if test t != "$PRESERVE_MERGES"
-			then
-				echo "pick $shortsha1 $rest" >> "$TODO"
-			else
+			$REVISIONS | sed -n "s/^>//p" > "$TODO.tmp"
+
+		if test t != "$PRESERVE_MERGES"
+		then
+			cat "$TODO.tmp" | sed "s/^/pick /" > "$TODO"
+		else
+			cat "$TODO.tmp" |
+			while read -r shortsha1 rest
+			do
 				sha1=$(git rev-parse $shortsha1)
 				if test -z "$REBASE_ROOT"
 				then
@@ -914,10 +915,12 @@ first and then run 'git rebase --continue' again."
 				if test f = "$preserve"
 				then
 					touch "$REWRITTEN"/$sha1
-					echo "pick $shortsha1 $rest" >> "$TODO"
+					grep "^$shortsha1" "$TODO.tmp" | sed "s/^/pick /" >> "$TODO"
 				fi
-			fi
-		done
+			done
+
+		fi
+		rm -f "$TODO.tmp"
 
 		# Watch for commits that been dropped by --cherry-pick
 		if test t = "$PRESERVE_MERGES"
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 47ca88f..2c3a0b9 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -648,4 +648,17 @@ test_expect_success 'rebase-i history with funny messages' '
 	test_cmp expect actual
 '
 
+cat >expect <<EOF
+pick COMMIT_ID   Commit header with beginning whitespace
+
+EOF
+
+test_expect_success 'preserve whitespace in commit summary' '
+	git checkout -b preserve-whitespace master &&
+	echo a >whitespace_test &&
+	git add whitespace_test &&
+	git commit -m"  Commit header with beginning whitespace" &&
+	REPLACE_COMMIT_ID=COMMIT_ID EXPECT_NON_COMMENT_LINES="expect" git rebase -i HEAD~1
+'
+
 test_done
-- 
1.7.2.rc2
