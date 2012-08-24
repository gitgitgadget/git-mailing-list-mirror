From: Junio C Hamano <gitster@pobox.com>
Subject: Re: in_merge_bases() is too expensive for recent "pu" update
Date: Fri, 24 Aug 2012 08:52:03 -0700
Message-ID: <7v1uiw2spo.fsf@alter.siamese.dyndns.org>
References: <CACsJy8C-VxzwigyUDHnUkXN7vhB+93X96pH9MvgB0ps7v-_NmQ@mail.gmail.com>
 <878vd5k7uu.fsf@thomas.inf.ethz.ch> <7vd32h4h1t.fsf@alter.siamese.dyndns.org>
 <7v393d49xs.fsf@alter.siamese.dyndns.org> <87393cbp6b.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 24 17:52:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4wBG-0007QX-Qm
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 17:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498Ab2HXPwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 11:52:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56518 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932354Ab2HXPwG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 11:52:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6340A8626;
	Fri, 24 Aug 2012 11:52:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t0cn4qEB8i1csjF1s3Vhpsjr4VM=; b=A7dai7
	1YbxCC2J+EKQbz9D0f3W08+TCKfaptqWgYk/fkB6hJDd2xd8K6l9tClIoyrCF3Jh
	CPLq3AcIoLumkML2hSliDxI92LzGXFp2BhilCBIsch3mgHgZ0SqwDxchy9rnmOVU
	B5CEQn9HlYFPR09mlHKmHKRRoOXMlkOnrU12I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pwl/ZxzFNZdJWAhodPStXQd4d/wcG9Ut
	4tGSvTpIyZN2JTY9oRHxRUBoUq0c0ggkuXk+DER7nj411ykcbH/wY4v0/zzU0Fxc
	ooYiIdwZPWRnRY+t0yxI/5u56vv4I3osmO7Og0+e2LMrjjt6Tt8tkdASw8V5kGMu
	ceIUp1P/qlg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 505158624;
	Fri, 24 Aug 2012 11:52:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89FA88621; Fri, 24 Aug 2012
 11:52:04 -0400 (EDT)
In-Reply-To: <87393cbp6b.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Fri, 24 Aug 2012 11:43:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6A16EF6-EE03-11E1-B9B7-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204216>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
>> Start from A and B.  Follow from B to find 'x' and paint it in blue,
>> follow from A to find 'y' and paint it in amber.  Follow from 'x' to
>> '1', paint it in blue.  Follow from 'y' to '1', paint it in amber
>> but notice that it already is painted in blue.
> [...]
>>             o-------o
>>            /         \
>>           /       y---A
>>          /       /
>>      ---2---z---1---x---B
>>          \         /
>>           o-------o
> [...]
>> So we need to notice that '1' and '2' have ancestry relation in
>> order to reject '2' as "common but not merge-base".  One way of
>> doing so is not to stop at '1' and keep digging (and eventually we
>> find that '2' is what we could reach from '1' that already is a
>> merge base), but then we will be susceptible to the same kind of
>> clock skew issue as the revision traverser.
>
> I think that is *the* way to do it.

But we do not live in *that* world.  At least not yet.

> I conjecture that every history walking problem can be solved in time
> linear in the number of commits once we properly use the generation
> numbers ;-)

I would conjecture that too, but we do not live in that world yet.
