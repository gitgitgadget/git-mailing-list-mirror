From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dangerous "git am --abort" behavior
Date: Tue, 21 Dec 2010 10:47:27 -0800
Message-ID: <7voc8f7ykg.fsf@alter.siamese.dyndns.org>
References: <AANLkTinP4SArMkjvTXOEG=tf=8EcEdP9fPAB7F=iitSc@mail.gmail.com>
 <7vtyi8arxp.fsf@alter.siamese.dyndns.org>
 <7vsjxr7zdn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 21 19:47:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV7FN-0001Xe-Nq
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 19:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562Ab0LUSrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 13:47:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34644 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136Ab0LUSrf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 13:47:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 944FF2247;
	Tue, 21 Dec 2010 13:48:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OhpM0opvp2QWWZw5Jgnplxx6aI8=; b=E0+88d
	9Lz1RaNlQF0AtTGs81BBNLF4njy9oM2R1vKaxJcseU5r8Y3siZzv6JTW0GRFYR0r
	Bj+XRFC/q4SMP00Y4c5movshDG60IpA6XTDAHuItuTbR+6f6zWR9diIogjtimhx6
	Mh6y3Nr9sUItHRnFyWcRuXFOcx+R9kTh02Xcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MIlmppODy7uUQ9iuiYJvZ7PcvCguxVUT
	km8B4FkxdrV6HbKm/wKbEsYB6HKMy3rg2ItoW5golzhQjZtflWyHKyiVKzDCgw0j
	St2znQvtZOQzAs9koLGorlaIGH4gZAnt1BvEUnPwzrs+eK60RHqtNkgsj+JdilY2
	hD63uy3Vkqs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6FB6C2242;
	Tue, 21 Dec 2010 13:48:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 41E99223E; Tue, 21 Dec 2010
 13:47:56 -0500 (EST)
In-Reply-To: <7vsjxr7zdn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 21 Dec 2010 10\:29\:56 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D5984AEE-0D32-11E0-B5CD-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164047>

Junio C Hamano <gitster@pobox.com> writes:

> So here is the first step in that direction.  I suspect that stop_here
> should also record what the current branch is, and safe_to_abort should
> check it (the potentially risky sequence is "after a failed am, check out
> a different branch and then realize you need to 'am --abort'"), but that
> is left to interested others ;-) or a later round.

And here is that later round...

-- >8 --
Subject: [PATCH] am --abort: also check the current branch

If the user checks out another branch after an "am" failure, am --abort
would have rewound the tip of that branch back to where the last failed
"am" started from, which would not be fun.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh           |   10 +++++++---
 t/t4151-am-abort.sh |   17 +++++++++++++++++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index e5671f6..ca3f910 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -68,7 +68,9 @@ sq () {
 
 stop_here () {
     echo "$1" >"$dotest/next"
-    git rev-parse --verify -q HEAD >"$dotest/abort-safety"
+    head=$(git rev-parse --verify -q HEAD)
+    branch=$(git symbolic-ref -q HEAD)
+    echo "$head,$branch" >"$dotest/abort-safety"
     exit 1
 }
 
@@ -84,11 +86,13 @@ safe_to_abort () {
 	fi
 
 	abort_safety=$(cat "$dotest/abort-safety")
-	if test "z$(git rev-parse --verify -q HEAD)" = "z$abort_safety"
+	head=$(git rev-parse --verify -q HEAD)
+	branch=$(git symbolic-ref -q HEAD)
+	if test "z$head,$branch" = "z$abort_safety"
 	then
 		return 0
 	fi
-	echo >&2 "You seem to have moved HEAD since the last 'am' failure."
+	echo >&2 "You seem to have done some other things since the last 'am' failure."
 	echo >&2 "Not rewinding to ORIG_HEAD"
 	return 1
 }
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 001b1e3..23a9fb0 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -71,4 +71,21 @@ test_expect_success 'am --abort will keep the local commits' '
 	test_cmp expect actual
 '
 
+test_expect_success 'am --abort will keep unrelated branch' '
+	git reset --hard &&
+	test_commit foo &&
+	test_must_fail git am 0004-*.patch &&
+	git checkout -b unrelated HEAD^ &&
+	(
+		git rev-parse HEAD
+		git symbolic-ref HEAD
+	) >expect &&
+	git am --abort &&
+	(
+		git rev-parse HEAD
+		git symbolic-ref HEAD
+	) >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.3.4.768.g2fa91
