From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [SQUASHED PATCH] Add support for GIT_CEILING_DIRECTORIES
Date: Sat, 17 May 2008 01:19:53 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805170117000.30431@racer>
References: <482C85C8.90804@facebook.com> <alpine.DEB.1.00.0805151958180.30431@racer> <alpine.DEB.1.00.0805152055280.30431@racer> <482CA693.3060602@facebook.com> <alpine.DEB.1.00.0805152327440.30431@racer> <482CBCF2.6030202@facebook.com>
 <alpine.DEB.1.00.0805160012310.30431@racer> <482D2F9D.4080809@viscovery.net> <alpine.DEB.1.00.0805161118160.30431@racer> <482D66DC.30602@viscovery.net> <482DC7B6.1080406@facebook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, gitster@pobox.com,
	git@vger.kernel.org
To: David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Sat May 17 02:20:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxAAF-0007a0-Qv
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 02:20:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753120AbYEQATv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 20:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753072AbYEQATv
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 20:19:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:47303 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752947AbYEQATu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 20:19:50 -0400
Received: (qmail invoked by alias); 17 May 2008 00:19:48 -0000
Received: from R2eb4.r.pppool.de (EHLO racer.local) [89.54.46.180]
  by mail.gmx.net (mp018) with SMTP; 17 May 2008 02:19:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gbnJa03+gdpSkHnknX1nynORVLu8BlZAQTfkFzP
	bDHRhZV1s8q/CK
X-X-Sender: gene099@racer
In-Reply-To: <482DC7B6.1080406@facebook.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82325>

Hi,

On Fri, 16 May 2008, David Reiss wrote:

> Sorry I missed this before.  As you said, in Johannes's version the 
> ceiling directories are the last directories we look in, whereas in my 
> implementation, they are the first directories we do not look in.  I 
> made this choice because it makes more sense for me to set my ceiling to 
> "/home", rather than "/home/dreiss", so it will work even if I am in 
> another user's homedir.
> 
> There is also a difference in how they handle the case where the cwd is 
> a ceiling directory, but I think it is worth sorting out the first issue 
> first.

Please do not top-post.

This is the interdiff to the last squashed patch:

-- snip --
diff --git a/setup.c b/setup.c
index cece3e4..2f7a17a 100644
--- a/setup.c
+++ b/setup.c
@@ -441,6 +441,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 */
 	offset = len = strlen(cwd);
 	for (;;) {
+		if (offset <= min_offset)
+			goto non_git;
 		gitfile_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
 		if (gitfile_dir) {
 			if (set_git_dir(gitfile_dir))
@@ -460,6 +462,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		chdir("..");
 		do {
 			if (offset <= min_offset) {
+non_git:
 				if (nongit_ok) {
 					if (chdir(cwd))
 						die("Cannot come back to cwd");
diff --git a/t/t1504-ceiling-directories.sh b/t/t1504-ceiling-directories.sh
index 6c8757d..edc00be 100644
--- a/t/t1504-ceiling-directories.sh
+++ b/t/t1504-ceiling-directories.sh
@@ -30,6 +30,15 @@ test_expect_success 'with non-matching ceiling directory' '
 
 '
 
+test_expect_success 'with matching ceiling directory' '
+
+	GIT_CEILING_DIRECTORIES="$CWD" &&
+	export GIT_CEILING_DIRECTORIES &&
+	(cd subdir && test_must_fail git rev-parse --git-dir) &&
+	test_must_fail git rev-parse --git-dir
+
+'
+
 test_expect_success 'with matching ceiling directories' '
 
 	GIT_CEILING_DIRECTORIES="$CWD/X:$CWD/subdir" &&
-- snap --

I will post the squashed patch as a response to this mail.

Ciao,
Dscho
