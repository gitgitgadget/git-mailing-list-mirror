From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [WIP PATCH 18/22] a fast fix
Date: Sat, 24 Jul 2010 23:13:50 +0800
Message-ID: <1279984434-28933-19-git-send-email-struggleyb.nku@gmail.com>
References: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 24 17:16:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcgSR-0002K0-Gt
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 17:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756230Ab0GXPPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 11:15:35 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58504 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756172Ab0GXPP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 11:15:29 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so3932862pwi.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=k0DIe4RrDqNbeTcmjWOmtnd2JHYXiDgnN2W8ldB7M5w=;
        b=iYpz+V7wMIyFv4lYMSKdOAdXHMGAiFf+6spoYRrHkHgtl5cvKItHsDAPdGy+5V8aQK
         SGAzVogCxG0Lo/cnyXlFR0UsDpd8LeNJZfNRX3r9FzoBrJVkFmiV/bZFacrGErsE9hcy
         o2vcQ8QQXlrBbtolJV6FkNkIDUeaPiYhx/8y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LNjvj41wrUXJMljpr3UKZcd1kNj3vntopqxNif6dxUmSIHSIqoxflkVCI41HfPPT42
         6iFvhE8wxPMTrXRaDA/aBzNBRrz+6evhwx5FtSMdxNhi2A4COTmFI21dy8uzLP0LLW3m
         9xfV/IJsctetM8p0PO926mN7PhsEeq+bG3pDc=
Received: by 10.142.157.6 with SMTP id f6mr6007371wfe.328.1279984528638;
        Sat, 24 Jul 2010 08:15:28 -0700 (PDT)
Received: from localhost.localdomain ([58.68.143.121])
        by mx.google.com with ESMTPS id w8sm1705169wfd.19.2010.07.24.08.15.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 08:15:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.80.g6f8ea9.dirty
In-Reply-To: <1279984434-28933-1-git-send-email-struggleyb.nku@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151651>

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 line.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/line.c b/line.c
index c8c9ad3..ca8980d 100644
--- a/line.c
+++ b/line.c
@@ -975,13 +975,15 @@ static void assign_parents_range(struct rev_info *rev, struct commit *commit)
 		parents = parents->next;
 	}
 
+	/* Never print out any diff for a merge commit */
+	commit->object.flags &= ~NEED_PRINT;
 	/*
 	 * yes, this must be an evil merge.
 	 */
 	range = copy;
 	while (range) {
 		if (range->nr) {
-			commit->object.flags |= NEED_PRINT | EVIL_MERGE;
+			commit->object.flags |= EVIL_MERGE;
 			nontrivial = 1;
 		}
 		range = range->next;
@@ -1256,7 +1258,8 @@ static void line_log_flush(struct rev_info *rev, struct commit *c)
 	char *line_prefix = "";
 	struct strbuf *msgbuf;
 
-	if (range == NULL)
+	if (range == NULL || ! (c->object.flags & EVIL_MERGE ||
+							c->object.flags & NEED_PRINT))
 		return;
 
 	log.commit = c;
@@ -1310,7 +1313,9 @@ int cmd_line_log_walk(struct rev_info *rev)
 			assign_parents_range(rev, commit);
 		}
 
-		if (commit->object.flags & NEED_PRINT || rev->full_line_diff || rev->graph) {
+		if (commit->object.flags & NEED_PRINT ||
+			commit->object.flags & EVIL_MERGE ||
+			rev->full_line_diff || rev->graph) {
 			if (rev->graph)
 				graph_update(rev->graph, commit);
 			line_log_flush(rev, commit);
-- 
1.7.0.2.273.gc2413.dirty
