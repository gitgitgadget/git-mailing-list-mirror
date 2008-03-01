From: Carlos Rica <jasampler@gmail.com>
Subject: [PATCH] Make builtin-reset.c use parse_options.
Date: Sat, 01 Mar 2008 17:29:38 +0100
Message-ID: <47C98472.8000002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 17:31:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVUc4-0000ti-Hm
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 17:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763959AbYCAQ3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 11:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763833AbYCAQ3w
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 11:29:52 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:29175 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763945AbYCAQ3v (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 11:29:51 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2733259nfb.21
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 08:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        bh=0oWS7X+AMfIaXx9EJK0KMwgU00+wZ/zxkc2Cis6fyjc=;
        b=S7+gkx4Vdf2liM13/Ap/pphULinqfruXdhN4EyphUhyELQs5NMERybn2iZAeyoCIBuNBekfyKT659AjeFLgpDWjUfw1G4bi6JVuZiLaWW38sbOYbmp1sO6h2l3OkGSf05WR99Vk1ephuxLSZXGGQ6GVnEawR4BQDpBApw0FYoNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=YcFc9ijzc0gjpweDdXcMgoHbTG0oXl96pHZ2nUd/+UZ4IaNE2S0OMrGF51PivO9a2A1fFRsuRS6Z45Hv9ZEUx4Qw2iCcd4BeHjsWVd2EVsjMukRTojGAi1Z3OvbV0UgRIQpKLkT9hSmm+HiptptgqnX6FioFFSwrNgKF9Hf3tiE=
Received: by 10.78.182.17 with SMTP id e17mr12096417huf.26.1204388988878;
        Sat, 01 Mar 2008 08:29:48 -0800 (PST)
Received: from ?192.168.0.192? ( [212.145.102.186])
        by mx.google.com with ESMTPS id f4sm468798nfh.26.2008.03.01.08.29.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 Mar 2008 08:29:47 -0800 (PST)
User-Agent: Thunderbird 2.0.0.4 (X11/20070604)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75684>


Signed-off-by: Carlos Rica <jasampler@gmail.com>
---
 builtin-reset.c |   47 ++++++++++++++++++++---------------------------
 1 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index af0037e..71892d0 100644
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
@@ -169,40 +173,31 @@ static const char *reset_type_names[] = { "mixed", "soft", "hard", NULL };

 int cmd_reset(int argc, const char **argv, const char *prefix)
 {
-	int i = 1, reset_type = NONE, update_ref_status = 0, quiet = 0;
+	int i = 0, reset_type = NONE, update_ref_status = 0, quiet = 0;
 	const char *rev = "HEAD";
 	unsigned char sha1[20], *orig = NULL, sha1_orig[20],
 				*old_orig = NULL, sha1_old_orig[20];
 	struct commit *commit;
 	char *reflog_action, msg[1024];
+	struct option options[] = {
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
