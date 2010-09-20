From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 14/37] merge-recursive: Small code clarification -- variable name and comments
Date: Mon, 20 Sep 2010 02:28:47 -0600
Message-ID: <1284971350-30590-15-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:28:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxbjT-0005rH-Qd
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858Ab0ITI2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:04 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37157 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755848Ab0ITI2A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:00 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1071833pvg.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5KAtg5U9wB3qZ9nRhFQSG+pbYsBGNGgWD1dzSs0do68=;
        b=udjf3YtyvMiJWet4t/i9tVgv6/ttl0iqU7VmCHjTnSE8ImS/x1EYEK2QIDCfwcAgOo
         AAZMW1KyE+354FEMQRPQyFFoFJUoF0LvIVQLBKgfo+QV0JRS9OFuGr+7RhYl9DarM1tE
         dmEI9XuYR6hFZ+aT+23FDyAuj/K7afyK3HjoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Cyf0QGf9YWHXBESRaa7JOsnOJo//dWByLwSDGiOTxO5IoBsKGIk6O4McxISLQBXK6S
         aMj3rWGVQcYFnMvHmIWwNuwvMJ4KsRdUQDREaq9AdaIYv0gn2TOpphQdE+E60Pbg7DP5
         zYqRBvo5kw/0uIyJpWs/B8XUNxV+WYE3J8Tno=
Received: by 10.142.199.18 with SMTP id w18mr7317290wff.336.1284971280289;
        Mon, 20 Sep 2010 01:28:00 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.27.58
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:27:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156566>

process_renames() had a variable named "stage" and derived variables
src_other and dst_other whose purpose was not immediately obvious; also,
I want to extend the scope of this variable and use it later, so it should
have a more descriptive name.  Do so, and add a brief comment explaining
how it is used and what it relates to.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4d9c165..8f45cec 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -925,15 +925,23 @@ static int process_renames(struct merge_options *o,
 			struct string_list_item *item;
 			/* we only use sha1 and mode of these */
 			struct diff_filespec src_other, dst_other;
-			int try_merge, stage = a_renames == renames1 ? 3: 2;
+			int try_merge;
 
-			remove_file(o, 1, ren1_src, o->call_depth || stage == 3);
+			/*
+			 * unpack_trees loads entries from common-commit
+			 * into stage 1, from head-commit into stage 2, and
+			 * from merge-commit into stage 3.  We keep track
+			 * of which side corresponds to the rename.
+			 */
+			int renamed_stage = a_renames == renames1 ? 2 : 3;
+			int other_stage =   a_renames == renames1 ? 3 : 2;
 
-			hashcpy(src_other.sha1, ren1->src_entry->stages[stage].sha);
-			src_other.mode = ren1->src_entry->stages[stage].mode;
-			hashcpy(dst_other.sha1, ren1->dst_entry->stages[stage].sha);
-			dst_other.mode = ren1->dst_entry->stages[stage].mode;
+			remove_file(o, 1, ren1_src, o->call_depth || renamed_stage == 2);
 
+			hashcpy(src_other.sha1, ren1->src_entry->stages[other_stage].sha);
+			src_other.mode = ren1->src_entry->stages[other_stage].mode;
+			hashcpy(dst_other.sha1, ren1->dst_entry->stages[other_stage].sha);
+			dst_other.mode = ren1->dst_entry->stages[other_stage].mode;
 			try_merge = 0;
 
 			if (sha_eq(src_other.sha1, null_sha1)) {
-- 
1.7.3.271.g16009
