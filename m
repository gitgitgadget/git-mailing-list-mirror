From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 10/15] ref-filter: introduce parse_align_position()
Date: Tue,  5 Jan 2016 13:33:09 +0530
Message-ID: <1451980994-26865-11-git-send-email-Karthik.188@gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:03:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGMaJ-0007yM-B0
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 09:03:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbcAEIDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 03:03:07 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34519 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbcAEIDF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 03:03:05 -0500
Received: by mail-pa0-f47.google.com with SMTP id uo6so191794924pac.1
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 00:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h0XbXg5erz20xkOrxPEeajjCSRZREWZv0yGbmc8zfPc=;
        b=RGFTGCzKFFpER6aavUwwyrreBF7EYtW0Zw8TNto+YttO0QKRdNptWSyslZ95/ki/EY
         EZ2TvQAa141SRPB31UQkT1XCxKxhmWTkgkF1pf8lGZLUq73oYsYsvNB7DaE9dxNF7jXY
         vQS2mPiS+k39/8SLW7jrZ1GOlhqELv+VqTlc6T+AUvK/o4qddBRGB+zt+J8D0BiFSl0P
         czMZlA/u6g5nTf2RgiF9ucYBWdSLW1zQmdbWQAo6w2HUXDwL3Ed4s9I2SCPuqQzya2Ru
         TdoFgNGt0Z4D5KMM+jyJQC5XE1k76hCOx27KzHTq7NiaLKC/xCutFbayf0fHhVzVgQHN
         avAQ==
X-Received: by 10.66.141.165 with SMTP id rp5mr73007354pab.56.1451980984611;
        Tue, 05 Jan 2016 00:03:04 -0800 (PST)
Received: from ashley.localdomain ([106.51.242.38])
        by smtp.gmail.com with ESMTPSA id q190sm125814275pfq.59.2016.01.05.00.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 05 Jan 2016 00:03:04 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283358>

>From align_atom_parser() form parse_align_position() which given a
string would give us the alignment position. This is a preparatory
patch as to introduce prefixes for the %(align) atom and avoid
redundancy in the code.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index fa081a8..ccad4c3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -74,6 +74,17 @@ static void color_atom_parser(struct used_atom *atom)
 		die(_("invalid color value: %s"), atom->u.color);
 }
 
+static align_type parse_align_position(const char *s)
+{
+	if (!strcmp(s, "right"))
+		return ALIGN_RIGHT;
+	else if (!strcmp(s, "middle"))
+		return ALIGN_MIDDLE;
+	else if (!strcmp(s, "left"))
+		return ALIGN_LEFT;
+	return -1;
+}
+
 static void align_atom_parser(struct used_atom *atom)
 {
 	struct align *align = &atom->u.align;
@@ -90,16 +101,13 @@ static void align_atom_parser(struct used_atom *atom)
 	align->position = ALIGN_LEFT;
 
 	while (*s) {
+		int position;
 		buf = s[0]->buf;
 
 		if (!strtoul_ui(buf, 10, (unsigned int *)&width))
 			;
-		else if (!strcmp(buf, "left"))
-			align->position = ALIGN_LEFT;
-		else if (!strcmp(buf, "right"))
-			align->position = ALIGN_RIGHT;
-		else if (!strcmp(buf, "middle"))
-			align->position = ALIGN_MIDDLE;
+		else if ((position = parse_align_position(buf)) >= 0)
+			align->position = position;
 		else
 			die(_("unrecognized %%(align) argument: %s"), buf);
 		s++;
-- 
2.6.4
