From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/15] t5520: style fixes
Date: Wed, 29 Apr 2015 14:29:21 -0700
Message-ID: <1430342973-30344-4-git-send-email-gitster@pobox.com>
References: <1430025967-24479-1-git-send-email-gitster@pobox.com>
 <1430342973-30344-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:29:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZYC-0006PM-Lr
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbbD2V3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:29:43 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750801AbbD2V3k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:29:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 43FE14DA9E;
	Wed, 29 Apr 2015 17:29:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=wpKe
	pRo3og6Vm2tjVuAkt4MeiCY=; b=Qk1Ig6p6Cb6XTmRvhXpYr7+lx7mtJJPqcvZE
	1J9jy/9fjgtqRyi++e3NbBl/EAjMeDVln/NtwblCZ/Gx7z8sciFD0l9p21jstP4H
	55ekyKWx0RbmGlYli//IZlFUs2jlEGyJdAkhpaUjViQAoTLgCZm1m6Q/MDlM6CJb
	wCf1jks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=P+x7RD
	fUhM3/tYocYf9nzxqPSE6O+36y5xwoODv0GOIdEmAU1EcuEvw4ZNKEpX1sapZ7J8
	5xNps+LOOLwUDdNZKRa28nN8NADFuywlz/P5P1pt1km6RR6gKv2NXUCrqIO1Mcza
	deZOOx0c/OzeVqjVIAtOz5hLNHlSwNQW77lFc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D2DE4DA9D;
	Wed, 29 Apr 2015 17:29:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBA3E4DA9B;
	Wed, 29 Apr 2015 17:29:38 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-300-g052d062
In-Reply-To: <1430342973-30344-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D713BD26-EEB6-11E4-BC30-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268013>

Fix style funnies in early part of this test script that checks "git
pull" into an unborn branch.  The primary change is that 'chdir' to
a newly created empty test repository is now protected by being done
in a subshell to make it more robust without having to chdir back to
the original place.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5520-pull.sh | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 227d293..5195a21 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -9,36 +9,27 @@ modify () {
 	mv "$2.x" "$2"
 }
 
-D=`pwd`
-
 test_expect_success setup '
-
 	echo file >file &&
 	git add file &&
 	git commit -a -m original
-
 '
 
 test_expect_success 'pulling into void' '
-	mkdir cloned &&
-	cd cloned &&
-	git init &&
-	git pull ..
-'
-
-cd "$D"
-
-test_expect_success 'checking the results' '
+	git init cloned &&
+	(
+		cd cloned &&
+		git pull ..
+	) &&
 	test -f file &&
 	test -f cloned/file &&
 	test_cmp file cloned/file
 '
 
 test_expect_success 'pulling into void using master:master' '
-	mkdir cloned-uho &&
+	git init cloned-uho &&
 	(
 		cd cloned-uho &&
-		git init &&
 		git pull .. master:master
 	) &&
 	test -f file &&
@@ -71,7 +62,6 @@ test_expect_success 'pulling into void does not overwrite staged files' '
 	)
 '
 
-
 test_expect_success 'pulling into void does not remove new staged files' '
 	git init cloned-staged-new &&
 	(
-- 
2.4.0-rc3-300-g052d062
