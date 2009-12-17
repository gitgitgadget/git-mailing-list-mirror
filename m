From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] am: fix patch format detection for Thunderbird "Save As" emails
Date: Thu, 17 Dec 2009 15:58:19 -0800
Message-ID: <1261094299-22930-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 00:58:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLQEt-0004z1-1g
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 00:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbZLQX6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 18:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbZLQX62
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 18:58:28 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:46529 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbZLQX6X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 18:58:23 -0500
Received: by yxe17 with SMTP id 17so2439919yxe.33
        for <git@vger.kernel.org>; Thu, 17 Dec 2009 15:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=9C8XjIm1JiuXikkmt+lOjYRX+BnIzid6B4TrtZmwMXo=;
        b=CYEqS5yCBewf6uJRuhulyhoVRa7w3yMmkMnWNOLsISRSlVRKggBTYSe7HoNyTDuuto
         hCOJk9D5cXPtciSn3nsev4MNAUmspOCGyPUBUDRTXpvBOC4MDT1gwpQCHFYoupYcT7Or
         1h/eo+EtPPR+13nHhL85nFAhRCuMo0Eq5FslY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=fbHQ06hUsh1lyqLqdqvLFsAhcaCJg2rQc0/L5htBilNqs3bRfFesuupBV+1kJChtXd
         35kWMSh1djGotVPKl1Oj1bZYiiJK7NYlSu5fvqYRNM4iI9nTcT18E/5PwMaBySihqR2x
         kDkVFhfmkjkc/fSADbZqkMM6rgGHGNYEInXPs=
Received: by 10.90.39.13 with SMTP id m13mr2701228agm.36.1261094302843;
        Thu, 17 Dec 2009 15:58:22 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 23sm926729ywh.33.2009.12.17.15.58.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Dec 2009 15:58:22 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc3.1.g8df51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135387>

The patch detection wants to inspect all the headers of a rfc2822 message
and ensure that they look like header field names. The headers are always
separated from the message body with a blank line. When Thunderbird3 saves
the message the blank line separating the headers from the body includes a
CR. The patch detection is failing because a CRLF doesn't match /^$/. Fix
this by allowing a CR to exist on the separating line.
---

I'm not sure how portable \r in a sed invocation is. Perhaps just checking
that l1, l2, and l3 are rfc2822 header fields (or indented lines) is better
than trying to check all of the headers?

This seems related to

  am fails to apply patches for files with CRLF lineendings
  http://article.gmane.org/gmane.comp.version-control.git/135229

but seems necessary because check_patch_format() is called before any
splitting with mailsplit is done (where I assume the fix for the issue
will be done).

 git-am.sh     |    2 +-
 t/t4150-am.sh |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 4838cdb..bb106b7 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -204,7 +204,7 @@ check_patch_format () {
 			# discarding the indented remainder of folded lines,
 			# and see if it looks like that they all begin with the
 			# header field names...
-			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p "$1" |
+			sed -n -e '/^\r*$/q' -e '/^[ 	]/d' -e p "$1" |
 			sane_egrep -v '^[!-9;-~]+:' >/dev/null ||
 			patch_format=mbox
 		fi
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 8296605..578bc81 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -83,6 +83,12 @@ test_expect_success setup '
 		echo "X-Fake-Field: Line Three" &&
 		git format-patch --stdout first | sed -e "1d"
 	} > patch1.eml &&
+	{
+		echo "X-Fake-Field: Line One" &&
+		echo "X-Fake-Field: Line Two" &&
+		echo "X-Fake-Field: Line Three" &&
+		git format-patch --stdout first | sed -e "1d"
+	} | sed -e "s/$/\r/" > patch1-crlf.eml &&
 	sed -n -e "3,\$p" msg >file &&
 	git add file &&
 	test_tick &&
@@ -123,6 +129,15 @@ test_expect_success 'am applies patch e-mail not in a mbox' '
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
 '
 
+test_expect_success 'am applies patch e-mail not in a mbox with CRLF' '
+	git checkout first &&
+	git am patch1-crlf.eml &&
+	! test -d .git/rebase-apply &&
+	test -z "$(git diff second)" &&
+	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
+	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
+'
+
 GIT_AUTHOR_NAME="Another Thor"
 GIT_AUTHOR_EMAIL="a.thor@example.com"
 GIT_COMMITTER_NAME="Co M Miter"
-- 
1.6.6.rc3.1.g8df51
