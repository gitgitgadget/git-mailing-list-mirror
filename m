From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] git-svn: Fix fetch --no-ignore-externals with GIT_SVN_NO_LIB=1
Date: Tue, 26 Sep 2006 13:42:55 +0400
Message-ID: <1159263775639-git-send-email-vsu@altlinux.ru>
Cc: git@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Tue Sep 26 11:43:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS9Sz-0006H4-IC
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 11:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWIZJm6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 05:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbWIZJm6
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 05:42:58 -0400
Received: from mivlgu.ru ([81.18.140.87]:17889 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S1750946AbWIZJm6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 05:42:58 -0400
Received: from localhost.localdomain (center4.mivlgu.local [192.168.1.4])
	by mail.mivlgu.ru (Postfix) with ESMTP
	id 65D9E804C; Tue, 26 Sep 2006 13:42:55 +0400 (MSD)
To: Eric Wong <normalperson@yhbt.net>
X-Mailer: git-send-email 1.4.2.1.ga8608c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27789>

When using Subversion 1.3.1 without Perl bindings (GIT_SVN_NO_LIB=1),
"git-svn fetch --no-ignore-externals" fails with errors like:

  Tree (.../.git/svn/git-svn/tree) is not clean:
  X      directory_with_external

In this case the 'X' lines in the "svn status" output are not a sign
of unclean tree, and therefore should be ignored.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---
 git-svn.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 0290850..2f5cf90 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1246,6 +1246,7 @@ sub assert_svn_wc_clean {
 	}
 	my @status = grep(!/^Performing status on external/,(`svn status`));
 	@status = grep(!/^\s*$/,@status);
+	@status = grep(!/^X/,@status) if $_no_ignore_ext;
 	if (scalar @status) {
 		print STDERR "Tree ($SVN_WC) is not clean:\n";
 		print STDERR $_ foreach @status;
-- 
1.4.2.1.ga8608c
