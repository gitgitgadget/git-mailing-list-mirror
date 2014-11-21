From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git merge a b when a == b but neither == o is always a successful merge?
Date: Fri, 21 Nov 2014 10:51:28 -0800
Message-ID: <xmqqwq6oz8sv.fsf@gitster.dls.corp.google.com>
References: <21610.16623.746985.383838@perdition.linnaean.org>
	<20141117205304.GA15880@peff.net>
	<21610.29903.366230.851787@perdition.linnaean.org>
	<20141121181539.GC26650@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Daniel Hagerty <hag@linnaean.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 21 19:51:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrtIt-0008Lv-VA
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 19:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbaKUSvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 13:51:32 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60425 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750752AbaKUSvb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2014 13:51:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 322FE20618;
	Fri, 21 Nov 2014 13:51:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v/oEku82G/5RYZ1QN1HMJ/zwuYw=; b=DCl24n
	d8B0zqYQv5wHXIjI1OWHchJ+wiGoeJXtkC85bn2mZUB+4J8msw1i0J0LQPCNM5mG
	Eql0Ln0GBZQ/Y806oViI0yBy6P7KprqGBDp/WUHkr73HkUFeMFy5XCLWXSduSEon
	xcdcf5wWvDr+7r9ua0PS9CW+F4SdfAIe9c+1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uvMH8xfVmXNITjcZ52bhNuFOO/5QC7yG
	oD4KW8XapTNQdtVY+dKcUep5FDpCqJNOmDk//sLFGg19Rst/kImSIfj7t0nlaZKj
	a/gVNMKxkB5NV2ZF5lsrhUWnpnHug96dps20iCKS7yscApFOMGF+Gwc9Uy3OOyUL
	PuBl3RLTYEU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 28E4620617;
	Fri, 21 Nov 2014 13:51:30 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E39A20616;
	Fri, 21 Nov 2014 13:51:29 -0500 (EST)
In-Reply-To: <20141121181539.GC26650@peff.net> (Jeff King's message of "Fri,
	21 Nov 2014 13:15:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6770A3DC-71AF-11E4-B7FF-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is the first use of gitattributes in the unpack-trees code path. I
> cannot think offhand of any philosophical reason that should not be OK,
> but it is something worth considering (i.e., this code path is deep
> plumbing; are there cases where we would not want to support
> gitattributes?).

It is not about "not want to support", but mroe about "not want to
be affected (by user preference)", and it is a valid concern.

> ... if I have a tree that starts at
> sha1 X, and ends up at sha1 Y in both sides of the merge, do we still
> descend into it to make the file-level comparisons, or do we optimize
> that out?

The code to look at is unpack-trees.c::unpack_callback(); even
though it does try to be clever to do that exact optimization when
it is used for "diff-index --cached", I do not think we do it during
a real merge.
>> +	struct git_attr_check check;
>> +	check.attr = git_attr("merge-minimal");
>> +	(void) git_check_attr(path, 1, &check);
>
> Please void C99 decl-after-statement, as we build on older compilers
> that do not like it.

Also I do not think we want to keep calling git_attr() interning
function.  All existing uses (well, at least the ones that were
written by those who know what they are doing ;-) should be avoiding
repeated look-ups, and if we are to use an attribute for this, we
should do the same.

Do we name our attributes with "dashes-in-its-name"?  I am not
asking if dashes are allowed (I know it is), but if that breaks
the pattern already established for the core part of the system
and makes this new one an oddball.

> We also do not typically annotate ignored return values.

True.

>
>> +	if(ATTR_TRUE(check.value))
>> +	  xmp.level = XDL_MERGE_MINIMAL;
>> +	else
>> +	  xmp.level = XDL_MERGE_ZEALOUS;
>
> ..and indentations should be a single tab.

True, too.

> Other than those minor style nits, I do not see anything obviously
> _wrong_ with the patch, but I am far from an expert in the area.

I agree that the approach taken here is a sensible way to implement
the design, _if_ the design and the problem it tries to solve makes
sense.  I am not sure about that yet myself, though.
