From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 25/34] mailinfo: handle_commit_msg() shouldn't be called after finding patchbreak
Date: Mon, 19 Oct 2015 00:28:42 -0700
Message-ID: <1445239731-10677-26-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:29:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4st-0002o3-Tm
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002AbbJSH30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:26 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34228 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbbJSH3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:24 -0400
Received: by padhk11 with SMTP id hk11so21777291pad.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=5o8OUIJCAXazzZ3pNjiPDUnF7iyfFJmsVGaCbqWNB3A=;
        b=c+DjGsOw255/bi5cb+r6HS1IcG2ASiSiiYsRkFncB70LRPEELR+5Z4vErMPdgxT5h3
         x5t4AShKAwjkWxK3lUbVYPyyV2Jz9qq42XP5im81DLDJnaGBGDNNUYFUwPyGEwOS2B9p
         4lGEFNX17FOn4ZpkgboATurCv1Oaxp26m7V/IRYF+fwz/qYp3e+shWYd3yExMCmnfV4N
         zAwJdEWXOlKL/erBRKTFgtQIdSUB1H8iJAkIdsQDXWbVnX48lv85vlfhqYiXIqGhhuvt
         MZbuwoDifKo9FcNh58vjrq+C9r3T3WfmGakZyYwmeDAN3Gm0hETENwjr/U9mwn8iYskJ
         3beA==
X-Received: by 10.66.119.135 with SMTP id ku7mr32815243pab.21.1445239763819;
        Mon, 19 Oct 2015 00:29:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id ir4sm34455008pbb.93.2015.10.19.00.29.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:23 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279841>

There is a strange "if (!mi->cmitmsg) return 0" at the very beginning
of handle_commit_msg(), but the condition should never trigger, because:

 * The only place cmitmsg is set to NULL is after this function sees
   a patch break, closes the FILE * to write the commit log message
   and returns 1.  This function returns non-zero only from that
   codepath.

 * The caller of this function, upon seeing a non-zero return,
   increments filter_stage, starts treating the input as patch text
   and will never call handle_commit_msg() again.

Replace it with an assert(!mi->filter_stage) to ensure the above
observation will stay to be true.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index ec65805..286eda0 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -725,8 +725,7 @@ static int is_scissors_line(const struct strbuf *line)
 
 static int handle_commit_msg(struct mailinfo *mi, struct strbuf *line)
 {
-	if (!mi->cmitmsg)
-		return 0;
+	assert(!mi->filter_stage);
 
 	if (mi->header_stage) {
 		if (!line->len || (line->len == 1 && line->buf[0] == '\n'))
-- 
2.6.2-383-g144b2e6
