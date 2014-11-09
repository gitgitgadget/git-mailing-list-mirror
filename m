From: Manzur Mukhitdinov <manzurmm@gmail.com>
Subject: [PATCH] replace: fix replacing object with itself
Date: Sun,  9 Nov 2014 01:05:31 +0100
Message-ID: <1415491531-29913-1-git-send-email-manzurmm@gmail.com>
Cc: Manzur Mukhitdinov <manzurmm@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 09 01:07:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnG2W-0005eu-Dy
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 01:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbaKIAH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2014 19:07:26 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37881 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbaKIAHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2014 19:07:25 -0500
Received: by mail-wi0-f169.google.com with SMTP id n3so7215443wiv.0
        for <git@vger.kernel.org>; Sat, 08 Nov 2014 16:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3Rj0xJxGZ8Uu5y3bpbSA513a45VSyo1VOPCbZT2H99w=;
        b=NPf3DkDltNMM75t+IT9CZ+kTk2WcNKunCVepC8qg0vgvfVxmZlvmraOooEkPMZ83pv
         M0Z9stig9iW4Hkb11z6Pxp6jQf8I+61YdBpCLhA0dhbYrZTvN/k5Li8uHmo2MQiY1nV5
         tu6tRNQ23i4GnRyTSSbSnnhjg7BckYdqJe/ICCEpLC2ZyO0iLUgFAYk9jtxBVJBtDo/B
         hxAekL6j2OUHRXOgzXciDMjlnBaNPV6vvPzTJiVmQEfOT9zFxAmznKQCa46iwX8atYlX
         N7/96hk4b/ywmKo61fWGinrxczMZqsD7dWZ3ge1eZNJPWuKQ5q6hqAKAwjTtHD9EBSEe
         QfZw==
X-Received: by 10.180.188.41 with SMTP id fx9mr17374443wic.59.1415491643818;
        Sat, 08 Nov 2014 16:07:23 -0800 (PST)
Received: from localhost.localdomain (a86147.upc-a.chello.nl. [62.163.86.147])
        by mx.google.com with ESMTPSA id gs9sm17107205wjc.47.2014.11.08.16.07.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 08 Nov 2014 16:07:23 -0800 (PST)
X-Mailer: git-send-email 2.1.3.2.gf4414d7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When object is replaced with itself git shows unhelpful messages like(git log):
    "fatal: replace depth too high for object <SHA1>"

Prevents user from replacing object with itself(with test for checking
this case).

Signed-off-by: Manzur Mukhitdinov <manzurmm@gmail.com>
---
 builtin/replace.c  | 3 +++
 t/t6050-replace.sh | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/builtin/replace.c b/builtin/replace.c
index 294b61b..b7e05ad 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -186,6 +186,9 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
 	if (get_sha1(replace_ref, repl))
 		die("Failed to resolve '%s' as a valid ref.", replace_ref);
 
+	if (!hashcmp(object, repl))
+		return error("new object is the same as the old one: '%s'", sha1_to_hex(object));
+
 	return replace_object_sha1(object_ref, object, replace_ref, repl, force);
 }
 
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 4d5a25e..f2b0307 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -440,4 +440,10 @@ test_expect_success GPG '--graft on a commit with a mergetag' '
 	git replace -d $HASH10
 '
 
+test_expect_success 'replacing object with itself must fail' '
+    test_must_fail git replace $HASH1 $HASH1 &&
+    HASH8=$(git rev-parse --verify HEAD) &&
+    test_must_fail git replace HEAD $HASH8
+'
+
 test_done
-- 
1.9.1
