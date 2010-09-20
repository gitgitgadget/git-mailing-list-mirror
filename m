From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 37/37] merge-recursive: Remove redundant path clearing for D/F conflicts
Date: Mon, 20 Sep 2010 02:29:10 -0600
Message-ID: <1284971350-30590-38-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblP-0006R4-Fh
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755973Ab0ITI2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:48 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49332 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968Ab0ITI2r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:47 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so1146755pwi.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BUkrtPpjbPYhHhUjXJi4VVmtsVv+2wKZL3+HaSeBwfo=;
        b=Qp67lm8/sO15Shz3ACBLE23ZSmcnwSxUybF3ASqF7idD1pd2bGv6rdXGXDCutiscmw
         3oMUy4aIwgrqPz/cYdukC6Y0jm2tHlp9rixEypmx3sEZikPtvQT12dQRYw6saJf+Z5vE
         dNeo2bgZ7j/4mBNezk/2Op0h8oryCuIJ48AYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KSuXalW97k65ExNWqZ2ai5QouAJyWfhcOEYT9PshyljLAos7BSzcfkpjL3Lgbhn51T
         fMdI14ZNWVs8tsVfS1ZVHiFslRJRDhqxWCjnTLMK0Pf7L4IkyW/E8mGraGHOZHKMdIYL
         8I756cMSpvvpLJeulRgIbEQIkJuubGnfEbAp0=
Received: by 10.143.32.14 with SMTP id k14mr5266519wfj.265.1284971327123;
        Mon, 20 Sep 2010 01:28:47 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.45
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156591>

The code had several places where individual checks were done to remove
files that could be in the way of directories in D/F conflicts.  Not all
D/F conflicts could have a path cleared for them in such a manner, however,
leading to the need to create make_room_for_directories_of_df_conflicts()
as done in the previous patch.  That new function could not have been
incorporated into the code sooner, since not all relevant code paths had
been deferred to process_df_entry() yet, leading to the creation of even
more of these now-redundant path removals.

Clean out all of these extra D/F path clearing cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c |   17 ++---------------
 1 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 821bed8..494e15a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1032,8 +1032,6 @@ static int process_renames(struct merge_options *o,
 							      branch2,
 							      ren1->dst_entry,
 							      ren2->dst_entry);
-				remove_file(o, 0, ren1_dst, 0);
-				/* ren2_dst not in head, so no need to delete */
 			} else {
 				remove_file(o, 1, ren1_src, 1);
 				update_stages_and_entry(ren1_dst,
@@ -1077,7 +1075,6 @@ static int process_renames(struct merge_options *o,
 								      branch2,
 								      ren1->dst_entry,
 								      NULL);
-					remove_file(o, 0, ren1_dst, 0);
 				} else {
 					clean_merge = 0;
 					conflict_rename_delete(o, ren1->pair, branch1, branch2);
@@ -1156,7 +1153,6 @@ static int process_renames(struct merge_options *o,
 								      NULL,
 								      ren1->dst_entry,
 								      NULL);
-					remove_file(o, 0, ren1_dst, 0);
 				}
 			}
 		}
@@ -1338,7 +1334,7 @@ static int process_entry(struct merge_options *o,
 		} else if (string_list_has_string(&o->current_directory_set,
 						  path)) {
 			entry->processed = 0;
-			return 1; /* Assume clean till processed */
+			return 1; /* Assume clean until processed */
 		} else {
 			/* Deleted in one and changed in the other */
 			clean_merge = 0;
@@ -1362,15 +1358,7 @@ static int process_entry(struct merge_options *o,
 		if (string_list_has_string(&o->current_directory_set, path)) {
 			/* Handle D->F conflicts after all subfiles */
 			entry->processed = 0;
-			/* But get any file out of the way now, so conflicted
-			 * entries below the directory of the same name can
-			 * be put in the working directory.
-			 */
-			if (a_sha)
-				output(o, 2, "Removing %s", path);
-			/* do not touch working file if it did not exist */
-			remove_file(o, 0, path, !a_sha);
-			return 1; /* Assume clean till processed */
+			return 1; /* Assume clean until processed */
 		} else {
 			output(o, 2, "Adding %s", path);
 			update_file(o, 1, sha, mode, path);
@@ -1492,7 +1480,6 @@ static int process_df_entry(struct merge_options *o,
 			output(o, 1, "CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s",
 			       conf, path, other_branch, path, new_path);
-			remove_file(o, 0, path, 0);
 			update_file(o, 0, sha, mode, new_path);
 		} else {
 			output(o, 2, "Adding %s", path);
-- 
1.7.3.271.g16009
