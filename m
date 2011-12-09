From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/9] revert: simplify getting commit subject in format_todo()
Date: Fri,  9 Dec 2011 21:12:01 +0530
Message-ID: <1323445326-24637-5-git-send-email-artagnon@gmail.com>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 09 16:43:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ2bi-00013I-7h
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 16:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754471Ab1LIPnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 10:43:24 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:41561 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305Ab1LIPnX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 10:43:23 -0500
Received: by mail-qy0-f174.google.com with SMTP id z2so2223292qcq.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 07:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9GAgjOLC4eRacC+YnTrB4cZ6k6N6RkzuWyujJmIG8bM=;
        b=Up6J8rFS6fG+X8vq0nNy4EANJmTP107Df4vI7btwjbkWh3k/Utaf1WwytOUsGd+sFy
         d5HjiM9D9KxJKfLGt/C0le7baV0AaNegyFNIUw+zzQzoeOwiAn4ujXcExP0eJECGzsCc
         1tKnXEaV4QAUhWkuDk5x4VlC6Hcleg7OZbmaQ=
Received: by 10.50.104.137 with SMTP id ge9mr3827106igb.38.1323445402403;
        Fri, 09 Dec 2011 07:43:22 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id a2sm18298821igj.7.2011.12.09.07.43.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 07:43:21 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186642>

format_todo() calls get_message(), but uses only the subject line of
the commit message.  As a minor optimization, save work and
unnecessary memory allocations by using find_commit_subject() instead.
Also, remove the unnecessary check on cur->item: the previous patch
makes sure that instruction sheets with missing commit subjects are
parsable.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/revert.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index b976562..86af516 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -697,16 +697,16 @@ static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
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
1.7.7.3
