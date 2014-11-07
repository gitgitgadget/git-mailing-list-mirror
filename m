From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 4/5] notes: Empty notes should be shown by 'git log'
Date: Fri,  7 Nov 2014 10:19:20 +0100
Message-ID: <1415351961-31567-5-git-send-email-johan@herland.net>
References: <1415351961-31567-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Nov 07 10:19:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmfhv-0007O8-7n
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 10:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbaKGJTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 04:19:42 -0500
Received: from mail-la0-f48.google.com ([209.85.215.48]:63145 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbaKGJTi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 04:19:38 -0500
Received: by mail-la0-f48.google.com with SMTP id gq15so4163225lab.35
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 01:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4PtCQ1FSBOVIvjheq8pPbrAa9sAV5tNBT+MwVFpSlCQ=;
        b=mtGgG0Lb0/4r/X5Az8/NSBiKJyBzwTsJDSwArrURrg1R88rWM4qYUn6fLGpeJ9H2v7
         X9rRJGLCsmQanrAwF//SwyKC3ZSogtFwh1cGavZEbJQr16MXFpbo7pm+d85QEmn/wlB8
         XkhWiQkvSBOD/vt02qAVEHPcUIOH0Px/Pkr/aDNsjxkXqWRpGG3qu/QDoCl6YtALekHA
         OZVNEr4kOgLyfsiifSolwndqu2S413apmH54x5E5fk904A6dyNYwalfgAHQaUpHtqEXu
         D/TOZCmnV1j7c+AhQuXvvg1Y0R6WArJNeZFk5NtgcB6QuhZYENzeM9o0n2BgGWQ68xYk
         fFEw==
X-Received: by 10.152.7.229 with SMTP id m5mr10240514laa.32.1415351976896;
        Fri, 07 Nov 2014 01:19:36 -0800 (PST)
Received: from alpha.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id 8sm3081897lav.15.2014.11.07.01.19.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Nov 2014 01:19:35 -0800 (PST)
X-Mailer: git-send-email 2.0.0.rc4.501.gdaf83ca
In-Reply-To: <1415351961-31567-1-git-send-email-johan@herland.net>
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
index 8280a1a..f5d8193 100755
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
