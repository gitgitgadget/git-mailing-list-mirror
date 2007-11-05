From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] Use parseopts in builtin-fetch
Date: Sun, 4 Nov 2007 22:35:34 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711042233590.7357@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Nov 05 04:35:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ioski-00067k-Gu
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 04:35:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbXKEDfh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 22:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753378AbXKEDfh
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 22:35:37 -0500
Received: from iabervon.org ([66.92.72.58]:44085 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753305AbXKEDfg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 22:35:36 -0500
Received: (qmail 19840 invoked by uid 1000); 5 Nov 2007 03:35:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Nov 2007 03:35:34 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63480>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
I mostly did this and the next one for practice with the API. I'm 
impressed that "git fetch -vv" is even handled correctly without anything 
special. Now that I've done it, assuming I did it right, it might as well 
get added to the series.

 builtin-fetch.c |   95 +++++++++++++++---------------------------------------
 1 files changed, 27 insertions(+), 68 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 6b1750d..a079cb0 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -8,8 +8,12 @@
 #include "path-list.h"
 #include "remote.h"
 #include "transport.h"
+#include "parse-options.h"
 
-static const char fetch_usage[] = "git-fetch [-a | --append] [--upload-pack <upload-pack>] [-f | --force] [--no-tags] [-t | --tags] [-k | --keep] [-u | --update-head-ok] [--depth <depth>] [-v | --verbose] [<repository> <refspec>...]";
+static const char * const fetch_usage[] = {
+	"git-fetch [option] [<repository> <refspec>...]",
+	NULL
+};
 
 static int append, force, tags, no_tags, update_head_ok, verbose, quiet;
 static char *default_rla = NULL;
@@ -470,71 +474,21 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	int cmd_len = 0;
 	const char *depth = NULL, *upload_pack = NULL;
 	int keep = 0;
-
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-		cmd_len += strlen(arg);
-
-		if (arg[0] != '-')
-			break;
-		if (!strcmp(arg, "--append") || !strcmp(arg, "-a")) {
-			append = 1;
-			continue;
-		}
-		if (!prefixcmp(arg, "--upload-pack=")) {
-			upload_pack = arg + 14;
-			continue;
-		}
-		if (!strcmp(arg, "--upload-pack")) {
-			i++;
-			if (i == argc)
-				usage(fetch_usage);
-			upload_pack = argv[i];
-			continue;
-		}
-		if (!strcmp(arg, "--force") || !strcmp(arg, "-f")) {
-			force = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--no-tags")) {
-			no_tags = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--tags") || !strcmp(arg, "-t")) {
-			tags = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--keep") || !strcmp(arg, "-k")) {
-			keep = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--update-head-ok") || !strcmp(arg, "-u")) {
-			update_head_ok = 1;
-			continue;
-		}
-		if (!prefixcmp(arg, "--depth=")) {
-			depth = arg + 8;
-			continue;
-		}
-		if (!strcmp(arg, "--depth")) {
-			i++;
-			if (i == argc)
-				usage(fetch_usage);
-			depth = argv[i];
-			continue;
-		}
-		if (!strcmp(arg, "--quiet") || !strcmp(arg, "-q")) {
-			quiet = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--verbose") || !strcmp(arg, "-v")) {
-			verbose++;
-			continue;
-		}
-		usage(fetch_usage);
-	}
-
-	for (j = i; j < argc; j++)
+	struct option options[] = {
+		OPT__VERBOSE(&verbose),
+		OPT_BOOLEAN('a', "append", &append, "append fetched data to exisitng FETCH_HEAD"),
+		OPT_BOOLEAN('f', "force", &force, "force"),
+		OPT_BOOLEAN( 0 , "no-tags", &no_tags, "don't fetch tags"),
+		OPT_BOOLEAN('t', "tags", &tags, "fetch all tags"),
+		OPT_BOOLEAN('k', "keep", &keep, "keep pack file"),
+		OPT_STRING( 0, "depth", &depth, "depth", "deepen the repository by <depth> commits"),
+		OPT_BOOLEAN('u', "update-head-ok", &update_head_ok, "allow updating head"),
+		OPT_BOOLEAN('q', "quiet", &quiet, "fetch silently"),
+		OPT_STRING( 0 , "upload-pack", &upload_pack, "upload-pack", "remote executable for git-upload-pack"),
+		OPT_END(),
+	};
+
+	for (j = 1; j < argc; j++)
 		cmd_len += strlen(argv[j]);
 
 	default_rla = xmalloc(cmd_len + 5 + argc + 1);
@@ -545,12 +499,16 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		rla_offset += strlen(argv[j]) + 1;
 	}
 
-	if (i == argc)
+	argc = parse_options(argc, argv, options, fetch_usage, 0);
+
+	if (argc == 0)
 		remote = remote_get(NULL);
 	else
-		remote = remote_get(argv[i++]);
+		remote = remote_get(argv[0]);
 
 	transport = transport_get(remote, remote->url[0]);
+	if (!transport)
+		die("couldn't get transport");
 	if (verbose >= 2)
 		transport->verbose = 1;
 	if (quiet)
@@ -565,6 +523,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (!transport->url)
 		die("Where do you want to fetch from today?");
 
+	i = 1;
 	if (i < argc) {
 		int j = 0;
 		refs = xcalloc(argc - i + 1, sizeof(const char *));
-- 
1.5.3.5.1528.gb6568-dirty
