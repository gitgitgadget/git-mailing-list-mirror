From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 09/34] mailinfo: do not let find_boundary() touch global "line" directly
Date: Mon, 19 Oct 2015 00:28:26 -0700
Message-ID: <1445239731-10677-10-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:30:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4uB-0003dG-5P
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbbJSH3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:06 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35623 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbbJSH3F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:05 -0400
Received: by pasz6 with SMTP id z6so22258031pas.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=2pe2mc90FZBUn21V7cmaxd8uNUqC24hcp3vGZsMrWYk=;
        b=x1eFXqMfzU7Dr4sBQJ0CoZBFHWLfn+mEH94glbaDCXkiTLCfHRW/4nug0v1fgg76Q7
         yktpUniwF3eVMepXlLRFSpKz+2OFoKOIup2ra0JB/6nsDSXIxoJpmRicskfMSQhmHEay
         RqMkZQzge7YrWwQjCyYZRTItyNmnTmL0BCNed0v0UvaV/mt3kZsHluVlIQ2OqAQy/SfX
         PRqm7WCBObUWjXQnlPAosJTArh96Nf2EZhfHXv08uJyuyvLy3pb7SSW5zC9JlaVXO1tJ
         Gay/sj0IrJ09M39oMhaeRK64+mNfCesAP1dTu7Jt15PtG80clZnmsw0zkm5QFyWQlAU5
         Jmkw==
X-Received: by 10.68.168.226 with SMTP id zz2mr32940583pbb.8.1445239744826;
        Mon, 19 Oct 2015 00:29:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id sn9sm34818798pac.16.2015.10.19.00.29.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:04 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279863>

With the previous two commits, we established that the local
variable "line" in handle_body() and handle_boundary() functions
always refer to the global "line" that is used as the common and
shared "current line from the input".  They are the only callers of
the last function that refers to the global line directly, i.e.
find_boundary().  Pass "line" as a parameter to this leaf function
to complete the clean-up.  Now the only function that directly refers
to the global "line" is the caller of handle_body() at the very
beginning of this whole callchain.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index cab1235..12d1eda 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -788,10 +788,10 @@ static void handle_filter(struct strbuf *line, int *filter_stage, int *header_st
 	}
 }
 
-static int find_boundary(void)
+static int find_boundary(struct strbuf *line)
 {
-	while (!strbuf_getline(&line, fin, '\n')) {
-		if (*content_top && is_multipart_boundary(&line))
+	while (!strbuf_getline(line, fin, '\n')) {
+		if (*content_top && is_multipart_boundary(line))
 			return 1;
 	}
 	return 0;
@@ -823,7 +823,7 @@ again:
 		strbuf_release(&newline);
 
 		/* skip to the next boundary */
-		if (!find_boundary())
+		if (!find_boundary(line))
 			return 0;
 		goto again;
 	}
@@ -852,7 +852,7 @@ static void handle_body(struct strbuf *line)
 
 	/* Skip up to the first boundary */
 	if (*content_top) {
-		if (!find_boundary())
+		if (!find_boundary(line))
 			goto handle_body_out;
 	}
 
-- 
2.6.2-383-g144b2e6
