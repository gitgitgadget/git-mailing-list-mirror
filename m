From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] replace: fix replacing object with itself
Date: Sun, 16 Nov 2014 10:59:57 -0800
Message-ID: <xmqqr3x3ynrm.fsf@gitster.dls.corp.google.com>
References: <1415887559-16585-1-git-send-email-manzurmm@gmail.com>
	<xmqqppcp1jvg.fsf@gitster.dls.corp.google.com>
	<CAP8UFD3dZMmGJp1p=ttVUoUkiwh7oYL3gqgsGZ+D8Bd16FiKjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Manzur Mukhitdinov <manzurmm@gmail.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 20:00:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xq53S-0007tE-Bw
	for gcvg-git-2@plane.gmane.org; Sun, 16 Nov 2014 20:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbaKPTAD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 14:00:03 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61974 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751152AbaKPTAB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2014 14:00:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 94D861A8BE;
	Sun, 16 Nov 2014 14:00:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YnFaHFvQQA0em2KahNDL+lqZCVQ=; b=io92z9
	8+t/ZEFDmyac3shvO0ZJwt1eZ6UWhkja84R3oGMfLZnRi0tJw9UOsJN1uCoSQj2R
	BpJs2Zj34FCKs1k5gik19YYJULIRmmVtzye3BHyJFjlEliuKUZWUP6jLW3o47UQ9
	YZwXTepK6A1xFRG/n+b8OLOIj8IceWHcH34Ck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hokUsOv+fOpfk2n7SyRJJdDoxbUFHMIb
	cLzAhd1Xefnl8Pf5XlDdx5cO1z+lFSCEHp6KA63g4g1CKNFnnLUKUQoEwDqdAfUV
	lHpCKyFj844dQ+HD5QsaDds74PTiEcaQNOrtMJ9V0C98gNjMzViZqC+vp347iTDT
	V2qd2b7tWpk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F9431A8BA;
	Sun, 16 Nov 2014 14:00:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A47341A8AE;
	Sun, 16 Nov 2014 14:00:00 -0500 (EST)
In-Reply-To: <CAP8UFD3dZMmGJp1p=ttVUoUkiwh7oYL3gqgsGZ+D8Bd16FiKjQ@mail.gmail.com>
	(Christian Couder's message of "Sat, 15 Nov 2014 12:55:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C4203304-6DC2-11E4-9ACC-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> The patch is not wrong per-se, but I wonder how useful this "do not
>> replace itself but all other forms of loops are not checked at all"
>> would be in practice.  If your user did this:
>>
>>         git replace A B ;# pretend as if what is in B is in A
>>         git replace B C ;# pretend as if what is in C is in B
>>         git replace C A ;# pretend as if we have loop
>>         git log C
>>
>> she would not be helped with this patch at all, no?
>
> Yeah, but such loops are much less likely mistakes and are more
> difficult to detect, so I think this patch is at least a good first
> step.

More difficult to notice by humans, hence deserves more help from
the tool.

When these two are both mistakes, which one do you think is easier
to notice (thusly unlikely to happen)?

	git replace A A
        git replace C A

Of course, the former is immediately obvious to the human who is
typing that it is a typo.

The latter would be harder to spot as a mistake as the invoker has
to know that there is an existing "pretend as if what is in A is in
C" aka "replace A C" done earlier in the repository.

And the cost of detecting such a possible "too deep replace chain"
(do not call that a loop---the runtime barfs if you have too deep a
replace chain without any loop) wouldn't be too high.  You only need
to look at existing refs/replace/* refs, their contents, and the two
object names that form the proposed new replacement <old,new>.

Even a kludge (read: I am not suggesting that you solve it this way)
like "first install the replacement as proposed, then enumerate all
the replacement refs and their values and try to see if the runtime
check would barf, and if it would, fail the operation and revert the
change" would catch a mistake to cause the repository in trouble.
