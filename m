From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/18] rerere: explain the remainder
Date: Fri, 17 Jul 2015 15:24:34 -0700
Message-ID: <1437171880-21590-13-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
 <1437171880-21590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:25:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE4H-0004Hr-2d
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756214AbbGQWZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:25:12 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35429 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171AbbGQWZB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:25:01 -0400
Received: by pdrg1 with SMTP id g1so67946601pdr.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=XP9jQqdRh4WRhV9zpcrJtP0r1SZhyD7yCQES48BwuLM=;
        b=SH7BaP8rh3VoKostIjmwpkslEBQP5MGkwvGstpdcAwLEXlR6nSTYq84Bp95rClujs4
         ySiqDWvbhJBd7yNTTc7xaa2bbzgWGU8N2/W2C8lXHjaZ2UobmF2v+hTRFT8/UhkNQm1A
         DLB4la+7OY92/mbwbbnWjs6kUi6sEM68UAci8MqC8jLSMjWkNWyfTxmWsNA1cHajc74u
         XxFg9oZKGxOQyaA6Tx3IZbBwRys0F/Q03Ouuo08LcmpkrqOUXPyZeNmXdACdcgZFAaxR
         zbYIIElbFB0Umwl9RGNd/VAkro5TotmonN8QB7+3DisZ/NS9bkS6udTk//8giIBKrvpN
         3dVA==
X-Received: by 10.68.103.164 with SMTP id fx4mr33588803pbb.125.1437171900947;
        Fri, 17 Jul 2015 15:25:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id tm3sm12380836pac.44.2015.07.17.15.25.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:25:00 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1437171880-21590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274119>

Explain the internals of rerere as in-code comments, while
sprinkling "NEEDSWORK" comment to highlight iffy bits and
questionable assumptions.

This covers the codepath that implements "rerere gc" and "rerere
clear".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/rerere.c b/rerere.c
index 3782be6..7ef951e 100644
--- a/rerere.c
+++ b/rerere.c
@@ -844,6 +844,9 @@ int rerere_forget(struct pathspec *pathspec)
 	return write_rr(&merge_rr, fd);
 }
 
+/*
+ * Garbage collection support
+ */
 static time_t rerere_created_at(const char *name)
 {
 	struct stat st;
@@ -856,11 +859,19 @@ static time_t rerere_last_used_at(const char *name)
 	return stat(rerere_path(name, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
 }
 
+/*
+ * Remove the recorded resolution for a given conflict ID
+ */
 static void unlink_rr_item(const char *name)
 {
 	unlink(rerere_path(name, "thisimage"));
 	unlink(rerere_path(name, "preimage"));
 	unlink(rerere_path(name, "postimage"));
+	/*
+	 * NEEDSWORK: what if this rmdir() fails?  Wouldn't we then
+	 * assume that we already have preimage recorded in
+	 * do_plain_rerere()?
+	 */
 	rmdir(git_path("rr-cache/%s", name));
 }
 
@@ -880,6 +891,7 @@ void rerere_gc(struct string_list *rr)
 	dir = opendir(git_path("rr-cache"));
 	if (!dir)
 		die_errno("unable to open rr-cache directory");
+	/* Collect stale conflict IDs ... */
 	while ((e = readdir(dir))) {
 		if (is_dot_or_dotdot(e->d_name))
 			continue;
@@ -897,11 +909,19 @@ void rerere_gc(struct string_list *rr)
 			string_list_append(&to_remove, e->d_name);
 	}
 	closedir(dir);
+	/* ... and then remove them one-by-one */
 	for (i = 0; i < to_remove.nr; i++)
 		unlink_rr_item(to_remove.items[i].string);
 	string_list_clear(&to_remove, 0);
 }
 
+/*
+ * During a conflict resolution, after "rerere" recorded the
+ * preimages, abandon them if the user did not resolve them or
+ * record their resolutions.  And drop $GIT_DIR/MERGE_RR.
+ *
+ * NEEDSWORK: shouldn't we be calling this from "reset --hard"?
+ */
 void rerere_clear(struct string_list *merge_rr)
 {
 	int i;
-- 
2.5.0-rc2-340-g0cccc16
