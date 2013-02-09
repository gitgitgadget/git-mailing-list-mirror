From: Junio C Hamano <gitster@pobox.com>
Subject: Re: segfault for git log --graph --no-walk --grep a
Date: Fri, 08 Feb 2013 16:39:12 -0800
Message-ID: <7vfw16xqvj.fsf@alter.siamese.dyndns.org>
References: <201302090052.22053.thom311@gmail.com>
 <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
 <7vobfuxrns.fsf@alter.siamese.dyndns.org>
 <20130209002710.GA5570@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Haller <thom311@gmail.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 09 01:39:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3yTn-0006s3-I4
	for gcvg-git-2@plane.gmane.org; Sat, 09 Feb 2013 01:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270Ab3BIAjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 19:39:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49188 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932076Ab3BIAjP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 19:39:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37ADEB041;
	Fri,  8 Feb 2013 19:39:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sNBKltJoinMgj8TTIVRPNxeuT7A=; b=d4bIK9
	MwkAAAau4ixdcXnTnNXsLcUkwyY426Vdvw1cSZn4g0d3txV4g4if9M9AZELbMXiT
	vWW01qTPO6BY2sO2dt3aw/AvcDn+kslyCYXx9kCX95peoOQD6vJr/KeI2yAU21Yu
	wnP55keSn6Coq0wHpOSqMhu0FJjLMHtGa8rZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rDZI0HnabYIK2ffCsIyKFLJmUsXL2kPX
	hL07WwCJSfHjc2E0JYY8htJCLv5FmoQi8t3vE0i1SmPyP4KK2B0kaoXob/vLSqBA
	jh08nOium4GixTjSqnuByXCHZBYzzdzcQx/iJsMHuyP70w6tU7kLzZnoSPfg+KzD
	XU+rHs4Xeos=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29A7DB040;
	Fri,  8 Feb 2013 19:39:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F772B03E; Fri,  8 Feb 2013
 19:39:13 -0500 (EST)
In-Reply-To: <20130209002710.GA5570@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 8 Feb 2013 19:27:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 206F385E-7251-11E2-9481-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215833>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 08, 2013 at 04:22:15PM -0800, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Thomas Haller <thom311@gmail.com> writes:
>> >
>> >> it happens in file revision.c:2306 because "commit->buffer" is zero:
>> >>
>> >>                 retval = grep_buffer(&opt->grep_filter,
>> >>                                      commit->buffer, strlen(commit->buffer));
>> >
>> > I think this has been fixed at be5c9fb9049e (logmsg_reencode: lazily
>> > load missing commit buffers, 2013-01-26); I haven't merged it to any
>> > of the maintenance releases, but the tip of 'master' should have it
>> > already.
>> 
>> Ah, no, this shares the same roots as the breakage the said commit
>> fixed, and the solution should use the same idea, but not fixed.
>
> Yeah, I think this needs separate treatment. However, this is a perfect
> example of the "case-by-case" I mention in the final two paragraphs
> there.
>
> What's the right encoding to be grepping in? The original, what we will
> output in, or even something else? IOW, I wonder if this should be using
> logmsg_reencode in the first place (the obvious reason not to want to do
> so is speed, but logmsg_reencode is written to only have an impact in
> the case that we do indeed need to reencode).

Yeah, that actually is a good point.  We should be using logmsg_reencode
so that we look for strings in the user's encoding.
