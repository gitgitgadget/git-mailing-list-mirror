From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/5] revert: simplify getting commit subject in format_todo()
Date: Wed,  7 Dec 2011 12:07:55 +0530
Message-ID: <1323239877-24101-4-git-send-email-artagnon@gmail.com>
References: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 07:39:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYBA3-0000Mn-44
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 07:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093Ab1LGGjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 01:39:14 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51429 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1LGGjN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 01:39:13 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so437161iak.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 22:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=7vnIB7OwSNMdqtpDvOFSO0ICxJQKaQG5RSss7TOQ/m0=;
        b=Bt2JtbnRFFKmPNW6JsXfw8vk9YCDNvheJHa8JY1ycPPP45ttVnrOWOKzjGWu0c0j7Z
         AjyYVfyJlQhTNJCn9Iw5VuGnBkHonFU2XYUc69npU1HFQ5Q8oVzMc6c9YgBXaAVVIWS0
         cr16ujSiNd4yzz61ztaMjwXp4DAaG8gKkMOe0=
Received: by 10.42.96.132 with SMTP id j4mr18624677icn.50.1323239953620;
        Tue, 06 Dec 2011 22:39:13 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id eb23sm3166839ibb.2.2011.12.06.22.39.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Dec 2011 22:39:12 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323239877-24101-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186428>

format_todo() calls get_message(), but uses only the subject line of
the commit message.  Save work and unnecessary memory allocations by
using find_commit_subject() instead.  Also, remove the spurious check
on cur->item: the previous patch makes sure that instruction sheets
with missing commit subjects are parsable.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/revert.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 70055e5..706b8d4 100644
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
