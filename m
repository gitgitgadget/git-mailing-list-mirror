From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH 5/5] run_hook(): allow more than 9 hook arguments
Date: Fri, 16 Jan 2009 20:10:02 +0100
Message-ID: <1232133002-21725-5-git-send-email-s-beyer@gmx.net>
References: <20090116172521.GD28177@leksak.fem-net>
 <1232133002-21725-1-git-send-email-s-beyer@gmx.net>
 <1232133002-21725-2-git-send-email-s-beyer@gmx.net>
 <1232133002-21725-3-git-send-email-s-beyer@gmx.net>
 <1232133002-21725-4-git-send-email-s-beyer@gmx.net>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>, gitster@pobox.com,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 16 20:12:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNu75-0005Fh-Te
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 20:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937031AbZAPTKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 14:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936768AbZAPTKf
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 14:10:35 -0500
Received: from mail.gmx.net ([213.165.64.20]:40024 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763787AbZAPTKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 14:10:09 -0500
Received: (qmail invoked by alias); 16 Jan 2009 19:10:06 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp002) with SMTP; 16 Jan 2009 20:10:06 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19hVWxcRathqUmYRDJcaXuP0wKaJyceFAI8DRVr39
	QvrU/A8otNbEpg
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNu4w-0005fS-O3; Fri, 16 Jan 2009 20:10:02 +0100
X-Mailer: git-send-email 1.6.1.160.gecdb
In-Reply-To: <1232133002-21725-4-git-send-email-s-beyer@gmx.net>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105988>

This is accomplished using the ALLOC_GROW macro.

5 cells are initially allocated for the argv array, allowing
four actual arguments without reallocating memory.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

	I was a little unsure if it looks better to
	initialize i = 0, alloc = 0
	and do:
		ALLOC_GROW(argv, i + 1, alloc);
		argv[i++] = git_path("hooks/%s", name);
	instead of the xmalloc().

	Do some people care about details like that?

 Documentation/technical/api-run-command.txt |    2 +-
 run-command.c                               |   16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

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
index fc54c07..22abd09 100644
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
+	size_t i = 1, alloc = 5;
 
 	if (access(git_path("hooks/%s", name), X_OK) < 0)
 		return 0;
 
 	va_start(args, name);
+	argv = xmalloc(alloc * sizeof(const char *));
 	argv[0] = git_path("hooks/%s", name);
-	i = 0;
-	do {
-		if (++i >= ARRAY_SIZE(argv))
-			die("run_hook(): too many arguments");
-		argv[i] = va_arg(args, const char *);
-	} while (argv[i]);
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
