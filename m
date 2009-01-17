From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 5/5] run_hook(): allow more than 9 hook arguments
Date: Sat, 17 Jan 2009 04:02:55 +0100
Message-ID: <1232161375-24503-1-git-send-email-s-beyer@gmx.net>
References: <1232133002-21725-4-git-send-email-s-beyer@gmx.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>, gitster@pobox.com,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 04:04:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO1U0-0000MM-1b
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 04:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbZAQDDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 22:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752741AbZAQDC7
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 22:02:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:52566 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752128AbZAQDC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 22:02:58 -0500
Received: (qmail invoked by alias); 17 Jan 2009 03:02:56 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp002) with SMTP; 17 Jan 2009 04:02:56 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+cR2sCvz2cFygvZS2OgdMGkHP5aPtS/Y9Id7UGFd
	W6p8mgjmwtG55v
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LO1SZ-0006O7-77; Sat, 17 Jan 2009 04:02:55 +0100
X-Mailer: git-send-email 1.6.1.160.gecdb
In-Reply-To: <1232133002-21725-4-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106015>

This is done using the ALLOC_GROW macro.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

	Ok, Dscho :-)

	The interdiff based on [PATCH 5/5] is...

	--- a/run-command.c
	+++ b/run-command.c
	@@ -350,14 +350,14 @@ int run_hook(const char *index_file, const char *name, ...)
		char index[PATH_MAX];
		va_list args;
		int ret;
	-	size_t i = 1, alloc = 5;
	+	size_t i = 0, alloc = 0;
	 
		if (access(git_path("hooks/%s", name), X_OK) < 0)
			return 0;
	 
		va_start(args, name);
	-	argv = xmalloc(alloc * sizeof(const char *));
	-	argv[0] = git_path("hooks/%s", name);
	+	ALLOC_GROW(argv, i + 1, alloc);
	+	argv[i++] = git_path("hooks/%s", name);
		while (argv[i-1]) {
			ALLOC_GROW(argv, i + 1, alloc);
			argv[i++] = va_arg(args, const char *);

 Documentation/technical/api-run-command.txt |    2 +-
 run-command.c                               |   18 +++++++++---------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index 13e7b63..2efe7a4 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -58,7 +58,7 @@ Functions
 	The first argument is a pathname to an index file, or NULL
 	if the hook uses the default index file or no index is needed.
 	The second argument is the name of the hook.
-	The further arguments (up to 9) correspond to the hook arguments.
+	The further arguments correspond to the hook arguments.
 	The last argument has to be NULL to terminate the arguments list.
 	If the hook does not exist or is not executable, the return
 	value will be zero.
diff --git a/run-command.c b/run-command.c
index fc54c07..d2f1262 100644
--- a/run-command.c
+++ b/run-command.c
@@ -346,23 +346,22 @@ int finish_async(struct async *async)
 int run_hook(const char *index_file, const char *name, ...)
 {
 	struct child_process hook;
-	const char *argv[10], *env[2];
+	const char **argv, *env[2];
 	char index[PATH_MAX];
 	va_list args;
 	int ret;
-	int i;
+	size_t i = 0, alloc = 0;
 
 	if (access(git_path("hooks/%s", name), X_OK) < 0)
 		return 0;
 
 	va_start(args, name);
-	argv[0] = git_path("hooks/%s", name);
-	i = 0;
-	do {
-		if (++i >= ARRAY_SIZE(argv))
-			die("run_hook(): too many arguments");
-		argv[i] = va_arg(args, const char *);
-	} while (argv[i]);
+	ALLOC_GROW(argv, i + 1, alloc);
+	argv[i++] = git_path("hooks/%s", name);
+	while (argv[i-1]) {
+		ALLOC_GROW(argv, i + 1, alloc);
+		argv[i++] = va_arg(args, const char *);
+	}
 	va_end(args);
 
 	memset(&hook, 0, sizeof(hook));
@@ -377,6 +376,7 @@ int run_hook(const char *index_file, const char *name, ...)
 	}
 
 	ret = start_command(&hook);
+	free(argv);
 	if (ret) {
 		warning("Could not spawn %s", argv[0]);
 		return ret;
-- 
1.6.1.160.gecdb
