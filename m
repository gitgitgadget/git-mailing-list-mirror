From: Luke Diamand <luke@diamand.org>
Subject: [PATCH v2 2/3] git-p4: small fix for locked-file-move-test
Date: Sat,  4 Apr 2015 09:46:02 +0100
Message-ID: <1428137163-13219-3-git-send-email-luke@diamand.org>
References: <1428137163-13219-1-git-send-email-luke@diamand.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Blair Holloway <Blair_Holloway@playstation.sony.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 04 10:47:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeJjK-0008Lm-Ut
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 10:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752284AbbDDIq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 04:46:57 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:34788 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348AbbDDIqo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 04:46:44 -0400
Received: by wgbdm7 with SMTP id dm7so126688706wgb.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2015 01:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ek8fh7ukC63qdpz1+cW1WQ25jXftK76kIiUKfOGGIoY=;
        b=PyGh51Cie5KKMeSBYCXidtnHTFDVnpD8xTkYSU99R7/0IFBeW3JnLrc2ezlJxqvV4/
         mJKco28zkjDBJR93MKMPLMdCMXKWFM9zodOPv+EFHGtatnum06hx6EwVO47iK/8bx1gQ
         wQpdDB+TRq7+mIzebKunriiV27ZC0sJCyumpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ek8fh7ukC63qdpz1+cW1WQ25jXftK76kIiUKfOGGIoY=;
        b=Jr1BF5407zS/LxpzhgGqYRkIjzEhEQtJ0gIaQgCJ/1tt7RVAk0yJcWx3fFi/XQgD67
         QnX8zSRWUc2cn9SvE7B0rXRq82iu+XPf+a2c2pStvFzt6nudJ9nqlxAMnX/tAbaaporW
         mvYiXGqpHo6kh4rpqSV6nBbsm6xb5NZdftFCj5GO42HrJV767FGAe7kzQFwuocWTjAKD
         syRKUNm0CeAs9/AUGbhmYiQOtXs91tvs7lNjVxvjcpgTHniRekcb27xV/k4PsVDMJflz
         W3F2chK9+Tt34tMrIT/zFSOVgbioaBjK5cQmsQPKGcKY7PZOjOkPBC+aSUhChocw7Ae0
         KwXQ==
X-Gm-Message-State: ALoCoQkAl70dIfO0xZW2IZOH0ujZ5EMHarzm4u6WG0jcdImx5icIuV0sgIMAsquiOPBna9Jc/Oct
X-Received: by 10.194.243.9 with SMTP id wu9mr12428599wjc.107.1428137203071;
        Sat, 04 Apr 2015 01:46:43 -0700 (PDT)
Received: from ethel.local.diamand.org (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id s7sm2455742wjy.2.2015.04.04.01.46.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Apr 2015 01:46:42 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
In-Reply-To: <1428137163-13219-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266773>

The test for handling of failure when trying to move a file
that is locked by another client was not quite correct - it
failed early on because the target file in the move already
existed.

The test now fails because git-p4 does not properly detect
that p4 has rejected the move, and instead just crashes. At
present, git-p4 has no support for detecting that a file
has been locked and reporting it to the user, so this is
the expected outcome.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9816-git-p4-locked.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9816-git-p4-locked.sh b/t/t9816-git-p4-locked.sh
index ce0eb22..464f10b 100755
--- a/t/t9816-git-p4-locked.sh
+++ b/t/t9816-git-p4-locked.sh
@@ -130,8 +130,8 @@ test_expect_failure 'move with lock taken' '
 	git p4 clone --dest="$git" //depot &&
 	(
 		cd "$git" &&
-		git mv file1 file2 &&
-		git commit -m "mv file1 to file2" &&
+		git mv file1 file3 &&
+		git commit -m "mv file1 to file3" &&
 		git config git-p4.skipSubmitEdit true &&
 		git config git-p4.detectRenames true &&
 		git p4 submit --verbose
-- 
2.3.4.48.g223ab37
