From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/7] t0004 (unwritable files): simplify error handling
Date: Mon, 6 Sep 2010 20:50:17 -0500
Message-ID: <20100907015017.GE1182@burratino>
References: <4C85357A.8090000@web.de>
 <20100906190655.GG25426@burratino>
 <4C854B36.6010606@web.de>
 <20100907014135.GA1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 07 03:52:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsnMY-0008F8-0s
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 03:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755678Ab0IGBwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 21:52:21 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58074 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754998Ab0IGBwU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 21:52:20 -0400
Received: by ywh1 with SMTP id 1so1776434ywh.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 18:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=qveVFJpNLMTNElZ8wpBuM7Vbe4aMBNRtJPh1O5C+HPU=;
        b=ladJKdA74EMpWiTIQ7qGYufxsM3TSqnUjYtpDBQxO8zbVldVTjrVgXDGesp3/553q2
         RWKyWt9q/wy6zXml6bH8kCw566Q2HSOyvK4zbfKIP2pgnfVLX9tzLZNSCab0Djm0I3Zj
         8Ab6wGQQ2kAqxm90rHvJ1UpdIvdQTBUsBNrJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=r0qD9vwrF//EGRIwBq9OI/7yirHeGV7cv5jLSuAtG4Gz6NJ9QW9dVwnhitLGj1NYV5
         RcppbDwSiawXMsYD5B14v5T+QxChSEDPPgq/s15pZsfIN9GjY1Sf9DHwM1II9KCXM5Te
         qlwNINaIVvGBB/lOofBbpeGmjQJhot7DP6ipk=
Received: by 10.150.92.13 with SMTP id p13mr267386ybb.207.1283824339914;
        Mon, 06 Sep 2010 18:52:19 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u24sm5503320yba.9.2010.09.06.18.52.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 18:52:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100907014135.GA1182@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155662>

Instead of

	... normal test script ...
	status=$?
	... cleanup ...
	(exit $status)

set up cleanup commands with test_when_finished.  This makes the
test script a little shorter, and more importantly, it ensures errors
during cleanup are reported.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t0004-unwritable.sh |   52 +++++++++++++-----------------------------------
 1 files changed, 14 insertions(+), 38 deletions(-)

diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
index 2342ac5..3e6a334 100755
--- a/t/t0004-unwritable.sh
+++ b/t/t0004-unwritable.sh
@@ -16,53 +16,29 @@ test_expect_success setup '
 '
 
 test_expect_success POSIXPERM 'write-tree should notice unwritable repository' '
-
-	(
-		chmod a-w .git/objects .git/objects/?? &&
-		test_must_fail git write-tree
-	)
-	status=$?
-	chmod 775 .git/objects .git/objects/??
-	(exit $status)
-
+	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
+	chmod a-w .git/objects .git/objects/?? &&
+	test_must_fail git write-tree
 '
 
 test_expect_success POSIXPERM 'commit should notice unwritable repository' '
-
-	(
-		chmod a-w .git/objects .git/objects/?? &&
-		test_must_fail git commit -m second
-	)
-	status=$?
-	chmod 775 .git/objects .git/objects/??
-	(exit $status)
-
+	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
+	chmod a-w .git/objects .git/objects/?? &&
+	test_must_fail git commit -m second
 '
 
 test_expect_success POSIXPERM 'update-index should notice unwritable repository' '
-
-	(
-		echo 6O >file &&
-		chmod a-w .git/objects .git/objects/?? &&
-		test_must_fail git update-index file
-	)
-	status=$?
-	chmod 775 .git/objects .git/objects/??
-	(exit $status)
-
+	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
+	echo 6O >file &&
+	chmod a-w .git/objects .git/objects/?? &&
+	test_must_fail git update-index file
 '
 
 test_expect_success POSIXPERM 'add should notice unwritable repository' '
-
-	(
-		echo b >file &&
-		chmod a-w .git/objects .git/objects/?? &&
-		test_must_fail git add file
-	)
-	status=$?
-	chmod 775 .git/objects .git/objects/??
-	(exit $status)
-
+	test_when_finished "chmod 775 .git/objects .git/objects/??" &&
+	echo b >file &&
+	chmod a-w .git/objects .git/objects/?? &&
+	test_must_fail git add file
 '
 
 test_done
-- 
1.7.2.3
