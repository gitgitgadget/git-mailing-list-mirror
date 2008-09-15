From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] help git-upload-pack find git
Date: Mon, 15 Sep 2008 18:24:51 +0200
Message-ID: <1221495891-12600-1-git-send-email-git@drmicha.warpmail.net>
References: <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com>
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 15 18:35:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfH2p-0000RZ-FB
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 18:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706AbYIOQeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 12:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754702AbYIOQeS
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 12:34:18 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58363 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754456AbYIOQeR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2008 12:34:17 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id CA4361633C9
	for <git@vger.kernel.org>; Mon, 15 Sep 2008 12:34:16 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 15 Sep 2008 12:34:16 -0400
X-Sasl-enc: TGpgxJwjWtSlCS6n8PT7YG238bLxqKY/5hbATe/i3GQN 1221495902
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 20428283A0;
	Mon, 15 Sep 2008 12:25:01 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.308.gede4c
In-Reply-To: <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com>
In-Reply-To: <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com>
References: <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95922>

The --upload-pack option to clone raises the expectation that finding
git-upload-pack on the server side is enough. But git-upload-pack needs
to find git (for forking "git pack-objects") which fails if git is not
in $PATH.

This patch makes git-upload-pack use git_set_argv0_path() so that an
explicitely specified path for git-upload-pack is added to the path
which is used when fork()ing.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 upload-pack.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

The corresponding bug was reported by Paul Johnston who wondered why "git clone"
failed when specifying --upload-pack for an out-of-$PATH installation of git.
I'm not sure whether we should encourage this, but the --upload-pack option
clearly gives the impression that git-upload-pack is all that is needed.

I haven't looked at other server side programmes yet regarding this issue,
but "git clone" works fine with this patch in the situation where it
would not without.

diff --git a/upload-pack.c b/upload-pack.c
index e5adbc0..1fb59de 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -615,6 +615,21 @@ int main(int argc, char **argv)
 	char *dir;
 	int i;
 	int strict = 0;
+	const char *cmd = argv[0] && *argv[0] ? argv[0] : "git-upload-pack";
+	char *slash = (char *)cmd + strlen(cmd);
+
+	/*
+	 * Take the basename of argv[0] as the command
+	 * name, and the dirname as the default exec_path
+	 * if we don't have anything better.
+	 */
+	do
+		--slash;
+	while (cmd <= slash && !is_dir_sep(*slash));
+	if (cmd <= slash) {
+		*slash++ = 0;
+		git_set_argv0_path(cmd);
+	}
 
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
-- 
1.6.0.1.308.gede4c
