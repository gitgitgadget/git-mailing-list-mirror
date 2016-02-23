From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] xdiff/xmerge: fix memory leak in xdl_merge
Date: Tue, 23 Feb 2016 12:59:17 +0100
Message-ID: <1456228757-19333-1-git-send-email-ps@pks.im>
References: <1456217151-16473-1-git-send-email-ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 12:59:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYBcn-0007T1-Rx
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 12:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbcBWL70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 06:59:26 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56353 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751077AbcBWL7Z (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2016 06:59:25 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 468E9202D8
	for <git@vger.kernel.org>; Tue, 23 Feb 2016 06:59:25 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 23 Feb 2016 06:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=MwLB
	VfM/iuWI6uQ+EcKvX+hdgSk=; b=qMqNb7Zr652EUT5Fbxvt4Ne558JeCAgG/G3B
	F+XgkGRwEOJsMu3hOD6o6VgF8PqhefnuVG6wKhufqqrLsFmo83D4quWLKSZ6WQcX
	qUq6chiP0yW8EwVAAcjaoarXamIGl9q5cXuEg3kcyapy9hXoKc1KnicwAJIox850
	JTiNp2U=
X-Sasl-enc: S9ONjTmQA7ffoeMJP8fkUFAjKZ48QwALt8WCWnjY1cXH 1456228764
Received: from localhost (x5ce0f886.dyn.telefonica.de [92.224.248.134])
	by mail.messagingengine.com (Postfix) with ESMTPA id C5B6FC0001D;
	Tue, 23 Feb 2016 06:59:24 -0500 (EST)
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1456217151-16473-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287044>

When building the script for the second file that is to be merged
we have already allocated memory for data structures related to
the first file. When we encounter an error in building the second
script we only free allocated memory related to the second file
before erroring out.

Fix this memory leak by also releasing allocated memory related
to the first file.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 xdiff/xmerge.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index d98f430..f338ad6 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -641,8 +641,11 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 	result->ptr = NULL;
 	result->size = 0;
 
-	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0 ||
-			xdl_do_diff(orig, mf2, xpp, &xe2) < 0) {
+	if (xdl_do_diff(orig, mf1, xpp, &xe1) < 0) {
+		return -1;
+	}
+	if (xdl_do_diff(orig, mf2, xpp, &xe2) < 0) {
+		xdl_free_env(&xe1);
 		return -1;
 	}
 	if (xdl_change_compact(&xe1.xdf1, &xe1.xdf2, xpp->flags) < 0 ||
@@ -654,6 +657,8 @@ int xdl_merge(mmfile_t *orig, mmfile_t *mf1, mmfile_t *mf2,
 	if (xdl_change_compact(&xe2.xdf1, &xe2.xdf2, xpp->flags) < 0 ||
 	    xdl_change_compact(&xe2.xdf2, &xe2.xdf1, xpp->flags) < 0 ||
 	    xdl_build_script(&xe2, &xscr2) < 0) {
+		xdl_free_script(xscr1);
+		xdl_free_env(&xe1);
 		xdl_free_env(&xe2);
 		return -1;
 	}
-- 
2.7.1
