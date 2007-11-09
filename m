From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin-blame: set up the work_tree before the first file
 access
Date: Fri, 9 Nov 2007 11:34:07 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711091132290.4362@racer.site>
References: <20071103100323.GA25305@laptop> <20071103131806.GA25109@laptop>
 <7vir4ivdcr.fsf@gitster.siamese.dyndns.org> <20071104070307.GA26071@laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 12:34:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqS8H-0007M0-Ks
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 12:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbXKILe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 06:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbXKILe1
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 06:34:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:55142 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751937AbXKILe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 06:34:26 -0500
Received: (qmail invoked by alias); 09 Nov 2007 11:34:14 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp050) with SMTP; 09 Nov 2007 12:34:14 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JoD10jRkJbEb0hjKJHS4s3CmdP1aSJRzGX32g7g
	hAwoUS4G1S1E/5
X-X-Sender: gene099@racer.site
In-Reply-To: <20071104070307.GA26071@laptop>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64168>


We check in cmd_blame() if the specified path is there, but we
failed to set up the working tree before that.

While at it, make setup_work_tree() just return if it was run
before.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	IMO both this patch and the recent patch to call setup_work_tree() 
	are needed.  Only the second call to setup_work_tree() will know 
	if there was no revision specified, and the first one will know if 
	a -- has been seen.

 builtin-blame.c |    1 +
 setup.c         |   10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 55a3c0b..ba80bf8 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2295,6 +2295,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			else if (i != argc - 1)
 				usage(blame_usage); /* garbage at end */
 
+			setup_work_tree();
 			if (!has_path_in_work_tree(path))
 				die("cannot stat path %s: %s",
 				    path, strerror(errno));
diff --git a/setup.c b/setup.c
index 084d722..1421a2c 100644
--- a/setup.c
+++ b/setup.c
@@ -207,12 +207,18 @@ static const char *set_work_tree(const char *dir)
 }
 
 void setup_work_tree(void) {
-	const char *work_tree = get_git_work_tree();
-	const char *git_dir = get_git_dir();
+	const char *work_tree, *git_dir;
+	static int initialized = 0;
+
+	if (initialized)
+		return;
+	work_tree = get_git_work_tree();
+	git_dir = get_git_dir();
 	if (!is_absolute_path(git_dir))
 		set_git_dir(make_absolute_path(git_dir));
 	if (!work_tree || chdir(work_tree))
 		die("This operation must be run in a work tree");
+	initialized = 1;
 }
 
 /*
-- 
1.5.3.5.1645.g1f4df
