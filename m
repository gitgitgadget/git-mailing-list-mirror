From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] Add "partial commit" tests during a conflicted merge
Date: Thu, 22 Jan 2009 22:17:53 -0800
Message-ID: <7vbpty4kby.fsf_-_@gitster.siamese.dyndns.org>
References: <4978202C.3090703@viscovery.net>
 <alpine.DEB.2.00.0901211549070.15860@vellum.laroia.net>
 <49779521.9040208@drmicha.warpmail.net>
 <c1a864630901211346j4b702fb3tcc5a098ed7e1541d@mail.gmail.com>
 <20090123094509.6117@nanako3.lavabit.com>
 <7viqo64kfo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Nathan Yergler <nathan@creativecommons.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Asheesh Laroia <asheesh@asheesh.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 07:20:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQFOZ-0001Zk-Oz
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 07:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbZAWGSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 01:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761734AbZAWGSF
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 01:18:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60896 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761755AbZAWGSD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 01:18:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 29ED41D1E1;
	Fri, 23 Jan 2009 01:18:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D844B1D1E0; Fri,
 23 Jan 2009 01:17:54 -0500 (EST)
In-Reply-To: <7viqo64kfo.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 22 Jan 2009 22:15:39 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 969F6FEA-E915-11DD-878E-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106839>

We are supposed to reject "--only path..." aka "a partial commit" during a
conflicted merge resolution, and accept "--include path..." aka "an also
commit" in such a case.

Recent git (since v1.3.0) always assumes that "git commit" with paths but
without --only nor --include requests the "--only" semantics, but there is
a discussion that it might be a good idea to assume "--include" semantics
during a merge.

The last test this commit adds expects such a behaviour and marked as
"expect_failure".  It will be changed by the third patch in the series.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7501-commit.sh |   44 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index b4e2b4d..0c10105 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -365,4 +365,48 @@ test_expect_success 'amend using the message from a commit named with tag' '
 
 '
 
+test_expect_success 'setup merge commit with paths test' '
+	git reset --hard &&
+	git checkout HEAD^0 &&
+	echo frotz >file &&
+	test_tick &&
+	git add file &&
+	git commit -a -m "one side says frotz" &&
+	git tag one-side-says-frotz &&
+	git reset --hard HEAD^ &&
+	echo nitfol >file &&
+	test_tick &&
+	git add file &&
+	git commit -a -m "the other side says nitfol" &&
+	git tag the-other-side-says-nitfol
+'
+
+test_expect_success 'reject --only during a merge' '
+	git checkout HEAD^0 &&
+	git reset --hard the-other-side-says-nitfol &&
+	test_must_fail git merge one-side-says-frotz &&
+	echo yomin-only >file &&
+	test_must_fail git commit -m merge --only file &&
+	git reset --hard
+'
+
+test_expect_success 'allow --include during a merge' '
+	git checkout HEAD^0 &&
+	git reset --hard the-other-side-says-nitfol &&
+	test_must_fail git merge one-side-says-frotz &&
+	echo yomin-include >file &&
+	git commit -m merge --include file &&
+	git reset --hard
+'
+
+test_expect_failure 'assume --include during a merge' '
+	git checkout HEAD^0 &&
+	git reset --hard the-other-side-says-nitfol &&
+	test_must_fail git merge one-side-says-frotz &&
+	echo yomin-assumed >file &&
+	git add file &&
+	git commit -m merge file &&
+	git reset --hard
+'
+
 test_done
-- 
1.6.1.265.g9a013
