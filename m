From: Nelson Elhage <nelhage@ksplice.com>
Subject: [PATCH] index-pack: Don't follow replace refs.
Date: Mon,  9 Aug 2010 20:45:49 -0400
Message-ID: <1281401149-23141-1-git-send-email-nelhage@ksplice.com>
Cc: git@vger.kernel.org, Nelson Elhage <nelhage@ksplice.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Aug 10 02:51:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oid41-0006PT-Qq
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 02:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078Ab0HJAvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 20:51:17 -0400
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:47581 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753978Ab0HJAvI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 20:51:08 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Aug 2010 20:51:08 EDT
X-AuditID: 1209190f-b7b0aae000000a7d-32-4c60a151a671
Received: from mailhub-auth-2.mit.edu (MAILHUB-AUTH-2.MIT.EDU [18.7.62.36])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Brightmail Gateway) with SMTP id F6.5D.02685.151A06C4; Mon,  9 Aug 2010 20:46:09 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id o7A0k4ic002154;
	Mon, 9 Aug 2010 20:46:04 -0400
Received: from PHANATIQUE.MIT.EDU (c-71-192-160-118.hsd1.nh.comcast.net [71.192.160.118])
	(authenticated bits=0)
        (User authenticated as nelhage@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7A0k1G4021107
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 9 Aug 2010 20:46:02 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.29.g6093d
X-Brightmail-Tracker: AAAAARV7UaI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153068>

Without this, attempting to index a pack containing objects that have been
replaced results in a fatal error that looks like:

fatal: SHA1 COLLISION FOUND WITH <replaced-object> !
Signed-off-by: Nelson Elhage <nelhage@ksplice.com>
---
 builtin/index-pack.c |    2 ++
 t/t6050-replace.sh   |    6 ++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a89ae83..fad76bf 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -884,6 +884,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (argc == 2 && !strcmp(argv[1], "-h"))
 		usage(index_pack_usage);
 
+	read_replace_refs = 0;
+
 	/*
 	 * We wish to read the repository's config file if any, and
 	 * for that it is necessary to call setup_git_directory_gently().
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 203ffdb..b5635a7 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -219,6 +219,12 @@ test_expect_success 'bisect and replacements' '
      git bisect reset
 '
 
+test_expect_success 'index-pack and replacements' '
+     git --no-replace-objects rev-list --objects HEAD | \
+       git --no-replace-objects pack-objects test-
+     git index-pack test-*.pack
+'
+
 #
 #
 test_done
-- 
1.7.1.29.g6093d
