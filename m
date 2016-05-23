From: Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>
Subject: [PATCH v3] upload-pack.c: use of parse-options API
Date: Mon, 23 May 2016 15:02:31 +0200
Message-ID: <20160523130231.8725-1-Antoine.Queru@ensimag.grenoble-inp.fr>
References: <20160519153903.22104-1-Antoine.Queru@ensimag.grenoble-inp.fr>
Cc: william.duclot@ensimag.grenoble-inp.fr,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 15:02:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4pVa-0003dJ-UI
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 15:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbcEWNCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 09:02:50 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:55570 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752135AbcEWNCt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2016 09:02:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 46524252D;
	Mon, 23 May 2016 15:02:46 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R1OXuDjlJMFK; Mon, 23 May 2016 15:02:46 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 36F8C251D;
	Mon, 23 May 2016 15:02:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 310282077;
	Mon, 23 May 2016 15:02:46 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZLq2NQAtMB1P; Mon, 23 May 2016 15:02:46 +0200 (CEST)
Received: from quetutemobile.grenet.fr (eduroam-032070.grenet.fr [130.190.32.70])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id C2ADF2066;
	Mon, 23 May 2016 15:02:45 +0200 (CEST)
X-Mailer: git-send-email 2.8.2.403.gf2352ca
In-Reply-To: <20160519153903.22104-1-Antoine.Queru@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295320>

Option parsing now uses the parser API instead of a local parser.
Code is now more compact.
Description for -stateless-rpc and --advertise-refs
come from the commit 42526b4 (Add stateless RPC options to upload-pack, receive-pack, 2009-10-30).

Signed-off-by: Antoine Queru <antoine.queru@grenoble-inp.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
Change since v2:

Commit message updated. 
WhiteSpace removed after the "setup_path();".
Description for --stateless-rpc changed to : "quit after a single request/response exchange".

For the description, i don't really understand what this option is doing, so i just copy pasted
Junio's sentence. 
 upload-pack.c | 59 +++++++++++++++++++++++++----------------------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index dc802a0..2d53c7b 100644
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
+			 N_("quit after a single request/response exchange")),
+		OPT_BOOL(0, "advertise-refs", &advertise_refs,
+			 N_("only the initial ref advertisement is output, program exits immediately")),
+		OPT_BOOL(0, "strict", &strict,
+			 N_("do not try <directory>/.git/ if <directory> is no Git directory")),
+		OPT_INTEGER(0, "timeout", &timeout,
+			    N_("interrupt transfer after <n> seconds of inactivity")),
+		OPT_END()
+	};
 
 	git_setup_gettext();
 
@@ -829,40 +843,17 @@ int main(int argc, char **argv)
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
+	argc = parse_options(argc, argv, NULL, options, upload_pack_usage, 0);
+	
+	if (argc != 1)
+		usage_with_options(upload_pack_usage, options);
 
-	if (i != argc-1)
-		usage(upload_pack_usage);
+	if (timeout)
+		daemon_mode = 1;
 
 	setup_path();
 
-	dir = argv[i];
+	dir = argv[0];
 
 	if (!enter_repo(dir, strict))
 		die("'%s' does not appear to be a git repository", dir);
-- 
2.8.2.403.gf2352ca
