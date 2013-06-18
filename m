From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] Fix checkout-dash to work with rebase
Date: Tue, 18 Jun 2013 09:15:39 -0700
Message-ID: <7vip1b75uc.fsf@alter.siamese.dyndns.org>
References: <1371372316-16059-1-git-send-email-artagnon@gmail.com>
	<7v1u81ibjp.fsf@alter.siamese.dyndns.org>
	<7vk3lsei4i.fsf@alter.siamese.dyndns.org>
	<CALkWK0n2AvL49DNp1t7ty0Dneprd7r_V2p=brS0qMKz=wdZz6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 18 18:15:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoyZZ-0000xn-Rc
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 18:15:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932969Ab3FRQPy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 12:15:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57162 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932670Ab3FRQPw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 12:15:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A370D2872A;
	Tue, 18 Jun 2013 16:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0UREpUdpHCPIdpoq/Bn04aSzOjs=; b=ZyTs6/
	gGlcZ1jEnN7paT3AemtxPZaR0R4ZQkOJJb3FOSOP62TT3/IyTOpP7sCWsjZJrZtj
	xJdEv/GVDX8IecvSXUcXbWrZPMaF0me8ftBuLs7wZDLTEcLGYLgU+b7gwNOBiDes
	Mm5F3jqZnVhOhoOHIi3yZ1akPUBwMA8F8oHgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fc1M5tt1vMDLhe54lgcZLi1hrbQGdf7r
	tnNaHVuKjiX0poUJSVmkiu82BrNbMQCuiie36cKF9vrLI824eN3mWTrnXhungsXw
	RB7j9KtSiHd1orrMUVmHb7h6Ei8WUZmSFaHlluEDUfohFlOmM2EhL4RjeJDGlG3N
	UZZ+qCO7VPQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AA7228729;
	Tue, 18 Jun 2013 16:15:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E535228716;
	Tue, 18 Jun 2013 16:15:49 +0000 (UTC)
In-Reply-To: <CALkWK0n2AvL49DNp1t7ty0Dneprd7r_V2p=brS0qMKz=wdZz6A@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Tue, 18 Jun 2013 16:06:03 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5751A478-D832-11E2-89E0-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228260>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
>> index a58406d..c175ef1 100755
>> --- a/t/t3404-rebase-interactive.sh
>> +++ b/t/t3404-rebase-interactive.sh
>> @@ -934,6 +934,21 @@ test_expect_success 'rebase --edit-todo can be used to modify todo' '
>>         test L = $(git cat-file commit HEAD | sed -ne \$p)
>>  '
>>
>> +test_expect_success 'rebase -i produces readable reflog' '
>
> I don't know if this test is a good idea at all.

It is.

This catches "a change to GIT_REFLOG_ACTION that is meant to only
apply to checkout done internally in git-rebase leaks to the later
codepath and affects the reflog message left by rebase--interactive".

Apply the test change without the "do not leak" part in the fix-up
(queued as a single "SQUASH???" commit on 'pu') to what you posted
earlier and see how it breaks.

    # rr/rebase-checkout-reflog with fix-up
    $ git checkout 33b1cdeb 
    # revert the fix but keep the test
    $ git checkout HEAD^ -- git-rebase--interactive.sh git-rebase.sh
    # run the test
    $ make && cd t && sh ./t3404-*.sh -v -i

The test fails with this:

    --- expect      2013-06-18 16:09:21.000000000 +0000
    +++ actual      2013-06-18 16:09:21.000000000 +0000
    @@ -1,4 +1,4 @@
    -rebase -i (start): checkout I
    +rebase -i (start): checkout branch-reflog-test: checkout I
     rebase -i (pick): G
     rebase -i (pick): H
     rebase -i (finish): returning to refs/heads/branch-reflog-test

"checkout branch-reflog-test" part is leaking from your setting of
GIT_REFLOG_ACTION for "git checkout" in "git rebase"; it is only
necessary to affect that "checkout" and it should not affect later
commands that write reflog entries, but we see the breakage.

And that is why I did the fix-up to make sure your changes only
apply to "git checkout".

If you apply the test part of that fixup to what you posted today,
what would you see?  I didn't look at the patches very closely, but
I wouldn't be surprised if they are still leaking the change meant
only to "checkout" to the later stages and breaking that test (the
reason why I would not be surprised is because the impression I am
getting from reading your responses is that you do not understand
why it is bad not to limit the setting only to checkout).

> Why make an exception in the case of rebase -i?

Because the whole point of last two patches are "word reflog
messages better for rebase", the improvements made by these two
patches are better protected from future changes; it also makes sure
that deliberate improvements will show up as changes to the tests.
