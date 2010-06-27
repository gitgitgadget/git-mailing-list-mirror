From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v4 3/3] Don't expand CRLFs when normalizing text during merge
Date: Sun, 27 Jun 2010 21:43:07 +0200
Message-ID: <1f8eb89768d01fbd0624b740c6698cf333b9d3a0.1277667177.git.eyvind.bernhardsen@gmail.com>
References: <cover.1277667177.git.eyvind.bernhardsen@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 27 21:43:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSxlL-00061C-O8
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 21:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604Ab0F0TnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 15:43:20 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:42701 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755315Ab0F0TnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jun 2010 15:43:16 -0400
Received: by mail-ww0-f46.google.com with SMTP id 17so2162397wwi.19
        for <git@vger.kernel.org>; Sun, 27 Jun 2010 12:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=TRgj8v/vO/CanJYYBj3JIOgLdXRFrLQQT9OJCwl1Kb8=;
        b=IUNZHLucYS+tVyDK1GbvZileYZJG5J53F0JMKo6GYfGfNyop6+3jdug3pCUdMryfY1
         U6dseX8JmLbVj+w/slCQBLmVEZrjseA052Aobp0qW0K9QxjR9+3EbcM6Wq39t7adJeiI
         OhLHHAy8htQqZ64j1hl8KqHHEXm2UWJeXQGwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=I5A6MGP6g5h0Pm5tUnP/ltsa63nEi1DQj2oInEMBkKUe+Vu/QAACUHP5XUscmLLBRq
         mVZDNuMVE/KIxIb1ZkRZbfqtqIL1itFOZcmDqqpmJ18becKGkBXa/Tgfan9vrSoQAmjV
         dadvM6fkjJBoKwOpha4dmKAcvyb8sTjaX3JPs=
Received: by 10.227.144.132 with SMTP id z4mr2955383wbu.70.1277667795744;
        Sun, 27 Jun 2010 12:43:15 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id y39sm4411401weq.3.2010.06.27.12.43.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Jun 2010 12:43:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.575.g383de
In-Reply-To: <cover.1277667177.git.eyvind.bernhardsen@gmail.com>
In-Reply-To: <cover.1277667177.git.eyvind.bernhardsen@gmail.com>
References: <cover.1277667177.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149803>

Disable CRLF expansion when convert_to_working_tree() is called from
normalize_buffer().  This improves performance when merging branches
with conflicting line endings when core.eol=crlf or core.autocrlf=true
by making the normalization act as if core.eol=lf.

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 convert.c |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/convert.c b/convert.c
index 0203be8..01de9a8 100644
--- a/convert.c
+++ b/convert.c
@@ -741,7 +741,9 @@ int convert_to_git(const char *path, const char *src, size_t len,
 	return ret | ident_to_git(path, src, len, dst, ident);
 }
 
-int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst)
+static int convert_to_working_tree_internal(const char *path, const char *src,
+					    size_t len, struct strbuf *dst,
+					    int normalizing)
 {
 	struct git_attr_check check[5];
 	enum action action = CRLF_GUESS;
@@ -767,18 +769,29 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 		src = dst->buf;
 		len = dst->len;
 	}
-	action = determine_action(action, eol_attr);
-	ret |= crlf_to_worktree(path, src, len, dst, action);
-	if (ret) {
-		src = dst->buf;
-		len = dst->len;
+	/*
+	 * CRLF conversion can be skipped if normalizing, unless there
+	 * is a smudge filter.  The filter might expect CRLFs.
+	 */
+	if (filter || !normalizing) {
+		action = determine_action(action, eol_attr);
+		ret |= crlf_to_worktree(path, src, len, dst, action);
+		if (ret) {
+			src = dst->buf;
+			len = dst->len;
+		}
 	}
 	return ret | apply_filter(path, src, len, dst, filter);
 }
 
+int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst)
+{
+	return convert_to_working_tree_internal(path, src, len, dst, 0);
+}
+
 int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst)
 {
-	int ret = convert_to_working_tree(path, src, len, dst);
+	int ret = convert_to_working_tree_internal(path, src, len, dst, 1);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
-- 
1.7.1.575.g383de
