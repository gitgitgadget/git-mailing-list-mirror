From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/6] revert: simplify getting commit subject in format_todo()
Date: Thu, 20 Oct 2011 02:33:24 +0530
Message-ID: <1319058208-17923-3-git-send-email-artagnon@gmail.com>
References: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:06:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGdKx-0000CW-PX
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105Ab1JSVGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:06:04 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52807 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559Ab1JSVGC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:06:02 -0400
Received: by mail-gy0-f174.google.com with SMTP id 13so2083069gyb.19
        for <git@vger.kernel.org>; Wed, 19 Oct 2011 14:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BjTyXOWwfw/rt4FJYarGbgJinNAcQLP+cSiGQmM3sbY=;
        b=P+nHWCHgBJn3L6y3HFoG8jz4Krio0bdMFqR9exiagkl/KVk/HgNqoAeSV2T856mecR
         ecgOKonVp9E+ZCe0hqx88iykMFONfdD0Hnn0g9GvY3Jj9DnKSzWdYmeM4MXeLv//Y6N/
         CBuYUF+FS5jHBI/pnMWYaQRscZ1TjuBJvPLvQ=
Received: by 10.68.14.105 with SMTP id o9mr14748046pbc.95.1319058361643;
        Wed, 19 Oct 2011 14:06:01 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id jm5sm11111752pbc.1.2011.10.19.14.05.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Oct 2011 14:06:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183964>

format_todo() calls get_message(), but uses only the subject line of
the commit message.  Save work and unnecessary memory allocations by
using find_commit_subject() instead.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/revert.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 94b7c50..acb357d 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -671,16 +671,16 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
 		struct replay_opts *opts)
 {
 	struct commit_list *cur = NULL;
-	struct commit_message msg = { NULL, NULL, NULL, NULL, NULL };
 	const char *sha1_abbrev = NULL;
 	const char *action_str = opts->action == REVERT ? "revert" : "pick";
+	const char *subject;
+	int subject_len;
 
 	for (cur = todo_list; cur; cur = cur->next) {
 		sha1_abbrev = find_unique_abbrev(cur->item->object.sha1, DEFAULT_ABBREV);
-		if (get_message(cur->item, &msg))
-			return error(_("Cannot get commit message for %s"), sha1_abbrev);
-		strbuf_addf(buf, "%s %s %s\n", action_str, sha1_abbrev, msg.subject);
-		free_message(&msg);
+		subject_len = find_commit_subject(cur->item->buffer, &subject);
+		strbuf_addf(buf, "%s %s %.*s\n", action_str, sha1_abbrev,
+			subject_len, subject);
 	}
 	return 0;
 }
-- 
1.7.6.351.gb35ac.dirty
