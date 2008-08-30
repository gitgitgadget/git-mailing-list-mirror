From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/12] git-merge-recursive: learn to honor merge.conflictstyle
Date: Fri, 29 Aug 2008 17:42:39 -0700
Message-ID: <1220056963-2352-9-git-send-email-gitster@pobox.com>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com>
 <1220056963-2352-2-git-send-email-gitster@pobox.com>
 <1220056963-2352-3-git-send-email-gitster@pobox.com>
 <1220056963-2352-4-git-send-email-gitster@pobox.com>
 <1220056963-2352-5-git-send-email-gitster@pobox.com>
 <1220056963-2352-6-git-send-email-gitster@pobox.com>
 <1220056963-2352-7-git-send-email-gitster@pobox.com>
 <1220056963-2352-8-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 30 02:44:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZEZu-00076v-Pl
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 02:44:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbYH3AnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 20:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbYH3AnM
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 20:43:12 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbYH3AnH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 20:43:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 468AC6DC0F
	for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:43:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8C1056DC0D for <git@vger.kernel.org>; Fri, 29 Aug 2008 20:43:06
 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.149.ga4c44
In-Reply-To: <1220056963-2352-8-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9CCF496E-762C-11DD-BED4-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94347>

This teaches the low-level ll_xdl_merge() routine to honor
merge.conflictstyle configuration variable, so that merge-recursive
strategy can show the conflicts in the style of user's choice.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-merge-recursive.c |    2 +-
 ll-merge.c                |   16 ++++++++++++----
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index dfb363e..f3b6ede 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -1348,7 +1348,7 @@ static int merge_config(const char *var, const char *value, void *cb)
 		merge_rename_limit = git_config_int(var, value);
 		return 0;
 	}
-	return git_default_config(var, value, cb);
+	return git_xmerge_config(var, value, cb);
 }
 
 int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
diff --git a/ll-merge.c b/ll-merge.c
index 9837c84..4a71614 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -63,6 +63,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 			int virtual_ancestor)
 {
 	xpparam_t xpp;
+	int style = 0;
 
 	if (buffer_is_binary(orig->ptr, orig->size) ||
 	    buffer_is_binary(src1->ptr, src1->size) ||
@@ -77,10 +78,12 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 	}
 
 	memset(&xpp, 0, sizeof(xpp));
+	if (git_xmerge_style >= 0)
+		style = git_xmerge_style;
 	return xdl_merge(orig,
 			 src1, name1,
 			 src2, name2,
-			 &xpp, XDL_MERGE_ZEALOUS,
+			 &xpp, XDL_MERGE_ZEALOUS | style,
 			 result);
 }
 
@@ -95,10 +98,15 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 	char *src, *dst;
 	long size;
 	const int marker_size = 7;
-
-	int status = ll_xdl_merge(drv_unused, result, path_unused,
-				  orig, src1, NULL, src2, NULL,
-				  virtual_ancestor);
+	int status, saved_style;
+
+	/* We have to force the RCS "merge" style */
+	saved_style = git_xmerge_style;
+	git_xmerge_style = 0;
+	status = ll_xdl_merge(drv_unused, result, path_unused,
+			      orig, src1, NULL, src2, NULL,
+			      virtual_ancestor);
+	git_xmerge_style = saved_style;
 	if (status <= 0)
 		return status;
 	size = result->size;
-- 
1.6.0.1.149.ga4c44
