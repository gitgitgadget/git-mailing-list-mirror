From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix set_work_tree on cygwin
Date: Thu, 2 Aug 2007 22:36:37 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708022230070.14781@racer.site>
References: <81b0412b0708020825q4b64c47r3fa1d67858271b1e@mail.gmail.com>
 <Pine.LNX.4.64.0708021636470.14781@racer.site> <20070802204909.GA2829@steel.home>
 <Pine.LNX.4.64.0708022204170.14781@racer.site> <7vwswdtz98.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 23:37:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGiMS-0000DV-4o
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 23:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559AbXHBVhK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 17:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754957AbXHBVhK
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 17:37:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:60540 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753343AbXHBVhG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 17:37:06 -0400
Received: (qmail invoked by alias); 02 Aug 2007 21:37:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp021) with SMTP; 02 Aug 2007 23:37:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1873WxNX6g76Uh1m5qLT+F36XvPqnbwEv27OpZrWd
	04T18vgrfJC6GN
X-X-Sender: gene099@racer.site
In-Reply-To: <7vwswdtz98.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54617>

Hi,

On Thu, 2 Aug 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Hi,
> >
> > On Thu, 2 Aug 2007, Alex Riesen wrote:
> >
> >> Johannes Schindelin, Thu, Aug 02, 2007 17:38:37 +0200:
> >> 
> >> > On Thu, 2 Aug 2007, Alex Riesen wrote:
> >> > 
> >> > >@@ -209,7 +209,8 @@ const char *set_work_tree(const char *dir)
> >> > >        len = strlen(dir);
> >> > >        if (len > postfix_len && !strcmp(dir + len - postfix_len,
> >> > >                                "/" DEFAULT_GIT_DIR_ENVIRONMENT)) {
> >> > >-                       strncpy(dir_buffer, dir, len - postfix_len);
> >> > >+               strncpy(dir_buffer, dir, len - postfix_len);
> >> > >+               dir_buffer[len - postfix_len] = '\0';
> >> > >
> >> > >                /* are we inside the default work tree? */
> >> > >                rel = get_relative_cwd(buffer, sizeof(buffer), dir_buffer);
> >> > 
> >> > Darn, darn, darn.  strncpy does _not_ NUL terminate.  I keep forgetting 
> >> > that.
> >> > 
> >> > Better use strlcpy()?
> >> 
> >> Of course, but it just should not be needed at all: static supposed to
> >> be zeroed.
> >
> > Certainly.  But reality outweighs theory, and so I Ack either your patch 
> > or replacing it by strlcpy().
> 
> Static is supposed to be zeroed and also is supposed to retain
> the value from the previous call.  I am guessing from the change
> to make "rel" to non-static that this function is called twice
> perhaps?

Apparently (but I would feel safer with strlcpy() anyway).  git-read-tree 
is the first and only offender which comes up in the test suite:

-- snipsnap --
[PATCH] read-tree: remove unnecessary call to setup_git_directory()

read-tree is already marked with RUN_SETUP in git.c, so there is
no need to call setup_git_directory() a second time.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-read-tree.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 41f8110..a3b17a3 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -97,7 +97,6 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
 	memset(&opts, 0, sizeof(opts));
 	opts.head_idx = -1;
 
-	setup_git_directory();
 	git_config(git_default_config);
 
 	newfd = hold_locked_index(&lock_file, 1);
-- 
1.5.3.rc3.121.g7f37
