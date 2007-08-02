From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix unterminated string copy in set_work_tree
Date: Fri, 3 Aug 2007 00:02:55 +0200
Message-ID: <20070802220255.GB2829@steel.home>
References: <81b0412b0708020825q4b64c47r3fa1d67858271b1e@mail.gmail.com> <Pine.LNX.4.64.0708021636470.14781@racer.site> <20070802204909.GA2829@steel.home> <Pine.LNX.4.64.0708022204170.14781@racer.site> <7vwswdtz98.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0708022230070.14781@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:03:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGilD-0000Tg-Jp
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 00:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbXHBWDF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 18:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754803AbXHBWDD
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 18:03:03 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:17426 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681AbXHBWDC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 18:03:02 -0400
Received: from tigra.home (Fac1b.f.strato-dslnet.de [195.4.172.27])
	by post.webmailer.de (mrclete mo11) (RZmta 10.3)
	with ESMTP id 007209j72LW4WD ; Fri, 3 Aug 2007 00:02:55 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 837D1277BD;
	Fri,  3 Aug 2007 00:02:55 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 604EEC21D; Fri,  3 Aug 2007 00:02:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708022230070.14781@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcF9thg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54623>

Use strlcpy which zero-terminates the output string

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Johannes Schindelin, Thu, Aug 02, 2007 23:36:37 +0200:
> On Thu, 2 Aug 2007, Junio C Hamano wrote:
> > 
> > Static is supposed to be zeroed and also is supposed to retain
> > the value from the previous call.  I am guessing from the change
> > to make "rel" to non-static that this function is called twice
> > perhaps?

Actually, I was very confused. When I wrote about cygwin problems,
I actually debugged it for dir_buffer, real stack-based variable,
which of course is not zero-initialized. For an unknown reason I
confused the variable with buffer, which is static. "rel" should
be left of this particular discussion (it just does not matter whether
it is static or not in this context).

So the fix is a real fix for real problem which just happens to be
invisible on our linux systems.

> Apparently (but I would feel safer with strlcpy() anyway).  git-read-tree 
> is the first and only offender which comes up in the test suite:

Yes, I feel so too, so here it is.

 setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index 3653092..27d585c 100644
--- a/setup.c
+++ b/setup.c
@@ -209,7 +209,7 @@ const char *set_work_tree(const char *dir)
 	len = strlen(dir);
 	if (len > postfix_len && !strcmp(dir + len - postfix_len,
 				"/" DEFAULT_GIT_DIR_ENVIRONMENT)) {
-			strncpy(dir_buffer, dir, len - postfix_len);
+		strlcpy(dir_buffer, dir, len - postfix_len + 1);
 
 		/* are we inside the default work tree? */
 		rel = get_relative_cwd(buffer, sizeof(buffer), dir_buffer);
-- 
1.5.3.rc3.139.ga57724
