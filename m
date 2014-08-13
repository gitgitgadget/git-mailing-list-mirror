From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 1/4] fast-import.c: replace `git_config()` with `git_config_get_*()` family
Date: Wed, 13 Aug 2014 01:21:59 -0700
Message-ID: <1407918122-29973-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 10:22:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHTpZ-0003Qr-5Q
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 10:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbaHMIWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 04:22:44 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:43233 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbaHMIWm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 04:22:42 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so14039745pdj.35
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 01:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1HgArH/WpE2hRZu/7k/yAt/Ct1dzsaDlnLYaPiqA5+s=;
        b=wPJiu5cHIMcJw1GXonOkEX9w3Yfdkm68GD2SjgZHJJs1TTOl2qcni7EO5pAnyP38F/
         W+h3y3o6GMmpzLZkPeLTRM8ye56K6Cv2x73Ow6BqvnIjVc4l6MrTDzlIMin8nW2W0C+v
         bREPkdCIRtE5Dkp1g214f284jbgmcpg5fbSwhYElhOU59g81Xv9QuVksT1qAnd2EH7X0
         js5D8FDvy6GLdIsfnTqeKYpsXAB3af7HAFaIeaZMBwncMcdM2lMcwxKrVQBXyE3oh5uk
         hQ2vXAUp21u0FIX4FX3jGbSuwJRQYaZgUFeCS7Zm0qh52btixXYwmJvCidPK/UGu+SWq
         uv9A==
X-Received: by 10.70.134.165 with SMTP id pl5mr2803389pdb.20.1407918162267;
        Wed, 13 Aug 2014 01:22:42 -0700 (PDT)
Received: from localhost.localdomain ([117.254.222.211])
        by mx.google.com with ESMTPSA id fm12sm1919517pdb.46.2014.08.13.01.22.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Aug 2014 01:22:41 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255186>

Use `git_config_get_*()` family instead of `git_config()` to take
advantage of the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 fast-import.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index d73f58c..eca5ed4 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -3274,36 +3274,32 @@ static void parse_option(const char *option)
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
+			die("bad pack compression level %d", pack_compression_level);
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
+			die("bad pack.indexversion=%"PRIu32, pack_idx_opts.version);
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
@@ -3356,7 +3352,7 @@ int main(int argc, char **argv)
 
 	setup_git_directory();
 	reset_pack_idx_option(&pack_idx_opts);
-	git_config(git_pack_config, NULL);
+	git_pack_config();
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level = core_compression_level;
 
-- 
1.9.0.GIT
