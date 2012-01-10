From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] attr: don't confuse prefixes with leading directories
Date: Tue, 10 Jan 2012 11:23:01 -0800
Message-ID: <7vlipf9xbe.fsf@alter.siamese.dyndns.org>
References: <20120110070300.GA17086@sigill.intra.peff.net>
 <4F0BFE6E.6080904@alum.mit.edu>
 <20120110171100.GA18962@sigill.intra.peff.net>
 <20120110180820.GA15273@sigill.intra.peff.net>
 <20120110182140.GB15273@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Henrik =?utf-8?Q?Grubbstr=C3=B6m?= <grubba@grubba.org>,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 10 20:23:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkhHv-0007KO-1X
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 20:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402Ab2AJTXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 14:23:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46031 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932244Ab2AJTXF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 14:23:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02B067707;
	Tue, 10 Jan 2012 14:23:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j44lkiFQUSleLb13nC4KR0TX2Uc=; b=iBJ3j4
	bd+0/jaRU4qeCSxolpFy4WRYb5MOVvtGgqCw06uKwP8R49BwqnhJ6JOA5zHIwU39
	OeyU5DP8HdQHi6jtDMmEAvv/y9ali+fy/l3ZirgiaiGcIxwMU68VVcDHdsHz/h5L
	OTK+0pniEW9ZOgIKoCsU+KYG6eIkHrkNCdaFM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mb8htDC6ObFYlpht2+5/gBtsU+8p9jKd
	O3P6XROuyGXccT6Nd+335Ug+xM9KofoKpKWXREbIEnJyrb2TbqRCvAcUsKJnXqAN
	7t/Lgg3eO8ZLXdcwjXHRj0fe7WkzQDlra3lYrqdSyGQQ7WmlfkTDILBszMpfS2Cp
	LWfpRqB8lOQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDE197706;
	Tue, 10 Jan 2012 14:23:03 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 82F117705; Tue, 10 Jan 2012
 14:23:03 -0500 (EST)
In-Reply-To: <20120110182140.GB15273@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 10 Jan 2012 13:21:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84327A22-3BC0-11E1-98B6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188281>

Jeff King <peff@peff.net> writes:

> IOW, our loop breaks out when attr_stack is NULL, but then we go on to
> assume that attr_stack is _not_ NULL. This isn't a bug, because it turns
> out that we always leave something in the attr_stack: the root
> gitattributes file (and the builtins).  But it is slightly confusing to
> a reader because of the useless loop condition.
> 
> I'm not sure if the right solution is to change the popping loop to:
>
>   /* we will never run out of stack, because we always have the root */
>   while (attr_stack->origin) {
>           ...

Yeah, that makes sense, as that existing check "attr_stack &&" was a
misguided defensive coding, that was _not_ defensive at all as we didn't
do anything after we stop iterating from that loop and without checking
dereferenced attr_stack->origin, which was a simple bogosity.

>
> Or to be extra defensive and put:
>
>   if (!attr_stack)
>           die("BUG: we ran out of attr stack!?");
>
> after the loop, or to somehow handle the case of an empty attr stack
> below (which is hard to do, because it can't be triggered, so I have no
> idea what it would mean).

And this is even more so.
