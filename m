From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] bundle: rewrite builtin to use parse-options
Date: Thu,  8 Dec 2011 18:40:12 +0530
Message-ID: <1323349817-15737-4-git-send-email-artagnon@gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 14:11:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYdl9-0004Lv-RF
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 14:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409Ab1LHNLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 08:11:31 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52142 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027Ab1LHNLa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 08:11:30 -0500
Received: by mail-iy0-f174.google.com with SMTP id c1so2573483iak.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 05:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=jbY3npIOCxQTEHLFLEf3akdAf+lxgLdJA45iv+KUd5I=;
        b=Ii5Yhh/ZnQHGsmGPlIhLzCn7qBGVaRTjLoL4r82XCZ+686UMiSHxI5aFg3KEUXnlMi
         8Sxh1DgGASpjnaT8pHDtS1NjG1ZyT+FFBd0MMHBYBWG+lXqAccbfiSEztwhmY0SQ58YL
         aATaUw7byMBEJ2cC5cv1tQ/fs4+z410S+QLdo=
Received: by 10.43.49.66 with SMTP id uz2mr3530327icb.9.1323349889782;
        Thu, 08 Dec 2011 05:11:29 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id dd36sm19583344ibb.7.2011.12.08.05.11.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 05:11:28 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186554>

The git-bundle builtin currently parses command-line options by hand;
this is both fragile and cryptic on failure.  Since we now have an
OPT_SUBCOMMAND, make use of it to parse the correct subcommand, while
forbidding the use of more than one subcommand in the same invocation.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/bundle.c |  111 +++++++++++++++++++++++++++++++++++------------------
 1 files changed, 73 insertions(+), 38 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 92a8a60..c977d9f 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "parse-options.h"
 #include "bundle.h"
 
 /*
@@ -9,57 +10,91 @@
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
+
+enum bundle_subcommand {
+	BUNDLE_NONE = 0,
+	BUNDLE_CREATE = 1,
+	BUNDLE_VERIFY = 2,
+	BUNDLE_LIST_HEADS = 4,
+	BUNDLE_UNBUNDLE = 8
+};
 
 int cmd_bundle(int argc, const char **argv, const char *prefix)
 {
-	struct bundle_header header;
-	const char *cmd, *bundle_file;
+	int prefix_length;
 	int bundle_fd = -1;
-	char buffer[PATH_MAX];
+	const char *bundle_file;
+	struct bundle_header header;
+	enum bundle_subcommand subcommand = BUNDLE_NONE;
 
-	if (argc < 3)
-		usage(builtin_bundle_usage);
+	struct option options[] = {
+		OPT_SUBCOMMAND("create", &subcommand,
+			"create a new bundle",
+			BUNDLE_CREATE),
+		OPT_SUBCOMMAND("verify", &subcommand,
+			"verify clean application of the bundle",
+			BUNDLE_VERIFY),
+		OPT_SUBCOMMAND("list-heads", &subcommand,
+			"list references defined in the bundle",
+			BUNDLE_LIST_HEADS),
+		OPT_SUBCOMMAND("unbundle", &subcommand,
+			"pass objects in the bundle to 'git index-pack'",
+			BUNDLE_UNBUNDLE),
+		OPT_END(),
+	};
 
-	cmd = argv[1];
-	bundle_file = argv[2];
-	argc -= 2;
-	argv += 2;
+	argc = parse_options(argc, argv, NULL,
+			options, builtin_bundle_usage,
+			PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN);
 
-	if (prefix && bundle_file[0] != '/') {
-		snprintf(buffer, sizeof(buffer), "%s/%s", prefix, bundle_file);
-		bundle_file = buffer;
-	}
+	if (argc < 2)
+		usage_with_options(builtin_bundle_usage, options);
 
-	memset(&header, 0, sizeof(header));
-	if (strcmp(cmd, "create") && (bundle_fd =
-				read_bundle_header(bundle_file, &header)) < 0)
-		return 1;
+	/* The next parameter on the command line is bundle_file */
+	prefix_length = prefix ? strlen(prefix) : 0;
+	bundle_file = prefix_filename(prefix, prefix_length, argv[1]);
+	argc -= 1;
+	argv += 1;
 
-	if (!strcmp(cmd, "verify")) {
+	/* Read out bundle header, except in BUNDLE_CREATE case */
+	if (subcommand == BUNDLE_VERIFY || subcommand == BUNDLE_LIST_HEADS ||
+		subcommand == BUNDLE_UNBUNDLE) {
+		memset(&header, 0, sizeof(header));
+		bundle_fd = read_bundle_header(bundle_file, &header);
+		if (bundle_fd < 0)
+			die_errno(_("Failed to open bundle file '%s'"), bundle_file);
+	}
+
+	switch (subcommand) {
+	case BUNDLE_CREATE:
+		if (!startup_info->have_repository)
+			die(_("Need a repository to create a bundle."));
+		return create_bundle(&header, bundle_file, argc, argv);
+	case BUNDLE_VERIFY:
 		close(bundle_fd);
 		if (verify_bundle(&header, 1))
-			return 1;
+			return -1; /* Error already reported */
 		fprintf(stderr, _("%s is okay\n"), bundle_file);
-		return 0;
-	}
-	if (!strcmp(cmd, "list-heads")) {
+		break;
+	case BUNDLE_LIST_HEADS:
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
+	case BUNDLE_UNBUNDLE:
+		if (!startup_info->have_repository) {
+			close(bundle_fd);
 			die(_("Need a repository to unbundle."));
-		return !!unbundle(&header, bundle_fd, 0) ||
+		}
+		return unbundle(&header, bundle_fd, 0) ||
 			list_bundle_refs(&header, argc, argv);
-	} else
-		usage(builtin_bundle_usage);
+	default:
+		usage_with_options(builtin_bundle_usage, options);
+	}
+	return 0;
 }
-- 
1.7.7.3
