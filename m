From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 3/4] verify-pack: migrate to parse-options
Date: Tue,  7 Jul 2009 22:15:40 -0700
Message-ID: <1247030141-11695-4-git-send-email-bebarino@gmail.com>
References: <1247030141-11695-1-git-send-email-bebarino@gmail.com>
 <1247030141-11695-2-git-send-email-bebarino@gmail.com>
 <1247030141-11695-3-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 07:16:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOPVu-00082W-Q2
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 07:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756848AbZGHFQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 01:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756748AbZGHFQI
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 01:16:08 -0400
Received: from mail-pz0-f193.google.com ([209.85.222.193]:35535 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756399AbZGHFQG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 01:16:06 -0400
Received: by pzk31 with SMTP id 31so3404566pzk.33
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 22:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=/1AA4zNE9JFSnAQl5q2nYOzbCXtw/YH2QmxEZygI/7o=;
        b=Ye+9EycLY2V0aH9RLiXYeUSB3XaQ9oB8ioUFSg9mgxKMCiunghDTNOPbGlzMMzGz6H
         q9+YOucItuQ7bbeY4JbJPKh8AKuF0aZffbDp4dsWN7TtDtvqKjI3JAwDzJLyogaJf7Dx
         DQ90T2aG7Yombh4C8ORPzENfWuqoUXGcNdJNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=x9Y5aB+jN2E6Nad6Ly/7OT7X60cZWqQIXSLmkHK8Fu/x2uFRXWmzZ6zvmh9ZqiSm7P
         qnMUyVeS0I3pMG2O2CRC8B7ZWIm9FtuQe8MMHR1m4w0M24PiK5IwMZmJMXvGPBI59Sk5
         MeRYtFmmLZa/MWEPjsesFXwOaY1Zb+DK5MAH4=
Received: by 10.114.135.16 with SMTP id i16mr10797302wad.3.1247030162462;
        Tue, 07 Jul 2009 22:16:02 -0700 (PDT)
Received: from earth (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id m30sm573161wag.69.2009.07.07.22.16.00
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Jul 2009 22:16:01 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 07 Jul 2009 22:15:58 -0700
X-Mailer: git-send-email 1.6.3.3.385.g60647
In-Reply-To: <1247030141-11695-3-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122887>

OPT__VERBOSE adds a --verbose option, so document the new addition.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-verify-pack.txt |    3 +-
 builtin-verify-pack.c             |   40 ++++++++++++++++--------------------
 2 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index c861163..d791a80 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -8,7 +8,7 @@ git-verify-pack - Validate packed git archive files
 
 SYNOPSIS
 --------
-'git verify-pack' [-v] [--] <pack>.idx ...
+'git verify-pack' [-v|--verbose] [--] <pack>.idx ...
 
 
 DESCRIPTION
@@ -23,6 +23,7 @@ OPTIONS
 	The idx files to verify.
 
 -v::
+--verbose::
 	After verifying the pack, show list of objects contained
 	in the pack.
 \--::
diff --git a/builtin-verify-pack.c b/builtin-verify-pack.c
index 0ee0a9a..ebd6dff 100644
--- a/builtin-verify-pack.c
+++ b/builtin-verify-pack.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "pack.h"
 #include "pack-revindex.h"
+#include "parse-options.h"
 
 #define MAX_CHAIN 50
 
@@ -107,36 +108,31 @@ static int verify_one_pack(const char *path, int verbose)
 	return err;
 }
 
-static const char verify_pack_usage[] = "git verify-pack [-v] <pack>...";
+static const char * const verify_pack_usage[] = {
+	"git verify-pack [-v|--verbose] <pack>...",
+	NULL
+};
 
 int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 {
 	int err = 0;
 	int verbose = 0;
-	int no_more_options = 0;
-	int nothing_done = 1;
+	int i;
+	const struct option verify_pack_options[] = {
+		OPT__VERBOSE(&verbose),
+		OPT_END()
+	};
 
 	git_config(git_default_config, NULL);
-	while (1 < argc) {
-		if (!no_more_options && argv[1][0] == '-') {
-			if (!strcmp("-v", argv[1]))
-				verbose = 1;
-			else if (!strcmp("--", argv[1]))
-				no_more_options = 1;
-			else
-				usage(verify_pack_usage);
-		}
-		else {
-			if (verify_one_pack(argv[1], verbose))
-				err = 1;
-			discard_revindex();
-			nothing_done = 0;
-		}
-		argc--; argv++;
+	argc = parse_options(argc, argv, prefix, verify_pack_options,
+			     verify_pack_usage, 0);
+	if (argc < 1)
+		usage_with_options(verify_pack_usage, verify_pack_options);
+	for (i = 0; i < argc; i++) {
+		if (verify_one_pack(argv[i], verbose))
+			err = 1;
+		discard_revindex();
 	}
 
-	if (nothing_done)
-		usage(verify_pack_usage);
-
 	return err;
 }
-- 
1.6.3.3.385.g60647
