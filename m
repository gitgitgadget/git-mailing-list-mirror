From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] git-merge: test octopus with redundant parents
Date: Tue, 17 Apr 2012 13:34:43 -0700
Message-ID: <1334694886-27756-2-git-send-email-gitster@pobox.com>
References: <1334694886-27756-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 22:34:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKF72-0006fv-ID
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 22:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252Ab2DQUew convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 16:34:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64893 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101Ab2DQUev convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 16:34:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9885F62A5;
	Tue, 17 Apr 2012 16:34:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3ox0PNcekmtp
	KuqyM+x2lU4p/Hw=; b=MSnL5okbn/N2VXoGKgaEfUckMSTXb5RvR8j2TYt1CJrh
	zefiwJDDTV5QKcrIu84bwBkBHuGB/++UTwVEOtLQqBfYozgiF+7mW9sP1RFsAQQh
	nJYF7s8VKJeIaLNNX8vUnuc3AHghxUB0WEBllCwP1X37KtVQJIQw3eMwe84MqSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=APTyGP
	KsxJ8hN5mIiVA+EG5mxeFZHpBJh7JVOCUHzLS96lEb+FL6f8mKg/ATJOPeAx3v4G
	lcF2/EcaqSBLu0r+xX6/4BFLOYla858ri4X2S2ZneGC1zku7dYDIWD5rQfX3zQiQ
	kgf14Gy9BEhy42p570jEpBRV8UrBhFGMHPLqI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90A5A62A4;
	Tue, 17 Apr 2012 16:34:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F29F262A0; Tue, 17 Apr 2012
 16:34:49 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.332.g1863c
In-Reply-To: <1334694886-27756-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C786F9F2-88CC-11E1-8527-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195800>

=46rom: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>

This happens when git merge is run to merge multiple commits that are
descendants of current HEAD (or are HEAD).  We've hit this while updati=
ng
master to origin/master but accidentaly we called (while being on maste=
r):

	$ git merge master origin/master

Here is a minimal testcase:

	$ git init a && cd a
	$ echo a >a && git add a
	$ git commit -minitial
	$ echo b >a && git add a
	$ git commit -msecond
	$ git checkout master^

	$ git merge master master
	Fast-forwarding to: master
	Already up-to-date with master
	Merge made by the 'octopus' strategy.
	 a |    2 +-
	  1 files changed, 1 insertions(+), 1 deletions(-)

	$ git cat-file commit HEAD
	tree eebfed94e75e7760540d1485c740902590a00332
	parent bd679e85202280b263e20a57639a142fa14c2c64
	author Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> 1329132996=
 +0100
	committer Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> 1329132=
996 +0100

	Merge branches 'master' and 'master' into HEAD

Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t6028-merge-up-to-date.sh |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/t/t6028-merge-up-to-date.sh b/t/t6028-merge-up-to-date.sh
index a91644e..824fca5 100755
--- a/t/t6028-merge-up-to-date.sh
+++ b/t/t6028-merge-up-to-date.sh
@@ -16,7 +16,12 @@ test_expect_success setup '
 	test_tick &&
 	git commit -m second &&
 	git tag c1 &&
-	git branch test
+	git branch test &&
+	echo third >file &&
+	git add file &&
+	test_tick &&
+	git commit -m third &&
+	git tag c2
 '
=20
 test_expect_success 'merge -s recursive up-to-date' '
@@ -74,4 +79,14 @@ test_expect_success 'merge -s subtree up-to-date' '
=20
 '
=20
+test_expect_failure 'merge fast-forward octopus' '
+
+	git reset --hard c0 &&
+	test_tick &&
+	git merge c1 c2
+	expect=3D$(git rev-parse c2) &&
+	current=3D$(git rev-parse HEAD) &&
+	test "$expect" =3D "$current"
+'
+
 test_done
--=20
1.7.10.332.g1863c
