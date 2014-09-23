From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH for-maint] apply: gitdiff_verify_name(): accept "/dev/null\r"
Date: Tue, 23 Sep 2014 13:35:29 -0700
Message-ID: <xmqqfvfihy7i.fsf@gitster.dls.corp.google.com>
References: <1411434583-27692-1-git-send-email-lersek@redhat.com>
	<xmqq1tr2jhg2.fsf@gitster.dls.corp.google.com>
	<5421CAA6.3040107@redhat.com>
	<xmqqsijihzrb.fsf@gitster.dls.corp.google.com>
	<5421D8C4.2080009@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jordan.l.justen@intel.com,
	matt.fleming@intel.com
To: Laszlo Ersek <lersek@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 22:49:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWWoY-0000Mz-0S
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 22:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbaIWUfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 16:35:33 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55614 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735AbaIWUfc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 16:35:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C392F3AFD9;
	Tue, 23 Sep 2014 16:35:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BtUg6GgNEfS2FsQ3QHSuouGBlKc=; b=bRZtT3
	w2rAbST5IoIdyJSiP/i1iZXAwcwPMLKJjspqBky0UQFIUOCEcLHRH9Wtlk6jJGjO
	Ef6TA6llv9V117pk7glKqFgXjtFqJ7PGzse54r7a/gPEpsMyfJzaIXYmvWqi9yT8
	9vnOHOgU8/ZAFkrekR2cKJW88qPyokK36l+Zs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PIvKCRwES1b1pX/hB/Zwz1o6rAm7Xaa9
	DCgAqphMhJHhTLktdTjcynnfl3tcyW16kwmjAI3RSDccAfWFJOsHzN9w3pGc6F8W
	U+yRbGhCHKYm1uTkvcllcBPsGVceFtu82UMN0y9aTssjBTx3Vx7Nq8U7DzoOrbgv
	WmkXDMr5BUA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 635313AFD8;
	Tue, 23 Sep 2014 16:35:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 688303AFD4;
	Tue, 23 Sep 2014 16:35:30 -0400 (EDT)
In-Reply-To: <5421D8C4.2080009@redhat.com> (Laszlo Ersek's message of "Tue, 23
	Sep 2014 22:32:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 28DC8478-4361-11E4-A65C-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257442>

Laszlo Ersek <lersek@redhat.com> writes:

> On 09/23/14 22:02, Junio C Hamano wrote:
>> Laszlo Ersek <lersek@redhat.com> writes:
>> 
>>> On 09/23/14 20:54, Junio C Hamano wrote:
>>> ...
>>>> SMTP transport may be CRLF-unsafe, so I have a suspicion that it may
>>>> turn out that what you are trying to do might be an equilvalent of
>>>>
>>>> 	git format-patch ... |
>>>>         # first lose all \r\n
>>>>         dos2unix | 
>>>> 	# then make everything \r\n
>>>>         unix2dos |
>>>>         # and apply
>>>>         git am
>>>>
>>>> which is not workable in the first place.  I dunno.
>>>
>>> I agree with your analysis. It is indeed the MTA...
>>>>    - CR and LF MUST only occur together as CRLF; they MUST NOT appear
>>>>      independently in the body.
>>>
>>> But why is this situation "not workable"? The same happens with *all*
>>> patches that people mail around, it's just not visible to them, because
>>> git-am strips all CRs indiscriminately.
>> 
>> It is not "git am" or "git apply" that "strips all CRs
>> indiscriminately".  I just tried to apply 0001-add-f2 without
>> letting your MTA/MUA corrupt it on "master" branch in the repository
>> you prepared that patch from, i.e.
>> 
>> 	git checkout master^0 ;# go back
>>         git am 0001-add-f2* ;# apply that "+hello world\r\n" patch
>>         git diff branch ;# nothing
>
> When you did this, was am.keepcr=true in effect?

I actually briefly scratched my head but realized when I saw it work
"as expected" without me passing "--keep-cr" to "am" myself.

But I did that experiment in the repository created by following
your reproduction recipe, in which it had these:

  git config core.whitespace cr-at-eol
  git config am.keepcr true

so yes I had keepcr set.
