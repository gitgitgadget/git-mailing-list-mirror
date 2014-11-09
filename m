From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 2/9] t3301: Verify that 'git notes' removes empty notes by default
Date: Sun,  9 Nov 2014 13:30:48 +0100
Message-ID: <1415536255-19961-3-git-send-email-johan@herland.net>
References: <1415536255-19961-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	sunshine@sunshineco.com, Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 09 13:31:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnReJ-0007k1-22
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 13:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbaKIMbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 07:31:12 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:35100 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbaKIMbG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 07:31:06 -0500
Received: by mail-la0-f50.google.com with SMTP id hs14so195878lab.9
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 04:31:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RsI8bIXHkbz1mDoVz8Sdqq3kR1xppPbLRTPns28aIck=;
        b=GkXkvVvtcoLGDom84MRA8CP6gM7M/L1mr5KxtiZSDl9cM+UmPANuNh/q5pYr9jZBzc
         jpNOI4YGF+aHygFyEYfhP/wsH2KCzwb5Dr1o/TpDODPAu1TU3sy9KH7a1MbV2iQxe00l
         kT7opGnZjpTKprlrG8gsjZ5Sf7/0oZjLEtU6i1Jo3ULBzc7NsBBE4M1sxpjTNQQnmItt
         ANPJVuQtPsdIzwGhCzT1RjZjR1OaO0hnkCGyN1OqF8nGNEMNRr8GjcNvgheUbHYpTTHB
         u7MHsf/A55vIsTHH0jeWyISb66GPi6q3GVYVTIn2TS/SA6Ob/mBjFXmo5o/GXKj4cI37
         ISOQ==
X-Received: by 10.112.148.130 with SMTP id ts2mr23490836lbb.43.1415536265032;
        Sun, 09 Nov 2014 04:31:05 -0800 (PST)
Received: from beta.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id l7sm4555178lah.27.2014.11.09.04.31.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Nov 2014 04:31:04 -0800 (PST)
X-Mailer: git-send-email 2.1.1.392.g062cc5d
In-Reply-To: <1415536255-19961-1-git-send-email-johan@herland.net>
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
index cfd67ff..f74b3fa 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1239,4 +1239,31 @@ test_expect_success 'git notes get-ref (--ref)' '
 	test "$(GIT_NOTES_REF=refs/notes/bar git notes --ref=baz get-ref)" = "refs/notes/baz"
 '
 
+test_expect_success 'setup testing of empty notes' '
+	test_unconfig core.notesRef &&
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
2.1.1.392.g062cc5d
