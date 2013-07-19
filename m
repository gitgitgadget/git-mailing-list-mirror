From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] traverse_trees(): clarify return value of the callback.
Date: Fri, 19 Jul 2013 22:26:32 +0200
Message-ID: <1374265592-2594-1-git-send-email-stefanbeller@googlemail.com>
References: <51E9A0D0.3090701@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 19 22:26:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0HGB-0007K0-3r
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 22:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656Ab3GSU0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 16:26:35 -0400
Received: from mail-ee0-f50.google.com ([74.125.83.50]:56430 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab3GSU0e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 16:26:34 -0400
Received: by mail-ee0-f50.google.com with SMTP id d49so2560816eek.37
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 13:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TYJh6ClCTMoAvqswSRSSnS5pcT0nwTOehXljpjpDpVo=;
        b=UuWOIoqR0jyeuEJrUSJiKQ5dlDG0sDMQh5wjO1BuSu/yOH86Oz/B7Ri/jG18uM+6wU
         ox7QVurAoMVyclXCMCFWAEfJ26NmPTPLH7AC8qwusX2c/yP4yIuFzueQE5drYWitC8Yp
         vqXUYCGSV0cQZp8UDrgyR1OBJTuqbsQ9KFyqUfnVz7EQPG8keW9E0tjZmQYDHg6y1LmF
         ztZ8dYiixXAho8VpFoSG82uBgR76Yehzo0nFVLjtodKij/nCvqPL0CZ7pfpdYoRDRY0V
         be7lGjxTNdsTlikQjFYzGv+70Thzvkz+2HR57km7VqlDmUJhuz5dU6y35gaWSvldncsN
         lkfQ==
X-Received: by 10.14.216.73 with SMTP id f49mr17387798eep.119.1374265593055;
        Fri, 19 Jul 2013 13:26:33 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id m1sm30017775eex.17.2013.07.19.13.26.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jul 2013 13:26:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.754.g9c3c367.dirty
In-Reply-To: <51E9A0D0.3090701@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230847>

The variable name ret sounds like the variable to be returned, but
since e6c111b4 we return error. Hence the variable name is miss leading.
As this variable is used only to extract the bits from the callback of
a tree object, trees_used is a better name.

Also the assignment to 0 was removed at the start of the function as well
after the if(interesting) block. Those were unneeded as that variable
is set to the callback return value any time we enter the if(interesting)
block, so we'd overwrite old values anyway.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 tree-walk.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index c366852..5ece8c3 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -324,7 +324,6 @@ static inline int prune_traversal(struct name_entry *e,
 
 int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 {
-	int ret = 0;
 	int error = 0;
 	struct name_entry *entry = xmalloc(n*sizeof(*entry));
 	int i;
@@ -342,6 +341,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 		strbuf_setlen(&base, info->pathlen);
 	}
 	for (;;) {
+		int trees_used;
 		unsigned long mask, dirmask;
 		const char *first = NULL;
 		int first_len = 0;
@@ -405,15 +405,14 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 		if (interesting < 0)
 			break;
 		if (interesting) {
-			ret = info->fn(n, mask, dirmask, entry, info);
-			if (ret < 0) {
-				error = ret;
+			trees_used = info->fn(n, mask, dirmask, entry, info);
+			if (trees_used < 0) {
+				error = trees_used;
 				if (!info->show_all_errors)
 					break;
 			}
-			mask &= ret;
+			mask &= trees_used;
 		}
-		ret = 0;
 		for (i = 0; i < n; i++)
 			if (mask & (1ul << i))
 				update_extended_entry(tx + i, entry + i);
-- 
1.8.3.3.754.g9c3c367.dirty
