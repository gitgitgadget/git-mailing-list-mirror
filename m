From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v4 09/14] reflog-walk.c: use ALLOC_GROW()
Date: Tue,  4 Mar 2014 02:31:57 +0400
Message-ID: <1393885922-21616-10-git-send-email-dmitrys.dolzhenko@yandex.ru>
References: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 23:33:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKbQU-0002rx-0Y
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 23:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755510AbaCCWdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 17:33:06 -0500
Received: from forward7l.mail.yandex.net ([84.201.143.140]:44285 "EHLO
	forward7l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755473AbaCCWcn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 17:32:43 -0500
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [37.140.190.28])
	by forward7l.mail.yandex.net (Yandex) with ESMTP id 2FDCBBC0DD5;
	Tue,  4 Mar 2014 02:32:42 +0400 (MSK)
Received: from smtp3o.mail.yandex.net (localhost [127.0.0.1])
	by smtp3o.mail.yandex.net (Yandex) with ESMTP id E5E2C1E1112;
	Tue,  4 Mar 2014 02:32:41 +0400 (MSK)
Received: from 212.192.143.249 (212.192.143.249 [212.192.143.249])
	by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 97cx6V3GKz-WfvOd7Tf;
	Tue,  4 Mar 2014 02:32:41 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 632c3b82-8ef8-45f7-828c-aa8d36d30bc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393885961;
	bh=eZpYS2wc1vpKNyDN88WH0xIfwmCEWi1FSGeufm2vvwU=;
	h=From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References;
	b=GIiIQ2Pl1mDgR13Un0S4qjQbk+R8noWDklkQbVJ1b5zMlQhUkJsbkD3IKfqFwcmd6
	 5KAwp86MHhn2F+BJEvLL42rp1pAn0tykObM3vgWBXKLAk/IF9pZPVzgfVeaGEs+IQn
	 W5GsucqCMHXyjBvYydVxxIuuaArfGlOXhH8LqroU=
Authentication-Results: smtp3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1393885922-21616-1-git-send-email-dmitrys.dolzhenko@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243289>

Use ALLOC_GROW() instead inline code in
add_commit_info() and read_one_reflog()

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 reflog-walk.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index b2fbdb2..2899729 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -26,11 +26,7 @@ static int read_one_reflog(unsigned char *osha1, unsigned char *nsha1,
 	struct complete_reflogs *array = cb_data;
 	struct reflog_info *item;
 
-	if (array->nr >= array->alloc) {
-		array->alloc = alloc_nr(array->nr + 1);
-		array->items = xrealloc(array->items, array->alloc *
-			sizeof(struct reflog_info));
-	}
+	ALLOC_GROW(array->items, array->nr + 1, array->alloc);
 	item = array->items + array->nr;
 	memcpy(item->osha1, osha1, 20);
 	memcpy(item->nsha1, nsha1, 20);
@@ -114,11 +110,7 @@ static void add_commit_info(struct commit *commit, void *util,
 		struct commit_info_lifo *lifo)
 {
 	struct commit_info *info;
-	if (lifo->nr >= lifo->alloc) {
-		lifo->alloc = alloc_nr(lifo->nr + 1);
-		lifo->items = xrealloc(lifo->items,
-			lifo->alloc * sizeof(struct commit_info));
-	}
+	ALLOC_GROW(lifo->items, lifo->nr + 1, lifo->alloc);
 	info = lifo->items + lifo->nr;
 	info->commit = commit;
 	info->util = util;
-- 
1.8.3.2
