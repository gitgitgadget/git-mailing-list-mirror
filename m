From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 1/2] t/t5400: demonstrate breakage caused by informational message from prune
Date: Mon,  6 Aug 2012 22:01:48 -0700
Message-ID: <1344315709-15897-1-git-send-email-drafnel@gmail.com>
References: <CA+sFfMdXc+usFRnCNVoke91_X2qWZARTvPHO=B7Ukxr-j7JB2g@mail.gmail.com>
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Aug 07 07:02:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SybwS-000708-07
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 07:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188Ab2HGFCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 01:02:06 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35330 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab2HGFCF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 01:02:05 -0400
Received: by yenl2 with SMTP id l2so3293673yen.19
        for <git@vger.kernel.org>; Mon, 06 Aug 2012 22:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=eRQEW5V+w7OYKJuFvS+RIxW5d2orvH9K6cduXVq0LQg=;
        b=vpGt0AR3wMcYKoOWri944YC5VrCFbXShSnGYlW5uOB20W8C4WgK1xJNCSiZcHRpfxt
         K3llD8YtadyO7BGtKHS2GJHotGCczDIpTcUlky/OtlPlhtzmPXznB2GBwYMJ900zZo6Q
         zN1sWEsG7eN69DhTq/SwjSGleHtC2tNAj+r3bFVs1HIzVDGi33+iSciZuDMFz12FcB73
         XlovmPA7PDzbcZ42PPD/oUNBXHx8beMpDTQduAJWHaMzg7/9Dz2ePrFnZPEBrmL9i56i
         4BIjcWfiqDJadJwZRsamPsKSy1xXHyEIIefnXHtf0AGdiIEWcntHwSOtSUuRb/yy4blL
         qhDQ==
Received: by 10.66.73.7 with SMTP id h7mr23257084pav.34.1344315723714;
        Mon, 06 Aug 2012 22:02:03 -0700 (PDT)
Received: from charliebrown.gateway.2wire.net (adsl-108-91-67-189.dsl.pltn13.sbcglobal.net. [108.91.67.189])
        by mx.google.com with ESMTPS id px1sm10375777pbb.49.2012.08.06.22.02.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Aug 2012 22:02:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.rc1.17.g9a7365c
In-Reply-To: <CA+sFfMdXc+usFRnCNVoke91_X2qWZARTvPHO=B7Ukxr-j7JB2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203012>

When receive-pack triggers 'git gc --auto' and 'git prune' is called to
remove a stale temporary object, 'git prune' prints an informational
message to stdout about the file that it will remove.  Since this message
is written to stdout, it is sent back over the transport channel to the git
client which tries to interpret it as part of the pack protocol and then
promptly terminates with a complaint about a protocol error.

Introduce a test which exercises the auto-gc functionality of receive-pack
and demonstrates this breakage.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t5400-send-pack.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 0eace37..04a8791 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -145,6 +145,41 @@ test_expect_success 'push --all excludes remote-tracking hierarchy' '
 	)
 '
 
+test_expect_failure 'receive-pack runs auto-gc in remote repo' '
+	rm -rf parent child &&
+	git init parent &&
+	(
+	    # Setup a repo with 2 packs
+	    cd parent &&
+	    echo "Some text" >file.txt &&
+	    git add . &&
+	    git commit -m "Initial commit" &&
+	    git repack -adl &&
+	    echo "Some more text" >>file.txt &&
+	    git commit -a -m "Second commit" &&
+	    git repack
+	) &&
+	cp -a parent child &&
+	(
+	    # Set the child to auto-pack if more than one pack exists
+	    cd child &&
+	    git config gc.autopacklimit 1 &&
+	    git branch test_auto_gc &&
+	    # And create a file that follows the temporary object naming
+	    # convention for the auto-gc to remove
+	    : >.git/objects/tmp_test_object &&
+	    test-chmtime =-1209601 .git/objects/tmp_test_object
+	) &&
+	(
+	    cd parent &&
+	    echo "Even more text" >>file.txt &&
+	    git commit -a -m "Third commit" &&
+	    git send-pack ../child HEAD:refs/heads/test_auto_gc >output 2>&1 &&
+	    grep "Auto packing the repository for optimum performance." output
+	) &&
+	test ! -e child/.git/objects/tmp_test_object
+'
+
 rewound_push_setup() {
 	rm -rf parent child &&
 	mkdir parent &&
-- 
1.7.12.rc1.17.g9a7365c
