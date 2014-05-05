From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] config: preserve config file permissions on edits
Date: Mon, 5 May 2014 21:58:53 +0000
Message-ID: <20140505215853.GA23299@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:51:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiAv-0007Xo-77
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756843AbaEEV6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 17:58:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41575 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756316AbaEEV6x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 17:58:53 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55FF520687;
	Mon,  5 May 2014 21:58:53 +0000 (UTC)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248154>

Users may already store sensitive data such as imap.pass in
.git/config; making the file world-readable when "git config"
is called to edit means their password would be compromised
on a shared system.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 config.c               | 7 +++++++
 t/t1300-repo-config.sh | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/config.c b/config.c
index a30cb5c..a0b6756 100644
--- a/config.c
+++ b/config.c
@@ -1636,6 +1636,13 @@ int git_config_set_multivar_in_file(const char *config_filename,
 			MAP_PRIVATE, in_fd, 0);
 		close(in_fd);
 
+		if (fchmod(fd, st.st_mode & 07777) < 0) {
+			error("fchmod on %s failed: %s",
+				lock->filename, strerror(errno));
+			ret = CONFIG_NO_WRITE;
+			goto out_free;
+		}
+
 		if (store.seen == 0)
 			store.seen = 1;
 
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 58cd543..d87693e 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1158,4 +1158,10 @@ test_expect_failure 'adding a key into an empty section reuses header' '
 	test_cmp expect .git/config
 '
 
+test_expect_success POSIXPERM,PERL 'preserves existing permissions' '
+	chmod 0600 .git/config &&
+	git config imap.pass Hunter2 &&
+	perl -e "die q(badperm) if ((stat(q(.git/config)))[2] & 07777) != 0600"
+'
+
 test_done
-- 
Eric Wong
