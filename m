From: Junio C Hamano <gitster@pobox.com>
Subject: Re: segfault for git log --graph --no-walk --grep a
Date: Mon, 11 Feb 2013 12:36:52 -0800
Message-ID: <7vvc9ylh97.fsf@alter.siamese.dyndns.org>
References: <201302090052.22053.thom311@gmail.com>
 <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
 <7vobfuxrns.fsf@alter.siamese.dyndns.org>
 <20130209002710.GA5570@sigill.intra.peff.net>
 <7vfw16xqvj.fsf@alter.siamese.dyndns.org>
 <7va9rexqii.fsf@alter.siamese.dyndns.org>
 <20130211191607.GA21269@sigill.intra.peff.net>
 <7v621ymxfv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Haller <thom311@gmail.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 21:37:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U507r-0000j4-9N
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 21:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759570Ab3BKUgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 15:36:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56810 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759394Ab3BKUgz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 15:36:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39549CA3F;
	Mon, 11 Feb 2013 15:36:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UubiaDehQa96A7JPV0ZFiZFwzwo=; b=ginM02
	uXCjopFJLI9efN9i3TEhmo60hSt07kFZyLlUQACRG8IU71A8sJ1heKdfxatQgnUa
	vEI2JdwFIabRnnHb107UIasDoe9I/zQIlSaRnHbdXu44ybS8JkAmz5un+gKjNs5q
	XF/p3DFYskhgG0nCZDAhRzxDBd27JNTGHlcVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WEEb6VOLWxjPTSIfgHllBOQdeeyWriwo
	IF+WaAJhf0MRV8Nh4DP18CgVlhtTTjxMPPyNMwiayiuMnHMxhMCLvgmYGZUyQ2ie
	FGIHaGwh/l2UsoQDVkOLPvU3BGl2Lb0krn9iNeYf/6P43tn5h6ZnE28h1HnuS6Fu
	AXaMp5GCVZk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D66ECA3E;
	Mon, 11 Feb 2013 15:36:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CE88CA3D; Mon, 11 Feb 2013
 15:36:53 -0500 (EST)
In-Reply-To: <7v621ymxfv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 11 Feb 2013 12:01:56 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C51CCEEE-748A-11E2-B573-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216083>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Fri, Feb 08, 2013 at 04:47:01PM -0800, Junio C Hamano wrote:
>>
>>> > Yeah, that actually is a good point.  We should be using logmsg_reencode
>>> > so that we look for strings in the user's encoding.
>>> 
>>> Perhaps like this.  Just like the previous one (which should be
>>> discarded), this makes the function always use the temporary strbuf,
>>> so doing this upfront actually loses more code than it adds ;-)
>>
>> I didn't see this in What's Cooking or pu. We should probably pick an
>> approach and go with it.
>>
>> I think using logmsg_reencode makes sense. I'd be in favor of avoiding
>> the extra copy in the common case, so something like the patch below. If
>> you feel strongly about the code cleanup at the minor run-time expense,
>> I won't argue too much, though.
>
> Sounds good to me.  Care to do the log message while at it?

Heh, how about this?  I still need a sign-off from you.

Thanks.

commit 6a76814cd08cac15c1faff5bd97c9e94ac8b6a01
Author: Jeff King <peff@peff.net>
Date:   Mon Feb 11 14:16:07 2013 -0500

    log --grep: look for the given string in log output encoding
    
    We used to grep in the raw commit buffer contents, possibly pieces
    of notes encoded in log output encoding appended to it, which was
    insane.
    
    Convert the contents of the commit message also to log output
    encoding before looking for the string.  This incidentally fixes a
    possible NULL dereference that can happen when commit->buffer has
    already been freed, which can happen with
    
    	git commit -m 'text1' --allow-empty
    	git commit -m 'text2' --allow-empty
    	git log --graph --no-walk --grep 'text2'
    
    which arguably does not make any sense (--graph inherently wants a
    connected history, and by --no-walk the command line is telling us
    to show discrete points in history without connectivity), and we
    probably should forbid the combination, but that is a separate
    issue.
