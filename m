From: Csaba Henk <csaba@gluster.com>
Subject: [PATCH v2] bundle: detect if bundle file cannot be created
Date: Fri, 27 Aug 2010 20:31:47 +0000 (UTC)
Message-ID: <i597bj$vtg$1@dough.gmane.org>
References: <20100826092333.GB32617@acharya.in.gluster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 27 22:32:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op5ak-0002rF-NJ
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 22:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab0H0Ub7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 16:31:59 -0400
Received: from lo.gmane.org ([80.91.229.12]:48294 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327Ab0H0Ub5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 16:31:57 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Op5ad-0002nI-Vq
	for git@vger.kernel.org; Fri, 27 Aug 2010 22:31:55 +0200
Received: from gluelinux.org ([195.56.45.29])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 22:31:55 +0200
Received: from csaba by gluelinux.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 22:31:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: gluelinux.org
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154619>

bundle command silently died with no sign of failure if it
could not create the bundle file. (Eg.: its path resovles to a directory,
or the parent dir is sticky while file already exists and is owned
by someone else.)

Signed-off-by: Csaba Henk <csaba@gluster.com>
---
 bundle.c          |    6 ++++--
 t/t5704-bundle.sh |    7 +++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index ff97adc..65ea26b 100644
--- a/bundle.c
+++ b/bundle.c
@@ -372,8 +372,10 @@ int create_bundle(struct bundle_header *header, const char *path,
 	close(rls.in);
 	if (finish_command(&rls))
 		return error ("pack-objects died");
-	if (!bundle_to_stdout)
-		commit_lock_file(&lock);
+	if (!bundle_to_stdout) {
+		if (commit_lock_file(&lock))
+			die_errno("cannot create '%s'", path);
+	}
 	return 0;
 }
 
diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index ddc3dc5..728ccd8 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -30,6 +30,13 @@ test_expect_success 'tags can be excluded by rev-list options' '
 
 '
 
+test_expect_success 'die if bundle file cannot be created' '
+
+	mkdir adir &&
+	test_must_fail git bundle create adir --all
+
+'
+
 test_expect_failure 'bundle --stdin' '
 
 	echo master | git bundle create stdin-bundle.bdl --stdin &&
-- 
1.7.2.2
