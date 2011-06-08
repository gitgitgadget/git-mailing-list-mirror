From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 32/48] merge-recursive: Add comments about handling rename/add-source cases
Date: Wed,  8 Jun 2011 01:31:02 -0600
Message-ID: <1307518278-23814-33-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEr-0006q0-3y
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320Ab1FHHbV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:31:21 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35036 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755091Ab1FHHaA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:30:00 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so118980pwi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=0vXHgF8Id7vI1bugPaqADa3F/5Fh9DU8ghjABmBMzUI=;
        b=dV4MlUEOEa9THksCyWlCjTt+LygVyw/B70EFk86a/ZUu3btf3KxZbJseOrrcuc9zmr
         NVk6sDFWDmR9aZC2SRm3FqTGX/A2PzZM7FywDzT0JyFQzdQCQWwIDQD78IZzN3LzdbEJ
         iN46Vth05J3i9nm6cq1RuWv9hg33G4xIvxe/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LrWVBMVsN7DFTbISSNqAiMMtLvKJ1OP7Vym8c3ai/zeKEljmnFQma+YM7UP2y5ct9M
         wMJTcjjgF6Ae4jYJsOsui6PeK61v8ZaGy62IpRPyQl07JO1ecyyJsfVI0tlchdUC1sQF
         mrH3PMA7HLqmOKNkLTjVkb9FteKUlLz9cuSJ4=
Received: by 10.142.249.6 with SMTP id w6mr205658wfh.116.1307518200386;
        Wed, 08 Jun 2011 00:30:00 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.58
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175326>

There are a couple of places where changes are needed to for situations
involving rename/add-source issues.  Add comments about the needed changes
(and existing bugs) until git has been enabled to detect such cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4c42838..5ccc59c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1072,6 +1072,9 @@ static int process_renames(struct merge_options *o,
 		}
 
 		ren1->dst_entry->processed = 1;
+		/* BUG: We should only mark src_entry as processed if we
+		 * are not dealing with a rename + add-source case.
+		 */
 		ren1->src_entry->processed = 1;
 
 		if (ren1->processed)
@@ -1098,6 +1101,10 @@ static int process_renames(struct merge_options *o,
 							      ren1->dst_entry,
 							      ren2->dst_entry);
 			} else {
+				/* BUG: We should only remove ren1_src in
+				 * the base stage (think of rename +
+				 * add-source cases).
+				 */
 				remove_file(o, 1, ren1_src, 1);
 				update_entry(ren1->dst_entry,
 					     ren1->pair->one,
@@ -1121,6 +1128,10 @@ static int process_renames(struct merge_options *o,
 			int renamed_stage = a_renames == renames1 ? 2 : 3;
 			int other_stage =   a_renames == renames1 ? 3 : 2;
 
+			/* BUG: We should only remove ren1_src in the base
+			 * stage and in other_stage (think of rename +
+			 * add-source case).
+			 */
 			remove_file(o, 1, ren1_src,
 				    renamed_stage == 2 || !was_tracked(ren1_src));
 
-- 
1.7.6.rc0.62.g2d69f
