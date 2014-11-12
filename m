From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 8/9] notes: Empty notes should be shown by 'git log'
Date: Wed, 12 Nov 2014 01:40:15 +0100
Message-ID: <1415752816-22782-9-git-send-email-johan@herland.net>
References: <1415752816-22782-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	sunshine@sunshineco.com, peff@peff.net, blume.mike@gmail.com,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 12 01:40:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoLzU-0005vi-KR
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 01:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbaKLAkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 19:40:49 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:43141 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506AbaKLAko (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 19:40:44 -0500
Received: by mail-la0-f46.google.com with SMTP id gm9so10293375lab.5
        for <git@vger.kernel.org>; Tue, 11 Nov 2014 16:40:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4o9eKWZ5p5ptln33WLKawBxrlBewzJRXVA5FzkyQDMk=;
        b=IbqkERSYTXwjiYBgwDUm7In7GaxG0ui4q0L8EfCpgIvjn8U9p1HIm1+sCpgAJP1RD6
         NuvIFyDkUke6nHjAoxPe6Y3IH40ChwAOmqur4815Ia8zogKwXKQqyI+SZi/BcNwL6VlP
         LlYI+ZdYj3ODBQvbdknewTe0cpnvFu3yRNxqHHMo5Q2LOrHHpvXey5+FTjdL3VY6hWs7
         jTP9uqM+ylUxno5dhp7itYE5myTRcB2X276UWWaPcwH0RjMlXeCY53gT8wsoB1Jo6d3n
         ndye8MDe6FiiUGZuxVwqEqMjIuA403gyycDMrNjQwfJ1h/W2ljy9CxTCiepFwzxAyf2B
         fYHQ==
X-Received: by 10.152.7.229 with SMTP id m5mr39496414laa.32.1415752843519;
        Tue, 11 Nov 2014 16:40:43 -0800 (PST)
Received: from alpha.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id 8sm6341174lav.15.2014.11.11.16.40.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Nov 2014 16:40:42 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
In-Reply-To: <1415752816-22782-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the user has gone through the trouble of explicitly adding an empty
note, then "git log" should not silently skip it (as if it didn't exist).

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c          |  3 +--
 t/t3301-notes.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/notes.c b/notes.c
index 5fe691d..62bc6e1 100644
--- a/notes.c
+++ b/notes.c
@@ -1218,8 +1218,7 @@ static void format_note(struct notes_tree *t, const unsigned char *object_sha1,
 	if (!sha1)
 		return;
 
-	if (!(msg = read_sha1_file(sha1, &type, &msglen)) || !msglen ||
-			type != OBJ_BLOB) {
+	if (!(msg = read_sha1_file(sha1, &type, &msglen)) || type != OBJ_BLOB) {
 		free(msg);
 		return;
 	}
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 70ec5c3..416ed9e 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1274,4 +1274,16 @@ append -C "$empty_blob"
 edit
 EOF
 
+test_expect_success 'empty notes are displayed by git log' '
+	test_commit 17th &&
+	git log -1 >expect &&
+	cat >>expect <<\EOF &&
+
+Notes:
+EOF
+	git notes add -C "$empty_blob" --allow-empty &&
+	git log -1 >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.0.0.rc4.501.gdaf83ca
