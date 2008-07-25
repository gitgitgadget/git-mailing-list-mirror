From: Steve Haslam <shaslam@lastminute.com>
Subject: [PATCH] Propagate -u/--upload-pack option of "git clone" to transport.
Date: Fri, 25 Jul 2008 18:51:51 +0100
Message-ID: <1217008311-27916-1-git-send-email-shaslam@lastminute.com>
Cc: Steve Haslam <shaslam@lastminute.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 20:02:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMRcq-00087j-Gb
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 20:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408AbYGYSBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 14:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbYGYSBo
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 14:01:44 -0400
Received: from sglonmg02-out.sabre.com ([151.193.120.24]:24088 "EHLO
	sglonmg02-out.sabre.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbYGYSBn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 14:01:43 -0400
X-Greylist: delayed 587 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jul 2008 14:01:43 EDT
X-ExtLoop1: From 10.136.85.54
X-IronPort-AV: E=Sophos;i="4.31,253,1215385200"; 
   d="scan'208";a="1124589508"
Received: from unknown (HELO sglonbh01.Global.ad.sabre.com) ([10.136.85.54])
  by sglonmg02-out.sabre.com with ESMTP; 25 Jul 2008 18:51:55 +0100
Received: from sglonms02.Global.ad.sabre.com ([10.136.85.20]) by sglonbh01.Global.ad.sabre.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 25 Jul 2008 18:51:54 +0100
Received: from localhost.localdomain ([10.104.41.28]) by sglonms02.Global.ad.sabre.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 25 Jul 2008 18:51:54 +0100
X-Mailer: git-send-email 1.6.0.rc0.43.g1cd6
X-OriginalArrivalTime: 25 Jul 2008 17:51:54.0325 (UTC) FILETIME=[1FE27050:01C8EE7F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90080>

The -u option to override the remote system's path to git-upload-pack was
being ignored by "git clone"; caused by a missing call to
transport_set_option to set TRANS_OPT_UPLOADPACK. Presumably this crept in
when git-clone was converted from shell to C.

Signed-off-by: Steve Haslam <shaslam@lastminute.com>
---
 builtin-clone.c              |    4 ++++
 t/t5602-clone-remote-exec.sh |   26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100755 t/t5602-clone-remote-exec.sh

diff --git a/builtin-clone.c b/builtin-clone.c
index 3522245..e086a40 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -480,6 +480,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (option_quiet)
 			transport->verbose = -1;
 
+		if (option_upload_pack)
+			transport_set_option(transport, TRANS_OPT_UPLOADPACK,
+					     option_upload_pack);
+
 		refs = transport_get_remote_refs(transport);
 		transport_fetch_refs(transport, refs);
 	}
diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec.sh
new file mode 100755
index 0000000..8367a68
--- /dev/null
+++ b/t/t5602-clone-remote-exec.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+test_description=clone
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo "#!/bin/sh" > not_ssh
+	echo "echo \"\$*\" > not_ssh_output" >> not_ssh
+	echo "exit 1" >> not_ssh
+	chmod +x not_ssh
+'
+
+test_expect_success 'clone calls git-upload-pack unqualified with no -u option' '
+	GIT_SSH=./not_ssh git clone localhost:/path/to/repo junk
+	echo "localhost git-upload-pack '\''/path/to/repo'\''" >expected
+	test_cmp expected not_ssh_output
+'
+
+test_expect_success 'clone calls specified git-upload-pack with -u option' '
+	GIT_SSH=./not_ssh git clone -u /something/bin/git-upload-pack localhost:/path/to/repo junk
+	echo "localhost /something/bin/git-upload-pack '\''/path/to/repo'\''" >expected
+	test_cmp expected not_ssh_output
+'
+
+test_done
-- 
1.6.0.rc0.43.g1cd6
