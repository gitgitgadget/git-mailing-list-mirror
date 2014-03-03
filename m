From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v3 09/11] reflog-walk.c: use ALLOC_GROW()
Date: Mon, 03 Mar 2014 11:24:35 +0400
Message-ID: <53142E33.6030303@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <53142CB9.80100@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 08:25:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKNFX-0003Ok-8V
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 08:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbaCCHZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 02:25:12 -0500
Received: from forward5l.mail.yandex.net ([84.201.143.138]:35028 "EHLO
	forward5l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753809AbaCCHZL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 02:25:11 -0500
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [37.140.190.27])
	by forward5l.mail.yandex.net (Yandex) with ESMTP id 53BFEC40E59
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:25:10 +0400 (MSK)
Received: from smtp2o.mail.yandex.net (localhost [127.0.0.1])
	by smtp2o.mail.yandex.net (Yandex) with ESMTP id 0720D36A15AB
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:25:09 +0400 (MSK)
Received: from unknown (unknown [31.181.208.245])
	by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id TczMafYZcY-P9eC3hTK;
	Mon,  3 Mar 2014 11:25:09 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 8ba074f3-a8e8-4f88-b949-5892367b6115
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393831509;
	bh=smDJfl5x6qucOdHMxeUKYq/wu4yuVmuas/7Hp6FyD1E=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=PHLy/bazbYNXfWRXSdlMUpszP2//CD1QZkrJWAM5LVi5Vf+dCEdOSLYWSahbNcaQ6
	 gE1R+RcnmxK3F0z3L+pEl7ILSd5/qjo2HNO9ZvvNpS9nA4scRpl+gwn5NYZI/xghQK
	 26+vgvlLHMIrMxDGJqgZj1iJ6fAmJyDiz/kI5/HY=
Authentication-Results: smtp2o.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <53142CB9.80100@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243188>

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
1.8.5.3
