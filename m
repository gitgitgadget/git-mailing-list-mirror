From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] bundle: rewrite builtin to use parse-options
Date: Thu, 15 Dec 2011 22:15:28 +0530
Message-ID: <1323967528-10537-3-git-send-email-artagnon@gmail.com>
References: <20111208175913.GK2394@elie.hsd1.il.comcast.net>
 <1323967528-10537-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Joey Hess <joey@kitenet.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 17:45:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbERQ-0001HY-75
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 17:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594Ab1LOQpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 11:45:49 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42502 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932565Ab1LOQps (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 11:45:48 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so3006690iae.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 08:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=T68pgjQ7Eayh3CxID/8dUDBYWedN9+E99T6FnBYufDw=;
        b=Qql5KY98snaWfD3ec+Q2FWLatK2Kcp5pyDc9oYAMDaGOSB0Oow2xectA3muUcRR3Js
         lKHEfcHprizfOlpmpa9ACN2Bb+hJBWCd9pr3aIl07Cqtagq8h4Eiajda7ExvwDgFP9I3
         GmUEl4LVSPPH21C7v5LMlJJQAVgPlCKKry42g=
Received: by 10.42.29.137 with SMTP id r9mr2879097icc.20.1323967548483;
        Thu, 15 Dec 2011 08:45:48 -0800 (PST)
Received: from localhost.localdomain ([122.174.88.206])
        by mx.google.com with ESMTPS id lu10sm11031370igc.0.2011.12.15.08.45.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 08:45:47 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1323967528-10537-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187212>

The git-bundle builtin currently parses command-line options by hand;
this is fragile, and reports cryptic errors on failure.  Use the
parse-options library to do the parsing instead.

Encouraged-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/bundle.c  |   91 +++++++++++++++++++++++++++++++----------------------
 t/t5704-bundle.sh |    2 +-
 2 files changed, 54 insertions(+), 39 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 92a8a60..13ed770 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "parse-options.h"
 #include "bundle.h"
 
 /*
@@ -9,57 +10,71 @@
  * bundle supporting "fetch", "pull", and "ls-remote".
  */
 
-static const char builtin_bundle_usage[] =
-  "git bundle create <file> <git-rev-list args>\n"
-  "   or: git bundle verify <file>\n"
-  "   or: git bundle list-heads <file> [<refname>...]\n"
-  "   or: git bundle unbundle <file> [<refname>...]";
+static const char * builtin_bundle_usage[] = {
+	"git bundle create <file> <git-rev-list args>",
+	"git bundle verify <file>",
+	"git bundle list-heads <file> [<refname>...]",
+	"git bundle unbundle <file> [<refname>...]",
+	NULL
+};
 
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
-	struct bundle_header header;
-	const char *cmd, *bundle_file;
+	int prefix_length;
 	int bundle_fd = -1;
-	char buffer[PATH_MAX];
+	const char *subcommand, *bundle_file;
+	struct bundle_header header;
+	struct option options[] = { OPT_END() };
 
-	if (argc < 3)
-		usage(builtin_bundle_usage);
+	argc = parse_options(argc, argv, prefix, options,
+			builtin_bundle_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
-	cmd = argv[1];
-	bundle_file = argv[2];
-	argc -= 2;
-	argv += 2;
+	if (argc < 2)
+		usage_with_options(builtin_bundle_usage, options);
+	subcommand = argv[0];
 
-	if (prefix && bundle_file[0] != '/') {
-		snprintf(buffer, sizeof(buffer), "%s/%s", prefix, bundle_file);
-		bundle_file = buffer;
-	}
+	argc = parse_options(argc, argv, prefix, options,
+			builtin_bundle_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+
+	/* Disallow stray arguments */
+	if ((strcmp(subcommand, "create") && argc > 2) ||
+		(!strcmp(subcommand, "verify") && argc > 1))
+		usage_with_options(builtin_bundle_usage, options);
 
-	memset(&header, 0, sizeof(header));
-	if (strcmp(cmd, "create") && (bundle_fd =
-				read_bundle_header(bundle_file, &header)) < 0)
-		return 1;
+	prefix_length = prefix ? strlen(prefix) : 0;
+	bundle_file = prefix_filename(prefix, prefix_length, argv[0]);
 
-	if (!strcmp(cmd, "verify")) {
+	/* Read out bundle header, except in the "create" case */
+	if (strcmp(subcommand, "create")) {
+		memset(&header, 0, sizeof(header));
+		bundle_fd = read_bundle_header(bundle_file, &header);
+		if (bundle_fd < 0)
+			die_errno(_("Failed to open bundle file '%s'"), bundle_file);
+	}
+
+	if (!strcmp(subcommand, "create")) {
+		if (!startup_info->have_repository)
+			die(_("Need a repository to create a bundle."));
+		return create_bundle(&header, bundle_file, argc, argv);
+	} else if (!strcmp(subcommand, "verify")) {
 		close(bundle_fd);
 		if (verify_bundle(&header, 1))
-			return 1;
+			return -1; /* Error already reported */
 		fprintf(stderr, _("%s is okay\n"), bundle_file);
-		return 0;
-	}
-	if (!strcmp(cmd, "list-heads")) {
+	} else if (!strcmp(subcommand, "list-heads")) {
 		close(bundle_fd);
-		return !!list_bundle_refs(&header, argc, argv);
-	}
-	if (!strcmp(cmd, "create")) {
-		if (!startup_info->have_repository)
-			die(_("Need a repository to create a bundle."));
-		return !!create_bundle(&header, bundle_file, argc, argv);
-	} else if (!strcmp(cmd, "unbundle")) {
-		if (!startup_info->have_repository)
+		return list_bundle_refs(&header, argc, argv);
+	} else if (!strcmp(subcommand, "unbundle")) {
+		if (!startup_info->have_repository) {
+			close(bundle_fd);
 			die(_("Need a repository to unbundle."));
-		return !!unbundle(&header, bundle_fd, 0) ||
+		}
+		return unbundle(&header, bundle_fd, 0) ||
 			list_bundle_refs(&header, argc, argv);
-	} else
-		usage(builtin_bundle_usage);
+	} else {
+		close(bundle_fd);
+		usage_with_options(builtin_bundle_usage, options);
+	}
+
+	return 0;
 }
diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index 09ff4f1..8e3f677 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -53,7 +53,7 @@ test_expect_success 'disallow stray command-line options' '
 	test_must_fail git bundle create --junk bundle second third
 '
 
-test_expect_failure 'disallow stray command-line arguments' '
+test_expect_success 'disallow stray command-line arguments' '
 	git bundle create bundle second third &&
 	test_must_fail git bundle verify bundle junk
 '
-- 
1.7.4.1
