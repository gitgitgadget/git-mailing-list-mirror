From: Junio C Hamano <junio@pobox.com>
Subject: [PATCH 4/5] builtin-prune.c: use parse_options()
Date: Mon, 24 Mar 2008 23:59:43 -0700
Message-ID: <7vzlsnmgps.fsf@gitster.siamese.dyndns.org>
References: <200803232150.29971.barra_cuda@katamail.com>
 <200803241502.21465.barra_cuda@katamail.com>
 <7vwsnrubmd.fsf@gitster.siamese.dyndns.org>
 <200803242218.44026.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 08:00:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je39E-0002xd-NY
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 08:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752781AbYCYG76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 02:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbYCYG75
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 02:59:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbYCYG74 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 02:59:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C873A2F8E;
	Tue, 25 Mar 2008 02:59:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 18F7D2F89; Tue, 25 Mar 2008 02:59:50 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78157>

From: Michele Ballabio <barra_cuda@katamail.com>
Date: Sun, 23 Mar 2008 21:50:29 +0100

Using the OPT_DATE() introduced earlier, this updates builtin-prune to
use parse_options().

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-prune.c |   38 ++++++++++++++++----------------------
 1 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index bb8ead9..71caac5 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -4,8 +4,12 @@
 #include "revision.h"
 #include "builtin.h"
 #include "reachable.h"
+#include "parse-options.h"
 
-static const char prune_usage[] = "git-prune [-n]";
+static const char * const prune_usage[] = {
+	"git-prune [-n] [--expire <time>] [--] [<head>...]",
+	NULL
+};
 static int show_only;
 static unsigned long expire;
 
@@ -123,32 +127,22 @@ static void remove_temporary_files(void)
 
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
-	int i;
 	struct rev_info revs;
-
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		if (!strcmp(arg, "-n")) {
-			show_only = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--expire")) {
-			if (++i < argc) {
-				expire = approxidate(argv[i]);
-				continue;
-			}
-		}
-		else if (!prefixcmp(arg, "--expire=")) {
-			expire = approxidate(arg + 9);
-			continue;
-		}
-		usage(prune_usage);
-	}
+	const struct option options[] = {
+		OPT_BOOLEAN('n', NULL, &show_only,
+			    "do not remove, show only"),
+		OPT_DATE(0, "expire", &expire,
+			 "expire objects older than <time>"),
+		OPT_END()
+	};
 
 	save_commit_buffer = 0;
 	init_revisions(&revs, prefix);
-	mark_reachable_objects(&revs, 1);
 
+	argc = parse_options(argc, argv, options, prune_usage, 0);
+	if (argc)
+		die ("unrecognized argument: %s", name);
+	mark_reachable_objects(&revs, 1);
 	prune_object_dir(get_object_directory());
 
 	sync();
-- 
1.5.5.rc1.121.g1594
