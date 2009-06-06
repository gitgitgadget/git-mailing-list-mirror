From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 02/23] t5540-http-push: test fetching of packed objects
Date: Sat, 6 Jun 2009 16:43:24 +0800
Message-ID: <20090606164324.c0a5e319.rctay89@gmail.com>
References: <cover.1244277116.git.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 10:48:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCrZx-0003d4-Uv
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 10:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbZFFIsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2009 04:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525AbZFFIsV
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 04:48:21 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:5748 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbZFFIsU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2009 04:48:20 -0400
Received: by wf-out-1314.google.com with SMTP id 26so882106wfd.4
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 01:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=XflAqflOLFTWw5Pt8nEDYPCJG5sfa90L6MrwDYuIvsI=;
        b=kpvLHH5vV//iVWfIKncFvKqVSSE9vQqKky8o2s2KDNdfQkEJmbQd7UofYC6o1irgKn
         QqOGJ4Re2xnPH/XrF08aldcY/FUoyWlClVqII/Wp3eHr3okaRSptmXk12OyS8u/RYC01
         GnDpe/gZae79d7qVhNW7y/iKAqxvkSaUh+g28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=UDlYdvWdH4bB3MHN+e6gl9eb/K+O86eIx4JbasCOQQAn12qWc6EClJF4QY4RoEz7GE
         CSeIGtT1or+ZQoKyfb8QBC9DY3mUrP2jS8lpVWC2Qr9QEQKitVG8JEpJ5k4J1g4pebb0
         ZKhNZXQ6QjSTQ5DKTpUQY15ZE61aDuykV66J0=
Received: by 10.142.77.7 with SMTP id z7mr1636790wfa.272.1244278102269;
        Sat, 06 Jun 2009 01:48:22 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 28sm2712580wfg.25.2009.06.06.01.48.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Jun 2009 01:48:21 -0700 (PDT)
In-Reply-To: <cover.1244277116.git.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120883>


Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5540-http-push.sh |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 65a41db..ad0f14b 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -83,6 +83,26 @@ test_expect_failure 'http-push fetches unpacked objects' '
 	 git push -f -v $HTTPD_URL/test_repo_unpacked.git master)
 '

+test_expect_failure 'http-push fetches packed objects' '
+	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
+		"$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_packed.git &&
+
+	git clone $HTTPD_URL/test_repo_packed.git \
+		"$ROOT_PATH"/test_repo_clone_packed &&
+
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_packed.git &&
+	 git --bare repack &&
+	 git --bare prune-packed) &&
+
+	# By reset, we force git to retrieve the packed object
+	(cd "$ROOT_PATH"/test_repo_clone_packed &&
+	 git reset --hard HEAD^ &&
+	 git remote rm origin &&
+	 git reflog expire --expire=0 --all &&
+	 git prune &&
+	 git push -f -v $HTTPD_URL/test_repo_packed.git master)
+'
+
 test_expect_success 'create and delete remote branch' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	git checkout -b dev &&
--
1.6.3.1
