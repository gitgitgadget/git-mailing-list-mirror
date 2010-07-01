From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: [PATCH v5 4/4] Don't expand CRLFs when normalizing text during merge
Date: Thu,  1 Jul 2010 11:09:52 +0200
Message-ID: <09d063fc517ef0de32adb53e832ad6a7a76649db.1277974452.git.eyvind.bernhardsen@gmail.com>
References: <cover.1277974452.git.eyvind.bernhardsen@gmail.com>
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 11:10:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUFmx-0007IR-Ms
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 11:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520Ab0GAJK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 05:10:26 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51956 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465Ab0GAJKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 05:10:09 -0400
Received: by bwz1 with SMTP id 1so797049bwz.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 02:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XaYd5yXp5gktJ2fn5RsrmOMuSEFfvl5Lxm118hXfg34=;
        b=Rn9zLdXwCzBxRd4Z8zyZTkFL0oIM719lUZGYOGqbQ5x3TKJpcypWjGBHhy7EDihG/X
         EHqMt3wLtzgcHLCeOV4Mykxhh3kaw3WM2eEv07fA/4lmksHigtzmHkQrbPcO6Rpl+tth
         P1sycmbyS13CJdkuqvqC2HdOE3gMrikjtuwsc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=h2/iiJCUjZK2jGF2NXCC4NavAkIrdCYUoqkoIcukZauyacIEh5+5bbpVHwVFSy+yEY
         EmeX2QyXtobWxeKFswTDYFRDx2on2i2YSqRIH5uE9gPD7x05QKRL8Usw47fD5DQSsNOU
         P0Shi8qHRVvhIqA/vNK4ZnWyuWDKyn/Lpk0vU=
Received: by 10.204.81.144 with SMTP id x16mr7090846bkk.55.1277975407188;
        Thu, 01 Jul 2010 02:10:07 -0700 (PDT)
Received: from localhost.localdomain ([62.113.137.5])
        by mx.google.com with ESMTPS id bi18sm11444654bkb.21.2010.07.01.02.10.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 02:10:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc1.4.g09d06
In-Reply-To: <cover.1277974452.git.eyvind.bernhardsen@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150015>

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
1.7.2.rc1.4.g09d06
