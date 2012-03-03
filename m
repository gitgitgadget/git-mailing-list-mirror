From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH 2/3] Fix memory leak in apply_patch in apply.c.
Date: Fri,  2 Mar 2012 21:31:14 -0500
Message-ID: <03cc2ba05a5744d8b48700556f1942757151ec4b.1330740964.git.jaredhance@gmail.com>
References: <cover.1330740964.git.jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 03:31:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3elA-0000AS-Gz
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 03:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312Ab2CCCbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 21:31:37 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43617 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771Ab2CCCbf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 21:31:35 -0500
Received: by mail-iy0-f174.google.com with SMTP id z16so3102984iag.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 18:31:35 -0800 (PST)
Received-SPF: pass (google.com: domain of jaredhance@gmail.com designates 10.50.207.42 as permitted sender) client-ip=10.50.207.42;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jaredhance@gmail.com designates 10.50.207.42 as permitted sender) smtp.mail=jaredhance@gmail.com; dkim=pass header.i=jaredhance@gmail.com
Received: from mr.google.com ([10.50.207.42])
        by 10.50.207.42 with SMTP id lt10mr636454igc.1.1330741895340 (num_hops = 1);
        Fri, 02 Mar 2012 18:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=lHUtUr6rr1+RDUAyinQ0nlUjnzoLC9CSRR4lTKgbVSM=;
        b=hnFt/jyyJ2vaxBwXJSdQeSlU6MyYF9yf2Wy2ei59Myz554wmjFSaCn3Wez5wQ5Fp6S
         sI88/0AtiV/Frp342mVplXxLtSH0NrWHjzBXgOUDPHkK4GHcYKrXDe9e74QBJE7c88qK
         urb33YgwQ3Xqs6kmbcDbKYrrYvX9472O9vzonks2rFwQZxNLwfHYpXllG+Kg/sW8o0vw
         LgctMTfr5kyvvVRrvoStHo2nrACIMfJZlbcPDoc5rhMLvshyI4LL6XZQrHyg/oax6hCq
         XyD7ca3yofBu78+WnDElQ2kEdu8u+yJDacZg17tMUHXk1hhWbntQolpzPxymt2Md3gBf
         pGDQ==
Received: by 10.50.207.42 with SMTP id lt10mr520695igc.1.1330741895304;
        Fri, 02 Mar 2012 18:31:35 -0800 (PST)
Received: from localhost.localdomain (cpe-174-101-220-163.cinci.res.rr.com. [174.101.220.163])
        by mx.google.com with ESMTPS id v3sm2578583igw.6.2012.03.02.18.31.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 18:31:34 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1330740964.git.jaredhance@gmail.com>
In-Reply-To: <cover.1330740964.git.jaredhance@gmail.com>
References: <cover.1330740964.git.jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192091>

In the while loop inside apply_patch, patch is dynamically allocated
with a calloc. However, only unused patches are actually free'd; the
rest are left in a memory leak. Since a list is actively built up
consisting of the used patches, they can simply be iterated and free'd
at the end of the function.

Signed-off-by: Jared Hance <jaredhance@gmail.com>
---
 builtin/apply.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 389898f..92ebd57 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3685,9 +3685,9 @@ static int apply_patch(int fd, const char *filename, int options)
 	size_t offset;
 	struct strbuf buf = STRBUF_INIT;
 	struct patch *list = NULL, **listp = &list;
+	struct patch *patch_iter;
 	int skipped_patch = 0;
 
-	/* FIXME - memory leak when using multiple patch files as inputs */
 	memset(&fn_table, 0, sizeof(struct string_list));
 	patch_input_file = filename;
 	read_patch_file(&buf, fd);
@@ -3712,7 +3712,6 @@ static int apply_patch(int fd, const char *filename, int options)
 			listp = &patch->next;
 		}
 		else {
-			/* perhaps free it a bit better? */
 			free(patch);
 			skipped_patch++;
 		}
@@ -3753,6 +3752,13 @@ static int apply_patch(int fd, const char *filename, int options)
 
 	if (summary)
 		summary_patch_list(list);
+	
+	patch_iter = list;
+	while(patch_iter != NULL) {
+	    struct patch *patch_iter_next = patch_iter->next;
+	    free(patch_iter);
+	    patch_iter = patch_iter_next;
+	}
 
 	strbuf_release(&buf);
 	return 0;
-- 
1.7.3.4
