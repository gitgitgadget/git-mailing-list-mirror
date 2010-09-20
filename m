From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 29/37] merge-recursive: Delay handling of rename/delete conflicts
Date: Mon, 20 Sep 2010 02:29:02 -0600
Message-ID: <1284971350-30590-30-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblL-0006R4-5q
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921Ab0ITI2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:33 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37157 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab0ITI2b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:31 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so1071833pvg.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fi9/6rpVubHyS62IlvtfFw6zysWitm0S/G1ZGMP1Tjk=;
        b=hLjc/pxLS0yx8iKiidIwDsGPhEdPS6G7o7jIGI9JtcGpXcZeogRfdCDwfbxAWXZelp
         S8w8BsqiAtNQ4vy7fTOGi/5JUagmpde/Dow5VK0t5pyx4opPxhVCGQLMKeGzjAJ/5obY
         t8MTeJERnf6EZcMMIGDO3H76uyDG+Yqb1QVsM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bLzkA77a2VcU9aFX0voo4SsxB6j2+jxc+mrEuVqTEmidcE9SCVZFbXeGU9QQOj39xo
         gKggzmxjmrq18BnCu/RcD2vx8WHpB5EbNz0A5aSSr9sZR9jdHMaEa73yyb/wCFEB1h09
         qv7FPlsYo2ZlNSYNUE8u3zuWqTdwwKDWCjp+I=
Received: by 10.142.101.1 with SMTP id y1mr7106393wfb.176.1284971310813;
        Mon, 20 Sep 2010 01:28:30 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.28
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156578>

Move the handling of rename/delete conflicts from process_renames() to
process_df_entry().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 21b52d4..81508b3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1004,8 +1004,20 @@ static int process_renames(struct merge_options *o,
 			try_merge = 0;
 
 			if (sha_eq(src_other.sha1, null_sha1)) {
-				clean_merge = 0;
-				conflict_rename_delete(o, ren1->pair, branch1, branch2);
+				if (string_list_has_string(&o->current_directory_set, ren1_dst)) {
+					ren1->dst_entry->processed = 0;
+					setup_rename_df_conflict_info(RENAME_DELETE,
+								      ren1->pair,
+								      NULL,
+								      branch1,
+								      branch2,
+								      ren1->dst_entry,
+								      NULL);
+					remove_file(o, 0, ren1_dst, 0);
+				} else {
+					clean_merge = 0;
+					conflict_rename_delete(o, ren1->pair, branch1, branch2);
+				}
 			} else if ((dst_other.mode == ren1->pair->two->mode) &&
 				   sha_eq(dst_other.sha1, ren1->pair->two->sha1)) {
 				/* Added file on the other side
@@ -1346,6 +1358,12 @@ static int process_df_entry(struct merge_options *o,
 		struct rename_df_conflict_info *conflict_info = entry->rename_df_conflict_info;
 		char *src;
 		switch (conflict_info->rename_type) {
+		case RENAME_DELETE:
+			clean_merge = 0;
+			conflict_rename_delete(o, conflict_info->pair1,
+					       conflict_info->branch1,
+					       conflict_info->branch2);
+			break;
 		case RENAME_ONE_FILE_TO_TWO:
 			src = conflict_info->pair1->one->path;
 			clean_merge = 0;
-- 
1.7.3.271.g16009
