From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 4/7] Glean libexec path from argv[0] for git-upload-pack and git-receive-pack.
Date: Sun, 21 Sep 2008 18:24:35 +0200
Message-ID: <1222014278-11071-5-git-send-email-prohaska@zib.de>
References: <1222014278-11071-1-git-send-email-prohaska@zib.de>
 <1222014278-11071-2-git-send-email-prohaska@zib.de>
 <1222014278-11071-3-git-send-email-prohaska@zib.de>
 <1222014278-11071-4-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steve Haslam <shaslam@lastminute.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Sep 21 18:27:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhRm7-0001PG-T6
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 18:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbYIUQZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 12:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbYIUQZa
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 12:25:30 -0400
Received: from mailer.zib.de ([130.73.108.11]:50403 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbYIUQZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 12:25:29 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m8LGOdhY005000;
	Sun, 21 Sep 2008 18:24:48 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m8LGOcxR015855;
	Sun, 21 Sep 2008 18:24:39 +0200 (MEST)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1222014278-11071-4-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96404>

From: Steve Haslam <shaslam@lastminute.com>

If the user specified the full path to git-upload-pack as the -u option to
"git clone" when cloning a remote repository, and git was not on the default
PATH on the remote machine, git-upload-pack was failing to exec
git-pack-objects.

By making the argv[0] path (if any) available to setup_path(), this will
allow finding the "git" executable in the same directory as
"git-upload-pack". The default built in to exec_cmd.c is to look for "git"
in the ".../libexec/git-core" directory, but it is not installed there (any
longer).

Much the same applies to invoking git-receive-pack from a non-PATH location
using the "--exec" argument to "git push".

[ spr: split Steve's original commit into two commits. ]

Signed-off-by: Steve Haslam <shaslam@lastminute.com>
Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 receive-pack.c |    3 +++
 upload-pack.c  |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index b81678a..3872180 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -467,6 +467,9 @@ int main(int argc, char **argv)
 	int i;
 	char *dir = NULL;
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	argv++;
 	for (i = 1; i < argc; i++) {
 		char *arg = *argv++;
diff --git a/upload-pack.c b/upload-pack.c
index e5adbc0..c469a60 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -616,6 +616,9 @@ int main(int argc, char **argv)
 	int i;
 	int strict = 0;
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
-- 
1.6.0.2.GIT
