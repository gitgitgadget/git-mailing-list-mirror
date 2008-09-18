From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 1/1] Make git archive respect core.autocrlf when creating
	zip format archives
Date: Thu, 18 Sep 2008 21:01:20 +0100
Message-ID: <20080918200120.GB8631@hashpling.org>
References: <1a7cc4db062b7df0dae0f27b29dba66c9d917e59.1221767629.git.charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 18 22:04:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgPi1-0001cq-37
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 22:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461AbYIRUB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 16:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755065AbYIRUB2
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 16:01:28 -0400
Received: from ptb-relay01.plus.net ([212.159.14.145]:60895 "EHLO
	ptb-relay01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047AbYIRUB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 16:01:26 -0400
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay01.plus.net with esmtp (Exim) id 1KgPgm-0002tY-OT; Thu, 18 Sep 2008 21:01:21 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id m8IK1KoW009065
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Sep 2008 21:01:20 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id m8IK1KLQ009064;
	Thu, 18 Sep 2008 21:01:20 +0100
Content-Disposition: inline
In-Reply-To: <1a7cc4db062b7df0dae0f27b29dba66c9d917e59.1221767629.git.charles@hashpling.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 3249f15c75de32132bf8396ad031363c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96237>

There is currently no call to git_config at the start of cmd_archive.
When creating tar archives the core config is read as a side-effect of
reading the tar specific config, but this doesn't happen for zip
archives.

The consequence is that in a configuration with core.autocrlf set,
although files in a tar archive are created with crlf line endings,
files in a zip archive retain unix line endings.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---

It took me a while to find the cause of the difference in behaviour
between tar and zip format archives when all the crlf fixing code
seemed to be in code shared by both archiving processes. I'm 99% sure
that creating zip archives from repositories with core.autocrlf set to
true should create zip entries with crlf line endings but it would be
good to have that confirmed.

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
