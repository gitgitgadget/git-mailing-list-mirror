From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2] builtin/apply: exit when parse_binary() fails
Date: Thu, 17 Mar 2016 10:23:34 +0100
Message-ID: <1458206614-2898-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 10:28:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agUEO-00049p-8h
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 10:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932932AbcCQJ2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 05:28:33 -0400
Received: from mail-wm0-f54.google.com ([74.125.82.54]:38100 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932329AbcCQJ2a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 05:28:30 -0400
Received: by mail-wm0-f54.google.com with SMTP id l68so107826365wml.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 02:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=bZGVD3JshOiBne8wBqC9hraj6LP8xUSsGWwLfP6Mu8U=;
        b=JHr8bpA7PcjSLoHj9qoiWtujzJQze9sQa27FW2eKzWe2hKkJQHNETheoN2gsdQlJ9w
         o3xnOsuUF/bDiOaYm7y7/n+CbvqQPH6qo2E6idziqHO9ouEmSfZNBY3sznNGRz+DnehT
         kkFIRFTjJ9LlPvV4Ycadu8RpWSnPH4XPv/wP3LWyOwd6R+UJ9FZPiNmdLoGWYMhmbs/B
         XmCceIJCF/zflmrdxWOKtHoBKSZ4VFQ/OaU/1GWxOMewiOzv7daTlLsamM8kNtMyIBnY
         BXaUvH/198ZdYACBvdf/i9fi86LtSOYb6tKRm8XMay1q4G6MnRsvnsn2HDXpHzpDUqNU
         1S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bZGVD3JshOiBne8wBqC9hraj6LP8xUSsGWwLfP6Mu8U=;
        b=HF3NOD2VdFWwpw8WuSAbYqUB88R9uTGxXH55SSEHbtaEmquMUrbT7OIGqGIOexlQC9
         7jjk5MSqG/MGoibNDRXhFpGtV1XKGHOB4eNhsS3PJ9YValYhdmz/NKlaiJqmuY6eBbIw
         QopTkltIQzZftyciuQRWo+lGS1Vx1rBofa/JatDBxhWh1l/8l3jAgofrwJi+BtqaGqGg
         EofkCNJvPt2sI40xjAop/tG0TV30UuSymrCMI5js6EjQBVOW9Ga0eA/Esz4R2CZrvCB3
         LBbJ1fPKoNzK/dGRDxsQDjZxGFn34Yp3M4Cz4f5X9aXuXmEncyx+EboVAcHWxCfFcey1
         VNWw==
X-Gm-Message-State: AD7BkJLxNNm6pqYtbHOy83p7XG1vTkzBWk3oGuAx3j0jXIbX6hQPwzTz0H8Xc1S/Qwizyw==
X-Received: by 10.28.111.92 with SMTP id k89mr36246715wmc.36.1458206909648;
        Thu, 17 Mar 2016 02:28:29 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id r8sm6723883wjz.34.2016.03.17.02.28.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Mar 2016 02:28:28 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc2.1.g21d258f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289090>

In parse_binary() there is:

	forward = parse_binary_hunk(&buffer, &size, &status, &used);
	if (!forward && !status)
		/* there has to be one hunk (forward hunk) */
		return error(_("unrecognized binary patch at line %d"), linenr-1);

so parse_binary() can return -1, because that's what error() returns.

Also parse_binary_hunk() sets "status" to -1 in case of error and
parse_binary() does "if (status) return status;".

In this case parse_chunk() should not add -1 to the patchsize it computes.
It is better for future libification efforts to make it just return -1.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/apply.c b/builtin/apply.c
index 42c610e..c399c97 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1872,6 +1872,11 @@ static struct fragment *parse_binary_hunk(char **buf_p,
 	return NULL;
 }
 
+/*
+ * Returns:
+ *   -1 in case of error,
+ *   the length of the parsed binary patch otherwise
+ */
 static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
 {
 	/*
@@ -2017,6 +2022,8 @@ static int parse_chunk(char *buffer, unsigned long size, struct patch *patch)
 			linenr++;
 			used = parse_binary(buffer + hd + llen,
 					    size - hd - llen, patch);
+			if (used < 0)
+				return -1;
 			if (used)
 				patchsize = used + llen;
 			else
-- 
2.8.0.rc2.1.g21d258f
