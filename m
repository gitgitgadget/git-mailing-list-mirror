From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t0003: do not chdir the whole test process
Date: Thu,  6 Feb 2014 10:40:32 -0800
Message-ID: <1391712033-9443-1-git-send-email-gitster@pobox.com>
References: <xmqqvbwsyvn8.fsf@gitster.dls.corp.google.com>
Cc: Lasse Makholm <lasse.makholm@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 06 19:40:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBTsR-0008OR-E0
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 19:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbaBFSkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 13:40:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51269 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751336AbaBFSki (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 13:40:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9EEC686ED;
	Thu,  6 Feb 2014 13:40:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xnXB
	ogRy33IbYZ3iMIBfcbo17BQ=; b=vcPmyKFdZDNVSGX0Q1SumHWPFY7OCKlNO+Sv
	crWkLgoBel9OQGA63gX5dv4bth4+bZWEkSn+b+UJh+C5mSjjxWWpJUGN2vUkl3Qv
	HD8kPzAeJSr/8nJrpH7RhuFtuF8vkDQVVr5u3JZD7ZCW+yG/Ip6Jguzt05ZkmBtQ
	wXHqZZo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	dDGyk+AuBtZh/sYJIHPWlVPB5c93w/3Iz90QHCN2XkyqSX8zPZkpi6LtzJUiFGnc
	mW0utYkg2E1Jmnn6NHHk8JLYylx6ofxgml70sEAJ+c1kdneGa9zQDBKTy5c32Cz/
	ICfevw7OzgM82pl8Tki4/L9j70RBhFPiruBrlP6BdrM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8791E686EC;
	Thu,  6 Feb 2014 13:40:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACB78686E8;
	Thu,  6 Feb 2014 13:40:36 -0500 (EST)
X-Mailer: git-send-email 1.9-rc2-233-ged4ee9f
In-Reply-To: <xmqqvbwsyvn8.fsf@gitster.dls.corp.google.com>
X-Pobox-Relay-ID: 2B495B8A-8F5E-11E3-8145-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241708>

Moving to some other directory and letting the remainder of the test
pieces to expect that they start there is a bad practice.  The test
that contains chdir itself may fail (or by mistake skipped via the
GIT_SKIP_TESTS mechanism) in which case the remainder may operate on
files in unexpected places.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is purely a preparatory clean-up in the test script I'll be
   adding a new test to in the next patch.

 t/t0003-attributes.sh | 52 +++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index febc45c..0554b13 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -197,39 +197,47 @@ test_expect_success 'root subdir attribute test' '
 '
 
 test_expect_success 'setup bare' '
-	git clone --bare . bare.git &&
-	cd bare.git
+	git clone --bare . bare.git
 '
 
 test_expect_success 'bare repository: check that .gitattribute is ignored' '
 	(
-		echo "f	test=f"
-		echo "a/i test=a/i"
-	) >.gitattributes &&
-	attr_check f unspecified &&
-	attr_check a/f unspecified &&
-	attr_check a/c/f unspecified &&
-	attr_check a/i unspecified &&
-	attr_check subdir/a/i unspecified
+		cd bare.git &&
+		(
+			echo "f	test=f"
+			echo "a/i test=a/i"
+		) >.gitattributes &&
+		attr_check f unspecified &&
+		attr_check a/f unspecified &&
+		attr_check a/c/f unspecified &&
+		attr_check a/i unspecified &&
+		attr_check subdir/a/i unspecified
+	)
 '
 
 test_expect_success 'bare repository: check that --cached honors index' '
-	GIT_INDEX_FILE=../.git/index \
-	git check-attr --cached --stdin --all <../stdin-all |
-	sort >actual &&
-	test_cmp ../specified-all actual
+	(
+		cd bare.git &&
+		GIT_INDEX_FILE=../.git/index \
+		git check-attr --cached --stdin --all <../stdin-all |
+		sort >actual &&
+		test_cmp ../specified-all actual
+	)
 '
 
 test_expect_success 'bare repository: test info/attributes' '
 	(
-		echo "f	test=f"
-		echo "a/i test=a/i"
-	) >info/attributes &&
-	attr_check f f &&
-	attr_check a/f f &&
-	attr_check a/c/f f &&
-	attr_check a/i a/i &&
-	attr_check subdir/a/i unspecified
+		cd bare.git &&
+		(
+			echo "f	test=f"
+			echo "a/i test=a/i"
+		) >info/attributes &&
+		attr_check f f &&
+		attr_check a/f f &&
+		attr_check a/c/f f &&
+		attr_check a/i a/i &&
+		attr_check subdir/a/i unspecified
+	)
 '
 
 test_done
-- 
1.9-rc2-233-ged4ee9f
