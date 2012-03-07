From: Jared Hance <jaredhance@gmail.com>
Subject: [PATCH v3 1/3] Fix memory leak in apply_patch in apply.c.
Date: Wed,  7 Mar 2012 17:21:25 -0500
Message-ID: <eadfc83a0d823cc04ea37bf606b57597fb632156.1331158240.git.jaredhance@gmail.com>
References: <cover.1331158240.git.jaredhance@gmail.com>
Cc: Jared Hance <jaredhance@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 07 23:21:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5PEu-0004ug-8Z
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 23:21:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757396Ab2CGWVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 17:21:35 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:37079 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755025Ab2CGWVd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 17:21:33 -0500
Received: by mail-tul01m020-f174.google.com with SMTP id uo6so7476933obb.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 14:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=KsKGrYqai3b4hKfFJOOviBv5rk02OrlUXSNYR6pUosU=;
        b=tggMIP/bJqw+pqV4MDVbafYyASnjOEnE94v0ebP1iUPCTbrNDE6726D380O2HuMHTl
         c30bm1R+ivT6/59QZTZ+vBfjEjNqTO0qJnuD86Lt3fd2pcrKxTpIs07zuo3lFJsDtR8Z
         Zh78nyxhW2MIL+k9M1AUSN5S9d0diWDQLsOmqAmWiln7xOpY+VgyXK6cA+uCJ5mf34yA
         PnWR1y3PTh3UrXL8QIHzXKV8pCzYAmG5RbrcjgDjytlRyYRgWQ46Fr3O9FfqZ3CuWAMP
         QiEd0JjsIV5g+Rkf50TzYYpirJGN/gVsDwnpBfBhNkMHFx2Q3xACPoJh0zsXe9IsIP7Q
         zb3Q==
Received: by 10.60.29.68 with SMTP id i4mr1612302oeh.7.1331158893380;
        Wed, 07 Mar 2012 14:21:33 -0800 (PST)
Received: from localhost.localdomain (mail.middletownlibrary.org. [66.213.99.6])
        by mx.google.com with ESMTPS id gl4sm23853230obb.23.2012.03.07.14.21.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Mar 2012 14:21:32 -0800 (PST)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <cover.1331158240.git.jaredhance@gmail.com>
In-Reply-To: <cover.1331158240.git.jaredhance@gmail.com>
References: <cover.1331158240.git.jaredhance@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192493>

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
 builtin/apply.c |   31 ++++++++++++++++++++++++++++---
 1 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 389898f..4c6b278 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -153,6 +153,7 @@ struct fragment {
 	unsigned long oldpos, oldlines;
 	unsigned long newpos, newlines;
 	const char *patch;
+	unsigned int free_patch:1;
 	int size;
 	int rejected;
 	int linenr;
@@ -196,6 +197,29 @@ struct patch {
 	struct patch *next;
 };
 
+static void free_patch(struct patch *patch)
+{
+	while (patch != NULL) {
+		struct patch *patch_next;
+		struct fragment *fragment;
+
+		patch_next = patch->next;
+
+		fragment = patch->fragments;
+		while (fragment != NULL) {
+			struct fragment *fragment_next = fragment->next;
+			if (fragment->patch != NULL && fragment->free_patch) {
+				free((void*) fragment->patch);
+			}
+			free(fragment);
+			fragment = fragment_next;
+		}
+
+		free(patch);
+		patch = patch_next;
+	}
+}
+
 /*
  * A line in a file, len-bytes long (includes the terminating LF,
  * except for an incomplete line at the end if the file ends with
@@ -1742,6 +1766,7 @@ static struct fragment *parse_binary_hunk(char **buf_p,
 
 	frag = xcalloc(1, sizeof(*frag));
 	frag->patch = inflate_it(data, hunk_size, origlen);
+	frag->free_patch = 1;
 	if (!frag->patch)
 		goto corrupt;
 	free(data);
@@ -3687,7 +3712,6 @@ static int apply_patch(int fd, const char *filename, int options)
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
 
-	/* FIXME - memory leak when using multiple patch files as inputs */
 	memset(&fn_table, 0, sizeof(struct string_list));
 	patch_input_file = filename;
 	read_patch_file(&buf, fd);
@@ -3712,8 +3736,7 @@ static int apply_patch(int fd, const char *filename, int options)
 			listp = &patch->next;
 		}
 		else {
-			/* perhaps free it a bit better? */
-			free(patch);
+			free_patch(patch);
 			skipped_patch++;
 		}
 		offset += nr;
@@ -3754,6 +3777,8 @@ static int apply_patch(int fd, const char *filename, int options)
 	if (summary)
 		summary_patch_list(list);
 
+	free_patch(list);
+
 	strbuf_release(&buf);
 	return 0;
 }
-- 
1.7.3.4
