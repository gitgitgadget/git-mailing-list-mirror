From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 2/2] builtin/commit.c: set status_format _after_ option parsing
Date: Thu, 26 May 2011 13:43:21 -0700
Message-ID: <vdMu20HxiNaWL_IogfamtflLupHrDNZVtQH5MK7obj8IjaOAuDtj-EwLzysKLoeGXYfBRtJqF-hgEQF5bfRzsQ@cipher.nrlssc.navy.mil>
References: <vdMu20HxiNaWL_IogfamtfZCd6xRyKanIqTSw0k4f2SrbLfUYHDzKT2EGkwdFRlaLzX-5vGGtDCZRGu84HrJzw@cipher.nrlssc.navy.mil>
Cc: peff@peff.net, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 26 22:56:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPhbk-0005bd-4a
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 22:56:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758525Ab1EZU4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 16:56:36 -0400
Received: from mail2.nrlssc.navy.mil ([128.160.25.4]:48670 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758413Ab1EZU4f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 16:56:35 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 May 2011 16:56:26 EDT
Received: by mail.nrlssc.navy.mil id p4QKo2Vw028043; Thu, 26 May 2011 15:50:02 -0500
In-Reply-To: <vdMu20HxiNaWL_IogfamtfZCd6xRyKanIqTSw0k4f2SrbLfUYHDzKT2EGkwdFRlaLzX-5vGGtDCZRGu84HrJzw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 26 May 2011 20:45:34.0431 (UTC) FILETIME=[DC4BAEF0:01CC1BE5]
X-Virus-Scanned: clamav-milter 0.95.3 at mail2
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174568>

From: Brandon Casey <drafnel@gmail.com>

'git status' should use --porcelain output format when -z is given.
It was not doing so since the _effect_ of using -z, namely that
null_termination would be set, was being checked _before_ option parsing
was performed.

So, move the check so that it is performed after option parsing.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin/commit.c  |    7 ++++---
 t/t7508-status.sh |    2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 5286432..e1af9b1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1207,9 +1207,6 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage_with_options(builtin_status_usage, builtin_status_options);
 
-	if (null_termination && status_format == STATUS_FORMAT_LONG)
-		status_format = STATUS_FORMAT_PORCELAIN;
-
 	wt_status_prepare(&s);
 	gitmodules_config();
 	git_config(git_status_config, &s);
@@ -1217,6 +1214,10 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix,
 			     builtin_status_options,
 			     builtin_status_usage, 0);
+
+	if (null_termination && status_format == STATUS_FORMAT_LONG)
+		status_format = STATUS_FORMAT_PORCELAIN;
+
 	handle_untracked_files_arg(&s);
 	if (show_ignored_in_status)
 		s.show_ignored_files = 1;
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 9601258..dc2cc33 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -533,7 +533,7 @@ test_expect_success 'status --porcelain ignores -b' '
 
 '
 
-test_expect_failure 'status -z implies porcelain' '
+test_expect_success 'status -z implies porcelain' '
 	echo " M dir1/modifiedQA  dir2/addedQ?? dir1/untrackedQ?? dir2/modifiedQ?? dir2/untrackedQ?? expectQ?? outputQ?? untrackedQ" |
 		q_to_nul | tr -d "\\012" >expect &&
 	git status -z >output &&
-- 
1.7.4.4
