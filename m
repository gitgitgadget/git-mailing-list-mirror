From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] t4203: fix checks for email address remapping
Date: Fri, 12 Jul 2013 20:35:09 -0400
Message-ID: <1373675709-40486-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 13 02:35:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxnoS-0000x5-LN
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jul 2013 02:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067Ab3GMAfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 20:35:37 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35240 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757968Ab3GMAf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 20:35:27 -0400
Received: by mail-ie0-f171.google.com with SMTP id qd12so21563786ieb.2
        for <git@vger.kernel.org>; Fri, 12 Jul 2013 17:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=IJjQBuOtTEYWG8zr/C4hIO7D8uXhLMeM3NtuCQJjujw=;
        b=EVlXWaADCq40AMHV6s8qYotJ0Fio4u2wE3yxWcxWiSY7EK7jgreDlTLs70HIfr8T+3
         6V/02oErRsOaKSNliwv01u/V3KQXAqpnL7p8KeUPP0oMrTx6pxkESDKUxsfwqbbafusz
         qqar4dOnGMVhpDhmID1hxumjidc7MuSsYYvgmhArVldVLOK/P6RQLGlBuV/agP8I3yDw
         5xg0OZqTZEYrRBep+BKp4zASxQbl8DPhhTTmd5Wc5CXN4ELFDRjHYtBOxYaj/A97cT/J
         hRhUGH0IRQ8fGAABYnDZO3KFc2lXXsqaVkxSrTDXjs92OGMp+DMmUCmtieyYQGRYm8hm
         D7YQ==
X-Received: by 10.43.67.3 with SMTP id xs3mr13340160icb.45.1373675726846;
        Fri, 12 Jul 2013 17:35:26 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ht10sm2473607igb.2.2013.07.12.17.35.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jul 2013 17:35:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.804.g0da7a53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230269>

Two tests in t4203-mailmap.sh set up the mapping <bugs@company.xx> =>
<bugs@company.xy> in an apparent attempt to check that email address
remapping works as expected (in addition to name remapping which is also
tested).  To test the remapping, git-shortlog is invoked but the
invocation lacks the -e option instructing it to show email addresses,
hence the tests do not actually prove that address remapping succeeded.
Fix this by instructing git-shortlog to output email addresses as well.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

The very last git-shortlog "complex" test in the script does use -e and
checks that email address remapping actually works, so it's not clear
that this patch is needed. The <bugs@company.xx> => <bugs@company.xy>
remapping done by the two tests touched by this patch, however, is
misleading to the reader since it seems to imply that these two tests
want to check address remapping as well. Perhaps a better change would
be to remove the address remapping from these two tests.


 t/t4203-mailmap.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 842b754..3cf64de 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -102,10 +102,10 @@ test_expect_success 'mailmap.file non-existent' '
 '
 
 cat >expect <<\EOF
-Internal Guy (1):
+Internal Guy <bugs@company.xy> (1):
       second
 
-Repo Guy (1):
+Repo Guy <author@example.com> (1):
       initial
 
 EOF
@@ -114,15 +114,15 @@ test_expect_success 'name entry after email entry' '
 	mkdir -p internal_mailmap &&
 	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap &&
 	echo "Internal Guy <bugs@company.xx>" >>internal_mailmap/.mailmap &&
-	git shortlog HEAD >actual &&
+	git shortlog -e HEAD >actual &&
 	test_cmp expect actual
 '
 
 cat >expect <<\EOF
-Internal Guy (1):
+Internal Guy <bugs@company.xy> (1):
       second
 
-Repo Guy (1):
+Repo Guy <author@example.com> (1):
       initial
 
 EOF
@@ -131,7 +131,7 @@ test_expect_success 'name entry after email entry, case-insensitive' '
 	mkdir -p internal_mailmap &&
 	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap &&
 	echo "Internal Guy <BUGS@Company.xx>" >>internal_mailmap/.mailmap &&
-	git shortlog HEAD >actual &&
+	git shortlog -e HEAD >actual &&
 	test_cmp expect actual
 '
 
-- 
1.8.3.2.804.g0da7a53
