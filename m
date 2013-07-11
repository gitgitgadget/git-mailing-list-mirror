From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/6] t5533: test "push --lockref"
Date: Thu, 11 Jul 2013 15:26:20 -0700
Message-ID: <1373581580-13651-7-git-send-email-gitster@pobox.com>
References: <1373581580-13651-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 00:26:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxPKD-0002ZM-AT
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 00:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987Ab3GKW0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 18:26:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41885 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755526Ab3GKW0f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 18:26:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7283130417
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=dCcm
	kkALe7WFvOWZ8ltOLCXL8Y0=; b=phX2a99xuroN5KTzNwQZpx264DmDtpU2iCpd
	vTkiBuD6mgcrHd+8IyATg4FubIvZZxlOeknB3W9lmj28pS9NqmDvRrOsft5DpEI8
	lKWppFXv4a9+QGBENVvvt1Zfxw5ZtMMeqAYub3bl/12vpY+6+zRLCbEbmP2LVlk/
	tAziZv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=qI4IAH
	ZJW3pCv3pdhm/z4tjyCLhAng6C/0DaxJYDGOIG70G9AqJxBuVMzVHHKYGi7lGi++
	qLQID6WAdj5nMhTTnfLXR7UxD7+ORHoDo7x+SXGEKJP68V3OxgW1KQu6kXA5x22H
	3SNYMgIn7XrK8v2ejNSTubMEW+I1xukhcrv8M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6753430416
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:26:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3D16430410
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 22:26:34 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-911-g2c4daa5
In-Reply-To: <1373581580-13651-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: F1769A1A-EA78-11E2-8292-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230140>

Prepare two repositories, src and dst, the latter of which is a
clone of the former (with tracking branches), and push from the
latter into the former, using --lockref=name (using tracking ref for
"name" when updating "name"), --lockref=name:value, --lockref=name:
(i.e. check creation), and --lockref (using tracking ref for
anything that we update).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5533-push-cas.sh | 189 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 189 insertions(+)
 create mode 100755 t/t5533-push-cas.sh

diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
new file mode 100755
index 0000000..ea1c789
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
+		test_must_fail git push --lockref=master:master origin master
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
+		git push --force --lockref=master:master origin master
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
+		test_must_fail git push --lockref=master origin master &&
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
+		git push --force --lockref=master origin master
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
+test_expect_success 'push to update (allowed even though no-ff)' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		git reset --hard HEAD^ &&
+		test_commit D &&
+		git push --lockref=master origin master
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
+		test_must_fail git push --lockref=master:master^ origin :master
+	) &&
+	git ls-remote src refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push to delete (protected, forced)' '
+	setup_srcdst_basic &&
+	(
+		cd dst &&
+		git push --force --lockref=master:master^ origin :master
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
1.8.3.2-912-g65cf5cf
