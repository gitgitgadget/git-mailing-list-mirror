From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 11/19] fsck: Add a simple test for receive.fsck.severity
Date: Sat, 31 Jan 2015 22:05:26 +0100
Organization: gmx
Message-ID: <1104acf532dc94156ec5a83214851ea08f896899.1422737997.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1422737997.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 31 22:05:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHfEW-0004Gb-UN
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 22:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062AbbAaVFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2015 16:05:33 -0500
Received: from mout.gmx.net ([212.227.17.21]:49978 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755777AbbAaVFb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2015 16:05:31 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M2ojS-1XQO7U4AiM-00scA4; Sat, 31 Jan 2015 22:05:27
 +0100
In-Reply-To: <cover.1422737997.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:D6BY1sZhPXxeHOUloGmC1f0Jbl6VHgYxMbbkSD4xDKAjCUOt0LL
 uAit/QM31eQzgr0wWgYDNABO3dLT26faqTMR5BiYGLomFXOOB/+bXQssu/x0n0fNtmuZfyv
 iKzx6VQV1hKbNi5kEL3P058P+FRDQqPRebcDoBMcW818AeH80iUd1GzhmNmdzUkK9wEOVe2
 eDnb+uaU72xV57XDdb3rA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263215>

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t5504-fetch-receive-strict.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 69ee13c..9d49cb7 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -115,4 +115,25 @@ test_expect_success 'push with transfer.fsckobjects' '
 	test_cmp exp act
 '
 
+cat >bogus-commit <<\EOF
+tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
+author Bugs Bunny 1234567890 +0000
+committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
+
+This commit object intentionally broken
+EOF
+
+test_expect_success 'push with receive.fsck.severity = missing-email=warn' '
+	commit="$(git hash-object -t commit -w --stdin < bogus-commit)" &&
+	git push . $commit:refs/heads/bogus &&
+	rm -rf dst &&
+	git init dst &&
+	git --git-dir=dst/.git config receive.fsckobjects true &&
+	test_must_fail git push --porcelain dst bogus &&
+	git --git-dir=dst/.git config \
+		receive.fsck.severity missing-email=warn &&
+	git push --porcelain dst bogus >act 2>&1 &&
+	grep "missing-email" act
+'
+
 test_done
-- 
2.2.0.33.gc18b867
