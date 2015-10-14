From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/31] mailinfo: explicitly close file handle to the patch output
Date: Wed, 14 Oct 2015 13:45:29 -0700
Message-ID: <1444855557-2127-4-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:46:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSwi-0001mB-GU
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827AbbJNUq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:27 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35193 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268AbbJNUqD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:03 -0400
Received: by padcn9 with SMTP id cn9so32990067pad.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=zvbxtu2qF3oVskNmsnRrjjfMGsOK6mRg9qCBKV/I8WY=;
        b=S4pYmleYs+z4WHQVn6uYpOdBQHv1LFnnLB/XSbkgx9RqMogPCUbRnGbkj8UfnSNNpd
         DWcTYnmvL8Gv4j7RNJLztkX7Qzfmx3Ldw60IA7z8k4XlIleJUC82/U5KD8UbUJ+NhcWe
         KBn2/o+Koa5qKbyXp8yM5QuprmhrIyp+U6Toe0anKvEhfCZkJ8v5dj1uMeWSsRf9FCvk
         Xk1W1vXe2JZzI10epx73/2t0ujcQv+6wy2eQG5tF0ztsKyZOiY0HrWfgMg1Cwf5S9IET
         m3WuywvLZyKtXN3ujoSY7yUvFUxuHeOk6Mx+uiYHOJkXDmAnwYPesJu5KPuTszBCz8KS
         TNsg==
X-Received: by 10.68.69.45 with SMTP id b13mr5579643pbu.67.1444855562722;
        Wed, 14 Oct 2015 13:46:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id lo9sm11334055pab.19.2015.10.14.13.46.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:02 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279596>

This does not make a difference within the context of "git mailinfo"
that runs once and exits, as flushing and closing would happen upon
process completion.  It however will matter when we eventually make
this function callable as an API function.

Besides, cleaning after yourself once you are done is a good hygiene.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index d3756cc..412a23b 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -1008,6 +1008,8 @@ static int mailinfo(FILE *in, FILE *out, const char *msg, const char *patch)
 		check_header(&line, p_hdr_data, 1);
 
 	handle_body();
+	fclose(patchfile);
+
 	handle_info();
 
 	return 0;
-- 
2.6.1-320-g86a1181
