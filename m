From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 2/3] t5540-http-push: test fetching of packed objects
Date: Sat, 25 Apr 2009 00:35:53 +0800
Message-ID: <49F1EA69.7080702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 18:41:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxOPs-0007uJ-4a
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 18:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758962AbZDXQg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 12:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758309AbZDXQg0
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 12:36:26 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:59162 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757758AbZDXQgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 12:36:25 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1071259rvb.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=JpXI4cH9G3SnhoHXooLVd86A0LYq1D+86ayR8WkDtUo=;
        b=avZTCNODd5OFfh9Wz9cHNmo7JetA5eyRJzctTyo09ETBcZTeI8Ssf6Zbayw7ertOcJ
         QEKYIH83l2vtUBoLSWc99i6Y7/13H6Ml4MTixOpgGztJJF8eIWSO7WAwVoENu/PyfOtC
         Rw2vR8qpkarzhsgs47W9Sze9WT/1OkPZRZWj0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=h2DWzYDacPtqW7Uu/heKvtgKD412LLNFRnpUfhzXr5nUCHoHA21P0ZFCMyBVHeaZq6
         tf7fd1mPTzQUulpRK6O12jFATD6iNCH5YbWsEflQykh4rUyhw2M4GDF7NlRMBff2D7BR
         ILc+J5VwdDVDukclf1HLC4uvUVw1FWvw2skO4=
Received: by 10.114.208.20 with SMTP id f20mr1459285wag.46.1240590985195;
        Fri, 24 Apr 2009 09:36:25 -0700 (PDT)
Received: from ?116.87.149.49? (cm49.zeta149.maxonline.com.sg [116.87.149.49])
        by mx.google.com with ESMTPS id k14sm1950867waf.30.2009.04.24.09.36.23
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Apr 2009 09:36:24 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117467>

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
1.6.3.rc0
