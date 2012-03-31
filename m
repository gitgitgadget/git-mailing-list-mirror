From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/3] commit: use mergesort() in commit_list_sort_by_date()
Date: Sun, 01 Apr 2012 00:10:39 +0200
Message-ID: <4F7780DF.1000902@lsrfire.ath.cx>
References: <201203291818.49933.mfick@codeaurora.org> <7v7gy2q1kq.fsf@alter.siamese.dyndns.org> <60bff12d-544c-4fbd-b48a-0fdf44efaded@email.android.com> <20120330093207.GA12298@sigill.intra.peff.net> <20120330094052.GB12298@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Martin Fick <mfick@codeaurora.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 01 00:11:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SE6Vk-0006ld-UM
	for gcvg-git-2@plane.gmane.org; Sun, 01 Apr 2012 00:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720Ab2CaWLB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Mar 2012 18:11:01 -0400
Received: from india601.server4you.de ([85.25.151.105]:33719 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753705Ab2CaWKq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2012 18:10:46 -0400
Received: from [192.168.2.105] (p4FFD98B5.dip.t-dialin.net [79.253.152.181])
	by india601.server4you.de (Postfix) with ESMTPSA id CACDF2F8038;
	Sun,  1 Apr 2012 00:10:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <20120330094052.GB12298@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194466>

Replace the insertion sort in commit_list_sort_by_date() with a
call to the generic mergesort function.  This sets the stage for
using commit_list_sort_by_date() for larger lists, as shown in
the next patch.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 commit.c |   29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/commit.c b/commit.c
index 4b39c19..0d0c424 100644
--- a/commit.c
+++ b/commit.c
@@ -7,6 +7,7 @@
 #include "revision.h"
 #include "notes.h"
 #include "gpg-interface.h"
+#include "mergesort.h"
 
 int save_commit_buffer = 1;
 
@@ -390,15 +391,31 @@ struct commit_list * commit_list_insert_by_date(struct commit *item, struct comm
 	return commit_list_insert(item, pp);
 }
 
+static int commit_list_compare_by_date(const void *a, const void *b)
+{
+	unsigned long a_date = ((const struct commit_list *)a)->item->date;
+	unsigned long b_date = ((const struct commit_list *)b)->item->date;
+	if (a_date < b_date)
+		return 1;
+	if (a_date > b_date)
+		return -1;
+	return 0;
+}
+
+static void *commit_list_get_next(const void *a)
+{
+	return ((const struct commit_list *)a)->next;
+}
+
+static void commit_list_set_next(void *a, void *next)
+{
+	((struct commit_list *)a)->next = next;
+}
 
 void commit_list_sort_by_date(struct commit_list **list)
 {
-	struct commit_list *ret = NULL;
-	while (*list) {
-		commit_list_insert_by_date((*list)->item, &ret);
-		*list = (*list)->next;
-	}
-	*list = ret;
+	*list = mergesort(*list, commit_list_get_next, commit_list_set_next,
+			  commit_list_compare_by_date);
 }
 
 struct commit *pop_most_recent_commit(struct commit_list **list,
-- 
1.7.9.2
