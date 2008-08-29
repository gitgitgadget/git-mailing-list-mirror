From: Romain Francoise <romain@orebokech.com>
Subject: [PATCH] builtin-help: fallback to GIT_MAN_VIEWER before man
Date: Fri, 29 Aug 2008 17:00:43 +0200
Organization: orebokech dot com
Message-ID: <877i9zsw6c.fsf@elegiac.orebokech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 17:01:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ5Ty-0002Ie-Mt
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 17:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbYH2PAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 11:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbYH2PAq
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 11:00:46 -0400
Received: from smtp8-g19.free.fr ([212.27.42.65]:46027 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751376AbYH2PAp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 11:00:45 -0400
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id C3CC632A7DE;
	Fri, 29 Aug 2008 17:00:43 +0200 (CEST)
Received: from elegiac.orebokech.com (home.orebokech.com [82.67.41.165])
	by smtp8-g19.free.fr (Postfix) with ESMTP id AA29332A857;
	Fri, 29 Aug 2008 17:00:43 +0200 (CEST)
Received: by elegiac.orebokech.com (Postfix, from userid 1000)
	id 215973B26A; Fri, 29 Aug 2008 17:00:43 +0200 (CEST)
X-Face: }9mYu,e_@+e!`Z-P5kVXa3\_b:hdJ"B)ww[&=b<2=awG:GOIM</2q'*t@MNa)R`k0h1KbUu "Ek%gXCQA(?k=Uf9}qgF_x#7/+Ql\R!NJ9[Z[ky\CTYI<H(kc][?[m%*rsf!OG11|f&H[VgX;),"!N JG6IziY\~""3M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94303>

In some situations it is useful to be able to switch viewers via the
environment, e.g. in Emacs shell buffers.  So check the GIT_MAN_VIEWER
environment variable and try it before falling back to "man".

Signed-off-by: Romain Francoise <romain@orebokech.com>
---

The motivation for this is that I want the viewer to be "woman" in
Emacs shell buffers and "man" otherwise, and having an environment
variable (like PAGER or EDITOR) is cleaner than using a
man.viewer.cmd wrapper to do the redirection.

 Documentation/git-help.txt |    4 +++-
 builtin-help.c             |    3 +++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index f414583..d9b9c34 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -112,7 +112,9 @@ For example, this configuration:
 will try to use konqueror first. But this may fail (for example if
 DISPLAY is not set) and in that case emacs' woman mode will be tried.
 
-If everything fails the 'man' program will be tried anyway.
+If everything fails, or if no viewer is configured, the viewer specified
+in the GIT_MAN_VIEWER environment variable will be tried.  If that
+fails too, the 'man' program will be tried anyway.
 
 man.<tool>.path
 ~~~~~~~~~~~~~~~
diff --git a/builtin-help.c b/builtin-help.c
index 721038e..64207cb 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -361,12 +361,15 @@ static void show_man_page(const char *git_cmd)
 {
 	struct man_viewer_list *viewer;
 	const char *page = cmd_to_page(git_cmd);
+	const char *fallback = getenv("GIT_MAN_VIEWER");
 
 	setup_man_path();
 	for (viewer = man_viewer_list; viewer; viewer = viewer->next)
 	{
 		exec_viewer(viewer->name, page); /* will return when unable */
 	}
+	if (fallback)
+		exec_viewer(fallback, page);
 	exec_viewer("man", page);
 	die("no man viewer handled the request");
 }
-- 
1.6.0.1.141.g445ca.dirty
