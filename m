From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] describe/name-rev: tell name-rev to peel the incoming object to commit first
Date: Tue, 09 Jul 2013 04:45:39 -0700
Message-ID: <7vr4f8vtwc.fsf@alter.siamese.dyndns.org>
References: <1373236424-25617-1-git-send-email-gitster@pobox.com>
	<1373236424-25617-5-git-send-email-gitster@pobox.com>
	<20130709050615.GF27903@sigill.intra.peff.net>
	<7va9lwxpp5.fsf@alter.siamese.dyndns.org>
	<20130709053533.GA4395@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 09 13:45:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwWMd-0003UB-MN
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 13:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751Ab3GILpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 07:45:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63908 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753677Ab3GILpn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 07:45:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12D092D3D1;
	Tue,  9 Jul 2013 11:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CTGydb/ClyX48KrsSx8m1iFaBXQ=; b=cnnnOb
	suNkjDOS5XO8TS6zUUrX4HrYrGZVs3LNzEQ0mKGNFVx1ce4s8jcL2+cRyk9BPwZu
	xLcnAAsmQSfVCXzHV63RoRvUqE2NmTptyySu+8UEWPirZ8yyskIY/sMXEqeSIqXD
	Ag+CJolEaiosKzi48x8cjVlCKwLFjk0r4KvJI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=doqcZ4nCDd2PlgmT7L5qShcrFpO8FHOS
	v0exHvvs13/MHj9kHWuklgXcWumbX0tkZl0Acz/Z6tqkgDSfowYkgX5sLfKJRKaL
	8C5FE20S5dWxjT13sdA0QNuxJP23arn3E1PWFKauIy6eGsG88RxIzfLTMp5L38fC
	aoqpqSTO01c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A00F2D3D0;
	Tue,  9 Jul 2013 11:45:42 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A6972D3CD;
	Tue,  9 Jul 2013 11:45:41 +0000 (UTC)
In-Reply-To: <20130709053533.GA4395@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 9 Jul 2013 01:35:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14E54548-E88D-11E2-8554-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229947>

Jeff King <peff@peff.net> writes:

> Although I am still not clear on why it would not be up to the caller of
> git-describe in the first place to decide which they wanted.

Thanks for a dose of sanity.

Even though the part of the miniseries that makes sure that "X (Y)"
output from "name-rev" always satisfies that "rev-parse" on X and Y
give the same thing is an improvement, the whole thing about
"describe" is misguided and wrong, I think.

It started from the observation that these do not match:

    $ git describe $(git rev-parse v1.8.3)
    v1.8.3
    $ git describe --contains $(git rev-parse v1.8.3)
    v1.8.3^0

and the miniseries veered in a wrong direction of "fixing" the
latter to match the former.

But the thing is, what is incosistent from the rest of the world is
the describe output without "--contains" for a commit that is
exactly at a tag (i.e. the former), and there is no need to "fix"
this "inconsistency", as we see below.

The form without "--contains" in general reads like this:

    $ git describe --long $(git rev-parse v1.8.3) a717d9e
    v1.8.3-0-gedca415
    v1.8.3-2-ga717d9e

They both name a commit object, but that is sort of an afterthought;
the support for describe name came late at 7dd45e15 (sha1_name.c:
understand "describe" output as a valid object name, 2006-09-20).

The primary purpose of "git describe" without "--contains" is to
give a string that is suitable for a version number to be embedded
in an executable.  For that purpose, "v1.8.3" is more convenient
than "v1.8.3-0-gedca415".

But this convenient format breaks the consistency.  While any other
describe name for a commmit names a commit, the output for a commit
that is exactly at a tag does not (in ancient times, describe output
were not even extended SHA-1 expressions, so this inconsistency did
not matter, but the "afterthought" brought the consistency to the
foreground).  The user chooses the convenience over the consistency
by not using "--long".

And the short form cannot be "v1.8.3^0" or "v1.8.3~0" for the sake of
"consistency", as these are no more suitable as a version number
than a short and sweet "v1.8.3".

The "--contains" form does not even aim to come up with a pleasant
looking version string without using funny line noise characters, so
it is perfectly fine for it to say:

    $ git describe --contains $(git rev-parse v1.8.3) a717d9e
    v1.8.3^0
    v1.8.3.1~9

and these are internally consistent (they both roundtrip via
rev-parse).  Stripping "^0" from the former will break the
consistency, even though it may make the output look prettier, but
the "--contains" output is not even meant to be "pretty" in the
first place.

So let's drop 4/4; it is breaking the system by trying to solve a
problem that does not exist.
