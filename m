From: santiago@nyu.edu
Subject: [PATCH v7 4/6] verify-tag: prepare verify_tag for libification
Date: Tue, 19 Apr 2016 13:47:19 -0400
Message-ID: <1461088041-19264-5-git-send-email-santiago@nyu.edu>
References: <1461088041-19264-1-git-send-email-santiago@nyu.edu>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Santiago Torres <santiago@nyu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 19:47:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asZkN-0002E9-A9
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 19:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932899AbcDSRrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 13:47:32 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33677 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754096AbcDSRra (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 13:47:30 -0400
Received: by mail-qg0-f43.google.com with SMTP id v14so13779644qge.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xk/9h46sIHPjX3afaZBxMw2/etFYKObrOinluM+yQGg=;
        b=g89NrISuiuUv+YKoLUrVU7mkoVvTHAQlUlwbgbmm2P+llHF8YehUcfPi/a/cmTQ8xh
         qQ7ML6SRD3w1KSWSC8pKfoibOnx7H2MlrkNmEVmyxeP4G05mFrZQptcpct9bh0ichzXO
         4aZxyneBwRMqX0dB8wVorWwCZ/n639LUydbp0PCHLSKA+azu9qOSV+aYzBLix8Z1UsOo
         Au8w0Gc9IiMhZfeuBnqPnGOhAkxATGtJK6IZeRZWU6+cHsbwWCf+fhe5zU2NY7iUHfs6
         VdFRqO39yvN+lgVAfjhx1gCey2yAou+6TDKOubIanfcSqr01E7qh8yJmk7UBdHH0pLW7
         UZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xk/9h46sIHPjX3afaZBxMw2/etFYKObrOinluM+yQGg=;
        b=geQcX8cTweXisu9yjTQ17CECWbhCkEpFA/HfxqneNrYHiP8ga9w2ueTOHiBS7rw2ZJ
         ROehlryHn6XwqpHchPYn0i9dpc42Gb551grnwHZZLdDfOsVPSQpIRPKwjbexBeDfKoWA
         2OKLu2HcKTUL2vHEBtFIUZXVKG7n+RmhjAoxAEfXtwtaqfXmrUtAxwjPss3deb1HT/1c
         z0jAUXVzXP5icpVyiu6S4zG6wfL17IlyDm4RbmLkB/96FuBtzBn1+oakXr1+HVo1ps4c
         ay4nCCZkr2elU+/VUdTsVoyzxiNWnT5T3Fa7wLshLNzB6oOVINg5s/fvdqfxWd+dT1xs
         /g6g==
X-Gm-Message-State: AOPr4FX9SffGIO15vMX7S0sVowNKyGSKvXaGfH/Qc3R/uzDEtmhxgzbyRZyXXHx5sQUJYxhT
X-Received: by 10.140.88.111 with SMTP id s102mr5145805qgd.63.1461088049625;
        Tue, 19 Apr 2016 10:47:29 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-19.NATPOOL.NYU.EDU. [216.165.95.8])
        by smtp.gmail.com with ESMTPSA id w184sm11073374qkw.4.2016.04.19.10.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Apr 2016 10:47:29 -0700 (PDT)
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1461088041-19264-1-git-send-email-santiago@nyu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291884>

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
 builtin/verify-tag.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index fa26e40..01e956f 100644
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
 
@@ -80,6 +83,8 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
 	unsigned flags = 0;
+	unsigned char sha1[20];
+	const char *name;
 	const struct option verify_tag_options[] = {
 		OPT__VERBOSE(&verbose, N_("print tag contents")),
 		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
@@ -96,8 +101,12 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 	if (verbose)
 		flags |= GPG_VERIFY_VERBOSE;
 
-	while (i < argc)
-		if (verify_tag(argv[i++], flags))
+	while (i < argc) {
+		name = argv[i++];
+		if (get_sha1(name, sha1))
+			had_error = !!error("tag '%s' not found.", name);
+		else if (verify_tag(sha1, name, flags))
 			had_error = 1;
+	}
 	return had_error;
 }
-- 
2.8.0
