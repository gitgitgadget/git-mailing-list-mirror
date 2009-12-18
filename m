From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2] am: fix patch format detection for Thunderbird "Save As" emails
Date: Fri, 18 Dec 2009 13:34:38 -0800
Message-ID: <1261172078-9174-1-git-send-email-bebarino@gmail.com>
References: <7vtyvpcf36.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 18 22:34:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLkTK-0003Vv-8x
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 22:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932940AbZLRVep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 16:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755557AbZLRVep
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 16:34:45 -0500
Received: from mail-gx0-f211.google.com ([209.85.217.211]:60715 "EHLO
	mail-gx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786AbZLRVeo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 16:34:44 -0500
Received: by gxk3 with SMTP id 3so2455125gxk.1
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 13:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=lKd7sCAYdVoQcNhn1gHf5NYTe2wqtqYjUAqiWVLxRio=;
        b=l04qZpWreN3H0XvezGjcFdFGux7pF9TZB4b9GavaZEZdBNg4I6Tbmniuzo/n0d4oTG
         FP6DA6k1GrQT0nA6RGvxg4QsIWPlV4wMP+NsKwPF6QcnTnMqVZasun2QgchZZYcb+WDP
         aJ91pJaQCtI2UDnuK3p/GHnWamWbuiDgLtkm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XAAaGeTQ4dhK7O5y6c7xfG7zbjc0aiB2ScYQfxQUVO55Q6p3Idqn44NIhJrDGVYTTG
         Uab99xpU1Jl482WYZhVZ9ZiOYK0kaoSc7AOBc7vw5DtbYPnwMJh9+WuCm7VGkp4imMhl
         RfPZHF8O1k98AJf/A9/f9Ex7TsuuAgtC0enxQ=
Received: by 10.150.24.2 with SMTP id 2mr7266390ybx.172.1261172081987;
        Fri, 18 Dec 2009 13:34:41 -0800 (PST)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 20sm1358178yxe.20.2009.12.18.13.34.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 13:34:41 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc3.1.g8df51
In-Reply-To: <7vtyvpcf36.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135439>

The patch detection wants to inspect all the headers of a rfc2822 message
and ensure that they look like header field names. The headers are always
separated from the message body with a blank line. When Thunderbird saves
the message the blank line separating the headers from the body includes a
CR. The patch detection is failing because a CRLF doesn't match /^$/. Fix
this by allowing a CR to exist on the separating line.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Changes since v1:
 - More portable code using tr (thanks Junio)
 - More portable testing by manually adding CRLFs

 git-am.sh     |    3 ++-
 t/t4150-am.sh |   24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 4838cdb..9e64deb 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -204,7 +204,8 @@ check_patch_format () {
 			# discarding the indented remainder of folded lines,
 			# and see if it looks like that they all begin with the
 			# header field names...
-			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p "$1" |
+			tr -d '\015' <"$1" |
+			sed -n -e '/^$/q' -e '/^[ 	]/d' -e p |
 			sane_egrep -v '^[!-9;-~]+:' >/dev/null ||
 			patch_format=mbox
 		fi
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 8296605..7b6269d 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -83,6 +83,21 @@ test_expect_success setup '
 		echo "X-Fake-Field: Line Three" &&
 		git format-patch --stdout first | sed -e "1d"
 	} > patch1.eml &&
+	{
+		echo "X-Fake-Field: Line One\015" &&
+		echo "X-Fake-Field: Line Two\015" &&
+		echo "X-Fake-Field: Line Three\015" &&
+		git format-patch --stdout first |
+		sed -e "1d" -e "3,\$d" | tr -d "\n" &&
+		echo "\015" &&
+		git format-patch --stdout first |
+		sed -e "1,2d" -e "4,\$d" | tr -d "\n" &&
+		echo "\015" &&
+		git format-patch --stdout first |
+		sed -e "1,3d" -e "5,\$d" | tr -d "\n" &&
+		echo "\015\n\015" &&
+		git format-patch --stdout first | sed -e "1,5d"
+	} > patch1-crlf.eml &&
 	sed -n -e "3,\$p" msg >file &&
 	git add file &&
 	test_tick &&
@@ -123,6 +138,15 @@ test_expect_success 'am applies patch e-mail not in a mbox' '
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
