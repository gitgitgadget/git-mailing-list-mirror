From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 2/2] Make git respect core.autocrlf for zip archives
Date: Sun, 21 Sep 2008 21:25:27 +0100
Message-ID: <1222028727-30097-2-git-send-email-charles@hashpling.org>
References: <1222028727-30097-1-git-send-email-charles@hashpling.org>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 22:26:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhVW3-0003ZV-Sj
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 22:26:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbYIUUZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 16:25:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbYIUUZd
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 16:25:33 -0400
Received: from pih-relay06.plus.net ([212.159.14.19]:52917 "EHLO
	pih-relay06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbYIUUZc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 16:25:32 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1KhVUm-0007tE-CZ; Sun, 21 Sep 2008 21:25:28 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m8LKPSBE030123
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 21 Sep 2008 21:25:28 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m8LKPS7Q030122;
	Sun, 21 Sep 2008 21:25:28 +0100
X-Mailer: git-send-email 1.6.0.1.309.g4f56
In-Reply-To: <1222028727-30097-1-git-send-email-charles@hashpling.org>
X-Plusnet-Relay: 003d3a1a833b927d7a41c74c99143b61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96429>

There is currently no call to git_config at the start of cmd_archive.
When creating tar archives the core config is read as a side-effect of
reading the tar specific config, but this doesn't happen for zip
archives.

The consequence is that in a configuration with core.autocrlf set,
although files in a tar archive are created with crlf line endings,
files in a zip archive retain unix line endings.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 builtin-archive.c       |    2 ++
 t/t0024-crlf-archive.sh |    2 +-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 5ceec43..432ce2a 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -111,6 +111,8 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 {
 	const char *remote = NULL;
 
+	git_config(git_default_config, NULL);
+
 	remote = extract_remote_arg(&argc, argv);
 	if (remote)
 		return run_remote_archiver(remote, argc, argv);
diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index 3511439..e533039 100644
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -33,7 +33,7 @@ if [ $? -eq 127 ]; then
 	exit
 fi
 
-test_expect_failure 'zip archive' '
+test_expect_success 'zip archive' '
 
 	git archive --format=zip HEAD >test.zip &&
 
-- 
1.6.0.1.309.g4f56
