From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 8/9] notes: Empty notes should be shown by 'git log'
Date: Sun,  9 Nov 2014 13:30:54 +0100
Message-ID: <1415536255-19961-9-git-send-email-johan@herland.net>
References: <1415536255-19961-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, mackyle@gmail.com, jhf@trifork.com,
	sunshine@sunshineco.com, Johan Herland <johan@herland.net>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 09 13:31:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnRec-00085I-77
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 13:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbaKIMbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 07:31:32 -0500
Received: from mail-la0-f42.google.com ([209.85.215.42]:49803 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbaKIMbR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 07:31:17 -0500
Received: by mail-la0-f42.google.com with SMTP id gq15so6541810lab.1
        for <git@vger.kernel.org>; Sun, 09 Nov 2014 04:31:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mOBrMJNQ9QQ4I6UAm4h5QjHTyjrQByAK5sFGz871Sjs=;
        b=JVQB0GpmG9AL5d+L2+FvnUwNh6lKyY6lmEsAia36s4KL8O6bS8GuLhP7m2PnW1Hbb9
         paEc0va9sbdX/vD68v87ki3VP76hSijly+kMpboMyYZ4gb3dihJuBnFCQn4WWpCthEFp
         F98Ex96PvBp0v//3fzWAFsHBPvwV8DGz6EjxQ4yrIerZ4I0NGGVUQ2t0wq2xMh/6MQMC
         H2lPmyzV4EOj843dkqprRzNUbvetkE8rxEGkgEkKDEAtPSTf0vOsOUepkxQY+MsPJF7v
         nz9FY/IGK3YqaJtihZmECo8h3tFjHWFeSJjuHSc8Tz2ATsAA/5o1dxlv/rvUgNmpPhGr
         DGVA==
X-Received: by 10.112.138.39 with SMTP id qn7mr23199648lbb.57.1415536276522;
        Sun, 09 Nov 2014 04:31:16 -0800 (PST)
Received: from beta.herland (245.37-191-128.fiber.lynet.no. [37.191.128.245])
        by mx.google.com with ESMTPSA id l7sm4555178lah.27.2014.11.09.04.31.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Nov 2014 04:31:15 -0800 (PST)
X-Mailer: git-send-email 2.1.1.392.g062cc5d
In-Reply-To: <1415536255-19961-1-git-send-email-johan@herland.net>
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
2.1.1.392.g062cc5d
