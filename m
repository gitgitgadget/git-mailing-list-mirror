From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 2/4] tag-verify: migrate to parse-options
Date: Tue,  7 Jul 2009 22:15:39 -0700
Message-ID: <1247030141-11695-3-git-send-email-bebarino@gmail.com>
References: <1247030141-11695-1-git-send-email-bebarino@gmail.com>
 <1247030141-11695-2-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 07:16:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOPVu-00082W-0x
	for gcvg-git-2@gmane.org; Wed, 08 Jul 2009 07:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756275AbZGHFP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 01:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754909AbZGHFP7
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 01:15:59 -0400
Received: from mail-px0-f181.google.com ([209.85.216.181]:37259 "EHLO
	mail-px0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbZGHFP6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 01:15:58 -0400
Received: by mail-px0-f181.google.com with SMTP id 11so141523pxi.33
        for <git@vger.kernel.org>; Tue, 07 Jul 2009 22:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=jI+kIa3x2WpoHONuxrFvPGrazQhOIsAEuhLK50QLaX0=;
        b=tReshAk9FLP4g8U72pC7ZJpv8+L/eJEYg30yhZleC+cFYFELH6oj/rW4KxaKQD96ra
         H/LRzkxeXkV9s6UmiaiUoNjH/bb6t377Qow9NLkEeADULtppzDrZ2Y/BKz98jLBzrs5L
         KeGloP7xAsRFztcL55Cy44Q9AXXT69QuSLhFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cZYjiPIZ4KDqM2foHnTrXIZMdBqQMuk5gVkrdh5wcvs/pyucY0N/J2wWQ0SVsQJgdU
         q+qkX4ZFuGrj3aH8gNP4EolZbVVuKpyIpZjZNt2TLbR2gECJORfrQbkNAWorWtTdPwHF
         KcwBaS5aEsQKoFm09DkU3Sr9u9G7NYtKJf3bU=
Received: by 10.114.167.3 with SMTP id p3mr10647097wae.92.1247030158241;
        Tue, 07 Jul 2009 22:15:58 -0700 (PDT)
Received: from earth (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id l30sm933942waf.35.2009.07.07.22.15.54
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Jul 2009 22:15:57 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Tue, 07 Jul 2009 22:15:49 -0700
X-Mailer: git-send-email 1.6.3.3.385.g60647
In-Reply-To: <1247030141-11695-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122886>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

It may be nicer to die with a message like "Must give a tag to verify"
or something when a tag isn't given, but that could probably be a
later patch.

 builtin-verify-tag.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/builtin-verify-tag.c b/builtin-verify-tag.c
index 7f7fda4..9f482c2 100644
--- a/builtin-verify-tag.c
+++ b/builtin-verify-tag.c
@@ -10,9 +10,12 @@
 #include "tag.h"
 #include "run-command.h"
 #include <signal.h>
+#include "parse-options.h"
 
-static const char builtin_verify_tag_usage[] =
-		"git verify-tag [-v|--verbose] <tag>...";
+static const char * const verify_tag_usage[] = {
+		"git verify-tag [-v|--verbose] <tag>...",
+		NULL
+};
 
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
 
@@ -89,17 +92,17 @@ static int verify_tag(const char *name, int verbose)
 int cmd_verify_tag(int argc, const char **argv, const char *prefix)
 {
 	int i = 1, verbose = 0, had_error = 0;
+	const struct option verify_tag_options[] = {
+		OPT__VERBOSE(&verbose),
+		OPT_END()
+	};
 
 	git_config(git_default_config, NULL);
 
-	if (argc > 1 &&
-	    (!strcmp(argv[i], "-v") || !strcmp(argv[i], "--verbose"))) {
-		verbose = 1;
-		i++;
-	}
-
+	argc = parse_options(argc, argv, prefix, verify_tag_options,
+			     verify_tag_usage, PARSE_OPT_KEEP_ARGV0);
 	if (argc <= i)
-		usage(builtin_verify_tag_usage);
+		usage_with_options(verify_tag_usage, verify_tag_options);
 
 	/* sometimes the program was terminated because this signal
 	 * was received in the process of writing the gpg input: */
-- 
1.6.3.3.385.g60647
