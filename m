From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/5] revert: simplify getting commit subject in format_todo()
Date: Sun, 23 Oct 2011 00:43:43 +0530
Message-ID: <1319310826-508-3-git-send-email-artagnon@gmail.com>
References: <1319310826-508-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 22 21:16:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHh3j-0003Uk-7Q
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 21:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575Ab1JVTQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 15:16:35 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57530 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab1JVTQe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 15:16:34 -0400
Received: by gyb13 with SMTP id 13so4735110gyb.19
        for <git@vger.kernel.org>; Sat, 22 Oct 2011 12:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=AQ1P4ISMs0rD5LFUFPS8QlWc5Z42P38ZjEyihu1dNrg=;
        b=UeNwtdhcGtZZQnBiOEM1wkp0bHwLpeZ1jGWLSPjujdL56kP6dsaUPeEJd0R36VfaAR
         co/R6Q/X4s22oSmpWFc1Y+MMZTDOR+wk2WQ723XdZyZnK+JDQUHbcmWD1K7tfwzsKEf3
         YqG01XDjX6ifcKe8k4HO6NZwIY6nGzkDjBBOs=
Received: by 10.68.16.69 with SMTP id e5mr4046167pbd.67.1319310993654;
        Sat, 22 Oct 2011 12:16:33 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id e10sm36939881pbq.10.2011.10.22.12.16.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 22 Oct 2011 12:16:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.351.gb35ac.dirty
In-Reply-To: <1319310826-508-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184114>

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
index a6f2ea7..efa8d00 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -680,16 +680,16 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
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
