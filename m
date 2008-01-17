From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: I don't want the .git directory next to my code.
Date: Thu, 17 Jan 2008 09:36:47 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801170849070.14959@woody.linux-foundation.org>
References: <478D79BD.7060006@talkingspider.com> <86hcheig3n.fsf@blue.stonehenge.com> <478D82FA.2030404@talkingspider.com> <478D95D8.5040806@theory.org> <478E3D8E.1090300@talkingspider.com> <alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org>
 <alpine.LFD.1.00.0801161019250.2806@woody.linux-foundation.org> <478EEAC4.2010006@talkingspider.com> <20080117151725.GC2816@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike <fromlists@talkingspider.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 18:38:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFYhS-0002WH-AY
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 18:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbYAQRiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 12:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbYAQRiM
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 12:38:12 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:60050 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751687AbYAQRiL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 12:38:11 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HHap0w016654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jan 2008 09:36:52 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0HHalBf003903;
	Thu, 17 Jan 2008 09:36:50 -0800
In-Reply-To: <20080117151725.GC2816@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-5.675 required=5 tests=AWL,BAYES_00,PATCH_UNIFIED_DIFF_OSDL,TW_QL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70879>



On Thu, 17 Jan 2008, Jeff King wrote:
> 
> You don't seem happy with any of those. But the fact remains that the
> git repo has to be stored _somewhere_, and when you run git, there needs
> to be some mapping telling it which git repo matches your working
> directory. So how _do_ you want to specify that mapping? 

Ok, here's the ugliest idea *ever*:

We could actually use POSIX extended attributes (or whatever 
system-specific version of it a particular filesystem supports) for people 
who *really* don't want to pollute their file structure.

I know, I know, it's horrible. It's one of those things that would 
actually be reqlly convenient (and probably even pretty easy to 
implement), but is also going to be *really* subtle when it breaks.

But I bet some people would like it. I personally tend to hate extended 
attributes (they tend to have serious problems with anything that moves 
things around or backs them up - especially across filesystem boundaries), 
but there is no question that they can't be convenient to hide 
information.

Anyway, here's a really stupid patch. It kind of works, but it has no way 
to turn this off.

On at least Linux, with this you can do something like

	.. start off with a git directory ..
	mv .git /external/git/location
	setfattr -n user.git-dir -v /external/git/location .

and now that "user.git-dir" thing acts as a kind of invisible "symlink" to 
the external git directory.

Not exactly heavily tested, and I don't know how portable the whole xattr 
thing is (ie I know OS X has file attributes, I just don't know if the 
interface is at all similar).

I don't like extended attributes myself, but this patch really is pretty 
simple and perhaps useful.

			Linus

---
 setup.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/setup.c b/setup.c
index adede16..97865f4 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "dir.h"
+#include <attr/xattr.h>
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
@@ -302,6 +303,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 */
 	offset = len = strlen(cwd);
 	for (;;) {
+		int attr_len;
+		static char git_dir[PATH_MAX];
+
 		if (is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT))
 			break;
 		if (is_git_directory(".")) {
@@ -312,6 +316,14 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			check_repository_format_gently(nongit_ok);
 			return NULL;
 		}
+		attr_len = getxattr(".", "user.git-dir", git_dir, sizeof(git_dir)-1);
+		if (attr_len > 0) {
+			git_dir[attr_len] = 0;
+			if (is_git_directory(git_dir)) {
+				setenv(GIT_DIR_ENVIRONMENT, git_dir, 1);
+				break;
+			}
+		}
 		chdir("..");
 		do {
 			if (!offset) {
