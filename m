From: santiago@nyu.edu
Subject: [PATCH v8 4/6] verify-tag: prepare verify_tag for libification
Date: Fri, 22 Apr 2016 10:52:03 -0400
Message-ID: <1461336725-29915-5-git-send-email-santiago@nyu.edu>
References: <1461336725-29915-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 16:52:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atcRW-0005C3-0s
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463AbcDVOwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 10:52:18 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:35638 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbcDVOwP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:52:15 -0400
Received: by mail-qg0-f51.google.com with SMTP id f74so54495533qge.2
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 07:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=01MKujRNvFEXdqr9O5FEUy/MtpVUMqbq2/zN6B34dNY=;
        b=sb5uUNYhUuuAuw6QMkEHiKCME+k55+At2RDLCywzhqBmHPXKPB1yCC5Cq+8SayzmGD
         YKUTDjUpeZctqWVlWUVqmUIgV2dgjOcS0PUUUiJYJIcollE+KaA3dkavAfBsizagUmkO
         ZtLn0x9qsbUzhZogX0fXlHj7PQyAwOj+PLipam6jb2H4Vm6DGFRVn5sKaZomTNp59JvF
         t667TjhAu04XQaTIP7+u3seJ6H2ph+6zvI5YKfhCpLfD8huBzmpnSTbcB6MNt2wv4u/y
         TUuBrsxtFkXWb7qdR9+f1n+MxNjWaSl3DbKq/6qpRoePW4DjrXN9dhP1fue/y5h2ivjI
         qJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=01MKujRNvFEXdqr9O5FEUy/MtpVUMqbq2/zN6B34dNY=;
        b=aXfF0tkoacpEFKFZPnFC9FaPqwVL+vj0wh2lwtBuopCSBWWxdnj+eBpQ3AOJCHEhSq
         3+e6RPU9Iev5DyZJBaPOuC2rkZpv5mxufyLhbik1j7m+3V+KLKfyyXBEk7PKtnF/WlkR
         +kZQEaoEnvwi+Fx4yhI9Bs7JXTpMuApqjQD37gZ16gzFE5iNdMvQHDX9l3qvp9ONv4K5
         i8TgYEAHai0U92W4FJRESr+WJrufWHZ2u3xavN+ubkR34cxop6xHqMwRNXek4DBFw9f0
         Ja6Gql8ZvT/Q799xDJBMzK/ahdIjcVc+piODGeUkU0YECeoN+iiKPBwSXT3Vddls3s2Y
         1CUQ==
X-Gm-Message-State: AOPr4FVE2wwgQ1jDFt41in56C/rbRTCIKncRrPnMtk4uP/cB1AlQFe1g3DvSa9jsoVk6DILK
X-Received: by 10.140.130.14 with SMTP id 14mr22887290qhc.85.1461336734165;
        Fri, 22 Apr 2016 07:52:14 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-18.NATPOOL.NYU.EDU. [216.165.95.7])
        by smtp.gmail.com with ESMTPSA id s67sm2583005qgs.48.2016.04.22.07.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 07:52:13 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461336725-29915-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292221>

From: Santiago Torres <santiago@nyu.edu>

The current interface of verify_tag() resolves reference names to SHA1,
however, the plan is to make this functionality public and the current
interface is cumbersome for callers: they are expected to supply the
textual representation of a sha1/refname. In many cases, this requires
them to turn the sha1 to hex representation, just to be converted back
inside verify_tag.

Add a SHA1 parameter to use instead of the name parameter, and rename
the name parameter to "name_to_report" for reporting purposes only.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/verify-tag.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index fa26e40..a3d3a43 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -42,25 +42,28 @@ static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
 	return ret;
 }
 
-static int verify_tag(const char *name, unsigned flags)
+static int verify_tag(const unsigned char *sha1, const char *name_to_report,
+			unsigned flags)
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
-				name, typename(type));
+				name_to_report ?
+				name_to_report :
+				find_unique_abbrev(sha1, DEFAULT_ABBREV),
+				typename(type));
 
 	buf = read_sha1_file(sha1, &type, &size);
 	if (!buf)
-		return error("%s: unable to read file.", name);
+		return error("%s: unable to read file.",
+				name_to_report ?
+				name_to_report :
+				find_unique_abbrev(sha1, DEFAULT_ABBREV));
 
 	ret = run_gpg_verify(buf, size, flags);
 
@@ -96,8 +99,13 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	if (verbose)
 		flags |= GPG_VERIFY_VERBOSE;
 
-	while (i < argc)
-		if (verify_tag(argv[i++], flags))
+	while (i < argc) {
+		unsigned char sha1[20];
+		const char *name = argv[i++];
+		if (get_sha1(name, sha1))
+			had_error = !!error("tag '%s' not found.", name);
+		else if (verify_tag(sha1, name, flags))
 			had_error = 1;
+	}
 	return had_error;
 }
-- 
2.8.0
