From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH v2] config: preserve config file permissions on edits
Date: Tue, 6 May 2014 00:17:14 +0000
Message-ID: <20140506001714.GA29049@dcvr.yhbt.net>
References: <20140505215853.GA23299@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 20:05:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiFN-0007Xo-QM
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933526AbaEFARR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 20:17:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42969 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933523AbaEFARP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 20:17:15 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id C928120687;
	Tue,  6 May 2014 00:17:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20140505215853.GA23299@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248200>

Users may already store sensitive data such as imap.pass in
.git/config; making the file world-readable when "git config"
is called to edit means their password would be compromised
on a shared system.

[v2: updated for section renames, as noted by Junio]

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 config.c               | 16 ++++++++++++++++
 t/t1300-repo-config.sh | 10 ++++++++++
 2 files changed, 26 insertions(+)

diff --git a/config.c b/config.c
index a30cb5c..c227aa8 100644
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
 
@@ -1784,6 +1791,7 @@ int git_config_rename_section_in_file(const char *config_filename,
 	int out_fd;
 	char buf[1024];
 	FILE *config_file;
+	struct stat st;
 
 	if (new_name && !section_name_is_ok(new_name)) {
 		ret = error("invalid section name: %s", new_name);
@@ -1805,6 +1813,14 @@ int git_config_rename_section_in_file(const char *config_filename,
 		goto unlock_and_out;
 	}
 
+	fstat(fileno(config_file), &st);
+
+	if (fchmod(out_fd, st.st_mode & 07777) < 0) {
+		ret = error("fchmod on %s failed: %s",
+				lock->filename, strerror(errno));
+		goto out;
+	}
+
 	while (fgets(buf, sizeof(buf), config_file)) {
 		int i;
 		int length;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 58cd543..3f80ff0 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1158,4 +1158,14 @@ test_expect_failure 'adding a key into an empty section reuses header' '
 	test_cmp expect .git/config
 '
 
+test_expect_success POSIXPERM,PERL 'preserves existing permissions' '
+	chmod 0600 .git/config &&
+	git config imap.pass Hunter2 &&
+	perl -e \
+	  "die q(badset) if ((stat(q(.git/config)))[2] & 07777) != 0600" &&
+	git config --rename-section imap pop &&
+	perl -e \
+	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) != 0600"
+'
+
 test_done
-- 
Eric Wong
