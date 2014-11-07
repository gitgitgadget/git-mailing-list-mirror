From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 2/5] t3301: Verify that 'git notes' removes empty notes by default
Date: Fri,  7 Nov 2014 10:19:18 +0100
Message-ID: <1415351961-31567-3-git-send-email-johan@herland.net>
References: <1415351961-31567-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 07 10:19:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmfhk-0007Bk-Km
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 10:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbaKGJTh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 04:19:37 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:57683 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaKGJTe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 04:19:34 -0500
Received: by mail-la0-f41.google.com with SMTP id s18so4073347lam.14
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 01:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jsn6xugSmiRS+5s1hS5p7gtRh7Aj7jno0NoybHEHj00=;
        b=BL8mD5Eig+Zp6niN+hoFYAhPL4NqkVP50QX1tJiyO/rXKSesMMEvdHQ+2tx/XpdZVP
         CrkSW37MgVau+JKjN6yvSVZJ7l29ZSq8/yb9785Js8sZnIRB6AkXs/Tw8jxy4Y0kBu+u
         7qnvYlrVZO5cokkkH+tS5nKmTfEt4Lzn9j1XyqjUoVyoIxvFGY8UtOoBX/FajjND75oI
         teKDskxwCRXgRi6musEXoF3ldDssQ5xBRB+fQWEsP2OFkt2lUrN21tS0lqaxvmX6+2Gh
         JjboOTgA4sbXYCZO7IOZa1feLgbCA7hCnmxSpGTZJnQwWq/JQto3CSiMODjsFRZyqNqT
         4dmg==
X-Received: by 10.112.132.34 with SMTP id or2mr10075792lbb.75.1415351972675;
        Fri, 07 Nov 2014 01:19:32 -0800 (PST)
Received: from alpha.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id 8sm3081897lav.15.2014.11.07.01.19.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Nov 2014 01:19:31 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
In-Reply-To: <1415351961-31567-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test cases documenting the current behavior when trying to
add/append/edit empty notes. This is in preparation for adding
--allow-empty; to allow empty notes to be stored.

Improved-by: Eric Sunshine <sunshine@sunshineco.com>
Improved-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t3301-notes.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index cfd67ff..33f0558 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1239,4 +1239,31 @@ test_expect_success 'git notes get-ref (--ref)' '
 	test "$(GIT_NOTES_REF=refs/notes/bar git notes --ref=baz get-ref)" = "refs/notes/baz"
 '
 
+test_expect_success 'setup testing of empty notes' '
+	git config --unset core.notesRef &&
+	test_commit 16th &&
+	empty_blob=$(git hash-object -w /dev/null)
+'
+
+while read cmd
+do
+	test_expect_success "'git notes $cmd' removes empty note" "
+		test_might_fail git notes remove HEAD &&
+		MSG= git notes $cmd &&
+		test_must_fail git notes list HEAD
+	"
+done <<\EOF
+add
+add -F /dev/null
+add -m ""
+add -c "$empty_blob"
+add -C "$empty_blob"
+append
+append -F /dev/null
+append -m ""
+append -c "$empty_blob"
+append -C "$empty_blob"
+edit
+EOF
+
 test_done
-- 
2.0.0.rc4.501.gdaf83ca
