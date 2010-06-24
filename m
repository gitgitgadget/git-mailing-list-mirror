From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v3 3/3] Don't expand CRLFs when normalizing text during merge
Date: Thu, 24 Jun 2010 22:44:32 +0200
Message-ID: <90f38b5f5c49f9b9f5427a026e51f867a1121982.1277408598.git.eyvind.bernhardsen@gmail.com>
References: <cover.1277408598.git.eyvind.bernhardsen@gmail.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:44:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORtIA-0001NK-4y
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:44:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307Ab0FXUoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 16:44:46 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:40029 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754937Ab0FXUom (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 16:44:42 -0400
Received: by wwi17 with SMTP id 17so577642wwi.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 13:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=cof7FXHtsYrvKox/q1VHNwyXrwHKQ9mTneadQYLa3nI=;
        b=jKxd08YeMHePCyvAAHIusiScoJLP4VT108FcEbr2NpfMe3ub0vyRTASPHwxnlxdPNo
         VrFZTaQaL1EYuPHRt3SgSxVxiyzovd1HsXfGrd087ZUWzC1DB6gTIKFecxXsZzJLqBR+
         pqsJLZ5z8XoKO4jjebBjyrxqr+aYTCT1dAaYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Db6kMKTTLH7pjRNS7f4OD2QUiSLb0dDZOGmg+rDjhSUFzVajeM1oYyNkxnkuow1TAK
         DPXCwq7Vr4o2/rqzPEZ6QwJEDlQRovRETDIa6JfVSLIHtrtwz/Cj0WfsNFcGh/LSyt37
         KdawniPHBglM3LjQbmug0hHCedWAZDg+Sw+oQ=
Received: by 10.227.127.83 with SMTP id f19mr9438146wbs.83.1277412281381;
        Thu, 24 Jun 2010 13:44:41 -0700 (PDT)
Received: from localhost.localdomain (eyvind.bernhardsens.net [84.49.224.5])
        by mx.google.com with ESMTPS id t15sm34373334wbc.17.2010.06.24.13.44.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 13:44:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.575.g383de
In-Reply-To: <cover.1277408598.git.eyvind.bernhardsen@gmail.com>
In-Reply-To: <cover.1277408598.git.eyvind.bernhardsen@gmail.com>
References: <cover.1277408598.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149644>

There's no need to expand CRLFs when convert_to_working_tree() is called
to normalize text for a merge since the text will be converted back
immediately.  Improves performance of merges with conflicting line
endings when core.eol=crlf or core.autocrlf=true.

Signed-off-by: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
---
 convert.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/convert.c b/convert.c
index e1561a9..d45d490 100644
--- a/convert.c
+++ b/convert.c
@@ -739,7 +739,9 @@ int convert_to_git(const char *path, const char *src, size_t len,
 	return ret | ident_to_git(path, src, len, dst, ident);
 }
 
-int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst)
+static int convert_to_working_tree_internal(const char *path, const char *src,
+					    size_t len, struct strbuf *dst,
+					    int normalizing)
 {
 	struct git_attr_check check[5];
 	enum action action = CRLF_GUESS;
@@ -765,17 +767,23 @@ int convert_to_working_tree(const char *path, const char *src, size_t len, struc
 		src = dst->buf;
 		len = dst->len;
 	}
-	action = determine_action(action, eol_attr);
-	ret |= crlf_to_worktree(path, src, len, dst, action);
-	if (ret) {
-		src = dst->buf;
-		len = dst->len;
+	if (!normalizing) {
+		action = determine_action(action, eol_attr);
+		ret |= crlf_to_worktree(path, src, len, dst, action);
+		if (ret) {
+			src = dst->buf;
+			len = dst->len;
+		}
 	}
 	return ret | apply_filter(path, src, len, dst, filter);
 }
 
+int convert_to_working_tree(const char *path, const char *src, size_t len, struct strbuf *dst) {
+	return convert_to_working_tree_internal(path, src, len, dst, 0);
+}
+
 int renormalize_buffer(const char *path, const char *src, size_t len, struct strbuf *dst) {
-	int ret = convert_to_working_tree(path, src, len, dst);
+	int ret = convert_to_working_tree_internal(path, src, len, dst, 1);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
-- 
1.7.1.575.g383de
