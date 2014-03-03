From: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>
Subject: [PATCH v3 05/11] diff.c: use ALLOC_GROW()
Date: Mon, 03 Mar 2014 11:22:02 +0400
Message-ID: <53142D9A.40707@yandex.ru>
References: <530FA3E7.8020200@yandex.ru> <53142CB9.80100@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 03 08:22:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKND3-0001jL-5o
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 08:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928AbaCCHWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 02:22:41 -0500
Received: from forward10l.mail.yandex.net ([84.201.143.143]:56378 "EHLO
	forward10l.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753772AbaCCHWk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 02:22:40 -0500
Received: from smtp1o.mail.yandex.net (smtp1o.mail.yandex.net [37.140.190.26])
	by forward10l.mail.yandex.net (Yandex) with ESMTP id 84089BA0EB9
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:22:39 +0400 (MSK)
Received: from smtp1o.mail.yandex.net (localhost [127.0.0.1])
	by smtp1o.mail.yandex.net (Yandex) with ESMTP id 57DB1DE1480
	for <git@vger.kernel.org>; Mon,  3 Mar 2014 11:22:39 +0400 (MSK)
Received: from unknown (unknown [31.181.208.245])
	by smtp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id A6iYLumV4H-MccasiNS;
	Mon,  3 Mar 2014 11:22:38 +0400
	(using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 00ddb282-ee0a-4beb-944c-793b91407635
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1393831359;
	bh=D64QvqW6kBhDBe3r+PITocwhQhKODPSsb/SVWQAhP+w=;
	h=Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=OzooTiEGN9Xq/YEdxgb5CDP9SSAWkefLTmawWdEI11Z8dbkUNGsC+71dV0p5GPraD
	 P5gSdYHW6rbkw3x9uhMYHOZ/i/fV9Rnbm6BixhwhoKez00MWRxztJkqFCokl+S2+8H
	 pzc3o0P2AJkajlktxpFmjciqBC/u6DHES0sOoDyw=
Authentication-Results: smtp1o.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <53142CB9.80100@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243184>

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
1.8.5.3
