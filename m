From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 1/5] fast-import.c: replace `git_config()` with `git_config_get_*()`
 family
Date: Wed, 13 Aug 2014 17:52:56 +0530
Message-ID: <53EB58A0.10307@gmail.com>
References: <1407918122-29973-1-git-send-email-tanayabh@gmail.com> <vpqppg4vdii.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 13 14:23:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHXa8-0006pW-Su
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 14:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbaHMMXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 08:23:04 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35482 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155AbaHMMXD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 08:23:03 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so14356406pde.37
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 05:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=/OUYlmdhtluGS+seKZ+SFrHUury6ZUUDDyEOtseUoY8=;
        b=P8hOU/UWcWARodCDf0BleRQBMYaP1Qk//5/BpwQTHWyGbsr96zy6P5X0/myTy9VtHQ
         ygr2h9OrexPPqSMGzqJOMSws2lDFhXqf4LI0mzhL6/p1LzZkgXNjAOmYLuu6t4HEdIUG
         pE3JDcSupm7hSHcSAAXdy28iClwR2xF+BX1vkqjpFGVNc9wmqCPgSr71irZkQzNh+yBb
         /gTedaE0r7umJwBN5WfTXnYwl3Sf1L78TVo8L0j5veZrIHOpDdYQV1POVARZP1j3D14+
         jdf+Hej/LwcQXNQjBBGL+J0Bx7dZrAnRldjnRlnE0NScjSsSXSubSHnVww3xoJjn3yQJ
         N8kw==
X-Received: by 10.68.69.71 with SMTP id c7mr3794387pbu.43.1407932582379;
        Wed, 13 Aug 2014 05:23:02 -0700 (PDT)
Received: from [127.0.0.1] ([117.254.223.107])
        by mx.google.com with ESMTPSA id xc5sm1977499pbc.66.2014.08.13.05.22.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Aug 2014 05:23:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqppg4vdii.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255205>

Use `git_config_get_*()` family instead of `git_config()` to take
advantage of the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 fast-import.c | 44 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index d73f58c..34e780d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3274,36 +3274,34 @@ static void parse_option(const char *option)
 	die("This version of fast-import does not support option: %s", option);
 }

-static int git_pack_config(const char *k, const char *v, void *cb)
+static void git_pack_config(void)
 {
-	if (!strcmp(k, "pack.depth")) {
-		max_depth = git_config_int(k, v);
+	int indexversion_value;
+	unsigned long packsizelimit_value;
+
+	if (!git_config_get_ulong("pack.depth", &max_depth)) {
 		if (max_depth > MAX_DEPTH)
 			max_depth = MAX_DEPTH;
-		return 0;
 	}
-	if (!strcmp(k, "pack.compression")) {
-		int level = git_config_int(k, v);
-		if (level == -1)
-			level = Z_DEFAULT_COMPRESSION;
-		else if (level < 0 || level > Z_BEST_COMPRESSION)
-			die("bad pack compression level %d", level);
-		pack_compression_level = level;
+	if (!git_config_get_int("pack.compression", &pack_compression_level)) {
+		if (pack_compression_level == -1)
+			pack_compression_level = Z_DEFAULT_COMPRESSION;
+		else if (pack_compression_level < 0 ||
+			 pack_compression_level > Z_BEST_COMPRESSION)
+			git_die_config("pack.compression",
+					"bad pack compression level %d", pack_compression_level);
 		pack_compression_seen = 1;
-		return 0;
 	}
-	if (!strcmp(k, "pack.indexversion")) {
-		pack_idx_opts.version = git_config_int(k, v);
+	if (!git_config_get_int("pack.indexversion", &indexversion_value)) {
+		pack_idx_opts.version = indexversion_value;
 		if (pack_idx_opts.version > 2)
-			die("bad pack.indexversion=%"PRIu32,
-			    pack_idx_opts.version);
-		return 0;
+			git_die_config("pack.indexversion",
+					"bad pack.indexversion=%"PRIu32, pack_idx_opts.version);
 	}
-	if (!strcmp(k, "pack.packsizelimit")) {
-		max_packsize = git_config_ulong(k, v);
-		return 0;
-	}
-	return git_default_config(k, v, cb);
+	if (!git_config_get_ulong("pack.packsizelimit", &packsizelimit_value))
+		max_packsize = packsizelimit_value;
+
+	git_config(git_default_config, NULL);
 }

 static const char fast_import_usage[] =
@@ -3356,7 +3354,7 @@ int main(int argc, char **argv)

 	setup_git_directory();
 	reset_pack_idx_option(&pack_idx_opts);
-	git_config(git_pack_config, NULL);
+	git_pack_config();
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level = core_compression_level;

-- 
1.9.0.GIT
