From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/8] conflict-marker-size: new attribute
Date: Sun, 17 Jan 2010 01:39:02 -0800
Message-ID: <1263721144-18605-7-git-send-email-gitster@pobox.com>
References: <1263721144-18605-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 17 10:40:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWRbv-0003v2-Fe
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 10:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753688Ab0AQJjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 04:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753670Ab0AQJj2
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 04:39:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab0AQJjU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 04:39:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A98691412
	for <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=dDVN
	SQDrz8Da/PXoz1B1ghjFzWI=; b=mw58FXLezn3r8h8HF2m1qbsx6FPXe94735sT
	hulyvlLZGKAnxbew+cZavq3/6qHIM4GSTV4DwzmH0jwtdhkwM6cQu0f7DyDMAuR4
	nlt4PBOyjwPn6H1rPcmcm9NT59H5LrqkxlbyPQ513sFd4yv2RsYLVQh2oRVNJavy
	2WyK8KY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=gI94RH
	Uixecuc0iUL1R8sjjSk84K95wsw0QkeNZEHcEyCyfd/g3dHNQgvv3+TNYhkxmOm9
	Y/jzLoMjoKJZE8MO3zmdayyAUCV2UlRgac3G4IDRL1Jlwf8yYczI2BfTMXs8APtV
	RHJYUUrgblVlyLlreoiVnayTL4Q8a8Uf5hB6g=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 07D3C91411
	for <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5FADA9140F for
 <git@vger.kernel.org>; Sun, 17 Jan 2010 04:39:19 -0500 (EST)
X-Mailer: git-send-email 1.6.6.405.g80ed6.dirty
In-Reply-To: <1263721144-18605-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 2FE049A8-034C-11DF-9659-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137289>

This can be specified to set the length of the conflict marker (usually 7)
to a non-default value per path.  Only the callers of ll_merge() that are
aware of the per-path attributes are modified.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ll-merge.c |   59 ++++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/ll-merge.c b/ll-merge.c
index be2bf43..d682071 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -18,7 +18,8 @@ typedef int (*ll_merge_fn)(const struct ll_merge_driver *,
 			   mmfile_t *orig,
 			   mmfile_t *src1, const char *name1,
 			   mmfile_t *src2, const char *name2,
-			   int virtual_ancestor);
+			   int virtual_ancestor,
+			   int marker_size);
 
 struct ll_merge_driver {
 	const char *name;
@@ -38,7 +39,7 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 			   mmfile_t *orig,
 			   mmfile_t *src1, const char *name1,
 			   mmfile_t *src2, const char *name2,
-			   int virtual_ancestor)
+			   int virtual_ancestor, int marker_size)
 {
 	/*
 	 * The tentative merge result is "ours" for the final round,
@@ -59,7 +60,7 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 			mmfile_t *orig,
 			mmfile_t *src1, const char *name1,
 			mmfile_t *src2, const char *name2,
-			int virtual_ancestor)
+			int virtual_ancestor, int marker_size)
 {
 	xmparam_t xmp;
 	int style = 0;
@@ -73,12 +74,14 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
 				       path,
 				       orig, src1, name1,
 				       src2, name2,
-				       virtual_ancestor);
+				       virtual_ancestor, marker_size);
 	}
 
 	memset(&xmp, 0, sizeof(xmp));
 	if (git_xmerge_style >= 0)
 		style = git_xmerge_style;
+	if (marker_size > 0)
+		xmp.marker_size = marker_size;
 	return xdl_merge(orig,
 			 src1, name1,
 			 src2, name2,
@@ -92,11 +95,10 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 			  mmfile_t *orig,
 			  mmfile_t *src1, const char *name1,
 			  mmfile_t *src2, const char *name2,
-			  int virtual_ancestor)
+			  int virtual_ancestor, int marker_size)
 {
 	char *src, *dst;
 	long size;
-	const int marker_size = 7;
 	int status, saved_style;
 
 	/* We have to force the RCS "merge" style */
@@ -104,7 +106,7 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 	git_xmerge_style = 0;
 	status = ll_xdl_merge(drv_unused, result, path_unused,
 			      orig, src1, NULL, src2, NULL,
-			      virtual_ancestor);
+			      virtual_ancestor, marker_size);
 	git_xmerge_style = saved_style;
 	if (status <= 0)
 		return status;
@@ -165,14 +167,15 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 			mmfile_t *orig,
 			mmfile_t *src1, const char *name1,
 			mmfile_t *src2, const char *name2,
-			int virtual_ancestor)
+			int virtual_ancestor, int marker_size)
 {
-	char temp[3][50];
+	char temp[4][50];
 	struct strbuf cmd = STRBUF_INIT;
 	struct strbuf_expand_dict_entry dict[] = {
 		{ "O", temp[0] },
 		{ "A", temp[1] },
 		{ "B", temp[2] },
+		{ "L", temp[3] },
 		{ NULL }
 	};
 	const char *args[] = { "sh", "-c", NULL, NULL };
@@ -187,6 +190,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 	create_temp(orig, temp[0]);
 	create_temp(src1, temp[1]);
 	create_temp(src2, temp[2]);
+	sprintf(temp[3], "%d", marker_size);
 
 	strbuf_expand(&cmd, fn->cmdline, strbuf_expand_dict_cb, &dict);
 
@@ -279,6 +283,7 @@ static int read_merge_config(const char *var, const char *value, void *cb)
 		 *    %O - temporary file name for the merge base.
 		 *    %A - temporary file name for our version.
 		 *    %B - temporary file name for the other branches' version.
+		 *    %L - conflict marker length
 		 *
 		 * The external merge driver should write the results in the
 		 * file named by %A, and signal that it has done with zero exit
@@ -339,16 +344,13 @@ static const struct ll_merge_driver *find_ll_merge_driver(const char *merge_attr
 	return &ll_merge_drv[LL_TEXT_MERGE];
 }
 
-static const char *git_path_check_merge(const char *path)
+static int git_path_check_merge(const char *path, struct git_attr_check check[2])
 {
-	static struct git_attr_check attr_merge_check;
-
-	if (!attr_merge_check.attr)
-		attr_merge_check.attr = git_attr("merge");
-
-	if (git_checkattr(path, 1, &attr_merge_check))
-		return NULL;
-	return attr_merge_check.value;
+	if (!check[0].attr) {
+		check[0].attr = git_attr("merge");
+		check[1].attr = git_attr("conflict-marker-size");
+	}
+	return git_checkattr(path, 2, check);
 }
 
 int ll_merge(mmbuffer_t *result_buf,
@@ -358,16 +360,23 @@ int ll_merge(mmbuffer_t *result_buf,
 	     mmfile_t *theirs, const char *their_label,
 	     int virtual_ancestor)
 {
-	const char *ll_driver_name;
+	static struct git_attr_check check[2];
+	const char *ll_driver_name = NULL;
+	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	const struct ll_merge_driver *driver;
 
-	ll_driver_name = git_path_check_merge(path);
+	if (!git_path_check_merge(path, check)) {
+		ll_driver_name = check[0].value;
+		if (check[1].value) {
+			marker_size = atoi(check[1].value);
+			if (marker_size <= 0)
+				marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
+		}
+	}
 	driver = find_ll_merge_driver(ll_driver_name);
-
 	if (virtual_ancestor && driver->recursive)
 		driver = find_ll_merge_driver(driver->recursive);
-	return driver->fn(driver, result_buf, path,
-			  ancestor,
-			  ours, our_label,
-			  theirs, their_label, virtual_ancestor);
+	return driver->fn(driver, result_buf, path, ancestor,
+			  ours, our_label, theirs, their_label,
+			  virtual_ancestor, marker_size);
 }
-- 
1.6.6.405.g80ed6.dirty
