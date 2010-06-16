From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v3] am: use get_author_ident_from_commit instead of mailinfo when rebasing
Date: Wed, 16 Jun 2010 03:12:40 -0400
Message-ID: <1276672360-15816-1-git-send-email-jaysoffian@gmail.com>
References: <4C186F9D.1060608@viscovery.net>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <junio@kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 16 09:13:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOmoG-0002T5-To
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 09:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758568Ab0FPHNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 03:13:11 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:49648 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709Ab0FPHNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 03:13:09 -0400
Received: by gwj15 with SMTP id 15so3799407gwj.19
        for <git@vger.kernel.org>; Wed, 16 Jun 2010 00:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NvSgJDRyt1SSb16bQFCSUpeJSPXHFBJK+ubMFR2ntK0=;
        b=eCW3RvTM3t/NsuJNGw/mXDZOlGnNhmTHsjDvlUSXy+3ZMJ1CuJFIdDq7uG5m9yYvOw
         SCKy9jVhW19pJmgngWaI0sKEUxfxrm/x8baxqzjUeV8fqNLAkcUns+iZjdBPpLlYrUga
         Edzk0mDoMVNNM/UwkAL+QL8tyoR3doHhx39ug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VEdZGlvTQxYNnN1r3gsmRfJmqKCtXLZ/gDJdaU6laRbPJ7hwUhuwxTBkRTbMkz9U4I
         pfy1oLvXNwjFkO07PEsx5q0BScMFU44BC7qB7fOeJzvwq70n3NAn7PUA1V0831ol0Ohx
         s9op5VwtOgQYgP6pZws3XLP4aGEt19rMT0OFY=
Received: by 10.150.254.16 with SMTP id b16mr9308846ybi.432.1276672381183;
        Wed, 16 Jun 2010 00:13:01 -0700 (PDT)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id w6sm44988780ybe.5.2010.06.16.00.12.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Jun 2010 00:12:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <4C186F9D.1060608@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149253>

In certain situations, commit authorship can consist of an invalid
e-mail address. For example, this is the case when working with git svn
repos where the author email has had the svn repo UUID appended such as:

 author@example.com <author@example.com@deadbeef-dead-beef-dead-beefdeadbeef>

Given such an address, mailinfo extracts the authorship incorrectly as
it assumes a valid domain. However, when rebasing the original
authorship should be preserved irrespective of its validity as an email
address.

Using get_author_ident_from_commit instead of mailinfo when rebasing
preserves the original authorship.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 git-am.sh         |   14 ++++++++++----
 t/t3400-rebase.sh |    9 +++++++--
 2 files changed, 17 insertions(+), 6 deletions(-)

Incorporated Hannes' suggestion to use get_author_ident_from_commit.

diff --git a/git-am.sh b/git-am.sh
index 87ffae2..1df5b04 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -593,7 +593,7 @@ do
 			echo "Patch is empty.  Was it split wrong?"
 			stop_here $this
 		}
-		rm -f "$dotest/original-commit"
+		rm -f "$dotest/original-commit" "$dotest/author-script"
 		if test -f "$dotest/rebasing" &&
 			commit=$(sed -e 's/^From \([0-9a-f]*\) .*/\1/' \
 				-e q "$dotest/$msgnum") &&
@@ -602,6 +602,7 @@ do
 			git cat-file commit "$commit" |
 			sed -e '1,/^$/d' >"$dotest/msg-clean"
 			echo "$commit" > "$dotest/original-commit"
+			get_author_ident_from_commit "$commit" > "$dotest/author-script"
 		else
 			{
 				sed -n '/^Subject/ s/Subject: //p' "$dotest/info"
@@ -613,9 +614,14 @@ do
 		;;
 	esac
 
-	GIT_AUTHOR_NAME="$(sed -n '/^Author/ s/Author: //p' "$dotest/info")"
-	GIT_AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' "$dotest/info")"
-	GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
+	if test -f "$dotest/author-script"
+	then
+		eval $(cat "$dotest/author-script")
+	else
+		GIT_AUTHOR_NAME="$(sed -n '/^Author/ s/Author: //p' "$dotest/info")"
+		GIT_AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' "$dotest/info")"
+		GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
+	fi
 
 	if test -z "$GIT_AUTHOR_EMAIL"
 	then
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
