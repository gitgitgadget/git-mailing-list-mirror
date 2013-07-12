From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] add a testcase for checking case insensitivity of mailmap
Date: Fri, 12 Jul 2013 14:38:55 -0700
Message-ID: <1373665135-32484-5-git-send-email-gitster@pobox.com>
References: <1373665135-32484-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 12 23:39:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uxl3l-0003fa-Ba
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 23:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965499Ab3GLVjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 17:39:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42708 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965486Ab3GLVjF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 17:39:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EFB23033A
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 21:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=pR+0
	Peg6sJsxzaGvgLhSiKDc+KM=; b=R/thJWsTLnZV+i+t9GkA+K4Fg5zS96LijAvn
	BucQ6sXeUbpNLptF9lmlIXoEsCpSf3XeN47z8Xi6XDVkEgQLpVrC4Z2zNVIeL3i1
	Lyj76BdOZU8sh+PJmGalVCay8T44vlLhZRFI5GJoDQ5YvCrgFJg3jIgVcZdZ0Gp9
	VHxZ4/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=jYpYYs
	cBg85+qxUr/csKyTe/25aXT7g8U6PjROz7XlgFl3E0ZipG3IwbJiiHGTI63mikUC
	MlElXWFgOo3/KesEczJm6AeJG0zh8nG+QiGasCfAyIguuqrzU6w08KSuELppBHt1
	82MEHlA7hGlVts/dIixJhB5vSeTe4dYVDuCM8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3561A30339
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 21:39:05 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CC5430335
	for <git@vger.kernel.org>; Fri, 12 Jul 2013 21:39:04 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-941-gda9c3c8
In-Reply-To: <1373665135-32484-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 795655CA-EB3B-11E2-A7B7-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230260>

From: Stefan Beller <stefanbeller@googlemail.com>

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4203-mailmap.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 842b754..07152e9 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -409,4 +409,37 @@ test_expect_success 'Blame output (complex mapping)' '
 	test_cmp expect actual.fuzz
 '
 
+test_expect_success 'cleanup after mailmap.blob tests' '
+	rm -f .mailmap
+'
+
+cat >expect <<\EOF
+     2	A <A@example.org>
+     2	Other Author <other@author.xx>
+     2	Santa Claus <santa.claus@northpole.xx>
+     1	A U Thor <author@example.com>
+     1	CTO <cto@company.xx>
+     1	Some Dude <some@dude.xx>
+EOF
+
+test_expect_success 'Test case sensitivity of Names' '
+	# do a commit:
+	echo "asdf" > test1
+	git add test1
+	git commit -a --author="A <A@example.org>" -m "add test1"
+
+	# commit with same name, but different email
+	# (different capitalization does the trick already,
+	# but here I am going to use a different mail)
+	echo "asdf" > test2
+	git add test2
+	git commit -a --author="A <changed_email@example.org>" -m "add test2"
+
+	# Adding the line to the mailmap should make life easy, so we know
+	# it is the same person
+	echo "A <A@example.org> <changed_email@example.org>" > .mailmap
+
+	git shortlog -sne HEAD >actual && test_cmp expect actual
+'
+
 test_done
-- 
1.8.3.2-941-gda9c3c8
