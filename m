From: Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>
Subject: [PATCH v5] upload-pack.c: use parse-options API
Date: Mon, 30 May 2016 16:53:47 +0200
Message-ID: <20160530145347.15643-1-antoine.queru@ensimag.grenoble-inp.fr>
References: <20160527141628.1677-1-Antoine.Queru@ensimag.grenoble-inp.fr>
Cc: william.duclot@ensimag.grenoble-inp.fr,
	simon.rabourg@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, gitster@pobox.com, peff@peff.net,
	sunshine@sunshineco.com,
	Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 16:54:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7OZu-0002fk-1t
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 16:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754895AbcE3Ox6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 10:53:58 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:39827 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754704AbcE3Ox5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 10:53:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 508FC24D7;
	Mon, 30 May 2016 16:53:54 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xGfg5oea4_AG; Mon, 30 May 2016 16:53:54 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 3F750246D;
	Mon, 30 May 2016 16:53:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 392122077;
	Mon, 30 May 2016 16:53:54 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VaiIUbpiUz0w; Mon, 30 May 2016 16:53:54 +0200 (CEST)
Received: from quetutemobile.grenet.fr (eduroam-032133.grenet.fr [130.190.32.133])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 12F3F2066;
	Mon, 30 May 2016 16:53:54 +0200 (CEST)
X-Mailer: git-send-email 2.8.2.403.g897e5a5
In-Reply-To: <20160527141628.1677-1-Antoine.Queru@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295903>

From: Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>

Use the parse-options API rather than a hand-rolled option parser.

Description for --stateless-rpc and --advertise-refs come from
42526b4 (Add stateless RPC options to upload-pack,
receive-pack, 2009-10-30).

Signed-off-by: Antoine Queru <antoine.queru@grenoble-inp.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
Change since v4:
Imperative mood for the commit message.
"Code is now more compact." removed.
Documentation for option is now clearer.
Help message for "--advertise-refs" rewritten.
"no" for "strict" option added to the doc.

Documentation/git-upload-pack.txt | 16 +++++++++--
 upload-pack.c                     | 59 +++++++++++++++++----------------------
 2 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 0abc806..8a03bed 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -9,8 +9,8 @@ git-upload-pack - Send objects packed back to git-fetch-pack
 SYNOPSIS
 --------
 [verse]
-'git-upload-pack' [--strict] [--timeout=<n>] <directory>
-
+'git-upload-pack' [--[no-]strict] [--timeout=<n>] [--stateless-rpc]
+		  [--advertise-refs] <directory>
 DESCRIPTION
 -----------
 Invoked by 'git fetch-pack', learns what
@@ -25,12 +25,22 @@ repository.  For push operations, see 'git send-pack'.
 OPTIONS
 -------
 
---strict::
+--[no-]strict::
 	Do not try <directory>/.git/ if <directory> is no Git directory.
 
 --timeout=<n>::
 	Interrupt transfer after <n> seconds of inactivity.
 
+--stateless-rpc::
+	Perform only a single read-write cycle with stdin and stdout.
+	This fits with the HTTP POST request processing model where
+	a program may read the request, write a response, and must exit.
+
+--advertise-refs::
+	Only the initial ref advertisement is output, and the program exits
+    	immediately. This fits with the HTTP GET request model, where
+    	no request content is received but a response must be produced.
+
 <directory>::
 	The repository to sync from.
 
diff --git a/upload-pack.c b/upload-pack.c
index dc802a0..083d068 100644
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
+			 N_("exit immediately after intial ref advertisement")),
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
2.8.2.403.g897e5a5
