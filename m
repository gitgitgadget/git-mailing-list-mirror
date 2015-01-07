From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Additional plumbing commands
Date: Wed, 07 Jan 2015 08:31:04 -0800
Message-ID: <xmqqa91ulfhz.fsf@gitster.dls.corp.google.com>
References: <CA+SVznFFPED+ms=4abNpvNQx-nt6imDMJtYKuNBTTLzCJ547Vw@mail.gmail.com>
	<CAP8UFD1OZ1QjHRyNGVs0Vm52=Ue-ta1gBzNxLpX25NSCbtu9EQ@mail.gmail.com>
	<20150107080408.GA1301@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Charles Rudolph <charles.w.rudolph@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 07 17:32:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8tVp-0005ak-EW
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 17:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600AbbAGQbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 11:31:08 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753293AbbAGQbG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 11:31:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FB9229762;
	Wed,  7 Jan 2015 11:31:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=svUsnlfc4AqUOfEagydrBZ/vfsE=; b=X8Ue/J
	u1aoeOFzC9fYaZ1uXBA/f7ymD44r3rdPAr504/43omOFZdXqctHwCzGJGzA0WF+l
	M7F8xLYS6iM/2D0XT1Ckiqt0AsTSdrDCqrGRh2mMHegGnMYEJh/jMggwHdn93tQ3
	dDvWrTFe4WHc58rtYhdwaih1Kn4GjSOnSDlT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LezMmQQ52fC4gScWFh2ybolox790dGZE
	hdXzp/uonwM3q12ER/xpVdDKeuRxYVEcRpynFg5EaG5IIjjhUTfYc/xWQ126pXF/
	ifJLxjYHKMlaHxhI2eZGAJUGut7BkCU8BcPey94t28ZUxb8osrElg/lXmNQGFsor
	hFGteyaC+5I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 36A5A29760;
	Wed,  7 Jan 2015 11:31:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 749C52975F;
	Wed,  7 Jan 2015 11:31:05 -0500 (EST)
In-Reply-To: <20150107080408.GA1301@peff.net> (Jeff King's message of "Wed, 7
	Jan 2015 03:04:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 93B2880C-968A-11E4-930C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262136>

Jeff King <peff@peff.net> writes:

> ... Knowing what each state _means_
> and what operations are meaningful to perform is much trickier (e.g., if
> we are in a rebase, you probably do not want to start a new rebase. But
> is it wrong to cherry-pick?).
>
> It would be nice if we could find a way to generalize in-progress
> operations and what they mean for starting new operations, but that is
> a much harder problem (if it is even possible at all).

Very good points. Thinking aloud, to see if we can start from a few
rules of thumb.

You can be "in the middle" for two largely different reasons.

One is that the command inherently wants to give control back to
you.  Think of a case where you said "exec false" in the "rebase -i"
insn sheet, or "bisect" checked out a version for you to try.

The other is that the command wanted to continue in the ideal world,
but couldn't and stopped asking for your help.  Think of a case
where "am" stopped due to corrupt patch, "cherry-pick A..B" or
"revert" stopped due to conflicts.

In the former case, depending on the nature of the command, what are
sensible things you can do are very different (during "bisect" you
would typically not want to do anything that causes a commit
created.  During "rebase -i" you may want to run any command that
creates a commit, to insert a new one into the series).  But a good
rule of thumb would be "If I should be able to edit the working tree
file, I should also be able to do "cherry-pick --no-commit", "merge
--no-commit", "apply", etc." "If I should be able to manually
commit, I should also be able to "cherry-pick", "merge", etc.

In the latter, the _only_ reason you are given control back is to
help the interrupted operation.  So "cherry-pick --no-commit" or
"apply" in lieu of editing files manually in order to fix conflicts
should be allowed, but a random "git merge" (without --no-commit)
would not be.

So after thinking aloud for a while, I very much agree with you that
you cannot say "X is allowed but not Y" in many situations.

One thing we can say for sure is that in a middle of a multi-step
operation (e.g. rebase, range pick) is stopped for either one of the
two reasons, you cannot do another multi-step operation.  This is
not fundamental but a consequence of how the sequencing machinery is
implemented.  But other than that, it really is case-by-case and not
even command-by-command.
