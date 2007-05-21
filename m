From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Allow user to specify mailbox format for mailsplit
Date: Tue, 22 May 2007 01:05:24 +0200
Message-ID: <20070521230524.GC10890@steel.home>
References: <20070520181447.GA10638@ferdyx.org> <7vd50uj29r.fsf@assigned-by-dhcp.cox.net> <20070521182052.GB4696@ferdyx.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: "Fernando J. Pereda" <ferdy@gentoo.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 22 01:05:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqGwX-0000Cd-GN
	for gcvg-git@gmane.org; Tue, 22 May 2007 01:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436AbXEUXF1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 19:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757244AbXEUXF1
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 19:05:27 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:11531 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756436AbXEUXF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 19:05:26 -0400
Received: from tigra.home (Fc8ee.f.strato-dslnet.de [195.4.200.238])
	by post.webmailer.de (fruni mo46) (RZmta 6.5)
	with ESMTP id G02613j4LK0OAu ; Tue, 22 May 2007 01:05:24 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 854BA277BD;
	Tue, 22 May 2007 01:05:24 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 67557D195; Tue, 22 May 2007 01:05:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070521182052.GB4696@ferdyx.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow37lQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48060>

If the argument ends with a slash - assume it is a Maildir and try to
create it. Otherwise - it is an mbox.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 Documentation/git-mailsplit.txt |    4 +++-
 builtin-mailsplit.c             |   10 ++++++++++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index abb0903..2c58e09 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -25,7 +25,9 @@ OPTIONS
 
 <Maildir>::
 	Root of the Maildir to split. This directory should contain the cur, tmp
-	and new subdirectories.
+	and new subdirectories. If the argument ends with a slash '/'
+	the directory and new, cur and tmp subdirectories will be
+	created automatically.
 
 <directory>::
 	Directory in which to place the individual messages.
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 454f943..370f7fa 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -253,6 +253,7 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 		const char *arg = *argp++;
 		struct stat argstat;
 		int ret = 0;
+		size_t arglen = strlen(arg);
 
 		if (arg[0] == '-' && arg[1] == 0) {
 			ret = split_mbox(arg, dir, allow_bare, nr_prec, nr);
@@ -264,6 +265,15 @@ int cmd_mailsplit(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
+		if (arglen && arg[arglen-1] == '/') {
+			char *dir = malloc(arglen + 5);
+			memcpy(dir, arg, arglen);
+			mkdir(arg, 0777);
+			mkdir(strcpy(dir + arglen, "new"), 0777);
+			mkdir(strcpy(dir + arglen, "cur"), 0777);
+			mkdir(strcpy(dir + arglen, "tmp"), 0777);
+			free(dir);
+		}
 		if (stat(arg, &argstat) == -1) {
 			error("cannot stat %s (%s)", arg, strerror(errno));
 			return 1;
-- 
1.5.2.rc3.112.gc1e43
