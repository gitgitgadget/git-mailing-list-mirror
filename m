From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v2 2/3] Fix memory leak in apply_patch in apply.c.
Date: Sat,  3 Mar 2012 09:40:29 -0500
Message-ID: <e631bb2059c800f9d49eed51cfa5ba4d04106a2e.1330785363.git.jaredhance@gmail.com>
References: <cover.1330740964.git.jaredhance@gmail.com>
Cc: gitster@pobox.com, Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 15:41:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3q9D-0000Yu-7x
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 15:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169Ab2CCOlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 09:41:12 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38321 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab2CCOlL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 09:41:11 -0500
Received: by mail-iy0-f174.google.com with SMTP id z16so3544384iag.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 06:41:11 -0800 (PST)
Received-SPF: pass (google.com: domain of jaredhance@gmail.com designates 10.43.49.195 as permitted sender) client-ip=10.43.49.195;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jaredhance@gmail.com designates 10.43.49.195 as permitted sender) smtp.mail=jaredhance@gmail.com; dkim=pass header.i=jaredhance@gmail.com
Received: from mr.google.com ([10.43.49.195])
        by 10.43.49.195 with SMTP id vb3mr3119175icb.33.1330785671262 (num_hops = 1);
        Sat, 03 Mar 2012 06:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=SijMJTkQ5SLvoQj9GRU0sB6twRzIXVxtgVJotyjRTlM=;
        b=gMGUeGSuFNHatG1vikc4y27D4u0MaLvdfTseklYF0PMSx6KOCYFpS8WHJsSTPJmv3Q
         5qplZcxyCPj1UAbHARmKsSAxQVN+HDACgs+8ubshrzPY4BbhPIyVVRG4JAcjS/6cxzs5
         ZKWSVm4FW8VFIArtGKxme+QlGtPLJJm9IRsOKq/WsbeC7UdQGZuWkEyEX27Gu345w+kV
         y/HyUrdi4haxBiDsUftAzTxXvrtohfps5W20MhHso+zFDhNqP3eiHVde4espu614rkyX
         pQU8Ae6FKqJA/cNGybHKxJCw4sK1XxeTLdptNZjirJmBapmFMUoRg3M21iLuHR0KwvFS
         7uxg==
Received: by 10.43.49.195 with SMTP id vb3mr2584070icb.33.1330785671221;
        Sat, 03 Mar 2012 06:41:11 -0800 (PST)
Received: from localhost.localdomain (cpe-174-101-220-163.cinci.res.rr.com. [174.101.220.163])
        by mx.google.com with ESMTPS id b6sm5212250igj.7.2012.03.03.06.41.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 06:41:10 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1330740964.git.jaredhance@gmail.com>
In-Reply-To: <cover.1330785363.git.jaredhance@gmail.com>
References: <cover.1330785363.git.jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192112>

In the while loop inside apply_patch, patch is dynamically allocated
with a calloc. However, only unused patches are actually free'd; the
rest are left in a memory leak. Since a list is actively built up
consisting of the used patches, they can simply be iterated and free'd
at the end of the function.

In addition, the list of fragments should be free'd. To fix this, the
utility function free_patch has been implemented. It loops over the
entire patch list, and in each patch, loops over the fragment list,
freeing the fragments, followed by the patch in the list. It frees both
patch and patch->next.

The main caveat is that the text in a fragment, ie,
patch->fragments->patch, may or may not need to be free'd. The text is
dynamically allocated and needs to be freed iff the patch is a binary
patch, as allocation occurs in inflate_it.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 builtin/apply.c |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 389898f..a73d339 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -196,6 +196,30 @@ struct patch {
 	struct patch *next;
 };
 
+static void free_patch(struct patch *patch) {
+    while(patch != NULL) {
+	struct patch *patch_next;
+	struct fragment *fragment;
+
+	patch_next = patch->next;
+
+	fragment = patch->fragments;
+	while(fragment != NULL) {
+	    struct fragment *fragment_next = fragment->next;
+	    if(fragment->patch != NULL) {
+		if(patch->is_binary) {
+		    free((void*) fragment->patch);
+		}
+	    }
+	    free(fragment);
+	    fragment = fragment_next;
+	}
+
+	free(patch);
+	patch = patch_next;
+    }
+}
+
 /*
  * A line in a file, len-bytes long (includes the terminating LF,
  * except for an incomplete line at the end if the file ends with
@@ -3687,7 +3711,6 @@ static int apply_patch(int fd, const char *filename, int options)
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
 
-	/* FIXME - memory leak when using multiple patch files as inputs */
 	memset(&fn_table, 0, sizeof(struct string_list));
 	patch_input_file = filename;
 	read_patch_file(&buf, fd);
@@ -3712,8 +3735,7 @@ static int apply_patch(int fd, const char *filename, int options)
 			listp = &patch->next;
 		}
 		else {
-			/* perhaps free it a bit better? */
-			free(patch);
+			free_patch(patch);
 			skipped_patch++;
 		}
 		offset += nr;
@@ -3754,6 +3776,8 @@ static int apply_patch(int fd, const char *filename, int options)
 	if (summary)
 		summary_patch_list(list);
 
+	free_patch(list);
+
 	strbuf_release(&buf);
 	return 0;
 }
-- 
1.7.3.4
