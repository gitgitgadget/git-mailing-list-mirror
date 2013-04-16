From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [Resend PATCH] t3903 (stash): add failing test for ref of form ^{/message}
Date: Tue, 16 Apr 2013 23:39:25 +0530
Message-ID: <1366135765-18437-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 16 20:09:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USAK8-0006a7-MF
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 20:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752917Ab3DPSJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 14:09:40 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:65360 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab3DPSJj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 14:09:39 -0400
Received: by mail-pa0-f44.google.com with SMTP id bi5so478248pad.31
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 11:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=4/DoIqYvhL7ehn9RhjkgCjUxoV2rDl9c6uAGVHWO2qE=;
        b=KGpqsBe0zZzpuiU54RG+L1hhUZkm90HZry8XYDg/ws7kxupG831+VXEiy1qeLB4UGC
         BJjk2KVllS9U5wB7HpKk8r9fjsSvVfrf9vR8sFSh1Gidr0WVoXLuQUiTxUVqvafTZXOR
         aqVcLZgfpW3uxvNmhhp7rqg7IU84NRBTyoWaXWq0c/2YWZQSc5TihTzvuCQQwupp6ub/
         EK0DhrAoXE2IroSLn4N8wpaApTPceaK2oiNDGt+oB8XYXvjJhDS0BUSe7OC0WnB2csbN
         Q4oiNQ9gf86GpOeiiNxJRltGq1jfm7zMGqYERAz2vTiTFivSy4wKCBFAW0iIiykdiQxN
         X8Yg==
X-Received: by 10.68.1.138 with SMTP id 10mr4939241pbm.136.1366135779058;
        Tue, 16 Apr 2013 11:09:39 -0700 (PDT)
Received: from localhost.localdomain ([122.164.25.24])
        by mx.google.com with ESMTPS id g8sm3589400pae.7.2013.04.16.11.09.37
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 16 Apr 2013 11:09:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.390.g924f6c3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221442>

While a 'git stash show stash^{/quuxery}' works just fine, a 'git
stash pop stash^{/quuxery}' complains with: 'stash^{/quuxery} is not a
stash reference'.  This confusing behavior arises from the differences
in logic that 'show' and 'pop' internally employ to validate the
specified ref.  Document this bug by adding a failing testcase for it.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 So sorry about misspelling Junio's address in my previous email.
 Please respond to this one instead.

 So if you look at git-stash.sh:377, you'll notice that it's doing a
 the shell substitution "${REV%@*}" to figure out whether the stash
 ref is a valid ref.  This hacky myopic design has to be done away
 with immediately, and we should really compare the SHA-1 hex of the
 specified ref with those in the stash reflog.

 The only reason I haven't written a fix yet is because I'm not sure
 why you need this convoluted IS_STASH_LIKE and IS_STASH_REF logic in
 the first place.  Can someone enlighten me as to what is going on?

 t/t3903-stash.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 5dfbda7..04ba983 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -583,6 +583,15 @@ test_expect_success 'invalid ref of the form stash@{n}, n >= N' '
 	git stash drop
 '
 
+test_expect_failure 'valid ref of the form stash^{/message}' '
+	git stash clear &&
+	echo bar > file &&
+	git add file &&
+	git stash save "quuxery" &&
+	git stash show stash^{/quuxery} &&
+	git stash pop stash^{/quuxery}
+'
+
 test_expect_success 'stash branch should not drop the stash if the branch exists' '
 	git stash clear &&
 	echo foo >file &&
-- 
1.8.2.1.390.g924f6c3.dirty
