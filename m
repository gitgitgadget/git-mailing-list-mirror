From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/2] Use parse-options in builtin-clean
Date: Sun, 4 Nov 2007 20:24:31 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711042023440.4362@racer.site>
References: <1194202941253-git-send-email-shawn.bohrer@gmail.com>
 <11942029442710-git-send-email-shawn.bohrer@gmail.com>
 <11942029474058-git-send-email-shawn.bohrer@gmail.com> <20071104194129.GA4207@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 04 21:26:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iom2o-0007BU-Iq
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 21:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703AbXKDUZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 15:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbXKDUZw
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 15:25:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:60023 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751387AbXKDUZv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 15:25:51 -0500
Received: (qmail invoked by alias); 04 Nov 2007 20:25:49 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp053) with SMTP; 04 Nov 2007 21:25:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18vEA100PYvSE7kbjhV+uuzkDlWeOj08+ND8HoXnm
	GCgWRH/lcoqYTb
X-X-Sender: gene099@racer.site
In-Reply-To: <20071104194129.GA4207@artemis.corp>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63438>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Sun, 4 Nov 2007, Pierre Habouzit wrote:

	> On Sun, Nov 04, 2007 at 07:02:21PM +0000, Shawn Bohrer wrote:
	> 
	> > +	for (i = 1; i < argc; i++) {
	> > +		const char *arg = argv[i];
	> > [...]
	> 
	>   Please, parse-options.c is now in next, please use it.

	Something like this?

 builtin-clean.c |   71 ++++++++++++++++++++----------------------------------
 1 files changed, 26 insertions(+), 45 deletions(-)

diff --git a/builtin-clean.c b/builtin-clean.c
index 4141eb4..d6fc2ad 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -9,81 +9,62 @@
 #include "builtin.h"
 #include "cache.h"
 #include "dir.h"
+#include "parse-options.h"
 
-static int disabled = 1;
+static int force = 0;
 static int show_only = 0;
 static int remove_directories = 0;
 static int quiet = 0;
 static int ignored = 0;
 static int ignored_only = 0;
 
-static const char builtin_clean_usage[] =
-"git-clean [-d] [-f] [-n] [-q] [-x | -X] [--] <paths>...";
+static const char *const builtin_clean_usage[] = {
+	"git-clean [-d] [-f] [-n] [-q] [-x | -X] [--] <paths>...",
+	NULL
+};
 
 static int git_clean_config(const char *var, const char *value)
 {
 	if (!strcmp(var, "clean.requireforce")) {
-		disabled = git_config_bool(var, value);
+		force = !git_config_bool(var, value);
 	}
 	return 0;
 }
 
 int cmd_clean(int argc, const char **argv, const char *prefix)
 {
-	int i, j;
+	int j;
 	struct strbuf directory;
 	struct dir_struct dir;
 	const char *path = ".";
 	const char *base = "";
 	int baselen = 0;
 	static const char **pathspec;
+	struct option options[] = {
+		OPT__QUIET(&quiet),
+		OPT__DRY_RUN(&show_only),
+		OPT_BOOLEAN('f', NULL, &force, "force"),
+		OPT_BOOLEAN('d', NULL, &remove_directories,
+				"remove whole directories"),
+		OPT_BOOLEAN('x', NULL, &ignored, "remove ignored files, too"),
+		OPT_BOOLEAN('X', NULL, &ignored_only,
+				"remove only ignored files"),
+		OPT_END()
+	};
 
-	memset(&dir, 0, sizeof(dir));
 	git_config(git_clean_config);
+	argc = parse_options(argc, argv, options, builtin_clean_usage, 0);
 
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-
-		if (arg[0] != '-')
-			break;
-		if (!strcmp(arg, "--")) {
-			i++;
-			break;
-		}
-		if (!strcmp(arg, "-n")) {
-			show_only = 1;
-			disabled = 0;
-			continue;
-		}
-		if (!strcmp(arg, "-f")) {
-			disabled = 0;
-			continue;
-		}
-		if (!strcmp(arg, "-d")) {
-			remove_directories = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-q")) {
-			quiet = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-x")) {
-			ignored = 1;
-			continue;
-		}
-		if (!strcmp(arg, "-X")) {
-			ignored_only = 1;
-			dir.show_ignored =1;
-			dir.exclude_per_dir = ".gitignore";
-			continue;
-		}
-		usage(builtin_clean_usage);
+	memset(&dir, 0, sizeof(dir));
+	if (ignored_only) {
+		dir.show_ignored =1;
+		dir.exclude_per_dir = ".gitignore";
 	}
 
 	if (ignored && ignored_only)
 		die("-x and -X cannot be used together");
 
-	if (disabled)
+	if (!show_only && !force)
 		die("clean.requireForce set and -n or -f not given; refusing to clean");
 
 	dir.show_other_directories = 1;
@@ -96,7 +77,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	pathspec = get_pathspec(prefix, argv + i);
+	pathspec = get_pathspec(prefix, argv);
 	read_cache();
 	read_directory(&dir, path, base, baselen, pathspec);
 	strbuf_init(&directory, 0);
-- 
1.5.3.5.1549.g91a3
