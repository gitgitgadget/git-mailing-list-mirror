From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Deduce exec_path also from calls to git with a relative path
Date: Sat, 20 Oct 2007 08:21:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710200818410.25221@racer.site>
References: <20071020064617.GC2237@srparish.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, spearce@spearce.org, gitster@pobox.com
To: Scott R Parish <srp@srparish.net>
X-From: git-owner@vger.kernel.org Sat Oct 20 09:22:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij8et-0007fn-Ks
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 09:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbXJTHVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 03:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbXJTHVx
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 03:21:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:42469 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751955AbXJTHVx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 03:21:53 -0400
Received: (qmail invoked by alias); 20 Oct 2007 07:21:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp056) with SMTP; 20 Oct 2007 09:21:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX185NFRFRXA5CGwX7t2Lo51KKbTbYWLP7zK8iOMLFi
	/Zzuyj9ZyDhOsE
X-X-Sender: gene099@racer.site
In-Reply-To: <20071020064617.GC2237@srparish.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61804>


There is already logic in the git wrapper to deduce the exec_path from
argv[0], when the git wrapper was called with an absolute path.  Extend
that logic to handle relative paths as well.

For example, when you call "../../hello/world/git", it will not turn
"../../hello/world" into an absolute path, and use that.

Initial implementation by Scott R Parish.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Fri, 19 Oct 2007, Scott R Parish wrote:

	>  Signed-off-by: Scott R Parish <srp@srparish.net>

	That is a little short for a commit message ;-)

	>  git.c |   35 +++++++++++++++++++++++++++++++++--
	>  1 files changed, 33 insertions(+), 2 deletions(-)

	I had commented on this before.  Probably I did a very bad job 
	at explaining things, so hopefully this is better:

 git.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index d7c6bca..1dad764 100644
--- a/git.c
+++ b/git.c
@@ -414,13 +414,14 @@ int main(int argc, const char **argv)
 	/*
 	 * Take the basename of argv[0] as the command
 	 * name, and the dirname as the default exec_path
-	 * if it's an absolute path and we don't have
-	 * anything better.
+	 * if we don't have anything better.
 	 */
 	if (slash) {
 		*slash++ = 0;
 		if (*cmd == '/')
 			exec_path = cmd;
+		else
+			exec_path = xstrdup(make_absolute_path(cmd));
 		cmd = slash;
 	}
 
-- 
1.5.3.4.1287.g8b31e
