From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] t3701: Editing a split hunk in an "add -p" session
Date: Fri, 29 Apr 2011 15:49:31 -0700
Message-ID: <1304117373-592-2-git-send-email-gitster@pobox.com>
References: <1304117373-592-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 00:49:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFwVR-0007vp-Bl
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 00:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165Ab1D2Wtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 18:49:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:32786 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363Ab1D2Wtn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 18:49:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C178554F
	for <git@vger.kernel.org>; Fri, 29 Apr 2011 18:51:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=dd4N
	8DXCIcRmALFcJYt3hVKRXWk=; b=NxxOzortoY8dRacJBM+Ik3GUJJZKHc5/VcVl
	CCBVO2CCpVZ0jAKV3L+f0Z/RRpjVUZIzx/49jXsYCrCz+kmbmgBW9aYttQQu4qtU
	Jdk/0vx1FL+u+lbcxN3fOZfvSW0BywsBHzvUbMyeQubRLS7pUU5RVEGJtmAzE/Xf
	dBhgexU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=hFQtTV
	wqXdJEJ3NVQAZRo7Maok0Ekj2IqJIxpMeKctyKgr/5K2pSscLBBlEwH4st6quPn8
	qwLFEayx/KwdtbvUOLS83JAk7rWaCDOMJ/cJRiTrhk0c53XoUDszbLcJtwDxPPdG
	3YUuUHeVbPU/zqhf+RuiiFwDr+yUoiUi1Jyjg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 78CFC554E
	for <git@vger.kernel.org>; Fri, 29 Apr 2011 18:51:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CDD73554D for
 <git@vger.kernel.org>; Fri, 29 Apr 2011 18:51:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.252.g565191
In-Reply-To: <1304117373-592-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 4174C0D6-72B3-11E0-BD2A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172507>

Arnaud Lacombe reported that with the recent change to reject overlapping
hunks fed to "git apply", the edit mode of an "add -p" session that lazily
feeds overlapping hunks without coalescing adjacent ones claim that the
patch does not apply.  Expose the problem to be fixed.

Cf. http://thread.gmane.org/gmane.comp.version-control.git/170685/focus=171000

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3701-add-interactive.sh |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index d6327e7..72559e1 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -295,4 +295,40 @@ test_expect_success PERL 'deleting an empty file' '
 	test_cmp expected diff
 '
 
+test_expect_success PERL 'split hunk setup' '
+	git reset --hard &&
+	for i in 10 20 30 40 50 60
+	do
+		echo $i
+	done >test &&
+	git add test &&
+	test_tick &&
+	git commit -m test &&
+
+	for i in 10 15 20 21 22 23 24 30 40 50 60
+	do
+		echo $i
+	done >test
+'
+
+test_expect_failure PERL 'split hunk "add -p (edit)"' '
+	# Split, say Edit and do nothing.  Then:
+	#
+	# 1. Broken version results in a patch that does not apply and
+	# only takes [y/n] (edit again) so the first q is discarded
+	# and then n attempts to discard the edit. Repeat q enough
+	# times to get out.
+	#
+	# 2. Correct version applies the (not)edited version, and asks
+	#    about the next hunk, against wich we say q and program
+	#    exits.
+	for a in s e     q n q q
+	do
+		echo $a
+	done |
+	EDITOR=: git add -p &&
+	git diff >actual &&
+	! grep "^+15" actual
+'
+
 test_done
-- 
1.7.5.252.g565191
