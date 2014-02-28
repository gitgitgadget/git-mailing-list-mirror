From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v2 09/11] reflog-walk.c: use ALLOC_GROW() instead of inline
 code
Date: Fri, 28 Feb 2014 13:46:26 +0400
Message-ID: <53105AF2.3070301@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 10:47:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJK2C-0003N5-HB
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 10:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbaB1JrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 04:47:05 -0500
Received: from forward8l.mail.yandex.net ([84.201.143.141]:58785 "EHLO
	forward8l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbaB1JrE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 04:47:04 -0500
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [37.140.190.27])
	by forward8l.mail.yandex.net (Yandex) with ESMTP id 0B9D81A40D60
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:47:02 +0400 (MSK)
Received: from smtp2o.mail.yandex.net (localhost [127.0.0.1])
	by smtp2o.mail.yandex.net (Yandex) with ESMTP id B91BF36A156E
	for <git@vger.kernel.org>; Fri, 28 Feb 2014 13:47:02 +0400 (MSK)
Received: from unknown (unknown [46.159.228.134])
	by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 1kcuzSFqqn-l2rqPPFD;
	Fri, 28 Feb 2014 13:47:02 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: c88156cc-393d-4cd9-addc-85dbbef0de0f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393580822;
	bh=d0uzRKr8bpPCjO36xCovNerBifmHVqBGWNVPiNEaI9o=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=uMXP1MbvtIPYtVUgmOKV0o3l7SkkNNrPQ0bcK2eEnCjqfXVMHAS3WdTrUUeGdwL8M
	 lVJP6P5Ls5AWyVWKhJGISKGC9O+LEPOgMr2JAdcZUPe0ZPsf3pJQhYLxhF6ZS7Xb81
	 Slt/gM9LS+TjeC7vmzLjuE/arqJULqgDV1Wgd9jA=
Authentication-Results: smtp2o.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <531056E7.3010305@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242929>

Affected functions: read_one_reflog(), add_commit_info()

Signed-off-by: Dmitry S. Dolzhenko <dmitrys.dolzhenko@yandex.ru>
---
 reflog-walk.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index b2fbdb2..879d2ed 100644
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
@@ -114,11 +110,8 @@ static void add_commit_info(struct commit *commit, void *util,
 		struct commit_info_lifo *lifo)
 {
 	struct commit_info *info;
-	if (lifo->nr >= lifo->alloc) {
-		lifo->alloc = alloc_nr(lifo->nr + 1);
-		lifo->items = xrealloc(lifo->items,
-			lifo->alloc * sizeof(struct commit_info));
-	}
+
+	ALLOC_GROW(lifo->items, lifo->nr + 1, lifo->alloc);
 	info = lifo->items + lifo->nr;
 	info->commit = commit;
 	info->util = util;
-- 
1.8.5.3
