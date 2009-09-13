From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push --confirm ?
Date: Sun, 13 Sep 2009 03:37:32 -0700
Message-ID: <7vljkjuo43.fsf@alter.siamese.dyndns.org>
References: <1252777897.2974.24.camel@localhost.localdomain>
 <20090912184342.GB20561@coredump.intra.peff.net>
 <7vvdjn8ymk.fsf@alter.siamese.dyndns.org>
 <20090913093324.GB14438@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Owen Taylor <otaylor@redhat.com>, git@vger.kernel.org,
	Colin Walters <walters@verbum.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 12:37:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmmSx-0001Wy-0N
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 12:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000AbZIMKhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 06:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752725AbZIMKho
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 06:37:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbZIMKho (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 06:37:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D55663059C;
	Sun, 13 Sep 2009 06:37:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x1lcDtQYS9IGem972to5FQUnHbQ=; b=Ikh37H
	sRZcv+quTNUQjCba/MiMICVVlWTDrHTPKFYsKyNGR89Dmk8/SmrTAQBKO/L3jkT6
	cJJEqMgrMDqLZdrxAmGQxL2M22v8YCsSY0IKB8tIbZuUfyn0ttJ73JROXsy0G+XY
	zHdfzcNTCCbz+mggzbNByqIwmEmxqRT2uq7Fw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wuXjBs6ZGY5sRNxgh1oLchstCWwwQD6P
	AQmUNQFNADzVN7/ZZ68HGB25PQ19DqA5aoOFNiVe5TUHp+BIC00jEuuERorWNpAS
	HUTm/aDTDglg8Qka8WKY+5uLGtlGrC7ltNJ12VBlt9Ze/4fIx98fNeLmxOQdkxrr
	BJkqtWikG5s=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DED73059B;
	Sun, 13 Sep 2009 06:37:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5F1C30594; Sun, 13 Sep
 2009 06:37:35 -0400 (EDT)
In-Reply-To: <20090913093324.GB14438@coredump.intra.peff.net> (Jeff King's
 message of "Sun\, 13 Sep 2009 05\:33\:24 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 765BB5CE-A051-11DE-AE41-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128352>

Jeff King <peff@peff.net> writes:

>> I do not think this is an unreasonable option to have.  Just please don't
>> justify this change based on atomicity argument, but justify it as a mere
>> convenience feature.
>
> I don't agree. Making sure we use the _same_ <old-sha1> in the
> confirmation output we show to the user and in the ref update we send to
> the remote is critical for this to be safe.

OK.

You may be giving stale info to the user if somebody else is pushing from
sideways anyway, and the difference between a separate --dry-run and real
push when that happens is where and how the human waits.

With a separate --dry-run, the wait happens while the output is examined
offline.  The user may run "git log --oneline old...new" himself before
deciding to run the real push.

With --confirm, the wait happens while the --confirm waits for the human,
and perhaps the command does "git log --oneline old...new" as convenience.
While all this is happening, the TCP connection to the remote end is still
kept open.  We do not lock anything, but if somebody else pushed from
sideways, at the end of this session we would notice that, and the push
will be aborted.

This somewhat makes me worry about DoS point of view, but it does make it
somewhat safer.

I think the largest practical safety would come from the fact that this
would make it convenient (i.e. a single command "push --confirm") than
having to run two separate ones with manual inspection in between.  A
safety feature that is cumbersome to use won't add much to safety, as that
is unlikely to be used in the first place.
