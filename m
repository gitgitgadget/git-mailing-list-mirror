From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/7] t5505: fix "set-head --auto with ambiguous HEAD" test
Date: Tue, 17 Sep 2013 22:14:17 -0700
Message-ID: <1379481263-29903-2-git-send-email-gitster@pobox.com>
References: <1379481263-29903-1-git-send-email-gitster@pobox.com>
Cc: Andreas Krey <a.krey@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 18 07:14:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMA69-0005p5-Vw
	for gcvg-git-2@plane.gmane.org; Wed, 18 Sep 2013 07:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534Ab3IRFOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Sep 2013 01:14:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50951 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256Ab3IRFO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Sep 2013 01:14:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D8A13C934;
	Wed, 18 Sep 2013 05:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=q5Ua
	lMyHWet/pmrKZJpuoRfrJ/I=; b=WuS/cGU40Up+i+mNAVUZi1VCf8VOjFgE4T9/
	QtUjr1Kt3LNHp2lR3cpsybwqKd1RKXVCS27Y0fdChot9GBv/AlrOQNjQib0zni9F
	HomjDji4dihSdUmJK/PUQDXeUH4EMt9ocu5bgg/X4GSOtzwfOcurfC5bgpjcruaV
	1rc2G70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	bXtphPqX6GJyFurI5oukVnFvkDACYeok4AO1wjHVmADrSYmbfaX1TGS8IU9ZHMsE
	JOUNJvxFtWYpdED3782EXONWfQtC5bY3oqCMOZM9zBEpHbCAE51xZwC8y6FusYJ4
	ZJJMxrdZRPqsmADNSKEPFsbpoUh23F7+XkDWeQ2ej5Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2166E3C933;
	Wed, 18 Sep 2013 05:14:28 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 637533C930;
	Wed, 18 Sep 2013 05:14:27 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-585-g8d1dcaf
In-Reply-To: <1379481263-29903-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 30B133C4-2021-11E3-AE1E-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234951>

When two or more branches point at the same commit and HEAD is
pointing at one of them, without the symref extension, there is no
way to remotely tell which one of these branches HEAD points at.
The test in question attempts to make sure that this situation is
diagnosed and results in a failure.

However, even if there _were_ a way to reliably tell which branch
the HEAD points at, "set-head --auto" would fail if there is no
remote tracking branch.  Make sure that this test does not fail
for that "wrong" reason.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * New in this round.

 t/t5505-remote.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 8f6e392..197d3f7 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -271,6 +271,7 @@ EOF
 test_expect_success 'set-head --auto fails w/multiple HEADs' '
 	(
 		cd test &&
+		git fetch two "refs/heads/*:refs/remotes/two/*" &&
 		test_must_fail git remote set-head --auto two >output 2>&1 &&
 		test_i18ncmp expect output
 	)
-- 
1.8.4-585-g8d1dcaf
