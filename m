From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 02/31] mailinfo: fix for off-by-one error in boundary stack
Date: Wed, 14 Oct 2015 13:45:28 -0700
Message-ID: <1444855557-2127-3-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:48:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSyQ-0003ZX-87
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932765AbbJNUqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:25 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34691 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932266AbbJNUqB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:01 -0400
Received: by payp3 with SMTP id p3so16202568pay.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=CsnPKjJXwwBPo1Nl4C3ymJaI/TB86R3pTccFLlq9PzY=;
        b=pIsuuJfren/lKjDoYlcC6J8+ybK1D1/8SS+l4OsxD0hqU701fMhch2298eFtxd4FzP
         zbmPfUPo+OzgveOUKrDbAS23RWdRxPqr/TEwvhWSWODJpM+fcLXTk3i2U7ta7Xn0/ybp
         8G84wRvSSFiXMaQBE3Z3pLVWtctRs0r9Kq33WC1v9TAnzVACvWcn9JMv5X4Bzwvy3NQC
         6uMmeyYXORTty4LJb574fuEfZF3Vs9bXFiExvPWZ4cs6Q4emqCYtR0DJCxZizL1FqxpM
         O35gO2xP87VGxaW+8NY1PpQ0v4h9/CptTB0oxnSAX8Fxk/eRBsvwMyn/73cx4nDYPw/v
         2xXg==
X-Received: by 10.66.146.69 with SMTP id ta5mr5824179pab.46.1444855561404;
        Wed, 14 Oct 2015 13:46:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id dg2sm11296423pbb.9.2015.10.14.13.46.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:00 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279618>

We pre-increment the pointer that we will use to store something at,
so the pointer is already beyond the end of the array if it points
at content[MAX_BOUNDARIES].

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 5a4ed75..d3756cc 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -185,7 +185,7 @@ static void handle_content_type(struct strbuf *line)
 
 	if (slurp_attr(line->buf, "boundary=", boundary)) {
 		strbuf_insert(boundary, 0, "--", 2);
-		if (++content_top > &content[MAX_BOUNDARIES]) {
+		if (++content_top >= &content[MAX_BOUNDARIES]) {
 			fprintf(stderr, "Too many boundaries to handle\n");
 			exit(1);
 		}
-- 
2.6.1-320-g86a1181
