From: Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>
Subject: [PATCH] upload-pack.c: use of parse-options API
Date: Wed, 18 May 2016 18:40:19 +0200
Message-ID: <20160518164019.26443-1-Antoine.Queru@ensimag.grenoble-inp.fr>
Cc: william.duclot@ensimag.grenoble-inp.fr,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr,
	Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>,
	Antoine Queru <antoine.queru@grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 18:48:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b34eH-0001LN-GC
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 18:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbcERQsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 12:48:38 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:45817 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753237AbcERQsh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2016 12:48:37 -0400
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 May 2016 12:48:36 EDT
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 1940720F4;
	Wed, 18 May 2016 18:41:05 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u2hcAFb8ufMN; Wed, 18 May 2016 18:41:05 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 05AAB20F1;
	Wed, 18 May 2016 18:41:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id F40832066;
	Wed, 18 May 2016 18:41:04 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HRuCfzAGUsbO; Wed, 18 May 2016 18:41:04 +0200 (CEST)
Received: from quetutemobile.grenet.fr (eduroam-032070.grenet.fr [130.190.32.70])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id DCFDD2064;
	Wed, 18 May 2016 18:41:04 +0200 (CEST)
X-Mailer: git-send-email 2.8.2.403.gaa9c3f6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294973>

Option parsing now uses the parser API instead of a local parser.
Code is now more compact.

Signed-off-by: Antoine Queru <antoine.queru@grenoble-inp.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
This is our first project as a warm up. It was taken from the GSoC microproject list. 
 upload-pack.c | 51 ++++++++++++++++-----------------------------------
 1 file changed, 16 insertions(+), 35 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index dc802a0..80f65eb 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -14,8 +14,12 @@
 #include "sigchain.h"
 #include "version.h"
 #include "string-list.h"
+#include "parse-options.h"
 
-static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<n>] <dir>";
+static const char * const upload_pack_usage[] = {
+	N_("git upload-pack [--strict] [--timeout=<n>] <dir>"),
+	NULL
+};
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -820,49 +824,26 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 int main(int argc, char **argv)
 {
 	char *dir;
-	int i;
 	int strict = 0;
+	struct option options[] = {
+		OPT_HIDDEN_BOOL(0, "stateless-rpc", &stateless_rpc, NULL),
+		OPT_HIDDEN_BOOL(0, "advertise-refs", &advertise_refs, NULL),
+		OPT_BOOL(0, "strict", &strict, NULL),
+		OPT_INTEGER(0, "timeout", &timeout, NULL),
+		OPT_END()
+	};
 
 	git_setup_gettext();
 
 	packet_trace_identity("upload-pack");
 	git_extract_argv0_path(argv[0]);
 	check_replace_refs = 0;
-
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
-
+	argc = parse_options(argc, (const char **)argv, NULL, options, upload_pack_usage, 0);
+	if (timeout != 0)
+		daemon_mode = 1;
 	setup_path();
 
-	dir = argv[i];
+	dir = argv[0];
 
 	if (!enter_repo(dir, strict))
 		die("'%s' does not appear to be a git repository", dir);
-- 
2.8.2.403.gaa9c3f6
