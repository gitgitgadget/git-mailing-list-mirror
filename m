From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Allow setup_work_tree() to be called several times
Date: Thu, 2 Aug 2007 23:04:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708022302360.14781@racer.site>
References: <81b0412b0708020825q4b64c47r3fa1d67858271b1e@mail.gmail.com>
 <Pine.LNX.4.64.0708021636470.14781@racer.site> <20070802204909.GA2829@steel.home>
 <Pine.LNX.4.64.0708022204170.14781@racer.site> <7vwswdtz98.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0708022230070.14781@racer.site> <7vk5sdtxx0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:04:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGiml-0000vk-DV
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 00:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737AbXHBWEo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 18:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbXHBWEo
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 18:04:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:46092 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751513AbXHBWEn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 18:04:43 -0400
Received: (qmail invoked by alias); 02 Aug 2007 22:04:41 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp034) with SMTP; 03 Aug 2007 00:04:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Ww4YW7BcWl0EzvXGcE5763LO8noO0+CmUy8hmxx
	uvwIxkecoBLMxk
X-X-Sender: gene099@racer.site
In-Reply-To: <7vk5sdtxx0.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54624>


setup_work_tree() used to rely on a static buffer being initialized to all 
zeroes.  While at it, unstatify a pointer.

Noticed by Alex Riesen.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Thu, 2 Aug 2007, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> >> Static is supposed to be zeroed and also is supposed to retain
	> >> the value from the previous call.  I am guessing from the change
	> >> to make "rel" to non-static that this function is called twice
	> >> perhaps?
	> >
	> > Apparently (but I would feel safer with strlcpy() anyway)...
	> 
	> Yup, send an appliable "final" version, somebody please?

	Here you are.

	> > ...  git-read-tree 
	> > is the first and only offender which comes up in the test suite:
	> 
	> It is unclear.
	> 
	> Is this an optimization, or enforcing the new world order?  IOW,
	> is it now banned to call setup twice?

	It is purely an optimization, because we allow calling setup twice 
	with this patch...  but we do not recommend it, as it is 
	unnecessary.

 setup.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/setup.c b/setup.c
index 3653092..16745f9 100644
--- a/setup.c
+++ b/setup.c
@@ -201,15 +201,15 @@ int is_inside_work_tree(void)
  */
 const char *set_work_tree(const char *dir)
 {
-	char dir_buffer[PATH_MAX];
-	static char buffer[PATH_MAX + 1], *rel = NULL;
+	char dir_buffer[PATH_MAX], *rel = NULL;
+	static char buffer[PATH_MAX + 1];
 	int len, postfix_len = strlen(DEFAULT_GIT_DIR_ENVIRONMENT) + 1;
 
 	/* strip the variable 'dir' of the postfix "/.git" if it has it */
 	len = strlen(dir);
 	if (len > postfix_len && !strcmp(dir + len - postfix_len,
 				"/" DEFAULT_GIT_DIR_ENVIRONMENT)) {
-			strncpy(dir_buffer, dir, len - postfix_len);
+			strlcpy(dir_buffer, dir, len - postfix_len + 1);
 
 		/* are we inside the default work tree? */
 		rel = get_relative_cwd(buffer, sizeof(buffer), dir_buffer);
-- 
1.5.3.rc3.121.g7f37
