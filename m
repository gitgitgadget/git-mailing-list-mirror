From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 1/2] t6031: Add a testcase covering multiple renames across a D/F conflict
Date: Tue, 17 Aug 2010 17:53:18 -0600
Message-ID: <1282089199-17253-2-git-send-email-newren@gmail.com>
References: <1282089199-17253-1-git-send-email-newren@gmail.com>
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 01:52:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlVwt-0006gP-5F
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 01:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013Ab0HQXvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 19:51:52 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:61327 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab0HQXvs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 19:51:48 -0400
Received: by qyk9 with SMTP id 9so391980qyk.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 16:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=XnbfBoBJqhgJ/xVxmlUJF33sWwshZSezoheu2mbaVEk=;
        b=BIFAyfjWbghm6U+GUr689QyjqH25hMagobx4iX82ZH0GpDzHZ6CAwuwGAeAE9bx5vY
         huWr9AqYeWs/tiEKbunYIMkA3QAKM95xKDoAd/41lo6zPGZHuP1DvwUWJGQxjxjfYFWb
         BaOjqrF2UXvS7m0xJHbS7w4bavDjnbn4KhG6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=w3oOqrmw3srsujUu1hHsf6S6p3YQ8NQznvBMfHJY+xKCl5jM0KmoSJ2XnR8vBgcG9D
         b2FfMjT2RvXrNoF6ZLUgQ/GCm2pWVeuvsSKixBLtt+vPccnOrYX0N/5nG6IC2Z7IhzzT
         Y5rGLr8OxiLUNcFiGw+I92FM/rwONPy6xZDs0=
Received: by 10.224.2.213 with SMTP id 21mr4910347qak.14.1282089108162;
        Tue, 17 Aug 2010 16:51:48 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r36sm9427471qcs.3.2010.08.17.16.51.46
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 16:51:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.227.g086c8
In-Reply-To: <1282089199-17253-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153795>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6031-merge-recursive.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/t/t6031-merge-recursive.sh b/t/t6031-merge-recursive.sh
index 8a3304f..aa235b9 100755
--- a/t/t6031-merge-recursive.sh
+++ b/t/t6031-merge-recursive.sh
@@ -57,4 +57,32 @@ test_expect_success FILEMODE 'verify executable bit on file' '
 	test -x file2
 '
 
+test_expect_failure 'merging with triple rename across D/F conflict' '
+	git reset --hard HEAD &&
+	git checkout --orphan main &&
+	git rm -rf . &&
+
+	echo "just a file" > sub1 &&
+	mkdir -p sub2 &&
+	echo content > sub2/file1 &&
+	echo content > sub2/file2 &&
+	echo content > sub2/file3 &&
+	mkdir simple &&
+	echo base > simple/bar &&
+	git add -A &&
+	git commit -m base &&
+
+	git checkout -b other &&
+	echo more >> simple/bar &&
+	git commit -a -m changesimplefile &&
+
+	git checkout main &&
+	git rm sub1 &&
+	git mv sub2 sub1 &&
+	git commit -m changefiletodir &&
+
+	git merge other
+'
+
+
 test_done
-- 
1.7.2.1.227.g086c8
