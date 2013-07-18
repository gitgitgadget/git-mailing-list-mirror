From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 1/3] treewalk.c: Rename variable ret to cb_bits and remove some dead lines.
Date: Thu, 18 Jul 2013 23:35:25 +0200
Message-ID: <1374183327-14939-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 18 23:35:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzvrO-0004bk-PS
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 23:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965385Ab3GRVff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 17:35:35 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:60776 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759222Ab3GRVfc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 17:35:32 -0400
Received: by mail-wi0-f176.google.com with SMTP id ey16so7164367wid.3
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 14:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=dUaex5o5MCbMMJ1W/KRCix647uoZcqTRqPqrQS9AGBM=;
        b=V+GEmEK/lX0oolmgNq35+ypQJrB9a+7BQY0a3N/roMiUb7CuXiW5hHITKavgTo6OjM
         5c0SECeolVQXprRb0bQ5lm8jJw7kwWfmiCp9d0r+nSn9dBfL7cuhTPdR2Ke21CMNstPG
         LeoRcZodqHd4EUfecdEx5aNdureEizaQmrHZDVQcCsdxJcgASR7L2f+JXR+3bP9IGapz
         KS9UBocN5xMyeRuKPlJHCfYBilMp1B7wWn9HwCaKkwAw0o6BtSACPn4/juAsyV6yCwHa
         oQhlKLvrqoVr8L1nR6xBS7pQLbIM7GprKamPCYvSVvrSfJV9vuX6EQpJwfG1ZjV0wFDw
         ogfg==
X-Received: by 10.180.211.233 with SMTP id nf9mr9438135wic.41.1374183331039;
        Thu, 18 Jul 2013 14:35:31 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id o10sm19242160wiz.5.2013.07.18.14.35.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 14:35:30 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.3.754.g9c3c367.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230749>

The variable name ret sounds like the variable to be returned, but
since e6c111b4 we return error. Hence the variable name is miss leading.
As this variable is used only to extract the bits from the callback of
a tree object, I named it cb_bits for callback bits.

Also the assignment to 0 was removed at the start of the function as well
after the if(interesting) block. Those were unneeded as that variable
is set to the callback return value any time we enter the if(interesting)
block, so we'd overwrite old values anyway.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 tree-walk.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index c366852..3c323d1 100644
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
+		int cb_bits;
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
+			cb_bits = info->fn(n, mask, dirmask, entry, info);
+			if (cb_bits < 0) {
+				error = cb_bits;
 				if (!info->show_all_errors)
 					break;
 			}
-			mask &= ret;
+			mask &= cb_bits;
 		}
-		ret = 0;
 		for (i = 0; i < n; i++)
 			if (mask & (1ul << i))
 				update_extended_entry(tx + i, entry + i);
-- 
1.8.3.3.754.g9c3c367.dirty
