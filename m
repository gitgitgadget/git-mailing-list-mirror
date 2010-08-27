From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/2] format-patch: Don't go over merge commits
Date: Sat, 28 Aug 2010 01:58:16 +0530
Message-ID: <1282940896-18350-3-git-send-email-artagnon@gmail.com>
References: <1282940896-18350-1-git-send-email-artagnon@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 27 22:30:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op5Zg-0002G1-6g
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 22:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754530Ab0H0Ua1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 16:30:27 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:55292 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab0H0UaY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 16:30:24 -0400
Received: by gwj17 with SMTP id 17so1288155gwj.19
        for <git@vger.kernel.org>; Fri, 27 Aug 2010 13:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Aeze8mT7lZX7g6MrnGTixhuMCbxstOlEYLvb5fvbjMw=;
        b=ZLdwUTFOq+BOJ/E0/IDxjQkgHsm+sJ/x9+cUB6FoxjFMn87uRXv7jjW/YaZVB3KBm3
         3HChHuK9QBeC859l3EOg5UPdDpyyiuCCwSKPG9lsKv3pP4r6GkBAQR21spZxQp0GAuP0
         THMJRCGJa2xXbAuRV9qSaoVs/Kwv8Y95nWkvA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bfHv+wnFJIDSVQvOwn5EjMDmsgm/5A12CxCCM/SG3P6L1l/JZFEKnWvlur0qENwxMo
         KAOB7lwdP4uonz1ci/64rrbnHHlH7i2JImDGwti/j/05zczFzezOo9wizjOvEtafW5z3
         fxEcUbj9bwLmKETvAOmhXssLS8nPLz0E/u2D0=
Received: by 10.100.207.7 with SMTP id e7mr1385475ang.52.1282941023499;
        Fri, 27 Aug 2010 13:30:23 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id e18sm3996898ana.15.2010.08.27.13.30.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Aug 2010 13:30:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.409.gdbb11.dirty
In-Reply-To: <1282940896-18350-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154618>

If the topmost three commits in a branch were merge commits, 'git
format-patch -3' used to output nothing. Since Git can't prepare
patches out of merge commits anyway, don't go over them in the first
place. 'git format-patch -3' now prepares three patches from the
topmost three commits without counting merge commits. Also add a
corresponding test in t4014-format-patch and update documentation.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-format-patch.txt |    2 +-
 builtin/log.c                      |    7 +------
 t/t4014-format-patch.sh            |   16 ++++++++++++++++
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 4b3f5ba..df77474 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -74,7 +74,7 @@ OPTIONS
 include::diff-options.txt[]
 
 -<n>::
-	Limits the number of patches to prepare.
+	Prepare patches from the topmost <n> commits.
 
 -o <dir>::
 --output-directory <dir>::
diff --git a/builtin/log.c b/builtin/log.c
index eaa1ee0..22d1290 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1056,8 +1056,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.commit_format = CMIT_FMT_EMAIL;
 	rev.verbose_header = 1;
 	rev.diff = 1;
-	rev.combine_merges = 0;
-	rev.ignore_merges = 1;
+	rev.no_merges = 1;
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 	rev.subject_prefix = fmt_patch_subject_prefix;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
@@ -1228,10 +1227,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		/* ignore merges */
-		if (commit->parents && commit->parents->next)
-			continue;
-
 		if (ignore_if_in_upstream &&
 				has_commit_patch_id(commit, &ids))
 			continue;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index a77eeed..07bf6eb 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -56,6 +56,22 @@ test_expect_success "format-patch --ignore-if-in-upstream" '
 
 '
 
+test_expect_success "format-patch doesn't consider merge commits" '
+
+	git checkout -b slave master &&
+	echo "Another line" >>file &&
+	test_tick &&
+	git commit -am "Slave change #1" &&
+	echo "Yet another line" >>file &&
+	test_tick &&
+	git commit -am "Slave change #2" &&
+	git checkout -b merger master &&
+	test_tick &&
+	git merge --no-ff slave &&
+	cnt=`git format-patch -3 --stdout | grep "^From " | wc -l` &&
+	test $cnt = 3
+'
+
 test_expect_success "format-patch result applies" '
 
 	git checkout -b rebuild-0 master &&
-- 
1.7.2.2.409.gdbb11.dirty
