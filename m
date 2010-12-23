From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug in "git rebase" (non-interactive) with regards to
 post-rewrite
Date: Wed, 22 Dec 2010 16:49:37 -0800
Message-ID: <7vd3ot48ke.fsf@alter.siamese.dyndns.org>
References: <AANLkTikv+TuVK3uyEd5ymLRq6Qs7tQYm4kUH3t9hTtQP@mail.gmail.com>
 <7vipyl4aqx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mihai Rusu <dizzy@google.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Dec 23 01:53:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVZQw-00011k-Cq
	for gcvg-git-2@lo.gmane.org; Thu, 23 Dec 2010 01:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481Ab0LWAty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 19:49:54 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791Ab0LWAtx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 19:49:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 164943959;
	Wed, 22 Dec 2010 19:50:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jd5+GZ5W8N3g6VWG8L4u9N84vCc=; b=Goav/4
	pFR9cuM+kfgpMaIadJg1mu+DJnJFqWpeGI5aRw8bhRlZPLQMaisCNPSOSwKZFuPq
	q/OhQ2BjIg3iB/oCUJWs3Ft8O4yUH4eGVTOO7bIRKqYGPwyFbNZmMMOhgpXZsAd+
	LvqjPwWezXyymF1vYgcGXb4Vo0e0TzQiLBoaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SJy1Y5QovhlopNIWkqKuIwZO9pDnCDXl
	eWIz8ZRUyjrJu5+809IhhSY5hD2uM+64HBCGkyHJXwjtPqaOi5gOvhmZhtr90zQP
	zLsJ1iNHuHFmwo2E0eAXL/ll6DFJQsEZ9gqGccb8M7SzHZPA+GyW8KdrUcEfdBL0
	YDi89ZYcCKU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B70F83958;
	Wed, 22 Dec 2010 19:50:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1517C3950; Wed, 22 Dec 2010
 19:50:08 -0500 (EST)
In-Reply-To: <7vipyl4aqx.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 22 Dec 2010 16\:02\:30 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9B40CB58-0E2E-11E0-92B8-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164115>

When "rebase --skip" is used to skip the last patch in the series, the
code to wrap up the rewrite by copying the notes from old to new commits
and also by running the post-rewrite hook was bypassed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh                    |    7 -------
 t/t5407-post-rewrite-hook.sh |   18 +++++++++++++++++-
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index de116a2..69474e5 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -554,13 +554,6 @@ then
 	resume=
 fi
 
-if test "$this" -gt "$last"
-then
-	say Nothing to do.
-	rm -fr "$dotest"
-	exit
-fi
-
 while test "$this" -le "$last"
 do
 	msgnum=`printf "%0${prec}d" $this`
diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 552da65..baa670c 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -10,7 +10,11 @@ test_expect_success 'setup' '
 	test_commit A foo A &&
 	test_commit B foo B &&
 	test_commit C foo C &&
-	test_commit D foo D
+	test_commit D foo D &&
+	git checkout A^0 &&
+	test_commit E bar E &&
+	test_commit F foo F &&
+	git checkout master
 '
 
 mkdir .git/hooks
@@ -79,6 +83,18 @@ EOF
 	verify_hook_input
 '
 
+test_expect_success 'git rebase --skip the last one' '
+	git reset --hard F &&
+	clear_hook_input &&
+	test_must_fail git rebase --onto D A &&
+	git rebase --skip &&
+	echo rebase >expected.args &&
+	cat >expected.data <<EOF &&
+$(git rev-parse E) $(git rev-parse HEAD)
+EOF
+	verify_hook_input
+'
+
 test_expect_success 'git rebase -m' '
 	git reset --hard D &&
 	clear_hook_input &&
