From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH v2 1/3] cherry: support --abbrev option
Date: Sat, 20 Mar 2010 19:55:27 +0100
Message-ID: <1269111329-5896-2-git-send-email-kusmabite@gmail.com>
References: <1269111329-5896-1-git-send-email-kusmabite@gmail.com>
Cc: rene.scharfe@lsrfire.ath.cx, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 19:57:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt3rB-0007TB-Fv
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 19:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900Ab0CTS4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 14:56:40 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:22150 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab0CTS4i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 14:56:38 -0400
Received: by ey-out-2122.google.com with SMTP id d26so371281eyd.19
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+qW0IsyyBpzqbIiOks6+oWOKQB3v9eCilHqGZkyLbr0=;
        b=iRJCNSRxRF8iT71Yw162ozNU5NY9keLTXmZfFECtjwu+0aDt7B564izX1iyJ19rErF
         ceHf/cbNH5IoI4rTZxCK0tJTO58X5ypL3Mxl2gCscB+Nad3DtuoOz/ptQPcSWeXA/sg/
         sSmb+iI+Epsh/yplYDh48Y0ttbKaeMJokZjXA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Bb1+hvj+wMJJNtfrZIXU/qSU231WjrBYKrKWnIKv79EJHofd1R7uoUiKPigyDMmIxC
         8Ta5QhBsnNhTKjZYrVKal442P4ZCHLD9X31JvDLKceOrGOEz6KgVFFSBChL+HrPHU1fM
         eVdM5bR8AUAk7E0aSXNU9DW6BJ74ltR5YHlfs=
Received: by 10.213.90.139 with SMTP id i11mr1661468ebm.96.1269111396845;
        Sat, 20 Mar 2010 11:56:36 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id 15sm1707328ewy.12.2010.03.20.11.56.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Mar 2010 11:56:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.456.g64f24
In-Reply-To: <1269111329-5896-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142737>

Switch to parse-options API while we're at it.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 builtin/log.c |   39 +++++++++++++++++++++------------------
 1 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index b70d0f7..fd8d18c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1286,8 +1286,11 @@ static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
 	return -1;
 }
 
-static const char cherry_usage[] =
-"git cherry [-v] [<upstream> [<head> [<limit>]]]";
+static const char * const cherry_usage[] = {
+	"git cherry [-v] [<upstream> [<head> [<limit>]]]",
+	NULL
+};
+
 int cmd_cherry(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -1298,26 +1301,25 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	const char *upstream;
 	const char *head = "HEAD";
 	const char *limit = NULL;
-	int verbose = 0;
+	int verbose = 0, abbrev = 0;
 
-	if (argc > 1 && !strcmp(argv[1], "-v")) {
-		verbose = 1;
-		argc--;
-		argv++;
-	}
+	struct option options[] = {
+		OPT__ABBREV(&abbrev),
+		OPT__VERBOSE(&verbose),
+		OPT_END()
+	};
 
-	if (argc > 1 && !strcmp(argv[1], "-h"))
-		usage(cherry_usage);
+	argc = parse_options(argc, argv, prefix, options, cherry_usage, 0);
 
 	switch (argc) {
-	case 4:
-		limit = argv[3];
-		/* FALLTHROUGH */
 	case 3:
-		head = argv[2];
+		limit = argv[2];
 		/* FALLTHROUGH */
 	case 2:
-		upstream = argv[1];
+		head = argv[1];
+		/* FALLTHROUGH */
+	case 1:
+		upstream = argv[0];
 		break;
 	default:
 		current_branch = branch_get(NULL);
@@ -1327,7 +1329,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 			fprintf(stderr, "Could not find a tracked"
 					" remote branch, please"
 					" specify <upstream> manually.\n");
-			usage(cherry_usage);
+			usage_with_options(cherry_usage, options);
 		}
 
 		upstream = current_branch->merge[0]->dst;
@@ -1380,12 +1382,13 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 			pretty_print_commit(CMIT_FMT_ONELINE, commit,
 					    &buf, &ctx);
 			printf("%c %s %s\n", sign,
-			       sha1_to_hex(commit->object.sha1), buf.buf);
+			       find_unique_abbrev(commit->object.sha1, abbrev),
+			       buf.buf);
 			strbuf_release(&buf);
 		}
 		else {
 			printf("%c %s\n", sign,
-			       sha1_to_hex(commit->object.sha1));
+			       find_unique_abbrev(commit->object.sha1, abbrev));
 		}
 
 		list = list->next;
-- 
1.7.0.2.456.g64f24
