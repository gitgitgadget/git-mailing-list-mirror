From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] ignore: make sure we have an xdg path before using it
Date: Tue, 24 Jul 2012 14:26:51 +0200
Message-ID: <1343132811-2296-1-git-send-email-Matthieu.Moy@imag.fr>
References: <20120724115357.GA7353@sigill.intra.peff.net>
Cc: peff@peff.net, Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 24 14:27:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SteD4-0007k6-Qj
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 14:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753837Ab2GXM10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 08:27:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38811 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528Ab2GXM1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 08:27:25 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q6OCP61S030887
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 24 Jul 2012 14:25:06 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SteCf-0007lX-9z; Tue, 24 Jul 2012 14:27:05 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SteCf-0000bs-6c; Tue, 24 Jul 2012 14:27:05 +0200
X-Mailer: git-send-email 1.7.11.2.402.g04c525e.dirty
In-Reply-To: <20120724115357.GA7353@sigill.intra.peff.net>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 24 Jul 2012 14:25:06 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q6OCP61S030887
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1343737510.79485@72bvrvv1IWGTXvIWmo+OVQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202035>

Commit e3ebc35 (config: fix several access(NULL) calls, 2012-07-12) was
fixing access(NULL) calls when trying to access $HOME/.config/git/config,
but missed the ones when trying to access $HOME/.config/git/ignore. Fix
and test this.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This can be appended to Jeff's serie. I thought if we had 3 bug
instances and already fixed 2, why not fix the (hopefully last)
one ;-).

 dir.c                | 2 +-
 t/t1306-xdg-files.sh | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index a772c6d..240bf0c 100644
--- a/dir.c
+++ b/dir.c
@@ -1313,7 +1313,7 @@ void setup_standard_excludes(struct dir_struct *dir)
 	}
 	if (!access(path, R_OK))
 		add_excludes_from_file(dir, path);
-	if (!access(excludes_file, R_OK))
+	if (excludes_file && !access(excludes_file, R_OK))
 		add_excludes_from_file(dir, excludes_file);
 }
 
diff --git a/t/t1306-xdg-files.sh b/t/t1306-xdg-files.sh
index 097184b..6d9e8cd 100755
--- a/t/t1306-xdg-files.sh
+++ b/t/t1306-xdg-files.sh
@@ -108,6 +108,13 @@ test_expect_success 'Exclusion in a non-XDG global ignore file' '
 	test_must_fail git add to_be_excluded
 '
 
+test_expect_success 'Checking XDG ignore file when HOME is unset' '
+	>expected &&
+	(sane_unset HOME &&
+	 git config --unset core.excludesfile &&
+	 git ls-files --exclude-standard --ignored >actual) &&
+	test_cmp expected actual
+'
 
 test_expect_success 'Checking attributes in the XDG attributes file' '
 	echo foo >f &&
-- 
1.7.11.2.402.g04c525e.dirty
