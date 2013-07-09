From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/7] t5533: test "push --lockref"
Date: Tue,  9 Jul 2013 12:53:29 -0700
Message-ID: <1373399610-8588-7-git-send-email-gitster@pobox.com>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
 <1373399610-8588-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 09 21:54:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uwdz2-00068J-LR
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 21:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089Ab3GITxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 15:53:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54742 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753158Ab3GITxp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 15:53:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBDA92F3D9
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 19:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=aDwK
	4Ee5lDCp1VePPM8czFIETQk=; b=mbKTeQZqKNC5vAg35fILO5OM+CcTwQie4hfo
	Z6th4QzacDgACTm0NJOzHv3+Vg6QZgVzb6J1vgad6kBOhdRWVVeXzzj4VmJ/tIuJ
	I8HCDcqDxErx/f4EEUrn5GvKot7DtA1pV7N1QhYdnj5eAHk861eV09nrT9Up6udh
	m9Fe5Zw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=rl9GiW
	YRpZSkiOsfJdWHntOJszRo9vAIZhWYBFzJTOnh3kyF+WNp0BshddwtFY+9CayZPZ
	jjmGW3DJdEyDfgowHblaJQ+PyJjqUUjmncv2/QaPcu8KphiVe7hJCpHhFlCMpqnd
	yZbabM8I0G/y80w+bboeK+zGj/fq5fV/r/5BI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E1B862F3D8
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 19:53:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1498A2F3D5
	for <git@vger.kernel.org>; Tue,  9 Jul 2013 19:53:43 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-875-g76c723c
In-Reply-To: <1373399610-8588-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 42CAC03E-E8D1-11E2-B1B1-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229994>

Prepare two repositories, src and dst, the latter of which is a
clone of the former (with tracking branches), and push from the
latter into the former, using --lockref=name (using tracking ref for
"name" when updating "name"), --lockref=name:value, --lockref=name:
(i.e. check creation), and --lockref (using tracking ref for
anything that we update).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5533-push-cas.sh | 176 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100755 t/t5533-push-cas.sh

diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
new file mode 100755
index 0000000..c080467
--- /dev/null
+++ b/t/t5533-push-cas.sh
@@ -0,0 +1,176 @@
+#!/bin/sh
+
+test_description='compare & swap push force/delete safety'
+
+. ./test-lib.sh
+
+setup_srcdst_basic () {
+	rm -fr src dst &&
+	git clone --no-local . src &&
+	git clone --no-local src dst &&
+	(
+		cd src && git checkout HEAD^0
+	)
+}
+
+test_expect_success setup '
+	: create template repository
+	test_commit A &&
+	test_commit B &&
+	test_commit C
+'
+
+test_expect_success 'push to create (protected)' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		test_commit D &&
+		test_must_fail git push --lockref=master: origin master &&
+		test_must_fail git push --force --lockref=master: origin master
+	) &&
+	>expect &&
+	git ls-remote src refs/heads/naster >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push to create (allowed)' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		test_commit D &&
+		git push --lockref=naster: origin HEAD:naster
+	) &&
+	git ls-remote dst refs/heads/master |
+	sed -e "s/master/naster/" >expect &&
+	git ls-remote src refs/heads/naster >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push to update (protected)' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		test_commit D &&
+		test_must_fail git push --lockref=master:master origin master &&
+		test_must_fail git push --force --lockref=master:master origin master
+	) &&
+	git ls-remote . refs/heads/master >expect &&
+	git ls-remote src refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push to update (protected, tracking)' '
+	setup_srcdst_basic &&
+	(
+		cd src &&
+		git checkout master &&
+		test_commit D &&
+		git checkout HEAD^0
+	) &&
+	git ls-remote src refs/heads/master >expect &&
+	(
+		cd dst &&
+		test_commit E &&
+		git ls-remote . refs/remotes/origin/master >expect &&
+		test_must_fail git push --lockref=master origin master &&
+		test_must_fail git push --force --lockref=master origin master &&
+		git ls-remote . refs/remotes/origin/master >actual &&
+		test_cmp expect actual
+	) &&
+	git ls-remote src refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push to update (allowed)' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		test_commit D &&
+		git push --lockref=master:master^ origin master
+	) &&
+	git ls-remote dst refs/heads/master >expect &&
+	git ls-remote src refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push to update (allowed, tracking)' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		test_commit D &&
+		git push --lockref=master origin master
+	) &&
+	git ls-remote dst refs/heads/master >expect &&
+	git ls-remote src refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push to update (still rejected with non-ff check)' '
+	setup_srcdst_basic &&
+	git ls-remote src refs/heads/master >expect &&
+	(
+		cd dst &&
+		git reset --hard HEAD^ &&
+		test_commit D &&
+		test_must_fail git push --lockref=master origin master
+	) &&
+	git ls-remote src refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push to delete (protected)' '
+	setup_srcdst_basic &&
+	git ls-remote src refs/heads/master >expect &&
+	(
+		cd dst &&
+		test_must_fail git push --lockref=master:master^ origin :master &&
+		test_must_fail git push --force --lockref=master:master^ origin :master
+	) &&
+	git ls-remote src refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push to delete (allowed)' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		git push --lockref=master origin :master
+	) &&
+	>expect &&
+	git ls-remote src refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cover everything with default lockref (protected)' '
+	setup_srcdst_basic &&
+	(
+		cd src &&
+		git branch naster master^
+	)
+	git ls-remote src refs/heads/\* >expect &&
+	(
+		cd dst &&
+		test_must_fail git push --lockref origin master master:naster
+	) &&
+	git ls-remote src refs/heads/\* >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cover everything with default lockref (allowed)' '
+	setup_srcdst_basic &&
+	(
+		cd src &&
+		git branch naster master^
+	)
+	(
+		cd dst &&
+		git fetch &&
+		git push --lockref origin master master:naster
+	) &&
+	git ls-remote dst refs/heads/master |
+	sed -e "s/master/naster/" >expect &&
+	git ls-remote src refs/heads/naster >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.3.2-875-g76c723c
