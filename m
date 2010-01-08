From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v4 1/6] t5541-http-push.sh: add tests for non-fast-forward pushes
Date: Fri,  8 Jan 2010 10:12:40 +0800
Message-ID: <1262916765-3728-2-git-send-email-rctay89@gmail.com>
References: <1262916765-3728-1-git-send-email-rctay89@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 03:13:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NT4M2-0005K8-9W
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 03:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290Ab0AHCNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2010 21:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195Ab0AHCNU
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jan 2010 21:13:20 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:35828 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168Ab0AHCNT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2010 21:13:19 -0500
Received: by yxe26 with SMTP id 26so18313338yxe.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2010 18:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=y0WM6oDnE49zcGeghlgTBJM9walYrfaLku9/A3o8BbE=;
        b=hdXgq++J+L77/53iHnjWob/APGwfVQLsLuq41ScaHGVjxtO3Xd0YqB6/p2sNr/1eqf
         /I3HQfKVfMq2YhP3nTxLTol820KhaU7JOvHvDIYB4IREJvBz4H64kjG34uB4/+TLdPHD
         D+8lJ32JZ1bel4X5Yf7YQ8YOatlnKQM13SS7A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=L4HB8HOmZGqLMm99Nopc3WkMsDpRfZqzd6y8ewPHzEw52ICx6QLR6faGd3W3ftQ0wl
         n3cr1uXkiIdpz70EqF4DOppaW+XtXk8baHPw0XBvz2WczCnX2J1ubXqIlcTJ6AI3HCo8
         eB07UBpi+S2+SumJLICwG1oc1iqhbQGsL/Pww=
Received: by 10.101.113.1 with SMTP id q1mr1043578anm.115.1262916798868;
        Thu, 07 Jan 2010 18:13:18 -0800 (PST)
Received: from localhost.localdomain (cm154.zeta152.maxonline.com.sg [116.87.152.154])
        by mx.google.com with ESMTPS id 14sm10999449gxk.10.2010.01.07.18.13.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 07 Jan 2010 18:13:18 -0800 (PST)
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1262916765-3728-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136406>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5541-http-push.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 2a58d0c..f49c7c4 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -88,5 +88,28 @@ test_expect_success 'used receive-pack service' '
 	test_cmp exp act
 '
 
+test_expect_success 'non-fast-forward push fails' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	git checkout master &&
+	echo "changed" > path2 &&
+	git commit -a -m path2 --amend &&
+
+	HEAD=$(git rev-parse --verify HEAD) &&
+	!(git push -v origin >output 2>&1) &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	 test $HEAD != $(git rev-parse --verify HEAD))
+'
+
+test_expect_failure 'non-fast-forward push show ref status' '
+	grep "^ ! \[rejected\][ ]*master -> master (non-fast-forward)$" output
+'
+
+test_expect_failure 'non-fast-forward push shows help message' '
+	grep \
+"To prevent you from losing history, non-fast-forward updates were rejected
+Merge the remote changes before pushing again.  See the '"'non-fast-forward'"'
+section of '"'git push --help'"' for details." output
+'
+
 stop_httpd
 test_done
-- 
1.6.6.341.ga7aec
