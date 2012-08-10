From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] jk/version-string and google code
Date: Fri, 10 Aug 2012 08:34:45 -0700
Message-ID: <7vfw7ulq0a.fsf@alter.siamese.dyndns.org>
References: <20120810075342.GA30072@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 17:34:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzrEl-0001qB-0f
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 17:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085Ab2HJPeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 11:34:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50098 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547Ab2HJPes (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 11:34:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA12A8658;
	Fri, 10 Aug 2012 11:34:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vZRVJjj/jZvr0v1ZCINZdcrvAx8=; b=XF1jK6
	xpxFbmimZNFyd7yh0kT9k9dEgB0cup1acWxPt4RND1ABm1ZCyDee38+UyQ91ypOT
	ZTrDmyFdC6v7ok+Ia/XydklXoPjU6s3F6cTPmj8vlOJ4Dj7QQIT1vLIlBwh376CO
	un5C9JGO1mDMl7ACwVHlxj+xueNBcXFYQg6RI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m2fgoM0RIRj2KTh6iM0IpvBUNT3CsXMU
	RE4b9XPE1HS0wflUNgH904jEma+7SZ6StDjvOw3Qh+r748b5BmsdR9i9emH5qD34
	t4bzojtLBgJDJC4KAQJcGPMqr3sDwJW2hzwsBrrGbp9iHnkZf40UA5k9oyE1HV15
	qx1LUBHwwD4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D778E8657;
	Fri, 10 Aug 2012 11:34:47 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EEA98656; Fri, 10 Aug 2012
 11:34:47 -0400 (EDT)
In-Reply-To: <20120810075342.GA30072@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 10 Aug 2012 03:53:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA904A46-E300-11E1-AC34-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203226>

Jeff King <peff@peff.net> writes:

> Ugh, the jk/version-string topic breaks fetching from Google Code. With
> my patch, the client unconditionally sends an "agent=foo" capability,
> but the server does not like seeing the unknown capability and ends the
> connection (I'm guessing with some kind of internal exception, since it
> spews "Internal server error" over the protocol channel).

The fix looks sane and the right thing to do.

I've been using 'next' and started seeing this breakage when pushing
to code.google.com only a few days ago.  My reflog tells that
ff5effd (include agent identifier in capability string, 2012-08-03)
was merged to my everyday-work branch on this Monday, which is more
or less consistent with what I am observing.

> This is the right thing to do according to protocol-capabilities.txt,
> which says:
>
>   Client will then send a space separated list of capabilities it wants
>   to be in effect. The client MUST NOT ask for capabilities the server
>   did not say it supports.
>
>   Server MUST diagnose and abort if capabilities it does not understand
>   was sent.  Server MUST NOT ignore capabilities that client requested
>   and server advertised.  As a consequence of these rules, server MUST
>   NOT advertise capabilities it does not understand.
>
> However, that is not how git-core behaves. Its server side will ignore
> an unknown capability coming from the client (so not only is it more
> lenient about what the client does, but it does not follow the "MUST"
> directives in the second paragraph).

Yeah, we probably should fix in the implementation to honor the
"MUST".  When various implementations of clients can start asking
something the server does not support and still yet expect the
request to cause the server do unusual things, it will lead to
chaos, and honoring that "MUST" is a good way to catch and help
diagnosing such a breakage early.

But that is a separate topic and a longer term direction item.

Thanks.
