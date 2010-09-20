From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 28/37] merge-recursive: Move handling of double rename of one file to other file
Date: Mon, 20 Sep 2010 02:29:01 -0600
Message-ID: <1284971350-30590-29-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblK-0006R4-LN
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755917Ab0ITI2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:30 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63878 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755897Ab0ITI23 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:29 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1072016pxi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=MNPyBLDrGWsiR9qcgooges4Pc5qHo5oLWIWCyW7Cmzw=;
        b=LygA498CbALQabueR5cYEdeqVc8YK+ZeXyIoDGcKijXVay9co9gvNcs4zFe9js3CqD
         vqBd5lTUPmkmqNOgm7UG9m0OpUPQIwNHlMMIftUPNBei42TyMbyMYtgNobqst8Vi2ZQV
         LHzIuzAgBmyI1zYWudCrLHv3T7KV+6whILtKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FjsQyijy4RCbdsNNz9TICFx39mYct5vmC/0+V8fffgY1f2YC86utT4EDk67JaX49RP
         WF7FCwRlAqQCsgkshJAaTmWp0msIjXP/e23ZOTvzsUzxkkhCLl9jHgt7TUBSKy5e7HVZ
         b/lYJZyfKBhRfox/nxbpF68VF9IRI1zDX6a5k=
Received: by 10.142.119.7 with SMTP id r7mr487415wfc.85.1284971308828;
        Mon, 20 Sep 2010 01:28:28 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.26
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:27 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156590>

Move the handling of rename/rename conflicts where one file is renamed on
both sides to the same file, from process_renames() to process_entry().
Here we avoid the three way merge logic by just using
update_stages_and_entry() to move the higher stage entries in the index
from the rename source to the rename destination, and then allow
process_entry() to do its magic.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   32 ++++++--------------------------
 1 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e219d62..21b52d4 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -971,33 +971,13 @@ static int process_renames(struct merge_options *o,
 				remove_file(o, 0, ren1_dst, 0);
 				/* ren2_dst not in head, so no need to delete */
 			} else {
-				struct merge_file_info mfi;
 				remove_file(o, 1, ren1_src, 1);
-				mfi = merge_file(o,
-						 ren1->pair->one,
-						 ren1->pair->two,
-						 ren2->pair->two,
-						 branch1,
-						 branch2);
-				if (mfi.merge || !mfi.clean)
-					output(o, 1, "Renaming %s->%s", src, ren1_dst);
-
-				if (mfi.merge)
-					output(o, 2, "Auto-merging %s", ren1_dst);
-
-				if (!mfi.clean) {
-					output(o, 1, "CONFLICT (content): merge conflict in %s",
-					       ren1_dst);
-					clean_merge = 0;
-
-					if (!o->call_depth)
-						update_stages(ren1_dst,
-							      ren1->pair->one,
-							      ren1->pair->two,
-							      ren2->pair->two,
-							      1 /* clear */);
-				}
-				update_file(o, mfi.clean, mfi.sha, mfi.mode, ren1_dst);
+				update_stages_and_entry(ren1_dst,
+							ren1->dst_entry,
+							ren1->pair->one,
+							ren1->pair->two,
+							ren2->pair->two,
+							1 /* clear */);
 			}
 		} else {
 			/* Renamed in 1, maybe changed in 2 */
-- 
1.7.3.271.g16009
