From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH 3/6] Glean libexec path from argv[0] for git-upload-pack and git-receive-pack.
Date: Sat, 10 Jan 2009 14:50:49 +0100
Message-ID: <1231595452-27698-3-git-send-email-prohaska@zib.de>
References: <1231595452-27698-1-git-send-email-prohaska@zib.de>
 <1231595452-27698-2-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Steve Haslam <shaslam@lastminute.com>,
	Steffen Prohaska <prohaska@zib.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 14:53:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLeH2-0006VW-Lu
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 14:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbZAJNvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 08:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753161AbZAJNv2
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 08:51:28 -0500
Received: from mailer.zib.de ([130.73.108.11]:45494 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726AbZAJNvY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 08:51:24 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n0ADosTV025832;
	Sat, 10 Jan 2009 14:50:59 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n0ADorWN016764;
	Sat, 10 Jan 2009 14:50:54 +0100 (MET)
X-Mailer: git-send-email 1.5.4.4
In-Reply-To: <1231595452-27698-2-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105108>

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
 builtin-receive-pack.c |    3 +++
 upload-pack.c          |    3 +++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-receive-pack.c b/builtin-receive-pack.c
index db67c31..bbedcfe 100644
--- a/builtin-receive-pack.c
+++ b/builtin-receive-pack.c
@@ -579,6 +579,9 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	int i;
 	char *dir = NULL;
 
+	if (argv[0] && *argv[0])
+		git_extract_argv0_path(argv[0]);
+
 	argv++;
 	for (i = 1; i < argc; i++) {
 		const char *arg = *argv++;
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
1.6.1.85.g32c5d
