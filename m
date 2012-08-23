From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] specifying ranges: we did not mean to make ".." an empty
 set
Date: Thu, 23 Aug 2012 14:40:19 -0700
Message-ID: <7vhart2sos.fsf@alter.siamese.dyndns.org>
References: <7vd32i5y8w.fsf@alter.siamese.dyndns.org>
 <20120823082916.GA6963@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 23 23:40:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4f8f-0005rC-OD
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 23:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759263Ab2HWVkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 17:40:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48808 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758304Ab2HWVkW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 17:40:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02BA98787;
	Thu, 23 Aug 2012 17:40:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7rLNbAqUd1gZCVBLAy6KtGspO28=; b=RiHo3z
	wI73aNk3fygP8VZ+g2KPjmVupQ+G2tI3VzJE7Ldm7qamTESPsc1raz0wkGl43SvR
	uYGmRYhTXnpwjhmogC+EvHGuMKSwfw3w3HPXTnnTv90kWX7G9M/CUYfDv7Ax+tnv
	k6Qex5jcWqGm6EQdYn0u3siR3OrdW6sMy52jM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vXYf0D0jdDTqj0G/+mTL20Wi4IzM8Z3e
	V2cgLOesoMd7OlxkSGg6AJYR2y0IAOJqPz4teEFSpgeDlHGwdifr6HKocVX+2gA+
	GpTNUG9Sue+5ftO9w08J4/nxNkdCLDCKg1LWnDnPWqJ0/6PWl8muR16njXk2hTSp
	F27L1b5MiCw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E3CC48785;
	Thu, 23 Aug 2012 17:40:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E20638783; Thu, 23 Aug 2012
 17:40:20 -0400 (EDT)
In-Reply-To: <20120823082916.GA6963@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 23 Aug 2012 04:29:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 236B2844-ED6B-11E1-8EE5-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204175>

Jeff King <peff@peff.net> writes:

>> --- a/Documentation/revisions.txt
>> +++ b/Documentation/revisions.txt
>> @@ -213,6 +213,13 @@ of 'r1' and 'r2' and is defined as
>>  It is the set of commits that are reachable from either one of
>>  'r1' or 'r2' but not from both.
>>  
>> +In these two shorthands, you can omit one end and let it default to HEAD.
>> +For example, 'origin..' is a shorthand for 'origin..HEAD' and asks "What
>> +did I do since I forked from the origin branch?"  Similarly, '..origin'
>> +is a shorthand for 'HEAD..origin' and asks "What did the origin do since
>> +I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
>> +empty range that is both reachable and unreachable from HEAD.
>
> This last sentence confuses me. Now we are documenting that "yes, ..
> really means HEAD..HEAD, which is the empty range". But isn't the point
> of this patch to say "sure, it would be the empty range, but because
> that is stupid and pointless, we do not consider it valid and treat ..
> as a pathspec"?

No, we still allow ".." as a short-hand for HEAD..HEAD when it is
understood as a rev.  We also allow ".." as a pathspec to match the
parent directory when it is understood as a pathspec.

The only thing the topic wanted to change was the disambiguation
logic.  When a string S can name both rev and path, we ask the user
to disambiguate, but when S is "..", we do not have to (as one
interpretation is meaningless).

> I think that may be what you are trying to say with the "would" in that
> sentence, but perhaps this would be a good point to expand and mention
> that we special-case "..".

I think that documentation belongs to the section of disambiguation
without "--".  Usually you need to use "--", but ".." is taken as
path even without "--".  An interesting side effect is that

	git log .. pu

used to error out for ".." being both rev and path, but it will
error out for "pu" not being a path in the working tree.  This is
because on a command line without "--" disambiguation, once you
start listing paths, you have to have nothing but paths after that
point.

>> +test_expect_success 'dotdot is not an empty set' '
>> +	( H=$(git rev-parse HEAD) && echo $H ; echo ^$H ) >expect &&
>
> It almost certainly doesn't matter in practice, but the ';' here would
> break the &&-chain from rev-parse.

Yeah, my bad.  Thanks for spotting.
