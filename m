From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2] am: gather GIT_AUTHOR_* from original commit when rebasing
Date: Tue, 15 Jun 2010 18:39:24 -0400
Message-ID: <1276641564-2074-1-git-send-email-jaysoffian@gmail.com>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <junio@kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 16 00:39:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOenD-0008En-03
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 00:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186Ab0FOWje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 18:39:34 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57748 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873Ab0FOWjd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 18:39:33 -0400
Received: by gwj15 with SMTP id 15so3657962gwj.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 15:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=mFjnTGnud6RYAhpctjEsC0yQ827x+0XBs49/th/tEik=;
        b=va9+kqf58oZu6vWcTbcqTNqitg7S+qj2MepUhaLvcAmu/KtsS94Gq2efpBoH2FLvGA
         Gd1SlW7RMxGfLZivQJGeCPAzCYEDNCWBTOnMpn0j6Bwd9+PxbW3D2EoYCHdMQUPU4UWU
         4Ts+/vqXl8SjWZTOTet1iBj8URZ4ShQwEYLKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=fkPu9meud4sRff5352RVdiZog33RZM5Rpmlrat9veZOTZlHCEbmLtZq8BSVEe1r2rY
         lzv79SytpgC3CpuMMaB+c6k6Fm/nid3W/iEbEp4y6moJgGNvqcKIp3PgwnFJcQPJVRuK
         v/IY/xuUTn6FmIyxV/4MS/U/DPIWkrBFIP1ws=
Received: by 10.150.246.23 with SMTP id t23mr8924115ybh.331.1276641571724;
        Tue, 15 Jun 2010 15:39:31 -0700 (PDT)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id p37sm42322117ybk.38.2010.06.15.15.39.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 15 Jun 2010 15:39:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149239>

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
 git-am.sh         |   14 +++++++++++---
 t/t3400-rebase.sh |    9 +++++++--
 2 files changed, 18 insertions(+), 5 deletions(-)

This is a second take at 
http://article.gmane.org/gmane.comp.version-control.git/148568

diff --git a/git-am.sh b/git-am.sh
index 87ffae2..568844c 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -613,9 +613,17 @@ do
 		;;
 	esac
 
-	GIT_AUTHOR_NAME="$(sed -n '/^Author/ s/Author: //p' "$dotest/info")"
-	GIT_AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' "$dotest/info")"
-	GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
+	if test -f "$dotest/original-commit"
+	then
+		original_commit="$(cat "$dotest/original-commit")"
+		GIT_AUTHOR_NAME="$(GIT_PAGER='' git log --format=%an -1 "$original_commit")"
+		GIT_AUTHOR_EMAIL="$(GIT_PAGER='' git log --format=%ae -1 "$original_commit")"
+		GIT_AUTHOR_DATE="$(GIT_PAGER='' git log --format=%aD -1 "$original_commit")"
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
