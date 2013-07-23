From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 6/6] t5533: test "push --force-with-lease"
Date: Mon, 22 Jul 2013 23:43:20 -0700
Message-ID: <1374561800-938-7-git-send-email-gitster@pobox.com>
References: <1374561800-938-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 23 08:43:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1WK5-0002Yj-QB
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 08:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754206Ab3GWGnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 02:43:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35843 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752664Ab3GWGnf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 02:43:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E0B124A23
	for <git@vger.kernel.org>; Tue, 23 Jul 2013 06:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=ATKg
	jyXVhyOvxFsVPFPcjHGQClQ=; b=K3EkN7eriFrVyDE1uYUDBSfPAIVJF6UJ11Fg
	EYEH0Vzhhgzif8AzR4bJOwaHHRwx/VUyqvAwEaw9eKSAStzB1kjW9VDnqRCZSm46
	eDXllXlW9jiL8LWcjduCrBbxNXQHbKT5sokxuP0Wc9K3E8keuETUfk56ZQBXq36R
	9lNP2O8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=rbOIWc
	bHHW3yj1tf8RWI5U9BwRBRA030o4AYAP+xFeZOhPvpgC/aFGLiHS7IrsUt5goONP
	kcHcJ+Yx/V1NMW3N73j6CZ4J0JD2r8neJ0m4aiZ7m7FWFahc44EfkY+71JnH6zF0
	k1mg4hJAJFUorsYWfO6wTlTWM847dYW0v+ock=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 353C624A21
	for <git@vger.kernel.org>; Tue, 23 Jul 2013 06:43:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 699F124A1F
	for <git@vger.kernel.org>; Tue, 23 Jul 2013 06:43:34 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.4-985-g5661af8
In-Reply-To: <1374561800-938-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 32383CA0-F363-11E2-83E1-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231022>

Prepare two repositories, src and dst, the latter of which is a
clone of the former (with tracking branches), and push from the
latter into the former, with various --force-with-lease options.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5533-push-cas.sh | 189 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)
 create mode 100755 t/t5533-push-cas.sh

diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
new file mode 100755
index 0000000..ba20d83
--- /dev/null
+++ b/t/t5533-push-cas.sh
@@ -0,0 +1,189 @@
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
+test_expect_success 'push to update (protected)' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		test_commit D &&
+		test_must_fail git push --force-with-lease=master:master origin master
+	) &&
+	git ls-remote . refs/heads/master >expect &&
+	git ls-remote src refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push to update (protected, forced)' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		test_commit D &&
+		git push --force --force-with-lease=master:master origin master
+	) &&
+	git ls-remote dst refs/heads/master >expect &&
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
+		test_must_fail git push --force-with-lease=master origin master &&
+		git ls-remote . refs/remotes/origin/master >actual &&
+		test_cmp expect actual
+	) &&
+	git ls-remote src refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push to update (protected, tracking, forced)' '
+	setup_srcdst_basic &&
+	(
+		cd src &&
+		git checkout master &&
+		test_commit D &&
+		git checkout HEAD^0
+	) &&
+	(
+		cd dst &&
+		test_commit E &&
+		git ls-remote . refs/remotes/origin/master >expect &&
+		git push --force --force-with-lease=master origin master
+	) &&
+	git ls-remote dst refs/heads/master >expect &&
+	git ls-remote src refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push to update (allowed)' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		test_commit D &&
+		git push --force-with-lease=master:master^ origin master
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
+		git push --force-with-lease=master origin master
+	) &&
+	git ls-remote dst refs/heads/master >expect &&
+	git ls-remote src refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push to update (allowed even though no-ff)' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		git reset --hard HEAD^ &&
+		test_commit D &&
+		git push --force-with-lease=master origin master
+	) &&
+	git ls-remote dst refs/heads/master >expect &&
+	git ls-remote src refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push to delete (protected)' '
+	setup_srcdst_basic &&
+	git ls-remote src refs/heads/master >expect &&
+	(
+		cd dst &&
+		test_must_fail git push --force-with-lease=master:master^ origin :master
+	) &&
+	git ls-remote src refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push to delete (protected, forced)' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		git push --force --force-with-lease=master:master^ origin :master
+	) &&
+	>expect &&
+	git ls-remote src refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push to delete (allowed)' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		git push --force-with-lease=master origin :master
+	) &&
+	>expect &&
+	git ls-remote src refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cover everything with default force-with-lease (protected)' '
+	setup_srcdst_basic &&
+	(
+		cd src &&
+		git branch naster master^
+	)
+	git ls-remote src refs/heads/\* >expect &&
+	(
+		cd dst &&
+		test_must_fail git push --force-with-lease origin master master:naster
+	) &&
+	git ls-remote src refs/heads/\* >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'cover everything with default force-with-lease (allowed)' '
+	setup_srcdst_basic &&
+	(
+		cd src &&
+		git branch naster master^
+	)
+	(
+		cd dst &&
+		git fetch &&
+		git push --force-with-lease origin master master:naster
+	) &&
+	git ls-remote dst refs/heads/master |
+	sed -e "s/master/naster/" >expect &&
+	git ls-remote src refs/heads/naster >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.8.3.4-980-g8decd39
