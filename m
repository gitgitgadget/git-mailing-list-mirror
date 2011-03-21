From: Elijah Newren <newren@gmail.com>
Subject: [WIP PATCH 03/10] A bunch of fixes and FIXMEs
Date: Mon, 21 Mar 2011 12:30:57 -0600
Message-ID: <1300732264-9638-4-git-send-email-newren@gmail.com>
References: <1300732264-9638-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 19:24:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1jmk-0000RW-9I
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 19:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128Ab1CUSYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 14:24:45 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62978 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab1CUSYm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 14:24:42 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so5291756vws.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 11:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=9VJfHjsy4hSr7k3xreV1iVStctdoUD+m7rzy2ZPcL90=;
        b=d/lbD3btWyFs/9E8ic5JAHCRK5dp2So92X7S0y3kc/gXUpQe9/QIwa2CFOYn8wYk8T
         QqFMBmhQRFIysp43xREmhk/rvrPloyPEmfjtimPamKryL5S5MKftkO8cD0TbDuD7Jf+a
         Hi7OhKPYVO7vYe8iPY2Cz14Gr2FVTPR9P6ysA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=nylVTTGKZe+7PKL1nidgxHjXYiXTGfK7FYfy1YlPRIGHDDHyvmXjQWXFIflGqz+OTY
         nDmrhvU4yJ/ScHc3CEETVW0z7sCUgYDr3B3bV6WCcXZGnLvaOcJFHyWdPgtNV3O6zNCl
         B7FI5C7OcnW6RS5mVaBAgXyWlnMVVk4j9RXNA=
Received: by 10.220.180.12 with SMTP id bs12mr1275678vcb.63.1300731882484;
        Mon, 21 Mar 2011 11:24:42 -0700 (PDT)
Received: from localhost6.localdomain6 (c-174-56-87-200.hsd1.nm.comcast.net [174.56.87.200])
        by mx.google.com with ESMTPS id b6sm1507291vci.0.2011.03.21.11.24.40
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 11:24:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.120.g38a18
In-Reply-To: <1300732264-9638-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169625>

---
 merge-recursive.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 8d28a54..fde9f9e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -910,7 +910,8 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 	if (o->call_depth) {
 		/*
 		 * FIXME: This is bogus.  dst_nameX are not in cache in
-		 * case of D/F conflict.
+		 * case of D/F conflict.  renX_dst are.  Simple typo, or
+		 * something worse?
 		 */
 		remove_file_from_cache(dst_name1);
 		remove_file_from_cache(dst_name2);
@@ -1290,10 +1291,12 @@ static int merge_content(struct merge_options *o,
 		const char *new_path;
 		update_file_flags(o, mfi.sha, mfi.mode, path,
 				  o->call_depth || mfi.clean, 0);
-		new_path = unique_path(o, path, df_rename_conflict_branch);
 		mfi.clean = 0;
-		output(o, 1, "Adding as %s instead", new_path);
-		update_file_flags(o, mfi.sha, mfi.mode, new_path, 0, 1);
+		if (!o->call_depth) {
+			new_path = unique_path(o, path, df_rename_conflict_branch);
+			output(o, 1, "Adding as %s instead", new_path);
+			update_file(o, mfi.clean, mfi.sha, mfi.mode, new_path);
+		}
 	} else {
 		update_file(o, mfi.clean, mfi.sha, mfi.mode, path);
 	}
@@ -1433,6 +1436,11 @@ static int process_df_entry(struct merge_options *o,
 			       src, conflict_info->pair2->two->path, conflict_info->branch2,
 			       o->call_depth ? " (left unresolved)" : "");
 			if (o->call_depth) {
+				/*
+				 * FIXME: Why remove file from cache, and
+				 * then immediately readd it?  Why not just
+				 * overwrite using update_file only?
+				 */
 				remove_file_from_cache(src);
 				update_file(o, 0, conflict_info->pair1->one->sha1,
 					    conflict_info->pair1->one->mode, src);
-- 
1.7.4
