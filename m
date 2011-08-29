From: sdaoden@googlemail.com
Subject: [PATCH 1/2] progress: add update_progress()
Date: Mon, 29 Aug 2011 22:17:39 +0200
Message-ID: <bc530ff857b92ad58bfd6f331cf6732ed86c42b0.1314647163.git.sdaoden@gmail.com>
References: <cover.1314647163.git.sdaoden@gmail.com>
Cc: Steffen Daode Nurpmeso <sdaoden@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 22:18:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy8IE-0000d8-OG
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 22:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114Ab1H2USp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 16:18:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37959 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755110Ab1H2USo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 16:18:44 -0400
Received: by fxh19 with SMTP id 19so4798916fxh.19
        for <git@vger.kernel.org>; Mon, 29 Aug 2011 13:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=3UC9MpeSvHXvwLmF8L20ftx2LgmTQkLs84LjLX4M+SA=;
        b=vE379ziO8IlpxwOPqu4hI6rv6s7/4tEuC+dJDBddkykCaI2oJbZRp2Q3YJu9LRx7kV
         7OeyvPLsu4uXFPHzl1F4dI8Su70xmKvdkiWB95NgDHXSsgLfhpP8RW3gptvMqO3BwWdW
         Nez3Xl7k6fkvbgu0TRhQIoF1tNrPGDnu05Joo=
Received: by 10.223.25.151 with SMTP id z23mr7652045fab.45.1314649123356;
        Mon, 29 Aug 2011 13:18:43 -0700 (PDT)
Received: from localhost.localdomain ([89.204.137.171])
        by mx.google.com with ESMTPS id 11sm4034094fav.34.2011.08.29.13.18.40
        (version=SSLv3 cipher=OTHER);
        Mon, 29 Aug 2011 13:18:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.dirty
In-Reply-To: <cover.1314647163.git.sdaoden@gmail.com>
In-Reply-To: <cover.1314647163.git.sdaoden@gmail.com>
References: <cover.1314647163.git.sdaoden@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180344>

From: Steffen Daode Nurpmeso <sdaoden@gmail.com>

Sometimes the task which is tracked via progress is splitted
into two parts, e.g. check_updates() in unpack_trees.c updates
the working tree by first removing files, followed by checking
out files.  Whereas it is possible to simply recreate a progress
reporter, it's easier to simply call in to update the state of
the yet existing one.

Inspired-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Steffen Daode Nurpmeso <sdaoden@gmail.com>
---
 progress.c |   15 +++++++++++++++
 progress.h |    2 ++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/progress.c b/progress.c
index 3971f49..c86f83f 100644
--- a/progress.c
+++ b/progress.c
@@ -234,6 +234,21 @@ struct progress *start_progress(const char *title, unsigned total)
 	return start_progress_delay(title, total, 0, 0);
 }
 
+void update_progress(struct progress *progress, const char *title,
+			unsigned total)
+{
+	if (!progress)
+		return;
+	progress->title = title;
+	progress->total = total;
+	progress->last_value = -1;
+	progress->last_percent = -1;
+	if (progress->delay < 0)
+		progress->delay = 0;
+	clear_progress_signal();
+	set_progress_signal();
+}
+
 void stop_progress(struct progress **p_progress)
 {
 	stop_progress_msg(p_progress, "done");
diff --git a/progress.h b/progress.h
index 611e4c4..eed5b58 100644
--- a/progress.h
+++ b/progress.h
@@ -8,6 +8,8 @@ int display_progress(struct progress *progress, unsigned n);
 struct progress *start_progress(const char *title, unsigned total);
 struct progress *start_progress_delay(const char *title, unsigned total,
 				       unsigned percent_treshold, unsigned delay);
+void update_progress(struct progress *progress, const char *title,
+			unsigned total);
 void stop_progress(struct progress **progress);
 void stop_progress_msg(struct progress **progress, const char *msg);
 
-- 
1.7.7.rc0.dirty
