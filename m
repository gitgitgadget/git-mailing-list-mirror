From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] upload-pack: Initialize the exec-path.
Date: Tue, 12 Feb 2008 12:45:52 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802121245140.3870@racer.site>
References: <51419b2c0802111822k4600e06bp4167a09b30bf947a@mail.gmail.com> <m31w7iegk6.fsf@localhost.localdomain> <47B15ADC.8080309@viscovery.net> <alpine.LSU.1.00.0802121028290.3870@racer.site> <47B182C1.60006@viscovery.net>
 <alpine.LSU.1.00.0802121149220.3870@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Feb 12 13:46:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOuWj-00019o-Fd
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 13:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbYBLMpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 07:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753432AbYBLMpq
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 07:45:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:42766 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752878AbYBLMpp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 07:45:45 -0500
Received: (qmail invoked by alias); 12 Feb 2008 12:45:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp012) with SMTP; 12 Feb 2008 13:45:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ScZYAgt6S/asxI+zQEI6jTQ+sXQRoPKnLa2LPK+
	NhnwjMoh2TmdYh
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0802121149220.3870@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73658>

Hi,

On Tue, 12 Feb 2008, Johannes Schindelin wrote:

> On Tue, 12 Feb 2008, Johannes Sixt wrote:
> 
> > Johannes Schindelin schrieb:
> >
> > > So, let's make git-upload-pack a builtin, no?
> > 
> > How about this (almost) one-liner instead?
> 
> I'm fine with it.

But I also made this:

-- snipsnap --
[PATCH] Make upload-pack a builtin

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                               |    2 +-
 upload-pack.c => builtin-upload-pack.c |    8 +++++---
 builtin.h                              |    1 +
 git.c                                  |    1 +
 4 files changed, 8 insertions(+), 4 deletions(-)
 rename upload-pack.c => builtin-upload-pack.c (98%)

diff --git a/Makefile b/Makefile
index 83c359a..1792039 100644
--- a/Makefile
+++ b/Makefile
@@ -259,7 +259,6 @@ PROGRAMS = \
 	git-show-index$X \
 	git-unpack-file$X \
 	git-update-server-info$X \
-	git-upload-pack$X \
 	git-pack-redundant$X git-var$X \
 	git-merge-tree$X git-imap-send$X \
 	git-merge-recursive$X \
@@ -392,6 +391,7 @@ BUILTIN_OBJS = \
 	builtin-update-index.o \
 	builtin-update-ref.o \
 	builtin-upload-archive.o \
+	builtin-upload-pack.o \
 	builtin-verify-pack.o \
 	builtin-verify-tag.o \
 	builtin-write-tree.o \
diff --git a/upload-pack.c b/builtin-upload-pack.c
similarity index 98%
rename from upload-pack.c
rename to builtin-upload-pack.c
index 7e04311..207754c 100644
--- a/upload-pack.c
+++ b/builtin-upload-pack.c
@@ -10,6 +10,7 @@
 #include "revision.h"
 #include "list-objects.h"
 #include "run-command.h"
+#include "builtin.h"
 
 static const char upload_pack_usage[] = "git-upload-pack [--strict] [--timeout=nn] <dir>";
 
@@ -593,14 +594,14 @@ static void upload_pack(void)
 	}
 }
 
-int main(int argc, char **argv)
+int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 {
 	char *dir;
 	int i;
 	int strict = 0;
 
 	for (i = 1; i < argc; i++) {
-		char *arg = argv[i];
+		const char *arg = argv[i];
 
 		if (arg[0] != '-')
 			break;
@@ -620,12 +621,13 @@ int main(int argc, char **argv)
 
 	if (i != argc-1)
 		usage(upload_pack_usage);
-	dir = argv[i];
+	dir = xstrdup(argv[i]);
 
 	if (!enter_repo(dir, strict))
 		die("'%s': unable to chdir or not a git archive", dir);
 	if (is_repository_shallow())
 		die("attempt to fetch/clone from a shallow repository");
 	upload_pack();
+	free(dir);
 	return 0;
 }
diff --git a/builtin.h b/builtin.h
index 3d1628c..5e7d661 100644
--- a/builtin.h
+++ b/builtin.h
@@ -85,6 +85,7 @@ extern int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_update_index(int argc, const char **argv, const char *prefix);
 extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_archive(int argc, const char **argv, const char *prefix);
+extern int cmd_upload_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_tar(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_tag(int argc, const char **argv, const char *prefix);
 extern int cmd_version(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 0cb8688..f0d831c 100644
--- a/git.c
+++ b/git.c
@@ -362,6 +362,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "update-index", cmd_update_index, RUN_SETUP },
 		{ "update-ref", cmd_update_ref, RUN_SETUP },
 		{ "upload-archive", cmd_upload_archive },
+		{ "upload-pack", cmd_upload_pack },
 		{ "verify-tag", cmd_verify_tag, RUN_SETUP },
 		{ "version", cmd_version },
 		{ "whatchanged", cmd_whatchanged, RUN_SETUP | USE_PAGER },
-- 
1.5.4.1.1276.g92036
