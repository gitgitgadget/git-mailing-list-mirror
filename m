From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] do not stream large files to pack when filters are
 in use
Date: Fri, 24 Feb 2012 13:20:01 -0800
Message-ID: <7vfwe0x726.fsf@alter.siamese.dyndns.org>
References: <20120224093924.GA11680@sigill.intra.peff.net>
 <20120224094805.GB11846@sigill.intra.peff.net>
 <7vehtkyp6i.fsf@alter.siamese.dyndns.org>
 <20120224204810.GC21447@sigill.intra.peff.net>
 <20120224210134.GA22177@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 24 22:20:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S12Yn-0000qR-1D
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 22:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758112Ab2BXVUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 16:20:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57792 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756160Ab2BXVUF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 16:20:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A61AB7033;
	Fri, 24 Feb 2012 16:20:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U2hMjkkL0iPfUUc52H9v8V61TNU=; b=N0/dct
	iZlxNLv6WTRwrhKteMX4NvZyakuUgNwnx+nW+o4LSYnaXmqO4jKXkdYKy5Mfxfau
	ool/ftZQFcj839OJiI5qMfQh/XF8TfwqQWYho68b9nz0uPFUAaIoUL4TsIeI84fG
	x24V6pewWPYhXBDrk+8EkgI8lvDY0xn17DXQY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ao8p2uneLq3XuAhmnr7WD+8AwJL2lL3j
	r9i6hTFc7Xq8lSF9Q3W/mKnmUDAZEtzXOQ841VWOcKHbOaZSNEEYGq16J9K1m9bX
	sQqn82wteU4RsC8TBt4AGgMuLu7v9YJz/ZXXiSw9mEoc+L6u93bhTuRwpsP4EmJ4
	yPpzY8NIuKM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D5817032;
	Fri, 24 Feb 2012 16:20:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F2D88702F; Fri, 24 Feb 2012
 16:20:02 -0500 (EST)
In-Reply-To: <20120224210134.GA22177@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 24 Feb 2012 16:01:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 50B5716E-5F2D-11E1-9653-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191483>

Jeff King <peff@peff.net> writes:

> On Fri, Feb 24, 2012 at 03:48:10PM -0500, Jeff King wrote:
>
>> On Fri, Feb 24, 2012 at 12:03:17PM -0800, Junio C Hamano wrote:
>> 
>> > > -	else if (size <= big_file_threshold || type != OBJ_BLOB)
>> > > +	else if (size <= big_file_threshold || type != OBJ_BLOB ||
>> > > +		 convert_to_git(path, NULL, 0, NULL, 0))
>> > 
>> > Nice.  It would be even nicer to give a readability macro whose name makes
>> > it clear that this is a query (unfortunately we cannot add '?' at the end
>> > of the function name) and not a conversion.  Any name suggestions?
>> ...
> I.e., you could call it like this:
>
>   convert_to_git(path, buf, len, NULL, 0);
>
> and find out the real answer, including inspecting buf, about whether
> we would convert. Or you could also use a NULL buffer to get the
> pessimistic "we might convert" case.
>
> I don't think it really matters that much, as I am introducing only one
> caller. I'm not sure if any other code paths would care about this
> speculative "maybe we would convert" question, so perhaps it is simply
> over-engineering.

I agree checking if dst is NULL makes a lot more sense than checking if
the src is NULL.

The reason I said "readability" macro was *NOT* because of these NULLs
looked unsightly.  I wanted the function name to tell "We are *NOT*
actually converting anything here at this point" to the readers.

I am perfectly fine to keep the source side of the parameters in the
readability macro, even if this partcular caller may have to spell NULL
and 0 there.

Thanks.
