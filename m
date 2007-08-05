From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix install-doc-quick target
Date: Sun, 5 Aug 2007 15:44:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708051533590.14781@racer.site>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site>
 <46B4A2B0.9080208@gmail.com> <Pine.LNX.4.64.0708041704040.14781@racer.site>
 <46B4A5FD.3070107@gmail.com> <Pine.LNX.4.64.0708041719490.14781@racer.site>
 <46B4BDCF.9060809@gmail.com> <Pine.LNX.4.64.0708042229130.14781@racer.site>
 <46B4F91D.1070907@lsrfire.ath.cx> <7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 16:44:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHhLZ-0003rv-AW
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 16:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752467AbXHEOoi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 10:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbXHEOoi
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 10:44:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:45834 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752418AbXHEOoh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 10:44:37 -0400
Received: (qmail invoked by alias); 05 Aug 2007 14:44:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp021) with SMTP; 05 Aug 2007 16:44:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZhoRZjiBZOjAL5W7RLwI7TE4Enf8aZJNuCHA6y3
	UdPp4R9OI3g/Gw
X-X-Sender: gene099@racer.site
In-Reply-To: <7vmyx6fohv.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55026>

Hi,

On Sun, 5 Aug 2007, Junio C Hamano wrote:

>    If you say:
> 
> 	git --work-tree=. foo
> 
>    without saying anything about GIT_DIR, shouldn't we run the
>    usual .git/ discovery, going up the directories? 

Well, it seems natural.

The problem is that if you are in a bare repository, after 
setup_git_directory_gently() you will no longer be able to tell where you 
started from, but you are in the same directory that HEAD was found.

I had the following patch, but it breaks all kinds of tests :-(

Will keep you posted,
Dscho

-- snipsnap --

 setup.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index d87e4e1..c627623 100644
--- a/setup.c
+++ b/setup.c
@@ -291,7 +291,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			if (!work_tree_env)
 				inside_work_tree = 0;
 			setenv(GIT_DIR_ENVIRONMENT, ".", 1);
-			return NULL;
+			goto ret;
 		}
 		chdir("..");
 		do {
@@ -311,6 +311,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	if (!work_tree_env)
 		inside_work_tree = 1;
 	git_work_tree_cfg = xstrndup(cwd, offset);
+ret:
 	if (offset == len)
 		return NULL;
 
@@ -376,14 +377,15 @@ const char *setup_git_directory(void)
 	/* If the work tree is not the default one, recompute prefix */
 	if (inside_work_tree < 0) {
 		static char buffer[PATH_MAX + 1];
+		const char *git_dir = get_git_dir();
 		char *rel;
 
 		/*
 		 * When the git dir was determined automatically, it is
 		 * a relative path.
 		 */
-		if (!getenv(GIT_DIR_ENVIRONMENT))
-			set_git_dir(make_absolute_path(get_git_dir()));
+		if (!is_absolute_path(git_dir))
+			set_git_dir(make_absolute_path(git_dir));
 
 		if (retval && chdir(retval))
 			die ("Could not jump back into original cwd");
