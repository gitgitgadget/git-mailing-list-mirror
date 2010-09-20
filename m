From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 16/37] merge-recursive: Nuke rename/directory conflict detection
Date: Mon, 20 Sep 2010 02:28:49 -0600
Message-ID: <1284971350-30590-17-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblG-0006R4-Em
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868Ab0ITI2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:07 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49332 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755848Ab0ITI2E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:04 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so1146755pwi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yQHGrAIHBEJyQjz3+ofOK53LOTNETdvIEf+IZ6r/1go=;
        b=k5rsVLfqfeKHsdOZvvYA3NoEYrtRvlx+TzgJ5UNhbzDsfQixm3ktzkansyZfyKPASr
         fZa5JQdE4PAzxYy0HawfMjz1AiaK3N46FoQ9rnj6R9hgknyWDu1e8Upl//UJap9lJbBn
         L9/X2znyE5/zS4/qbmfmoWCsMbTE67o1URWIg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GkE9bvcgRsLyEXjz/Jv3O6IYa1D5djZqrpKrsWxqxiVchUgaVREaxbC63p85IkVfOe
         qWa1I5SFNs5aBuEpMIRD2YJfDtXK3B3Yi5Jf7riTzyYgRo7cxuAm765Npjdy3VK8FjxN
         1RdbxIzAflSQfi+9Oy4Nx8unKi4QYS4ES9Q5k=
Received: by 10.142.61.38 with SMTP id j38mr7317129wfa.344.1284971284651;
        Mon, 20 Sep 2010 01:28:04 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.02
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156575>

Since we want to resolve merges in-core and then detect at the end whether
D/F conflicts remain in the way, we should just apply renames in-core and
let logic elsewhere check for D/F conflicts.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index cc1ab92..f7591a3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -773,17 +773,6 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		free(del[delp]);
 }
 
-static void conflict_rename_dir(struct merge_options *o,
-				struct rename *ren1,
-				const char *branch1)
-{
-	char *new_path = unique_path(o, ren1->pair->two->path, branch1);
-	output(o, 1, "Renaming %s to %s instead", ren1->pair->one->path, new_path);
-	remove_file(o, 0, ren1->pair->two->path, 0);
-	update_file(o, 0, ren1->pair->two->sha1, ren1->pair->two->mode, new_path);
-	free(new_path);
-}
-
 static void conflict_rename_rename_2to1(struct merge_options *o,
 					struct rename *ren1,
 					const char *branch1,
@@ -1044,13 +1033,6 @@ static int process_renames(struct merge_options *o,
 					if (!ren1->dst_entry->stages[2].mode !=
 					    !ren1->dst_entry->stages[3].mode)
 						ren1->dst_entry->processed = 0;
-				} else if (string_list_has_string(&o->current_directory_set, ren1_dst)) {
-					clean_merge = 0;
-					output(o, 1, "CONFLICT (rename/directory): Rename %s->%s in %s "
-					       " directory %s added in %s",
-					       ren1_src, ren1_dst, branch1,
-					       ren1_dst, branch2);
-					conflict_rename_dir(o, ren1, branch1);
 				} else {
 					if (mfi.merge || !mfi.clean)
 						output(o, 1, "Renaming %s => %s", ren1_src, ren1_dst);
-- 
1.7.3.271.g16009
