From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH-v2/RFC 3/6] xutils: fix ignore-all-space on incomplete
 line
Date: Sun, 23 Aug 2009 12:40:51 -0700
Message-ID: <7vljlauxmk.fsf@alter.siamese.dyndns.org>
References: <1250999285-10683-1-git-send-email-git@tbfowler.name>
 <1250999357-10827-3-git-send-email-git@tbfowler.name>
 <7vvdkfx8rl.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0908231110500.29625@GWPortableVCS>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Thell Fowler <git@tbfowler.name>
X-From: git-owner@vger.kernel.org Sun Aug 23 21:41:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfIwA-0002C5-NH
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 21:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933928AbZHWTlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 15:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933883AbZHWTlA
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 15:41:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37258 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933882AbZHWTk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 15:40:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C2548162EF;
	Sun, 23 Aug 2009 15:40:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=8cbqAETNrIJAIWkhMKaRE4PGA40=; b=IdpcIyFQnnTrl3uLxalihZG
	F3Aeoo5A3qfzqRv83it8Q3FRKneGBFj3KjLdRW/G/O8H5B2fWIYdplyRcTK0YucK
	XpkF0CcYnF/XEg3J2ZEI8xxTJOeoACzVr63WtyehMN5c8Ddff0TBuLqO8HC19d46
	JU4pGKEAwPVfBkqzg7LA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=m3cQ5NfMvol9Rjm7NMJVv/bCunRVgDO/Fv2pZXvjFDVpHZCt8
	iP+mVRyHapzplBfqxxnX7XMwokuIeBpikFEXMJnWUUMxRlPO0eMAswCoHUJ1oSsG
	m/932zyjmnrd8y0VV17PGeZ0TfskUT32JRj+OjPhU/N9Bjaht1mt2Y9FJ8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9629E162EE;
	Sun, 23 Aug 2009 15:40:56 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B7FE9162ED; Sun, 23 Aug
 2009 15:40:52 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E06266D8-901C-11DE-B957-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126866>

Thell Fowler <git@tbfowler.name> writes:

> Because the flow is much more direct it also makes the test additions to 
> t4015 obsolete as they essentially tested for line end conditions instead 
> of whitespace (like they should have).

Your patch 6/6 that added the tests were useful to find a bug I originally
had, which is the one below that is commented out.

>> +		/*
>> +		 * If we do not want -b to imply --ignore-space-at-eol
>> +		 * then you would need to add this:
>> +		 *
>> +		 * if (!(flags & XDF_IGNORE_WHITESPACE_AT_EOL))
>> +		 *	return (s1 <= i1 && s2 <= i2);
>> +		 *
>> +		 */
>> +
>
> While it would be nice to have -b and --ignore-space-at-eol be two 
> different options that could be merged together the documentation states 
> that -b ignores spaces at eol, and there are scripts that depend on this 
> behavior.

Also that is how "diff -b" behaves, and that is why I said your tests
found a _bug_ in my original.  I'll drop the above large comment and
replace it with just a "/* -b implies --ignore-space-at-eol */".

> Right now the xdl_recmatch() checks three distinct flags before having the 
> opportunity to do the default behavior of a straight diff.  In 
> xdl_hash_record there is an initial check for whitespace flags.
>
> ...
> 	if (flags & XDF_WHITESPACE_FLAGS)
> 		return xdl_hash_record_with_whitespace(data, top, flags);
> ...
>
> Perhaps a similar setup for xdl_rematch() and a 
> xdl_recmatch_with_whitespace() ?

Or we can just move the final else clause up and start the function like
this:

	int i1, i2;

	if (!(flags & XDF_WHITESPACE_FLAGS))
 		return s1 == s2 && !memcmp(l1, l2, s1);

	i1 = i2 = 0;
 	if (flags & XDF_IGNORE_WHITESPACE) {
		...

that would get rid of two unnecessary clearing of variables (i1 and i2,
even though I suspect that the compiler _could_ optimize them out without
such an change), and three flags-bit check in the most common case of not
ignoring any whitespaces.

> Since your to counter-proposals give the same results, provide safer and 
> faster processing, eliminate the additional test, as well as being easier 
> to read and comprehend I propose a v3 with just those two patches.  I'll 
> be glad to post it, with or without a xdl_recmatch_with_whitespace, if 
> need be.  And should I, or do I need to, add something to the commit (ie: 
> ack, tested, ...) ?

I can amend the counterproposal patches with tests from your 6/6 and add
your "Tested-by:" and commit them myself.

> Thank you again for taking the time to look at this change!

Thank _you_ for bringing this issue up in the first place.
