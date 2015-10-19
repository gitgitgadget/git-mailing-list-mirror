From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 29/34] mailinfo: move cleanup_space() before its users
Date: Mon, 19 Oct 2015 00:28:46 -0700
Message-ID: <1445239731-10677-30-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:30:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4tO-000365-48
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbbJSH3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:54 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34332 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027AbbJSH33 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:29 -0400
Received: by padhk11 with SMTP id hk11so21779648pad.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=beTQO0aW18W87LNm0RKCBXuvzGER7mI/nE9WQG60WVc=;
        b=sq4ZM5xPce5ChcLGMeZ6n/8JvCljawuFSvGmbw0U08lyVo0cUo5+1NIEDAJfuXVqfC
         tTtBfMSz+1LROx55Zqvu04Ki/StpsuslN3GJZ0h2+hCHVp6Wws/Su6s2JhRmVmjuY+HF
         TGuq5gDNbAprIiQ9TIqk276BJev8Z7F5Oomg2VPb9Bv0f8C9o7C2I5hxQgHsh9MYDyif
         2uodrxC/IHVUTCCspEqNKxKZJ3ZxA/afNvzjp5LiXK/xQJOvOAuGAi47hkAz3aN5ft1R
         CNChqH3FNT9BUjvxFgPzHPSwI7CVjOD3myu7aB5HtlGzZP8Kp19nzKpHDtbVdZTdYcTE
         xNsQ==
X-Received: by 10.66.222.70 with SMTP id qk6mr33371848pac.68.1445239769073;
        Mon, 19 Oct 2015 00:29:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id es4sm34475739pbc.42.2015.10.19.00.29.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:28 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279851>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 6fc6aa8..104d3d9 100644
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
2.6.2-383-g144b2e6
