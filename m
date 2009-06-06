From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 01/23] t5540-http-push: test fetching of loose objects
Date: Sat, 6 Jun 2009 16:43:23 +0800
Message-ID: <20090606164323.471f5224.rctay89@gmail.com>
References: <cover.1244277116.git.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 10:48:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCrZe-0003VA-CS
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:48:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486AbZFFIsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 04:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbZFFIsQ
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:48:16 -0400
Received: from mail-pz0-f171.google.com ([209.85.222.171]:57058 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbZFFIsP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 04:48:15 -0400
Received: by mail-pz0-f171.google.com with SMTP id 1so1305125pzk.33
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 01:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=2hUFi1R6ogGDYUHfUX9U2b3WwN74O8hyAv4meMeIHY8=;
        b=KS7s5TO3kziQufFxrW1V7JDlB0OfW2eu4zbFfsKroVA9jNWLwEQzXDgaT+mkM0nCJO
         Y0Z1814u82ju4qcKM2suM03tU0HEhcl2eWAIk+K8N8xWfW8b0l84CoaCWCPSolBdNUR6
         ksEVQ1lYQS9jt1p5R+ZZMrUrLkdYNo31nJDy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=r94b03Q6JhrRsOa+tykQHPdS47VeN5OZIGgq4jhi3K/n5T7tVi4KY3ThozpQMRssIJ
         zU7zLQxEPf7/vUQS7iTxQSbTxDIUZ2BznMUSPW6U9yVM6nZAQOfWzuplPecMdqc9iVFE
         c/HBa4sJyOPu7gTwKhMiEK0XeW91flykLSK30=
Received: by 10.142.154.9 with SMTP id b9mr1486485wfe.151.1244278098095;
        Sat, 06 Jun 2009 01:48:18 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 28sm2712417wfg.25.2009.06.06.01.48.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 01:48:17 -0700 (PDT)
In-Reply-To: <cover.1244277116.git.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120881>


Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5540-http-push.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 5fe479e..65a41db 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -67,6 +67,22 @@ test_expect_success ' push to remote repository with unpacked refs' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '

+test_expect_failure 'http-push fetches unpacked objects' '
+	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
+		"$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_unpacked.git &&
+
+	git clone $HTTPD_URL/test_repo_unpacked.git \
+		"$ROOT_PATH"/fetch_unpacked &&
+
+	# By reset, we force git to retrieve the object
+	(cd "$ROOT_PATH"/fetch_unpacked &&
+	 git reset --hard HEAD^ &&
+	 git remote rm origin &&
+	 git reflog expire --expire=0 --all &&
+	 git prune &&
+	 git push -f -v $HTTPD_URL/test_repo_unpacked.git master)
+'
+
 test_expect_success 'create and delete remote branch' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	git checkout -b dev &&
--
1.6.3.1
