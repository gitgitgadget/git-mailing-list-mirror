From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin-clone: create remotes/origin/HEAD symref, if
 guessed
Date: Sun, 2 Mar 2008 05:57:58 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803020556380.22527@racer.site>
References: <alpine.LNX.1.00.0802251604460.19024@iabervon.org> <200802260321.14038.johan@herland.net> <alpine.LNX.1.00.0802261128360.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <sbejar@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 06:59:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVhEF-00048x-Tx
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 06:59:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbYCBF6o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 00:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750853AbYCBF6n
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 00:58:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:43221 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750774AbYCBF6n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 00:58:43 -0500
Received: (qmail invoked by alias); 02 Mar 2008 05:58:41 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp010) with SMTP; 02 Mar 2008 06:58:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/WR1k25FnWs1hvPZ0NG2DXdcYBYMd0xe2pBAgxqH
	3QrJb1q2R9/l75
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802261128360.19024@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75726>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 26 Feb 2008, Daniel Barkalow wrote:

	> On Tue, 26 Feb 2008, Johan Herland wrote:
	> 
	> > I've tried to test this by diffing a cloned repo against an 
	> > equivalent clone done by the old script. Below I pasted in a 
	> > few immediate fixes I found. With these fixes, the only 
	> > remaining diff between the clones is that 
	> > refs/remotes/origin/HEAD used to be a symbolic ref (with no
	> > reflog), but is now a "regular" ref (with reflog).
	> 
	> I think that's just a call to the wrong function (and a lack of 
	> very very explicit documentation).

	This fixes it.

 builtin-clone.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 89ef665..bd09b0f 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -518,33 +518,35 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		git_config_set_multivar(key, value, "^$", 0);
 	}
 
+	if (head_points_at)
+		/* Local default branch */
+		create_symref("HEAD", head_points_at->name, NULL);
+
 	if (option_bare) {
-		if (head_points_at) {
-			/* Local default branch */
-			create_symref("HEAD", head_points_at->name, NULL);
-		}
 		junk_work_tree = NULL;
 		junk_git_dir = NULL;
 		return 0;
 	}
 
 	if (head_points_at) {
+		struct strbuf buf;
+
 		if (strrchr(head_points_at->name, '/'))
 			head = strrchr(head_points_at->name, '/') + 1;
 		else
 			head = head_points_at->name;
 
-		/* Local default branch */
-		create_symref("HEAD", head_points_at->name, NULL);
