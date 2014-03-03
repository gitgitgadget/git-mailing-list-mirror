From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v4 05/14] diff.c: use ALLOC_GROW()
Date: Tue,  4 Mar 2014 02:31:53 +0400
Message-ID: <1393885922-21616-6-git-send-email-dmitrys.dolzhenko@yandex.ru>
References: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 23:33:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbQU-0002rx-Io
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518AbaCCWdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:33:07 -0500
Received: from forward7l.mail.yandex.net ([84.201.143.140]:44282 "EHLO
	forward7l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755466AbaCCWck (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:32:40 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward7l.mail.yandex.net (Yandex) with ESMTP id C9AFEBC0DD5;
	Tue,  4 Mar 2014 02:32:38 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id 82C781E1112;
	Tue,  4 Mar 2014 02:32:38 +0400 (MSK)
Received: from 212.192.143.249 (212.192.143.249 [212.192.143.249])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 97cx6V3GKz-WcvCY9No;
	Tue,  4 Mar 2014 02:32:38 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 40c50c0f-ba47-4e72-8a03-c27f540beb8e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393885958;
	bh=OZiZObGCg6zXQSV/5aJCa0X913ZcznDn0fJmUTdsl4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References;
	b=WzuXeMPUtI/BiWnCJBuq29/uUdEnnrE8ig/i5VX/QJdXY0TwMVagqbQCvi3afm5gP
	 2RfikmmchAkrbKEpQe24319CjO1UzuHP+jwiPr1PG0i8npDp6Nj54j68U2eYHWJHhx
	 LSMQRzAx3hMq4wXHOA0Rx5Y8/uakq7vhcDgX9pj0=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243290>

Use ALLOC_GROW() instead inline code in
diffstat_add() and diff_q()

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 diff.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/diff.c b/diff.c
index e800666..aebdfda 100644
--- a/diff.c
+++ b/diff.c
@@ -1361,11 +1361,7 @@ static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
 {
 	struct diffstat_file *x;
 	x = xcalloc(sizeof (*x), 1);
-	if (diffstat->nr == diffstat->alloc) {
-		diffstat->alloc = alloc_nr(diffstat->alloc);
-		diffstat->files = xrealloc(diffstat->files,
-				diffstat->alloc * sizeof(x));
-	}
+	ALLOC_GROW(diffstat->files, diffstat->nr + 1, diffstat->alloc);
 	diffstat->files[diffstat->nr++] = x;
 	if (name_b) {
 		x->from_name = xstrdup(name_a);
@@ -3965,11 +3961,7 @@ struct diff_queue_struct diff_queued_diff;
 
 void diff_q(struct diff_queue_struct *queue, struct diff_filepair *dp)
 {
-	if (queue->alloc <= queue->nr) {
-		queue->alloc = alloc_nr(queue->alloc);
-		queue->queue = xrealloc(queue->queue,
-					sizeof(dp) * queue->alloc);
-	}
+	ALLOC_GROW(queue->queue, queue->nr + 1, queue->alloc);
 	queue->queue[queue->nr++] = dp;
 }
 
-- 
1.8.3.2
