From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Why is "git fetch --prune" so much slower than "git remote prune"?
Date: Thu, 19 Mar 2015 12:24:21 -0700
Message-ID: <xmqqpp84iye2.fsf@gitster.dls.corp.google.com>
References: <CACBZZX5n5tTCSa-_A5gQzbzboF_v8a3_oVUjdjyFtKHHe8h-NA@mail.gmail.com>
	<20150306225917.GA1589@peff.net> <550AE1E4.7020407@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	=?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 19 20:24:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYg3R-0003WN-Cg
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 20:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbbCSTYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 15:24:25 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63737 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750787AbbCSTYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 15:24:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C8BD41A48;
	Thu, 19 Mar 2015 15:24:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nvXPFYSptUSzsDNzVhMsZvCidaA=; b=XhWFJb
	ctQ0A5SC9VU3I757XvQLHlrHPz2wAF+r7NQ2Fk2cVRYDuJNuX9XMeGvxm83cT14m
	wI3N5wRON0j0tJYj7pq/VX31aYU5z2o4gi2TScD6dGpF2kI7icf7yOB1CBKfdkzG
	T2APBhOBxTZAwufzkUATmPizY+vwan6XcB0vE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CJPL0r5/Eh1NEBlgqEbFuQIR1nrVfF35
	ZAmuEjghHyXFSlHmZCeCXA8tSGt78f+n4Rc7rSMHlUtJD2Cf9iEjUpLaHSAkdlGO
	DAb7QpeUl9AUZHhKez8LhBzu9sd1aaOh3YuhOqy6sXmyRnhAG+fGuQ4DgMUB4SUC
	ShPUIx5eKpA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 943C441A47;
	Thu, 19 Mar 2015 15:24:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 073B541A46;
	Thu, 19 Mar 2015 15:24:23 -0400 (EDT)
In-Reply-To: <550AE1E4.7020407@alum.mit.edu> (Michael Haggerty's message of
	"Thu, 19 Mar 2015 15:49:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8C74398A-CE6D-11E4-B60A-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265819>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> Now that we have ref_transaction_*, I think if git-fetch fed all of the
>> deletes (along with the updates) into a single transaction, we would get
>> the same optimization for free. Maybe that is even part of some of the
>> pending ref_transaction work from Stefan or Michael (both cc'd). I
>> haven't kept up very well with what is cooking in pu.
>
> I am looking into this now.
>
> For pruning, we can't use a ref_transaction as it is currently
> implemented because it would fail if any of the reference deletions
> failed. But in this case I think if any deletions fail, we would prefer
> to emit a warning but keep going.

I am not quite sure what you mean here.  I agree with you if you
meant "we shouldn't fail the fetch only because 'fetch --prune'
failed to remove only one of the remote-tracking refs that are no
longer there" but that can easily be solved by the pruning phase
into a separate transaction.  If you meant "we would rather remove
origin/{a,b} non-atomically when we noticed that origin/{a,b,c} are
all gone than leaving all three intact only because we failed to
remove origin/c for whatever reason", my knee-jerk reaction is "does
it make practical difference to the end user between these two?"

What are the plausible cause of failing to prune unused
remote-tracking refs?
