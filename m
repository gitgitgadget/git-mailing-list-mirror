From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 4/4] prune-packed: migrate to parse-options
Date: Tue,  7 Jul 2009 22:15:41 -0700
Message-ID: <1247030141-11695-5-git-send-email-bebarino@gmail.com>
References: <1247030141-11695-1-git-send-email-bebarino@gmail.com>
 <1247030141-11695-2-git-send-email-bebarino@gmail.com>
 <1247030141-11695-3-git-send-email-bebarino@gmail.com>
 <1247030141-11695-4-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 07:16:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOPVv-00082W-Il
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 07:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756989AbZGHFQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 01:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756827AbZGHFQK
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 01:16:10 -0400
Received: from mail-pz0-f193.google.com ([209.85.222.193]:35234 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756513AbZGHFQH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 01:16:07 -0400
Received: by pzk31 with SMTP id 31so3404578pzk.33
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 22:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=31lt85hi0GfmmxZhQZm/E66Sw7XGfg+DK9CVL9tN68M=;
        b=jlLVoZrWWLWHc0bqKPRhoIwVSTDlIbncWVu4ugaL5kbgPnXXj06S7Wa1GmaGgvSQD0
         E4lHagTqzdE/BIY/6c+4N6LEJVgQiStUnmFs/m9DqHrzcNNKqUMH0Jw70NN7RYl+p1BI
         9qrzBSsFCSHmhnlI9YmV73YAXT2FXgSI5p55A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dKYFVQJOe4p4MLkoC7+kXinzyI6f+sAeXeUIF9Fk3KkwFZ4LamUJfx3qPX0k94xTje
         M/WfMlcxJqeRVaN8kZyFcoKYQgzTHPwwXCVd9O0arS6JMWFws9Ybb4KTLpa8PO2UelRL
         rTSa0L0f7NEOaID2sGw4cJ6UYk0q1XLgYfAn0=
Received: by 10.114.59.9 with SMTP id h9mr10659882waa.88.1247030166333;
        Tue, 07 Jul 2009 22:16:06 -0700 (PDT)
Received: from earth (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id n30sm815569wag.6.2009.07.07.22.16.04
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Jul 2009 22:16:05 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 07 Jul 2009 22:16:02 -0700
X-Mailer: git-send-email 1.6.3.3.385.g60647
In-Reply-To: <1247030141-11695-4-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122890>

Add --dry-run and --quiet to be more consistent with the rest of git.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 Documentation/git-prune-packed.txt |    4 +++-
 builtin-prune-packed.c             |   29 ++++++++++++-----------------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
index b5f26ce..abfc6b6 100644
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -8,7 +8,7 @@ git-prune-packed - Remove extra objects that are already in pack files
 
 SYNOPSIS
 --------
-'git prune-packed' [-n] [-q]
+'git prune-packed' [-n|--dry-run] [-q|--quiet]
 
 
 DESCRIPTION
@@ -28,10 +28,12 @@ disk storage, etc.
 OPTIONS
 -------
 -n::
+--dry-run::
         Don't actually remove any objects, only show those that would have been
         removed.
 
 -q::
+--quiet::
 	Squelch the progress indicator.
 
 Author
diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index 00590b1..be99eb0 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -1,9 +1,12 @@
 #include "builtin.h"
 #include "cache.h"
 #include "progress.h"
+#include "parse-options.h"
 
-static const char prune_packed_usage[] =
-"git prune-packed [-n] [-q]";
+static const char * const prune_packed_usage[] = {
+	"git prune-packed [-n|--dry-run] [-q|--quiet]",
+	NULL
+};
 
 #define DRY_RUN 01
 #define VERBOSE 02
@@ -68,24 +71,16 @@ void prune_packed_objects(int opts)
 
 int cmd_prune_packed(int argc, const char **argv, const char *prefix)
 {
-	int i;
 	int opts = VERBOSE;
+	const struct option prune_packed_options[] = {
+		OPT_BIT('n', "dry-run", &opts, "dry run", DRY_RUN),
+		OPT_NEGBIT('q', "quiet", &opts, "be quiet", VERBOSE),
+		OPT_END()
+	};
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
+	argc = parse_options(argc, argv, prefix, prune_packed_options,
+			     prune_packed_usage, 0);
 
-		if (*arg == '-') {
-			if (!strcmp(arg, "-n"))
-				opts |= DRY_RUN;
-			else if (!strcmp(arg, "-q"))
-				opts &= ~VERBOSE;
-			else
-				usage(prune_packed_usage);
-			continue;
-		}
-		/* Handle arguments here .. */
-		usage(prune_packed_usage);
-	}
 	prune_packed_objects(opts);
 	return 0;
 }
-- 
1.6.3.3.385.g60647
