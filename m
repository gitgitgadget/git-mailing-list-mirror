From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry-pick is slow
Date: Tue, 15 May 2012 13:32:01 -0700
Message-ID: <7v1umldw3i.fsf@alter.siamese.dyndns.org>
References: <CAPZ_ugYojqTaWi0atr2ApOu9xmcwy4y8FduNC+TDhgWgSxXNPQ@mail.gmail.com>
 <CAPc5daW6eBLUf55_Qk+4bA6Y16TehfOUGc1xFzhib9vm=8O2Yw@mail.gmail.com>
 <CAPZ_ugbV6hB+8z8UsQKdHhxGuHbLzC5WK19mK7M8k2tMz+mtXw@mail.gmail.com>
 <20120514145412.GA1159@sigill.intra.peff.net>
 <CAPZ_ugbD=mOPBs6GyapWtv6NWuJ-=r2+bqBN9n+gdTPwGj3F0Q@mail.gmail.com>
 <20120515132451.GA25378@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Risenberg <dmitry.risenberg@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 15 22:32:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUOPl-0002UV-1c
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 22:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966262Ab2EOUcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 16:32:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51708 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965427Ab2EOUcD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 16:32:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77A71834A;
	Tue, 15 May 2012 16:32:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yztgHko8OZZlenTw8WfEP4JcF4A=; b=VlH+qH
	rV4ZlYCjoEmmpvoPVtkvr7NjSkEuQGM7ircZ4TwQrWOFZyItbeRX2riCHxyD5bqC
	Yc6dKh2BoV7Wft0SeNbN9JLDPqktk44IGEirdFRjFXEQp14qEOAwxEFD1NFBDvLH
	VQdFM0dk3cZAkRdNt14yVvZL93ENBQbcCxCac=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VwMlwTish16bv6V6DxHWwiGDQkbhsDTG
	kcnokjcV8nA2wLP0PbBx4HxwGIsZxXVHl/yd2MF2Aq28UAkX6o2etbZJGoF7JMh7
	JKRlshE2B5FqT4E0p3eQ5DL/RGEJu9Gc3oVURaAsuDhfp6Zy7Uedt0gEVJ7Ta125
	wXfhe05VIr0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67B138349;
	Tue, 15 May 2012 16:32:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C00BE8348; Tue, 15 May 2012
 16:32:02 -0400 (EDT)
In-Reply-To: <20120515132451.GA25378@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 15 May 2012 09:24:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 076E3B50-9ECD-11E1-8219-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197855>

Jeff King <peff@peff.net> writes:

> [let's keep this on-list so others can benefit from the discussion]
>
> On Tue, May 15, 2012 at 12:38:59PM +0400, Dmitry Risenberg wrote:
>
>> > It's probably detecting renames as part of the merge, which can be
>> > expensive if the thing you are cherry-picking is far away from HEAD. You
>> > can try setting the merge.renamelimit config variable to something small
>> > (like 1; setting it to 0 means "no limit").
>> 
>> I set it to 1, but it didn't help at all - cherry-pick time is still
>> about the same.
>
> OK, then my guess was probably wrong. You'll have to try profiling (if
> you are on Linux, "perf record git cherry-pick ..."; perf report" is the
> simplest way). Or if the repository is publicly available, I can do a
> quick profile run.

Perhaps the word "cherry-pick" invites an expectation that it must be
faster than a full-tree merge, i.e. something like "format-patch | am -3",
especially when the change introduced by the commit being cherry-picked
touch only a handful of paths.

Unfortunately, I do not think that the actual implementation of
"cherry-pick" matches that expectation, as it is a full three-way merge.

I am somewhat curious to see what the performance characteristics would be
if the same commit is replayed using

	git format-patch -1 --stdout $commit | git apply --index --3way

pipeline.  Depending on the number of paths in the whole tree vs the
number of paths the $commit touches, I wouldn't be surprised if it is
faster.
