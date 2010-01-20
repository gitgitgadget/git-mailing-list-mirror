From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t1506: more test for @{upstream} syntax
Date: Wed, 20 Jan 2010 01:38:41 -0800
Message-ID: <1263980322-4142-2-git-send-email-gitster@pobox.com>
References: <1263980322-4142-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 10:38:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXX1d-0004sY-Nc
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 10:38:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752148Ab0ATJiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 04:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144Ab0ATJiy
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 04:38:54 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab0ATJiw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 04:38:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D42F92074;
	Wed, 20 Jan 2010 04:38:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=VNJi
	aY4wVff7T0jBdsAtzYxne+8=; b=dleRUShs3fpovLWKfuoCTV9urIpaZkOZ1dXx
	Ws5aWFvMHjddY1X3HOtj53gx24frRRrJB8DY+RiHhoqCKvz8Pp/nw11Wfdmu0Lz6
	me9GY/d2CyiUYT8VouNr4HU/Tej2Qc++dniYGClWuQSJl7S/28p5xhMi12xaBi6w
	KX4+yW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	aivWBAyRDDDMvMAFOE8lxpYqt6jobnm+p7JRwKRLmkXa0zrhBtotAp3Yw4smmGna
	8JJmxg61xbgkco8Y+kcWPo0OjY6aQJD0xQIzR4lPydLkkotRRQcwRacIWVRlCUaW
	Rx2BQcz/obVQ0UfHBJDoO+BbkcWOmGPxmVrNBI6mLRw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 56BB692071;
	Wed, 20 Jan 2010 04:38:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A15492066; Wed, 20 Jan
 2010 04:38:47 -0500 (EST)
X-Mailer: git-send-email 1.6.6.513.g63f4c
In-Reply-To: <1263980322-4142-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9D6D1E26-05A7-11DF-9556-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137529>

This adds a few more tests that exercises @{upstream} syntax by commands
that operate differently when they are given branch name as opposed to a
refname (i.e. where "master" and "refs/heads/master" makes a difference).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1506-rev-parse-upstream.sh |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/t/t1506-rev-parse-upstream.sh b/t/t1506-rev-parse-upstream.sh
index 5abdc13..a2c7f92 100755
--- a/t/t1506-rev-parse-upstream.sh
+++ b/t/t1506-rev-parse-upstream.sh
@@ -66,4 +66,45 @@ test_expect_success '@{u} without specifying branch fails on a detached HEAD' '
 	test_must_fail git rev-parse @{u}
 '
 
+test_expect_success 'checkout -b new my-side@{u} forks from the same' '
+(
+	cd clone &&
+	git checkout -b new my-side@{u} &&
+	git rev-parse --symbolic-full-name my-side@{u} >expect &&
+	git rev-parse --symbolic-full-name new@{u} >actual &&
+	test_cmp expect actual
+)
+'
+
+test_expect_failure 'merge my-side@{u} records the correct name' '
+(
+	sq="'\''" &&
+	cd clone || exit
+	git checkout master || exit
+	git branch -D new ;# can fail but is ok
+	git branch -t new my-side@{u} &&
+	git merge -s ours new@{u} &&
+	git show -s --pretty=format:%s >actual &&
+	echo "Merge remote branch ${sq}origin/side${sq}" >expect &&
+	test_cmp expect actual
+)
+'
+
+test_expect_failure 'branch -d other@{u}' '
+	git checkout -t -b other master &&
+	git branch -d @{u} &&
+	git for-each-ref refs/heads/master >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
+test_expect_failure 'checkout other@{u}' '
+	git branch -f master HEAD &&
+	git checkout -t -b another master &&
+	git checkout @{u} &&
+	git symbolic-ref HEAD >actual &&
+	echo refs/heads/master >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.6.6.513.g63f4c
