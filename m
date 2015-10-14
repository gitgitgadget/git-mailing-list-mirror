From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 26/31] mailinfo: move cleanup_space() before its users
Date: Wed, 14 Oct 2015 13:45:52 -0700
Message-ID: <1444855557-2127-27-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:47:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSxV-0002bU-7w
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932951AbbJNUrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:47:23 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36737 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932880AbbJNUqb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:31 -0400
Received: by pabws5 with SMTP id ws5so153646pab.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=on398EvNqibf+lfKwafYd/P0GaWBRrM/HkmINFsHr6Q=;
        b=dZafscugzn54bSsCC1Myaz6v+laz9L0J7B51uhelt3UsC16gYJ8pvwczgnep+5YmeR
         bNqFjTZffa1I7Oa57w1vUfJFTYIjy65/iMW3hNYzSFPTcmub3TV677XCLlE9Qsj94CXR
         YVvoX9mCq+xiReebYITvFzWeWn2qCWkAUrfoSq5K/wrGfcy6V0HeH7QzLyIHmp3JES5u
         5rbppNWFzwmw4w/XoTJStpoxJT1YiGp6uSqRquwHrFkqDJrTj9aS8uFeRZ/OONsoJE8x
         LO+Yw/ZYBB/fIztIl1GDqyT22GO66gWDQgdNJ7ujgry7ap4Vru3qsXJuPCJyVG6NeqwQ
         j7xw==
X-Received: by 10.68.105.193 with SMTP id go1mr5599501pbb.59.1444855591265;
        Wed, 14 Oct 2015 13:46:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id yg2sm11252556pbb.79.2015.10.14.13.46.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:30 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279612>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index ee669b9..f4771ee 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -41,8 +41,17 @@ struct mailinfo {
 
 #define MAX_HDR_PARSED 10
 
-static void cleanup_space(struct strbuf *sb);
-
+static void cleanup_space(struct strbuf *sb)
+{
+	size_t pos, cnt;
+	for (pos = 0; pos < sb->len; pos++) {
+		if (isspace(sb->buf[pos])) {
+			sb->buf[pos] = ' ';
+			for (cnt = 0; isspace(sb->buf[pos + cnt + 1]); cnt++);
+			strbuf_remove(sb, pos + 1, cnt);
+		}
+	}
+}
 
 static void get_sane_name(struct strbuf *out, struct strbuf *name, struct strbuf *email)
 {
@@ -281,18 +290,6 @@ static void cleanup_subject(struct mailinfo *mi, struct strbuf *subject)
 	strbuf_trim(subject);
 }
 
-static void cleanup_space(struct strbuf *sb)
-{
-	size_t pos, cnt;
-	for (pos = 0; pos < sb->len; pos++) {
-		if (isspace(sb->buf[pos])) {
-			sb->buf[pos] = ' ';
-			for (cnt = 0; isspace(sb->buf[pos + cnt + 1]); cnt++);
-			strbuf_remove(sb, pos + 1, cnt);
-		}
-	}
-}
-
 static const char *header[MAX_HDR_PARSED] = {
 	"From","Subject","Date",
 };
-- 
2.6.1-320-g86a1181
