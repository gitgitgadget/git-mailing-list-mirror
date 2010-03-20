From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/5] verify_tag_signature(): let caller look up tag object
 sha1
Date: Sat, 20 Mar 2010 00:14:41 -0500
Message-ID: <20100320051441.GE24791@progeny.tock>
References: <20100320050953.GA24746@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos Rica <jasampler@gmail.com>,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 06:13:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsr0V-00011x-94
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 06:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab0CTFNu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 01:13:50 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45231 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab0CTFNu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 01:13:50 -0400
Received: by gwaa18 with SMTP id a18so139940gwa.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 22:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=nAJ0n3uWjmIeP/330+PxkKNu1lmyJ+58JkMdI2d0kD0=;
        b=bM5rU0FeQHPUzQ6FbAtlRzyJw/Wt1DLEEeuhopliEzmQj123buryYq5kR64a3Qdg0q
         u99C1wXhDCWPebVYM8HIifBVAjNbIX+9Wo/gjRTeBvXkWRHrVRg3d4dMDZsZselE+FIf
         +wNrFngvBRq3dvFnkhsWrdYn1t2NY1Ai/VhO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PWc+mYrDapxLbAu2CFtpRC1Nn34lIp8dJWW25hObfo+/cfbxdzWM/Yxp8r2yWjj9OA
         +/C2dbRLc+nCHngVgC/dH3xISUlOyAkxc1ldJl+FIIOrqR6QE1/SkIgylk7+CgjAwzhf
         +Ai30aLKdECpg6KTYZHH2tNOmg0Jf2v026o00=
Received: by 10.101.105.39 with SMTP id h39mr9373283anm.12.1269062029169;
        Fri, 19 Mar 2010 22:13:49 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm864426iwn.3.2010.03.19.22.13.48
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 22:13:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100320050953.GA24746@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142687>

Avoid an unnecessary get_sha1() call in cmd_tag().

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/tag.c        |    2 +-
 builtin/verify-tag.c |   16 ++++++++++++++--
 tag.h                |    3 ++-
 verify-tag.c         |    6 +-----
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index d138e0c..df94a8c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -147,7 +147,7 @@ static int delete_tag(const char *name, const char *ref,
 static int verify_tag(const char *name, const char *ref,
 				const unsigned char *sha1)
 {
-	if (verify_tag_signature(sha1_to_hex(sha1), 1))
+	if (verify_tag_signature(sha1, name, 1))
 		return error("could not verify the tag '%s'", name);
 	return 0;
 }
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index ca075bd..df2e095 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -14,6 +14,13 @@ static const char * const verify_tag_usage[] = {
 		NULL
 };
 
+static int get_sha1_or_whine(const char *name, unsigned char *sha1)
+{
+	if (get_sha1(name, sha1))
+		return error("tag '%s' not found.", name);
+	return 0;
+}
+
 int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
@@ -29,8 +36,13 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	if (argc <= i)
 		usage_with_options(verify_tag_usage, verify_tag_options);
 
-	while (i < argc)
-		if (verify_tag_signature(argv[i++], verbose))
+	while (i < argc) {
+		unsigned char sha1[20];
+		const char *name = argv[i++];
+
+		if (get_sha1_or_whine(name, sha1) < 0 ||
+		    verify_tag_signature(sha1, name, verbose) < 0)
 			had_error = 1;
+	}
 	return had_error;
 }
diff --git a/tag.h b/tag.h
index 1034109..f83dce6 100644
--- a/tag.h
+++ b/tag.h
@@ -16,6 +16,7 @@ extern struct tag *lookup_tag(const unsigned char *sha1);
 extern int parse_tag_buffer(struct tag *item, void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
-extern int verify_tag_signature(const char *name, int verbose);
+extern int verify_tag_signature(const unsigned char *sha1, const char *name,
+				int verbose);
 
 #endif /* TAG_H */
diff --git a/verify-tag.c b/verify-tag.c
index 7152e99..bf88707 100644
--- a/verify-tag.c
+++ b/verify-tag.c
@@ -60,17 +60,13 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 	return ret;
 }
 
-int verify_tag_signature(const char *name, int verbose)
+int verify_tag_signature(const unsigned char *sha1, const char *name, int verbose)
 {
 	enum object_type type;
-	unsigned char sha1[20];
 	char *buf;
 	unsigned long size;
 	int ret;
 
-	if (get_sha1(name, sha1))
-		return error("tag '%s' not found.", name);
-
 	type = sha1_object_info(sha1, NULL);
 	if (type != OBJ_TAG)
 		return error("%s: cannot verify a non-tag object of type %s.",
-- 
1.7.0.2
