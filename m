From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git.c: Re-introduce sane error messages on missing
 commands.
Date: Wed, 28 Jun 2006 12:45:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606281240480.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060627083508.E912A5BBAB@nox.op5.se> <7vpsgu6wba.fsf@assigned-by-dhcp.cox.net>
 <44A23A38.3090206@op5.se> <Pine.LNX.4.63.0606281118330.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr71938t4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 12:46:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvXY5-00074i-8h
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 12:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWF1Kpa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 06:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932764AbWF1Kpa
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 06:45:30 -0400
Received: from mail.gmx.net ([213.165.64.21]:44781 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932504AbWF1Kp3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 06:45:29 -0400
Received: (qmail invoked by alias); 28 Jun 2006 10:45:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp043) with SMTP; 28 Jun 2006 12:45:28 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr71938t4.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22802>

Hi,

On Wed, 28 Jun 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Try this:
> >
> > $ mkdir 5
> > $ cd 5
> > $ git-init-db
> > $ rm .git/config # yes, really.
> > $ git abc
> 
> Thanks for trying to help, but not really.

Okay. Does not happen with 'next' here, too. I have some changes in my 
private repo (which eventually should culminate in the big mmap()ed sooper 
config parsing / writing thingie), which make it break. The following 
patch fixes this (and potentially Andreas' problem, too).

-- cut here --

[PATCH] save errno in handle_alias()

git.c:main() relies on the value of errno being set by the last attempt to 
execute the command. However, if something goes awry in handle_alias(), 
that assumption is wrong. So restore errno before returning from 
handle_alias().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

---

diff --git a/git.c b/git.c
index 94e9a4a..7c7106e 100644
--- a/git.c
+++ b/git.c
@@ -99,7 +99,7 @@ static int split_cmdline(char *cmdline, 
 
 static int handle_alias(int *argcp, const char ***argv)
 {
-	int nongit = 0, ret = 0;
+	int nongit = 0, ret = 0, saved_errno = errno;
 	const char *subdir;
 
 	subdir = setup_git_directory_gently(&nongit);
@@ -137,6 +137,8 @@ static int handle_alias(int *argcp, cons
 	if (subdir)
 		chdir(subdir);
 
+	errno = saved_errno;
+
 	return ret;
 }
 
