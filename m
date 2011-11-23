From: vfr@lyx.org
Subject: [PATCH] builtin-branch: Fix crash on invalid use of --force
Date: Wed, 23 Nov 2011 07:31:55 +0100
Message-ID: <1322029915-18486-1-git-send-email-vfr@lyx.org>
Cc: gitster@pobox.com, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 07:33:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT6OS-0001br-NV
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 07:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757066Ab1KWGdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 01:33:11 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33290 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473Ab1KWGdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 01:33:09 -0500
Received: by bke11 with SMTP id 11so1206557bke.19
        for <git@vger.kernel.org>; Tue, 22 Nov 2011 22:33:08 -0800 (PST)
Received: by 10.204.151.84 with SMTP id b20mr22761541bkw.22.1322029988510;
        Tue, 22 Nov 2011 22:33:08 -0800 (PST)
Received: from vincent-VirtualBox.tudelft.nl (221-44.206-83.static-ip.oleane.fr. [83.206.44.221])
        by mx.google.com with ESMTPS id e18sm11881905bkr.15.2011.11.22.22.33.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Nov 2011 22:33:07 -0800 (PST)
X-Mailer: git-send-email 1.7.8-rc3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185821>

From: Vincent van Ravesteijn <vfr@lyx.org>

The option --force should not put us in 'create branch' mode. The
fact that this option is only valid in 'create branch' mode is
already caught by the the next 'if' in which we assure that we
are in the correct mode.

Without this patch, we end up calling create_branch without any
arguments. This means that argv[0] makes not much sense and
that we will finally crash because the branch name is a NULL
pointer. Hence the added safety check that we should not try
to create a branch without a name.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 builtin/branch.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 51ca6a0..55cad76 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -705,7 +705,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
 
-	if (!delete && !rename && !force_create && argc == 0)
+	if (!delete && !rename && argc == 0)
 		list = 1;
 
 	if (!!delete + !!rename + !!force_create + !!list > 1)
@@ -726,7 +726,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			rename_branch(argv[0], argv[1], rename > 1);
 		else
 			usage_with_options(builtin_branch_usage, options);
-	} else if (argc <= 2) {
+	} else if (argc > 0 && argc <= 2) {
 		if (kinds != REF_LOCAL_BRANCH)
 			die(_("-a and -r options to 'git branch' do not make sense with a branch name"));
 		create_branch(head, argv[0], (argc == 2) ? argv[1] : head,
-- 
1.7.8-rc3
