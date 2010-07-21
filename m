From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/: work around one-shot variable assignment with
 test_must_fail
Date: Wed, 21 Jul 2010 12:29:28 -0700
Message-ID: <7v1vawk50n.fsf@alter.siamese.dyndns.org>
References: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil> <iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, erick.mattos@gmail.com, avarab@gmail.com,
	jrnieder@gmail.com, jaredhance@gmail.com, drafnel@gmail.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jul 21 21:29:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObezM-0002y7-UX
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 21:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758888Ab0GUT3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jul 2010 15:29:50 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758820Ab0GUT3t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jul 2010 15:29:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA41DC6858;
	Wed, 21 Jul 2010 15:29:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VhPtFlRDIpmX4IorSWOzJSOxLh0=; b=s8cXVz
	JfPuoDwm/SkywowKpj/6YNgaIeS91hr93ezNZJy+IYuJNmkJfN2TQYJRmiGFBqu4
	JMrvlOOLT9NciqcV8kZpChek5ibuk4dfXknRmuskJrbN3YAXZoB51f53pvnKXM5X
	ktC89ue24WyxFp8TTQDNsx6m/6AQjooHWjWmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wRJMgAEasiHz7ExCy396TARSgP5ybkGH
	W/MrKvyurdTFtYx+//w1p1AJeQ9+WwiDZrnjDJPB2AIbSZUeEUO/TwpAyLF0hq6g
	YetLVOGcLZa1K8PBd8g0fipH/xoWY/3ekemvm1W047IJyuKlYKW0/Umk2eDaVvkE
	fXhzA0NszCQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 36246C6852;
	Wed, 21 Jul 2010 15:29:39 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5DC4C6851; Wed, 21 Jul
 2010 15:29:29 -0400 (EDT)
In-Reply-To: <iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Tue\, 20 Jul 2010 16\:55\:31 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4DC5893A-94FE-11DF-8A14-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151412>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> No time to investigate, but here is an example patch and the
> results of running the affected tests.  Looks like reflog may
> be creating a reflog when it is not supposed to.

Your later analysis is correct; "git reflog show <branch>" does not
complain when there is no reflog for <branch>, which might or might not be
a bug.

Because these tests are not about behaviour of "git reflog show" command,
let's do this for now.

Thanks.

-- >8 --
Subject: tests: correct "does reflog exist" tests

These two tests were not about how "git reflog show <branch>" exits when
there is no reflog, but were about whether "checkout" and "branch" create
or not create reflog when creating a new <branch>, update the tests to
check it in a more direct way, namely using "git rev-parse --verify".

Also lose tests based on "test -f .git/logs/refs/heads/<branch>" from
nearby, to avoid exposing this particular implementation detail
unnecessarily.

---
 t/t2017-checkout-orphan.sh |   47 +++++++------------------------------------
 t/t3200-branch.sh          |   13 ++---------
 2 files changed, 11 insertions(+), 49 deletions(-)

diff --git a/t/t2017-checkout-orphan.sh b/t/t2017-checkout-orphan.sh
index 81cb393..2d2f63f 100755
--- a/t/t2017-checkout-orphan.sh
+++ b/t/t2017-checkout-orphan.sh
@@ -68,65 +68,34 @@ test_expect_success '--orphan makes reflog by default' '
 	git checkout master &&
 	git config --unset core.logAllRefUpdates &&
 	git checkout --orphan delta &&
-	! test -f .git/logs/refs/heads/delta &&
-	(
-		PAGER= &&
-		export PAGER &&
-		test_must_fail git reflog show delta
-	) &&
+	test_must_fail git rev-parse --verify delta@{0} &&
 	git commit -m Delta &&
-	test -f .git/logs/refs/heads/delta &&
-	PAGER= git reflog show delta
+	git rev-parse --verify delta@{0}
 '
 
 test_expect_success '--orphan does not make reflog when core.logAllRefUpdates = false' '
 	git checkout master &&
 	git config core.logAllRefUpdates false &&
 	git checkout --orphan epsilon &&
-	! test -f .git/logs/refs/heads/epsilon &&
-	(
-		PAGER= &&
-		export PAGER &&
-		test_must_fail git reflog show epsilon
-	) &&
+	test_must_fail git rev-parse --verify epsilon@{0} &&
 	git commit -m Epsilon &&
-	! test -f .git/logs/refs/heads/epsilon &&
-	(
-		PAGER= &&
-		export PAGER &&
-		test_must_fail git reflog show epsilon
-	)
+	test_must_fail git rev-parse --verify epsilon@{0}
 '
 
 test_expect_success '--orphan with -l makes reflog when core.logAllRefUpdates = false' '
 	git checkout master &&
 	git checkout -l --orphan zeta &&
-	test -f .git/logs/refs/heads/zeta &&
-	(
-		PAGER= &&
-		export PAGER &&
-		test_must_fail git reflog show zeta
-	) &&
+	test_must_fail git rev-parse --verify zeta@{0} &&
 	git commit -m Zeta &&
-	PAGER= git reflog show zeta
+	git rev-parse --verify zeta@{0}
 '
 
 test_expect_success 'giving up --orphan not committed when -l and core.logAllRefUpdates = false deletes reflog' '
 	git checkout master &&
 	git checkout -l --orphan eta &&
-	test -f .git/logs/refs/heads/eta &&
-	(
-		PAGER= &&
-		export PAGER &&
-		test_must_fail git reflog show eta
-	) &&
+	test_must_fail git rev-parse --verify eta@{0} &&
 	git checkout master &&
-	! test -f .git/logs/refs/heads/eta &&
-	(
-		PAGER= &&
-		export PAGER &&
-		test_must_fail git reflog show eta
-	)
+	test_must_fail git rev-parse --verify eta@{0}
 '
 
 test_expect_success '--orphan is rejected with an existing name' '
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index bf7747d..f54a533 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -228,28 +228,21 @@ test_expect_success 'checkout -b makes reflog by default' '
 	git checkout master &&
 	git config --unset core.logAllRefUpdates &&
 	git checkout -b alpha &&
-	test -f .git/logs/refs/heads/alpha &&
-	PAGER= git reflog show alpha
+	git rev-parse --verify alpha@{0}
 '
 
 test_expect_success 'checkout -b does not make reflog when core.logAllRefUpdates = false' '
 	git checkout master &&
 	git config core.logAllRefUpdates false &&
 	git checkout -b beta &&
-	! test -f .git/logs/refs/heads/beta &&
-	(
-		PAGER= &&
-		export PAGER &&
-		test_must_fail git reflog show beta
-	)
+	test_must_fail git rev-parse --verify beta@{0}
 '
 
 test_expect_success 'checkout -b with -l makes reflog when core.logAllRefUpdates = false' '
 	git checkout master &&
 	git checkout -lb gamma &&
 	git config --unset core.logAllRefUpdates &&
-	test -f .git/logs/refs/heads/gamma &&
-	PAGER= git reflog show gamma
+	git rev-parse --verify gamma@{0}
 '
 
 test_expect_success 'avoid ambiguous track' '
