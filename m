From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] Plug a resource leak in threaded pack-objects code.
Date: Mon, 17 Dec 2007 20:12:52 +0100
Message-ID: <200712172012.52374.johannes.sixt@telecom.at>
References: <200712160018.54171.johannes.sixt@telecom.at> <200712162045.34456.johannes.sixt@telecom.at> <476628D1.4020300@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Peter Baumann <waste.manager@gmx.de>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 20:15:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4LPC-0006Og-Qi
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 20:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbXLQTNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 14:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753029AbXLQTNL
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 14:13:11 -0500
Received: from smtp5.srv.eunet.at ([193.154.160.227]:33499 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402AbXLQTNK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 14:13:10 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id 7161313A2AC;
	Mon, 17 Dec 2007 20:13:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 275BD4CC27;
	Mon, 17 Dec 2007 20:12:53 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <476628D1.4020300@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68602>

A mutex and a condition variable is allocated for each thread and torn
down when the thread terminates. However, for certain workloads it can
happen that some threads are actually not started at all. In this case
we would leak the mutex and condition variable. Now we allocate them only
for those threads that are actually started.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
> I just discovered a theoretical resource leakage:
>
> Will send a patch this evening.

Here it is.

-- Hannes

 builtin-pack-objects.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 5765d02..e0ce114 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1670,8 +1670,6 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 		p[i].processed = processed;
 		p[i].working = 1;
 		p[i].data_ready = 0;
-		pthread_mutex_init(&p[i].mutex, NULL);
-		pthread_cond_init(&p[i].cond, NULL);
 
 		/* try to split chunks on "path" boundaries */
 		while (sub_size < list_size && list[sub_size]->hash &&
@@ -1690,6 +1688,8 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 	for (i = 0; i < delta_search_threads; i++) {
 		if (!p[i].list_size)
 			continue;
+		pthread_mutex_init(&p[i].mutex, NULL);
+		pthread_cond_init(&p[i].cond, NULL);
 		ret = pthread_create(&p[i].thread, NULL,
 				     threaded_find_deltas, &p[i]);
 		if (ret)
-- 
1.5.4.rc0.37.g78e7
