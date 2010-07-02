From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v6 3/3] Don't expand CRLFs when normalizing text during merge
Date: Fri,  2 Jul 2010 21:20:49 +0200
Message-ID: <6a8530fa3cba7cbc14882a9f5979d13452ab52b5.1278093311.git.eyvind.bernhardsen@gmail.com>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 21:21:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUlnn-0007HA-3D
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 21:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759812Ab0GBTVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 15:21:09 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38307 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759672Ab0GBTVG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 15:21:06 -0400
Received: by wwb24 with SMTP id 24so567546wwb.1
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 12:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=LaXaSm5GqUl4jMu++psN/PtqBg6aSL+mD3rHZ4xK8mk=;
        b=c64pafJEEWUttQ5RA/6INkmYzQILfEfKK2RCNRH441QSkENn+NspU5NNxCXJZCksZs
         7aVPxxyaVICYGEqPKr0e8Y9pgL1r/dCVw1o8TCNF6egjQWUcY46WYVZklAvnE9q4GO1f
         o1q0MbRapZL/qwdfzPl+ZwQJ06cU8cb4Z6KvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rDdWv7U8WXSVcZYGN2FJ3gllFlzm20IIE03wrMFew5Jum4ipBPc7FgnuA8Bq/FFx5k
         2oNTRy/yXIPxDUVsI0Vgfc2B8stbodb/bmaqro3s5MhwD6iG3dPjMIRxNuFfYJIMwvqj
         NxvGyUeMjHZzU86u4YhSCMdXvmg5TfxW8SHSg=
Received: by 10.213.33.135 with SMTP id h7mr4352744ebd.56.1278098463874;
        Fri, 02 Jul 2010 12:21:03 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id v8sm8093578eeh.14.2010.07.02.12.21.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 12:21:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.575.g383de
In-Reply-To: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150152>

Disable CRLF expansion when convert_to_working_tree() is called from
normalize_buffer().  This improves performance when merging branches
with conflicting line endings when core.eol=crlf or core.autocrlf=true
by making the normalization act as if core.eol=lf.

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
