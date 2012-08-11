From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry-pick and 'log --no-walk' and ordering
Date: Fri, 10 Aug 2012 23:28:06 -0700
Message-ID: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
References: <CAOeW2eE=VcUs1YcWqqEUc6vM6jW9JaXzE-_tVWy48VtPzm_+wA@mail.gmail.com>
 <7vfw7uig13.fsf@alter.siamese.dyndns.org>
 <CAOeW2eHz5un9cNoy-=7Y8=F_G6u-n8kk7kXGHQ+dKrHD8wW6BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 08:28:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T05BI-0002Xl-K9
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 08:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477Ab2HKG2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Aug 2012 02:28:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43694 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767Ab2HKG2K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 02:28:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E87FE69F6;
	Sat, 11 Aug 2012 02:28:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UtAqRXo8RpvsPmur00Q4O3YGlPw=; b=ER1sHi
	pAJws/tsKpMw1cLCEVy5jdfnGTZIElltCjF1w0IsGwEXviNPi9S5io+8UesYb6hS
	/CF0dHmgn3l2+MqfICjuDOmRgbrLbHaHshT7dyYHB/8190qVYI/BtzfUYki8YF0F
	lH19PlTBnX7pdChGdtHqOhyXdIgbDeb8DWPco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PC13tujHGmsn4IuXXXCBsFS1zNT80E6X
	b4u5ydNm64UJ8Xnt8HFTfHNuTCrW/ER8XvsmsZ34VJKNua/IPLk+9yKP5SS1lj1f
	rTzBy+b9TZMLaRIOs6S/TBnD0TQPudsg0CTX3Iw5TayaOVYKWYL+bEwWYKZIipf/
	Gesv/ePE47M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4F8369F5;
	Sat, 11 Aug 2012 02:28:08 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 339F069F4; Sat, 11 Aug 2012
 02:28:08 -0400 (EDT)
In-Reply-To: <CAOeW2eHz5un9cNoy-=7Y8=F_G6u-n8kk7kXGHQ+dKrHD8wW6BA@mail.gmail.com> (Martin
 von Zweigbergk's message of "Fri, 10 Aug 2012 22:34:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B738E2E8-E37D-11E1-84BE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203279>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> On Fri, Aug 10, 2012 at 2:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>>
>>> There is also cherry-pick/revert, which I _think_ does not really want
>>> the revisions sorted.
>>
>> Yes, I think sequencer.c::prepare_revs() is wrong to unconditoinally
>> call prepare_revision_walk().
>>
>> It instead should first check the revs->pending.objects list to see
>> if what was given by the caller is a mere collection of individual
>> objects or a range expression (i.e. check if any of them is marked
>> with UNINTERESTING), and refrain from going into the body of the
>> preparation steps, which has to involve sorting.
>
> Do you mean "has to involve sorting" as in "has to involve sorting in
> order not to break current users of e.g. 'git log --no-walk
> --branches'"  or "revision walking inherently involves sorting"?

Range limited revision walking, e.g. "git cherry-pick A..B D~4..D",
fundamentally implies sorting and you cannot assume B would appear
before D only because B comes before D on the command line (B may
even be inside D~4..D range in which case it would not even appear
in the final output).

Any caller that wants to retrieve the objects given from the command
line in the order the user gave it, e.g. "git cherry-pick A B C",
using setup_revisions() and without walking the history, must look
at revs->pending.objects without calling prepare_revision_walk().
