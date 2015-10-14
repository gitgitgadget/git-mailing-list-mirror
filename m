From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 19/31] mailinfo: handle_commit_msg() shouldn't be called after finding patchbreak
Date: Wed, 14 Oct 2015 13:45:45 -0700
Message-ID: <1444855557-2127-20-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:48:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSyg-0003pY-Ax
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937AbbJNUso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:48:44 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33980 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932557AbbJNUqX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:23 -0400
Received: by payp3 with SMTP id p3so16210375pay.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=rpxN2bxq1uPz3BtNQ5OPwACxfPzogrWvsimKb1TbO2Q=;
        b=gRFNsXD3G84pM9XP/j7LG1FCisjcPA3jI3s2WU/pITGznxYOfANXF0ht6KhyoZSlQC
         AzfAmLmUEir0m0lwMcuq0fKFMnZEd+5LbcCYrUFgJCDLULq3dqexAfaoB5CAEYHcsLIa
         i70VHmYEVEJo5VPk2D9wOzOYLI6da99dwPSsFUi9qKAlBidXBtHmiUQbNfc75Un/97ly
         hbRfPRLaNU57hztGhqd2wAvOCWABWOhuZBn7517WvC4rk+bTl+X/RQ83R8GAqrlWHADi
         rUhsVFtDrbeWalFBH8ZRdWd4t9nb7vla8lgYyLCGLt804kKuHwEgcU7i8e9AECaZCB0Q
         fQvg==
X-Received: by 10.68.129.168 with SMTP id nx8mr5587869pbb.168.1444855583119;
        Wed, 14 Oct 2015 13:46:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id ja4sm11290938pbb.19.2015.10.14.13.46.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:22 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279624>

There is a strange "if (!cmitmsg) return 0" at the very beginning of
handle_commit_msg(), but the condition should never trigger,
because:

 * The only place cmitmsg is set to NULL is after this function sees
   a patch break, closes the FILE * to write the commit log message
   and returns 1.  This function returns non-zero only from that
   codepath.

 * The caller of this function, upon seeing a non-zero return,
   increments filter_stage, starts treating the input as patch text
   and will never call handle_commit_msg() again.

Replace it with an assert(!mi->filter_stage).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 41f659d..f48a260 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -724,8 +724,7 @@ static int is_scissors_line(const struct strbuf *line)
 
 static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 {
-	if (!cmitmsg)
-		return 0;
+	assert(!mi->filter_stage);
 
 	if (mi->header_stage) {
 		if (!line->len || (line->len == 1 && line->buf[0] == '\n'))
-- 
2.6.1-320-g86a1181
