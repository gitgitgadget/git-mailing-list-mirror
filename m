From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dangerous "git am --abort" behavior
Date: Tue, 21 Dec 2010 10:29:56 -0800
Message-ID: <7vsjxr7zdn.fsf@alter.siamese.dyndns.org>
References: <AANLkTinP4SArMkjvTXOEG=tf=8EcEdP9fPAB7F=iitSc@mail.gmail.com>
 <7vtyi8arxp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 21 19:30:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV6yX-0007fw-5A
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 19:30:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538Ab0LUSaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 13:30:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50056 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab0LUSaG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 13:30:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A49E3F79;
	Tue, 21 Dec 2010 13:30:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nAFqzUUUji2h06cZ/0OYNtHN/ZU=; b=Njpouw
	4erujjqGbt3j6aNPIvgtVLsZgrF1OtcVCPaq3zUu3d8X/q0tnDHYLRRqfTf0Hj3e
	6YHx6lUBu/c9Ke1IhnxLBnwe3/ARYvBXXHWHXXTW1zNKaWlRaIMcW7kLAmE2l1LR
	0IKkhQGJOxtTLa3KLanEyPdyM2DXEJzrxQuLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OUk9njz0cdxi2/e2xucqvFDqIxvSv5bC
	IyaZMKFmPxZuLTmDu9IQQvxA3iKMdoHIlKtuBko26lG5KSM35O6qbT+YqRQYLwnA
	sv6lxGD5gIeyM4gOT7MR0i6UznJ9T9amjnC+FDTyGY3kspy4e6Me4mgkEfSdXJKu
	oFGkowd6vec=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 47EFF3F75;
	Tue, 21 Dec 2010 13:30:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 19FFF3F73; Tue, 21 Dec 2010
 13:30:27 -0500 (EST)
In-Reply-To: <7vtyi8arxp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 20 Dec 2010 16\:30\:10 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 643F0560-0D30-11E0-805F-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164045>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> ...
>> Maybe "git am" should actually save the last commit ID that it did,
>> and only do the "reset" if the current HEAD matches the rebase-apply
>> state and warns if it doesn't? Or maybe we could just introduce a new
>> "git am --clean" that just flushes any old pending state (ie does that
>> "clean_abort" thing, which is basically just the "rm -rf" I've done by
>> hand). Or both?
> ...
> Back then my tentative conclusion was actually to get rid of "am --abort"
> and give "am --clean", making the final "reset HEAD~$n" the responsiblity
> of the user.  But I forgot to pursue it.

So here is the first step in that direction.  I suspect that stop_here
should also record what the current branch is, and safe_to_abort should
check it (the potentially risky sequence is "after a failed am, check out
a different branch and then realize you need to 'am --abort'"), but that
is left to interested others ;-) or a later round.

-- >8 --
Subject: am --abort: keep unrelated commits since the last failure and warn

After making commits (either by pulling or doing their own work) after a
failed "am", the user will be reminded by next "am" invocation that there
was a failed "am" that the user needs to decide to resolve or to get rid
of the old "am" attempt.  The "am --abort" option was meant to help the
latter.  However, it rewinded the HEAD back to the beginning of the failed
"am" attempt, discarding commits made (perhaps by mistake) since.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh           |   27 +++++++++++++++++++++++++--
 t/t4151-am-abort.sh |    9 +++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index df09b42..cf1f64b 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -68,9 +68,31 @@ sq () {
 
 stop_here () {
     echo "$1" >"$dotest/next"
+    git rev-parse --verify -q HEAD >"$dotest/abort-safety"
     exit 1
 }
 
+safe_to_abort () {
+	if test -f "$dotest/dirtyindex"
+	then
+		return 1
+	fi
+
+	if ! test -s "$dotest/abort-safety"
+	then
+		return 0
+	fi
+
+	abort_safety=$(cat "$dotest/abort-safety")
+	if test "z$(git rev-parse --verify -q HEAD)" = "z$abort_safety"
+	then
+		return 0
+	fi
+	echo >&2 "You seem to have moved HEAD since the last 'am' failure."
+	echo >&2 "Not rewinding to ORIG_HEAD"
+	return 1
+}
+
 stop_here_user_resolve () {
     if [ -n "$resolvemsg" ]; then
 	    printf '%s\n' "$resolvemsg"
@@ -419,10 +441,11 @@ then
 			exec git rebase --abort
 		fi
 		git rerere clear
-		test -f "$dotest/dirtyindex" || {
+		if safe_to_abort
+		then
 			git read-tree --reset -u HEAD ORIG_HEAD
 			git reset ORIG_HEAD
-		}
+		fi
 		rm -fr "$dotest"
 		exit ;;
 	esac
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index b55c411..001b1e3 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -62,4 +62,13 @@ do
 
 done
 
+test_expect_success 'am --abort will keep the local commits' '
+	test_must_fail git am 0004-*.patch &&
+	test_commit unrelated &&
+	git rev-parse HEAD >expect &&
+	git am --abort &&
+	git rev-parse HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
