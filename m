From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git checkout: create unparented branch by --orphan
Date: Sat, 20 Mar 2010 13:54:30 -0700
Message-ID: <7vfx3ubto9.fsf@alter.siamese.dyndns.org>
References: <1268928579-11660-1-git-send-email-erick.mattos@gmail.com>
 <7vvdcrowlc.fsf@alter.siamese.dyndns.org>
 <55bacdd31003201206w6215c6a4qec09797fbe060725@mail.gmail.com>
 <7v4okad9by.fsf@alter.siamese.dyndns.org>
 <55bacdd31003201336u685f4b91u5206ca719609d153@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 21:54:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt5gy-0000Wa-By
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 21:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410Ab0CTUyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 16:54:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60163 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935Ab0CTUyi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 16:54:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 76E1BA3402;
	Sat, 20 Mar 2010 16:54:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58oH9Sj+8Hf4k6NV5NHCR3vfCmQ=; b=e5hND1
	uVcniMw81pmqLMygMlyjFTcYGf6ghG+znVv7kd+PfTnK75H7JjcoMfB/cKaK7+UE
	rnyt6B8UNdWgBqX2OU7pY8jFtndPw2naMSE+dXF/caRjxpbxzmK1C2YpZ7f94zjn
	MLD2/41t66rRcn+c2BfIzUMX+Yj16XSNyUkxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CS3WTV/iUgUS0AQbUMtcbOIOrzfSuNm+
	2kDS/9WKty8CuCdW+Aix2ZXivCBcug/Hml8vjLoVlmh+LUY/6SCPGPQJdNPfJs6T
	cGMh22qbPcBHN0rBBFkV/C/FkwiXoK27xh8i7Ai9ho+5PiuIdLmcrdxuLmT8VTih
	2MI8VUklnz4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 543C3A3401;
	Sat, 20 Mar 2010 16:54:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA64CA3400; Sat, 20 Mar
 2010 16:54:31 -0400 (EDT)
In-Reply-To: <55bacdd31003201336u685f4b91u5206ca719609d153@mail.gmail.com>
 (Erick Mattos's message of "Sat\, 20 Mar 2010 17\:36\:06 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C9E6631A-3462-11DF-9D77-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142749>

I hope I am not giving you undue burden, but here is what I would add.
One thing that I am not sure about is what to do with "-l --orhpan".

---

 t/t2017-checkout-orphan.sh |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index 5a9a3fa..e80e167 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -44,7 +44,48 @@ test_expect_success '--orphan creates a new orphan branch from <start_point>' '
 '
 
 test_expect_success '--orphan must be rejected with -b' '
-	test_must_fail git checkout --orphan new -b newer
+	git checkout master &&
+	test_must_fail git checkout --orphan new -b newer &&
+	test refs/heads/master = "$(git symbolic-ref HEAD)"
+'
+
+test_expect_success '--orphan is rejected with an existing name' '
+	git checkout master &&
+	test_must_fail git checkout --orphan master &&
+	test refs/heads/master = "$(git symbolic-ref HEAD)"
+'
+
+test_expect_success '--orhapn refuses to switch if a merge is needed' '
+	git checkout master &&
+	git reset --hard &&
+	echo local >>"$TEST_FILE" &&
+	cat "$TEST_FILE" >"$TEST_FILE.saved" &&
+	test_must_fail git checkout --orphan gamma master^ &&
+	test refs/heads/master = "$(git symbolic-ref HEAD)" &&
+	test_cmp "$TEST_FILE" "$TEST_FILE.saved" &&
+	git diff-index --quiet --cached HEAD &&
+	git reset --hard
+'
+
+test_expect_success '--orphan does not mix well with -t' '
+	git checkout master &&
+	test_must_fail git checkout -t master --orphan gamma &&
+	test refs/heads/master = "$(git symbolic-ref HEAD)"
+'
+
+test_expect_success '--orphan ignores branch.autosetupmerge' '
+	git checkout -f master &&
+	git config branch.autosetupmerge always &&
+	git checkout --orphan delta &&
+	test -z "$(git config branch.delta.merge)" &&
+	test refs/heads/delta = "$(git symbolic-ref HEAD)" &&
+	test_must_fail git rev-parse --verify HEAD^
+'
+
+# This is iffy.
+test_expect_success '--orphan does not mix well with -l' '
+	git checkout -f master &&
+	test_must_fail git checkout -l --orphan gamma
 '
 
 test_done
