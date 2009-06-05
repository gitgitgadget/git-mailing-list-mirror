From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 02/23] t5540-http-push: test fetching of packed objects
Date: Sat, 6 Jun 2009 00:00:30 +0800
Message-ID: <20090606000030.35be616e.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 18:09:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCbz9-00053w-9Z
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 18:09:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430AbZFEQIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 12:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754184AbZFEQIM
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 12:08:12 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:10154 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbZFEQIL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 12:08:11 -0400
Received: by wf-out-1314.google.com with SMTP id 26so716862wfd.4
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 09:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=XflAqflOLFTWw5Pt8nEDYPCJG5sfa90L6MrwDYuIvsI=;
        b=wIysThMbxM/NS5FgqvGtmetlgtQprUk/jnpeRj/7G47qO4Z452DPzeRp5Qn/IXEkBI
         8uMQIeOFsSj07vYCS9XTTjlObUHbyoO1ZW50cHtZn39zRlyjdwZj2WCvlo4rnpJYCsZ4
         Ia4bUG6EzNg4BUGmhQqBfNkDw/BpHkJP71Hyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=tLcPUNFVXGRT6kao0bu62BvoG0T79CqJlkWHwzN1FCEflZ71FOaN/863dtN5o/J8+h
         ORomMrQsCVRuV2geXFwWOb9MsnFkkdwBZfONywpGZ8cCXBPH0Zqw16xkMJB28+vLl4kC
         f1O9kDryzF5jZvwY0rZWaSbh/ERFaz/fdbnt4=
Received: by 10.142.49.20 with SMTP id w20mr1220654wfw.330.1244218093249;
        Fri, 05 Jun 2009 09:08:13 -0700 (PDT)
Received: from your-cukc5e3z5n (cm97.zeta149.maxonline.com.sg [116.87.149.97])
        by mx.google.com with ESMTPS id 27sm428601wfa.2.2009.06.05.09.08.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 09:08:12 -0700 (PDT)
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120781>


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
