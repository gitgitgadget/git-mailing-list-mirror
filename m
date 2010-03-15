From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase--interactive: don't enforce valid branch
Date: Sun, 14 Mar 2010 23:14:26 -0700
Message-ID: <7vd3z6f6wt.fsf@alter.siamese.dyndns.org>
References: <1268628502-29696-1-git-send-email-cxreg@pobox.com>
 <7vsk82i2kd.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1003142227100.796@narbuckle.genericorp.net>
 <7vvdcygmz8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Olszewski <cxreg@pobox.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 07:14:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr3ZZ-0000Lc-5F
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 07:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933452Ab0COGOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 02:14:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65042 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933028Ab0COGOf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 02:14:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 21477A105E;
	Mon, 15 Mar 2010 02:14:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g+vHIQteGrzv8IPJOaT0Vt1uWGs=; b=l1x4hO
	qPbEaojnTnkTuxvTO5u57BjrszL5aDvb35gYjXz5X0OASfyFXp9iTlIsb7et75CS
	eLcOYp6TkZMD949IL1IXncY7xkdso1bvLoa7D9d9bwbjoNTCIDlohpZTVBfbYIZY
	fO6Wxf6tSUAWRjTgBGKZRmdQqauVMsdmgimQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GxXIWw0msU1X+ws7vzAhb2ahYQjjjGqV
	cDuALQwMSQ5wQw3cVJV38bO/k1ToRMO25PsumXGc+u7x+3csCi+Up4ymO9wewKuw
	zHZyKCMyVOFW9ak/P1Tbarma41voApmY5OiRA9kIB7AryuteP3AddfyanoUPwggM
	u/woDFjCP5c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F2154A105D;
	Mon, 15 Mar 2010 02:14:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C1CCA105B; Mon, 15 Mar
 2010 02:14:28 -0400 (EDT)
In-Reply-To: <7vvdcygmz8.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 14 Mar 2010 22\:42\:03 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 052DC660-2FFA-11DF-AB91-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142173>

Junio C Hamano <gitster@pobox.com> writes:

> Dave Olszewski <cxreg@pobox.com> writes:
>
>>>> +test_expect_success 'rebase while detaching HEAD' '
>>>> +	grandparent=$(git rev-parse HEAD~2) &&
>>>> +	test_tick &&
>>>> +	FAKE_LINES="2 1" git rebase -i HEAD~2 HEAD^0 &&
>>>
>>> What's the point of saying this?  You could instead say:
>>>
>>> 	git rebase -i HEAD~2
>>>
>>> no?
>> ...

Ahh, Ok, the point is that when we start this sequence we are on a branch,
and then you want to end up on a detached HEAD that points at the result
of the branch.

I'll queue it in 'pu', but with a little tweak to the test to make it
clear what is going on, perhaps like this.

    test_expect_success 'rebase while detaching HEAD' '
            git symbolic-ref HEAD &&
            grandparent=$(git rev-parse HEAD~2) &&
            test_tick &&
            FAKE_LINES="2 1" git rebase -i HEAD~2 HEAD^0 &&
            test $grandparent = $(git rev-parse HEAD~2) &&
            test_must_fail git symbolic-ref HEAD
    '

We may need to document this behaviour, by the way, if we make it official
that the extra "branch to be rewritten" parameter can be a non-branch.
Two points are that you can give arbitrary commit, and that you will end
up with a detached HEAD that points at the result if you did so.

Also I did't followed the code, but does it behave sanely when you say
"rebase --abort"?
