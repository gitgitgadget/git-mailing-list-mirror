From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] unpack-objects: migrate to parse-options
Date: Wed, 30 Mar 2011 01:37:26 -0700
Message-ID: <1301474246-7515-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 10:37:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4quQ-0000q7-IZ
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 10:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127Ab1C3Ihh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 04:37:37 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:56590 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124Ab1C3Ihd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 04:37:33 -0400
Received: by gxk21 with SMTP id 21so425933gxk.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 01:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=RRo3AzhfudcDDo9+IPR7N9s+bpDMWGlDlZlGOdqTGxE=;
        b=LX8Zae4pv9186K1I7z0Vv4gkmo8KLXAB/X4D8M6zrffvEKCxVTolJZzaucDTWJUpfh
         JE0CIKGJZqYDL2luKMIjrCoAyC4lTEQpIXvezf2MZCHnR+jaRAqq0k0XNL52tYNcUo21
         Mq2Y/+mFyNYTIf8mjRJRa8qIbuiIkYCSauHPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Z4hIqNULaBU+TvDgkhynkKzJ3IalyII9K8ZVE79aSKH1VZaC5ZAx+NJFhHzTwI/1EN
         u9ZdyCyV4D7W8bqYmGhi1Bu49aV/i9eXjqmqHnwxuRRdDqdPNPOX6FsbtezebXPADWAO
         5Owpc9kzPOeV+kNzGmpNulGvRowHdv4XbqJnI=
Received: by 10.236.197.9 with SMTP id s9mr1205614yhn.324.1301474252440;
        Wed, 30 Mar 2011 01:37:32 -0700 (PDT)
Received: from earth ([75.85.182.25])
        by mx.google.com with ESMTPS id h41sm2905560yhm.66.2011.03.30.01.37.28
        (version=SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 01:37:31 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Wed, 30 Mar 2011 01:37:26 -0700
X-Mailer: git-send-email 1.7.4.2.422.g537d99
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170364>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 builtin/unpack-objects.c |   80 ++++++++++++++++++++++------------------------
 1 files changed, 38 insertions(+), 42 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index f63973c..183a967 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -11,9 +11,13 @@
 #include "progress.h"
 #include "decorate.h"
 #include "fsck.h"
+#include "parse-options.h"
 
 static int dry_run, quiet, recover, has_errors, strict;
-static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict] < pack-file";
+static const char * const unpack_usage[] = {
+	"git unpack-objects [options] < pack-file",
+	NULL
+};
 
 /* We always read in 4kB chunks. */
 static unsigned char buffer[4096];
@@ -492,10 +496,38 @@ static void unpack_all(void)
 		die("unresolved deltas left after unpacking");
 }
 
+static int pack_header_cb(const struct option *opt, const char *arg, int unset)
+{
+	struct pack_header *hdr;
+	char *c;
+
+	hdr = (struct pack_header *)buffer;
+	hdr->hdr_signature = htonl(PACK_SIGNATURE);
+	hdr->hdr_version = htonl(strtoul(arg, &c, 10));
+	if (*c != ',')
+		die("bad %s", arg);
+	hdr->hdr_entries = htonl(strtoul(c + 1, &c, 10));
+	if (*c)
+		die("bad %s", arg);
+	len = sizeof(*hdr);
+	return 0;
+}
+
 int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 {
-	int i;
 	unsigned char sha1[20];
+	const struct option unpack_options[] = {
+		OPT__DRY_RUN(&dry_run,
+			    "check the pack file but don't actually unpack it"),
+		OPT__QUIET(&quiet, "suppress percentage progress"),
+		OPT_BOOLEAN('r', NULL, &recover, "ignore corrupt packfiles"),
+		OPT_BOOLEAN(0, "strict", &strict,
+			    "don't write objects with broken content or links"),
+		{ OPTION_CALLBACK, 0, "pack_header", NULL, "<ver>,<entries>",
+		  "internal option", PARSE_OPT_HIDDEN | PARSE_OPT_NONEG |
+		  PARSE_OPT_LITERAL_ARGHELP, pack_header_cb },
+		OPT_END()
+	};
 
 	read_replace_refs = 0;
 
@@ -503,47 +535,11 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 
 	quiet = !isatty(2);
 
-	for (i = 1 ; i < argc; i++) {
-		const char *arg = argv[i];
-
-		if (*arg == '-') {
-			if (!strcmp(arg, "-n")) {
-				dry_run = 1;
-				continue;
-			}
-			if (!strcmp(arg, "-q")) {
-				quiet = 1;
-				continue;
-			}
-			if (!strcmp(arg, "-r")) {
-				recover = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--strict")) {
-				strict = 1;
-				continue;
-			}
-			if (!prefixcmp(arg, "--pack_header=")) {
-				struct pack_header *hdr;
-				char *c;
-
-				hdr = (struct pack_header *)buffer;
-				hdr->hdr_signature = htonl(PACK_SIGNATURE);
-				hdr->hdr_version = htonl(strtoul(arg + 14, &c, 10));
-				if (*c != ',')
-					die("bad %s", arg);
-				hdr->hdr_entries = htonl(strtoul(c + 1, &c, 10));
-				if (*c)
-					die("bad %s", arg);
-				len = sizeof(*hdr);
-				continue;
-			}
-			usage(unpack_usage);
-		}
-
+	argc = parse_options(argc, argv, prefix, unpack_options,
+			     unpack_usage, 0);
+	if (argc)
 		/* We don't take any non-flag arguments now.. Maybe some day */
-		usage(unpack_usage);
-	}
+		usage_with_options(unpack_usage, unpack_options);
 	git_SHA1_Init(&ctx);
 	unpack_all();
 	git_SHA1_Update(&ctx, buffer, offset);
-- 
1.7.4.2.422.g537d99
