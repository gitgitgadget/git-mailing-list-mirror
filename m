From: santiago@nyu.edu
Subject: [PATCH/RFC] builtin/tag.c: move PGP verification inside builtin.
Date: Thu, 24 Mar 2016 17:39:20 -0400
Message-ID: <1458855560-28519-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Santiago Torres <torresariass@gmail.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 22:43:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajD2p-0001mB-NJ
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 22:43:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbcCXVnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 17:43:51 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33677 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbcCXVnt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 17:43:49 -0400
Received: by mail-qg0-f44.google.com with SMTP id j35so49393770qge.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 14:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=4sMJH43sT94dJWmwiltPf9DBDF8jFCnRJ2rBsrDdpvE=;
        b=JRWNOsOe/dXxxYIsgRCWiikFyJRzRyqFA1eNkqb+MvuYzpv70CWCXfWIEu6Cztxxx8
         73HoGm23qDXaVQw6In1NsPlFSUZxN2y8DqXVSerN0iiizZVJHR0V+N6oXTywdLc/tOxY
         Oq6AQBuF5W58A+gQdxDUgP5S7d9acojq2DsOZbAP61Jk40ZUOV/Sv150cA9OojHzgMqc
         qQT0YmZOOVknAyojeiVoVDIlRDFeHCY5lXg9hfiusoShM85wq19MoLt48xjlG/q+I0Lh
         htGtqSSIgI4oYiag7u/NRAlWr3h6b3XGSTyci7dukBRh5x1CnLEqBFw6bnb8eNFc5fJs
         3n6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4sMJH43sT94dJWmwiltPf9DBDF8jFCnRJ2rBsrDdpvE=;
        b=FNi0xy/8Hq4g/P4YTLAxJWgmezxd9oODVXBcdKxqppnyTm0TOp7zxjFqdt0OvkrwXa
         wRjNsx9MnmX78YJPXwej+X8ii/r6xovtucJk1RnhJg7/6LDpwSl1tn7G5wDMkWYjn/wM
         arJ0rLViIw+rgxZXlZHyEd1QrPaPWa4Ag8HkueYd4lok1Ko7en8iJ05CWRsp+l/nuIeP
         UA4TXvYNE6x6GELQrR2GWFG1eG/2UkU9LelXWhw9qqBfMvJncOidsLiOizpkeKDOi0SA
         ks0THgMVsoIKNWlNauJoEBwXeZjnZuNoWEwm+O4aelHrnHPlFrfRn9WJ5bEvyfk3ea8S
         mEIA==
X-Gm-Message-State: AD7BkJKWl2K1WYSEF+OZmRNEhvMXzOPiaKP3gxdPjp4lyDWj8tExSTgqBJDBQfuAAkIRWSHS
X-Received: by 10.140.158.135 with SMTP id e129mr14395712qhe.84.1458855828412;
        Thu, 24 Mar 2016 14:43:48 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-11.NATPOOL.NYU.EDU. [216.165.95.0])
        by smtp.gmail.com with ESMTPSA id 139sm4019906qhh.33.2016.03.24.14.43.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Mar 2016 14:43:47 -0700 (PDT)
X-Mailer: git-send-email 2.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289803>

From: Santiago Torres <torresariass@gmail.com>

The verify tag function is just a thin wrapper around the verify-tag
command. We can avoid one fork call by doing the verification instide
the tag builtin instead.

Signed-off-by: Santiago Torres <santiago@nyu.edu>
---
 builtin/tag.c | 44 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 1705c94..be5d7c7 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -30,6 +30,27 @@ static const char * const git_tag_usage[] = {
 
 static unsigned int colopts;
 
+static int run_gpg_verify(const char *buf, unsigned long size, unsigned flags)
+{
+	struct signature_check sigc;
+	int len;
+	int ret;
+
+	memset(&sigc, 0, sizeof(sigc));
+
+	len = parse_signature(buf, size);
+
+	if (size == len) {
+		write_in_full(1, buf, len);
+	}
+
+	ret = check_signature(buf, len, buf + len, size - len, &sigc);
+	print_signature_buffer(&sigc, flags);
+
+	signature_check_clear(&sigc);
+	return ret;
+}
+
 static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
 {
 	struct ref_array array;
@@ -104,13 +125,24 @@ static int delete_tag(const char *name, const char *ref,
 static int verify_tag(const char *name, const char *ref,
 				const unsigned char *sha1)
 {
-	const char *argv_verify_tag[] = {"verify-tag",
-					"-v", "SHA1_HEX", NULL};
-	argv_verify_tag[2] = sha1_to_hex(sha1);
 
-	if (run_command_v_opt(argv_verify_tag, RUN_GIT_CMD))
-		return error(_("could not verify the tag '%s'"), name);
-	return 0;
+	enum object_type type;
+	unsigned long size;
+	const char* buf;
+	int ret;
+
+	type = sha1_object_info(sha1, NULL);
+	if (type != OBJ_TAG)
+		return error("%s: cannot verify a non-tag object of type %s.",
+				name, typename(type));
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return error("%s: unable to read file.", name);
+
+	ret = run_gpg_verify(buf, size, 0);
+
+	return ret;
 }
 
 static int do_sign(struct strbuf *buffer)
-- 
2.7.3
