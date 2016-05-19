From: Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>
Subject: [PATCH v2] upload-pack.c: use of parse-options API
Date: Thu, 19 May 2016 17:39:03 +0200
Message-ID: <20160519153903.22104-1-Antoine.Queru@ensimag.grenoble-inp.fr>
References: <20160518164019.26443-1-Antoine.Queru@ensimag.grenoble-inp.fr>
Cc: william.duclot@ensimag.grenoble-inp.fr,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 17:39:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Q2e-0006CN-D3
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 17:39:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbcESPjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 11:39:12 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:60531 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932261AbcESPjL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2016 11:39:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 7A019212A;
	Thu, 19 May 2016 17:39:07 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2ux_Qk0YMBvn; Thu, 19 May 2016 17:39:07 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 63F68210F;
	Thu, 19 May 2016 17:39:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 60A282066;
	Thu, 19 May 2016 17:39:07 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zi4LUkLVWGDT; Thu, 19 May 2016 17:39:07 +0200 (CEST)
Received: from quetutemobile.grenet.fr (eduroam-032070.grenet.fr [130.190.32.70])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 4B3972055;
	Thu, 19 May 2016 17:39:07 +0200 (CEST)
X-Mailer: git-send-email 2.8.2.403.gf2352ca
In-Reply-To: <20160518164019.26443-1-Antoine.Queru@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295069>

Option parsing now uses the parser API instead of a local parser.
Code is now more compact.
Description for -stateless-rpc and --advertise-refs
come from the commit (gmane/131517) where there were implemented.

Signed-off-by: Antoine Queru <antoine.queru@grenoble-inp.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---

diff v1 v2:
Usage display "[options]" instead of "[--strict] [--timeout=<n>]".
"argv" is now "const char **".
"-stateless-rpc and --advertise-refs" are no more hidden.
Description has been added for every option.
Usage is displayed if there is not exactly one non option argument.

If we agree on not having hidden option anymore, I will update the doc. 
 upload-pack.c | 62 +++++++++++++++++++++++++----------------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index dc802a0..a8617ac 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -14,8 +14,12 @@
 #include "sigchain.h"
 #include "version.h"
 #include "string-list.h"
+#include "parse-options.h"
 
-static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<n>] <dir>";
+static const char * const upload_pack_usage[] = {
+	N_("git upload-pack [options] <dir>"),
+	NULL
+};
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -817,11 +821,21 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
-int main(int argc, char **argv)
+int main(int argc, const char **argv)
 {
-	char *dir;
-	int i;
+	const char *dir;
 	int strict = 0;
+	struct option options[] = {
+		OPT_BOOL(0, "stateless-rpc", &stateless_rpc,
+			 N_("may perform only a single read-write cycle with stdin and stdout")),
+		OPT_BOOL(0, "advertise-refs", &advertise_refs,
+			 N_("only the initial ref advertisement is output, program exits immediately")),
+		OPT_BOOL(0, "strict", &strict,
+			 N_("do not try <directory>/.git/ if <directory> is no Git directory")),
+		OPT_INTEGER(0, "timeout", &timeout,
+			    N_("interrupt transfer after <n> seconds of inactivity")),
+		OPT_END()
+	};
 
 	git_setup_gettext();
 
@@ -829,41 +843,17 @@ int main(int argc, char **argv)
 	git_extract_argv0_path(argv[0]);
 	check_replace_refs = 0;
 
-	for (i = 1; i < argc; i++) {
-		char *arg = argv[i];
-
-		if (arg[0] != '-')
-			break;
-		if (!strcmp(arg, "--advertise-refs")) {
-			advertise_refs = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--stateless-rpc")) {
-			stateless_rpc = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--strict")) {
-			strict = 1;
-			continue;
-		}
-		if (starts_with(arg, "--timeout=")) {
-			timeout = atoi(arg+10);
-			daemon_mode = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--")) {
-			i++;
-			break;
-		}
-	}
-
-	if (i != argc-1)
-		usage(upload_pack_usage);
+	argc = parse_options(argc, argv, NULL, options, upload_pack_usage, 0);
+	
+	if (argc != 1)
+		usage_with_options(upload_pack_usage, options);
 
-	setup_path();
+	if (timeout)
+		daemon_mode = 1;
 
-	dir = argv[i];
+	setup_path();	
 
+	dir = argv[0];
 	if (!enter_repo(dir, strict))
 		die("'%s' does not appear to be a git repository", dir);
 
-- 
2.8.2.403.gf2352ca
