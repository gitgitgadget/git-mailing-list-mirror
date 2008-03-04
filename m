From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] Make builtin-reset.c use parse_options.
Date: Tue, 04 Mar 2008 23:11:34 +0100
Message-ID: <47CDC916.6010008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 23:12:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWfNJ-0002pu-Nu
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 23:12:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758766AbYCDWME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 17:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758272AbYCDWMD
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 17:12:03 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:3851 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758633AbYCDWMB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 17:12:01 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2924005ugc.16
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 14:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=L6YhN7+div7YHRPY3jXGt+LGqSfEBHz4pZSHV/ErsHk=;
        b=gvm+3veHUeMw+9U74EdtKbatNuQsbtdyfwwOPtMVJeRYlG7pybXado5XTiuDCz5mXSSHnSX//JsA1xXlnQ5rWXTfrLPtY2Plw4t8ZZXsl0dSDNGR60rzTtX+5bsqMagWJYF/rbi3D51gci1l61OjokwQwZp2iUa1aStFx4G4w8U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=AbKgmTgO6QV4wgYBUg2RGeLaQGBWSTLv0L60dQuq4duwMYttZZCA6kGSoYtU1lwVqfVYl5UhVhMly37/uOsDvBIKwxSmpZ/j31M2P3JPK8tgoq2KNzHmgR7w6KLst/brZCXw0VR0K0pEVhIf64HQgj92rcD3dl4xSMOLTkD7MM4=
Received: by 10.78.131.8 with SMTP id e8mr4756287hud.35.1204668719525;
        Tue, 04 Mar 2008 14:11:59 -0800 (PST)
Received: from ?192.168.0.192? ( [212.145.102.186])
        by mx.google.com with ESMTPS id 31sm249884nfu.24.2008.03.04.14.11.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Mar 2008 14:11:58 -0800 (PST)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76148>

Signed-off-by: Carlos Rica <jasampler@gmail.com>
---

   Since builtin-reset.c changed in the recent last update,
   this patch is built on top of it to make easier applying it.

   The only change from previous version is the struct options, now const.

   Note that --h ambiguity favoring --hard over --help is still here,
   not a big problem because --help cannot be abbreviated in git.

   I copied the SYNOPSIS from the documentation to enhance the
   help message, splitting the old one-line message in two lines.
   Now this usage is showed when you run "git reset -h" and
   also when you includes an unknown option in command line.

 builtin-reset.c |   47 ++++++++++++++++++++---------------------------
 1 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index bb3e192..79424bb 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -17,9 +17,13 @@
 #include "diffcore.h"
 #include "tree.h"
 #include "branch.h"
+#include "parse-options.h"

-static const char builtin_reset_usage[] =
-"git-reset [--mixed | --soft | --hard] [-q] [<commit-ish>] [ [--] <paths>...]";
+static const char * const git_reset_usage[] = {
+	"git-reset [--mixed | --soft | --hard] [-q] [<commit>]",
+	"git-reset [--mixed] <commit> [--] <paths>...",
+	NULL
+};

 static char *args_to_str(const char **argv)
 {
@@ -165,40 +169,31 @@ static const char *reset_type_names[] = { "mixed", "soft", "hard", NULL };

 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
-	int i = 1, reset_type = NONE, update_ref_status = 0, quiet = 0;
+	int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0;
 	const char *rev = "HEAD";
 	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
 				*old_orig = NULL, sha1_old_orig[20];
 	struct commit *commit;
 	char *reflog_action, msg[1024];
+	const struct option options[] = {
+		OPT_SET_INT(0, "mixed", &reset_type,
+						"reset HEAD and index", MIXED),
+		OPT_SET_INT(0, "soft", &reset_type, "reset only HEAD", SOFT),
+		OPT_SET_INT(0, "hard", &reset_type,
+				"reset HEAD, index and working tree", HARD),
+		OPT_BOOLEAN('q', NULL, &quiet,
+				"disable showing new HEAD in hard reset"),
+		OPT_END()
+	};

 	git_config(git_default_config);

+	argc = parse_options(argc, argv, options, git_reset_usage,
+						PARSE_OPT_KEEP_DASHDASH);
 	reflog_action = args_to_str(argv);
 	setenv("GIT_REFLOG_ACTION", reflog_action, 0);

-	while (i < argc) {
-		if (!strcmp(argv[i], "--mixed")) {
-			reset_type = MIXED;
-			i++;
-		}
-		else if (!strcmp(argv[i], "--soft")) {
-			reset_type = SOFT;
-			i++;
-		}
-		else if (!strcmp(argv[i], "--hard")) {
-			reset_type = HARD;
-			i++;
-		}
-		else if (!strcmp(argv[i], "-q")) {
-			quiet = 1;
-			i++;
-		}
-		else
-			break;
-	}
