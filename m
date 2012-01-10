From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 6/8] sha1_name: introduce getn_sha1() to take length
Date: Tue, 10 Jan 2012 21:43:57 +0530
Message-ID: <1326212039-13806-7-git-send-email-artagnon@gmail.com>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 10 17:16:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkeN8-0005XL-7H
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 17:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256Ab2AJQQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 11:16:07 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47391 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932143Ab2AJQQF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 11:16:05 -0500
Received: by mail-iy0-f174.google.com with SMTP id z25so1076194iab.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 08:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=p+RwGsbT6/UTFhnvDtGWjZIqlPBC/WcYiAZNd3aLPcM=;
        b=f9lRIZn2K2Hmmr/OMhPGotQn6uK6pmNfuw3/dnuTjjNWCqa/F104YHQcu5EaGcpKyl
         5XFeVpWzHpl1R3VWpMhoFV6iHtIh9J1GICY2L64tg66H75QdEb3CKOjpOxSYO5wFdeiu
         +gWS97DDJ1tdtiyeOQw6KSKG6dyFu96iE2yqg=
Received: by 10.43.124.130 with SMTP id go2mr13790321icc.20.1326212164922;
        Tue, 10 Jan 2012 08:16:04 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id lu10sm129662851igc.0.2012.01.10.08.16.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 08:16:04 -0800 (PST)
X-Mailer: git-send-email 1.7.8.2
In-Reply-To: <1326212039-13806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188263>

Introduce a variant of get_sha1() that additionally takes the length
of the buffer, so it can parse object names from buffers that don't
necessarily terminate with NUL.

Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 cache.h     |    1 +
 sha1_name.c |   23 +++++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 10afd71..8bb6759 100644
--- a/cache.h
+++ b/cache.h
@@ -812,6 +812,7 @@ struct object_context {
 };
 
 extern int get_sha1(const char *str, unsigned char *sha1);
+extern int getn_sha1(const char *name, int namelen, unsigned char *sha1);
 extern int get_sha1_with_mode_1(const char *str, unsigned char *sha1, unsigned *mode, int only_to_die, const char *prefix);
 static inline int get_sha1_with_mode(const char *str, unsigned char *sha1, unsigned *mode)
 {
diff --git a/sha1_name.c b/sha1_name.c
index 03ffc2c..31d412e 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1019,12 +1019,11 @@ static char *resolve_relative_path(const char *rel)
 			   rel);
 }
 
-int get_sha1_with_context_1(const char *name, unsigned char *sha1,
-			    struct object_context *oc,
-			    int only_to_die, const char *prefix)
+static int getn_sha1_with_context_1(const char *name, int namelen,
+				unsigned char *sha1, struct object_context *oc,
+				int only_to_die, const char *prefix)
 {
 	int ret, bracket_depth;
-	int namelen = strlen(name);
 	const char *cp;
 
 	memset(oc, 0, sizeof(*oc));
@@ -1134,3 +1133,19 @@ int get_sha1_with_context_1(const char *name, unsigned char *sha1,
 	}
 	return ret;
 }
+
+int get_sha1_with_context_1(const char *name, unsigned char *sha1,
+			struct object_context *oc,
+			int only_to_die, const char *prefix)
+{
+	int namelen = strlen(name);
+	return getn_sha1_with_context_1(name, namelen, sha1,
+					oc, only_to_die, prefix);
+}
+
+/* A variant of get_sha1 that takes a length. */
+int getn_sha1(const char *name, int namelen, unsigned char *sha1)
+{
+	struct object_context unused;
+	return getn_sha1_with_context_1(name, namelen, sha1, &unused, 0, NULL);
+}
-- 
1.7.8.2
