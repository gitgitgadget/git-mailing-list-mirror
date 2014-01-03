From: Junio C Hamano <gitster@pobox.com>
Subject: Re: aborted 'git fetch' leaves workspace unusable
Date: Fri, 03 Jan 2014 09:58:43 -0800
Message-ID: <xmqqsit5lzfw.fsf@gitster.dls.corp.google.com>
References: <32eeea08963ec4438f97ff9ef6553a75@stephe-leake.org>
	<xmqqbnzuqmqe.fsf@gitster.dls.corp.google.com>
	<85iou13fse.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Leake <stephen_leake@stephe-leake.org>
X-From: git-owner@vger.kernel.org Fri Jan 03 18:58:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vz91G-0002Y8-Lf
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 18:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbaACR6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 12:58:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33513 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635AbaACR6q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 12:58:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAFBB5CA50;
	Fri,  3 Jan 2014 12:58:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R/XdJ3ldjer/PfOs9FA3CUsiaH0=; b=gSqoiU
	XQOHRPkQo8DyYw8vcVPJD7AYVl8/HxQx8lfnKKdVhDjep26mgnbKeuFAyJlkeLqf
	UNzBqia2nBeNUiNULUzpLGPhbwN36FArTGyHOjurrnj7Awi4THeB8CiBkHSYeAKs
	xzYz9ZMteKkoIURIDkK+YUE5exB0FQUHEpSf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=modDZybGsbutGb5tJTk2OwlfLyy1CqV2
	TsLEVCb3vwgV7pgT09DX6mvTaga6+I6mRx6gxuASl2Pt/9VDTbx5XzDuUdaAjiO3
	Sxok/NrB3I8Iz2TN6gsFEQvLL/xQwnen60aa+LcS/yRj4Y9ylubLdI+kNGkXA+Ga
	ATjuAJc4aKA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB0265CA4F;
	Fri,  3 Jan 2014 12:58:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 283675CA4E;
	Fri,  3 Jan 2014 12:58:45 -0500 (EST)
In-Reply-To: <85iou13fse.fsf@stephe-leake.org> (Stephen Leake's message of
	"Thu, 02 Jan 2014 21:28:17 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B03ECA2E-74A0-11E3-B62C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239919>

Stephen Leake <stephen_leake@stephe-leake.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> stephen_leake@stephe-leake.org writes:
>>
>>> However, in this case, even running the fetch was a mistake; I would
>>> have prefered that it leave FETCH_HEAD in its previous state.
>>
>> I think the clearing of leftover FETCH_HEAD is one of the early
>> things "git fetch" does, unless "--append" is in effect.  I haven't
>> looked at the code for a long time, but it may be possible to move
>> the logic of doing so around so that this clearing is done as lazily
>> as possible.
>>
>> I however suspect that such a change may have fallouts on other
>> people who are writing tools like yours; they may be depending on
>> seeing FETCH_HEAD cleared after a failed fetch, and be surprised to
>> see a stale contents after they (attempt to) run "git fetch" in it.
>>
>> So it is not so clear if it is a good thing to change the behaviour
>> of "git fetch" not to touch FETCH_HEAD upon a failure.
>
> Ok; backwards compatibility is important.
>
> Perhaps FETCH_HEAD could be copied to FETCH_HEAD_prev or some such, to
> allow recovering in an error case?

As FETCH_HEAD is purely ephemeral (so are other ephemeral markers
like MERGE_HEAD and friends), and the promise between "git fetch"
and its users has always been that an invocation of "git fetch"
clears FETCH_HEAD (logical consequence of which is that the user
runs "git fetch" only when s/he are _done_ with the old FETCH_HEAD),
I doubt FETCH_HEAD_prev would add much value to the system and only
introduce more things we have to worry about, like "when will it be
cleaned?", "what happens to the old value in FETCH_HEAD_prev?".

It is like asking "Should 'rm -f foo' save the original 'foo' to
somewhere else just in case?".

If your emacs wrapper for some reason needs to know what happened in
the last fetch, I imagine that it can check and record what was in
FETCH_HEAD before issuing "git fetch", so...
