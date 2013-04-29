From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] Add new @ shortcut for HEAD
Date: Mon, 29 Apr 2013 14:35:06 -0500
Message-ID: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 29 21:39:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWtvP-0005r1-1g
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 21:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760862Ab3D2Tjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 15:39:37 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:34150 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758454Ab3D2TgW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 15:36:22 -0400
Received: by mail-ob0-f171.google.com with SMTP id er7so5814529obc.30
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=qgH4ozb6YJ/4ViIQmJ7/xEYZYVbRSzop20Tkdx1cXwY=;
        b=avxtnsYba2rFZ6jTjOeI6Uvg4sJmhPGVNwqoNS0F2mSk9IfQwaUhMtGLvMeGi5tJzO
         zKCHrd7UG3Wq1m2x2zkr9JevLrO+bc0DtN0XDZVk2+JQ/qP4JOjq5Iwy7K7sZRBVpccE
         sg8nZui2q+9mS846hsL/fLWS4WhaKXQ4om8SCvlXF4KqCgmWIOxj4u1TDSaGDiGJHkJ9
         bAq6B7hc6h6odNFipThOnMSnxyyKVuqqlr6tzhmtqoBsYJ3wXg0oBAYVywDB0iqJfRP6
         gbcChIszIPBzmdwko6ttkxYN/qpkadJ9+kKpEGbmPvdAfGkgmgbms/EgW0YaL95fRXmM
         vB8A==
X-Received: by 10.60.79.161 with SMTP id k1mr10407171oex.106.1367264181997;
        Mon, 29 Apr 2013 12:36:21 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id qt5sm21995032oeb.4.2013.04.29.12.36.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Apr 2013 12:36:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.1031.g2ee5873
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222852>

So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
remove '~0', and we can remove 'HEAD', but we can't remove '{0}'?

This patch allows 'HEAD@' to be the same as 'HEAD@{0}', and similarly with
'master@'.

So we can type '@' instead of 'HEAD@', or rather 'HEAD'. So now we can
use 'git show @~1', and all that goody goodness.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

People have complained about the lack of a HEAD shortcut before, and some
proposals have been made, but I think this one is a clean trick in accordance
with our current syntax.

 Documentation/revisions.txt | 3 +++
 sha1_name.c                 | 8 +++++++-
 t/t1503-rev-parse-verify.sh | 9 +++++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index d477b3f..6315ce5 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -58,6 +58,9 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
 While the ref name encoding is unspecified, UTF-8 is preferred as
 some output processing may assume ref names in UTF-8.
 
+'@'::
+  '@' alone is a shortcut for 'HEAD'
+
 '<refname>@\{<date>\}', e.g. 'master@\{yesterday\}', 'HEAD@\{5 minutes ago\}'::
   A ref followed by the suffix '@' with a date specification
   enclosed in a brace
diff --git a/sha1_name.c b/sha1_name.c
index 3820f28..d7c3d6f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -437,11 +437,15 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	static const char *warn_msg = "refname '%.*s' is ambiguous.";
 	char *real_ref = NULL;
 	int refs_found = 0;
-	int at, reflog_len;
+	int at, reflog_len, empty_at;
 
 	if (len == 40 && !get_sha1_hex(str, sha1))
 		return 0;
 
+	empty_at = len && str[len-1] == '@';
+	if (empty_at)
+		len = len-1;
+
 	/* basic@{time or number or -number} format to query ref-log */
 	reflog_len = at = 0;
 	if (len && str[len-1] == '}') {
@@ -475,6 +479,8 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
 	} else if (reflog_len)
 		refs_found = dwim_log(str, len, sha1, &real_ref);
+	else if (!len && empty_at)
+		refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
 	else
 		refs_found = dwim_ref(str, len, sha1, &real_ref);
 
diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index 813cc1b..426c63f 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -115,4 +115,13 @@ test_expect_success 'master@{n} for various n' '
 	test_must_fail git rev-parse --verify master@{$Np1}
 '
 
+test_expect_success 'empty @' '
+	rev_hash=$(git rev-parse --verify @) &&
+	test "$rev_hash" = "$HASH4" &&
+	rev_hash=$(git rev-parse --verify HEAD@) &&
+	test "$rev_hash" = "$HASH4" &&
+	rev_hash=$(git rev-parse --verify master@) &&
+	test "$rev_hash" = "$HASH4"
+'
+
 test_done
-- 
1.8.2.1.1031.g2ee5873
