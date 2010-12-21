From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dangerous "git am --abort" behavior
Date: Mon, 20 Dec 2010 16:30:10 -0800
Message-ID: <7vtyi8arxp.fsf@alter.siamese.dyndns.org>
References: <AANLkTinP4SArMkjvTXOEG=tf=8EcEdP9fPAB7F=iitSc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 21 01:30:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUq7U-0004NI-GG
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 01:30:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932970Ab0LUAaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Dec 2010 19:30:19 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52261 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757844Ab0LUAaS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Dec 2010 19:30:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D04F354B;
	Mon, 20 Dec 2010 19:30:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LUpjT2dJgLdqnkbLs5ihILlq9ho=; b=qrqsYZ
	uQ1hL71REoJyk9iA5fAmx1FGBI9eNBfOybcnjSwZaIbyZJ6zGV/85NNuokD8q3lp
	piOzzgVN+l77ldW978XM6qdpV3PnT/8NgPYWzAWlmu6EcGPKbGaIG+6ctSY05VoV
	HwENkSMI4sV7mLP/CrtMpFZJwy2m2n8f3xLeE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=txJgolvcvgrVfNzZq+u6n8/lYcZAxtK/
	Fi+1+YjhKdG/dLMVY/GgI6TlmKSm0Ui0rbcNw+ZDZoAxj/1rPDgWbxhMyE05IW2E
	LUksJlH9t5u3JBWTk75SCy4dKO0P3Fu1VcWqnEeVzOYS7+HgVypjS1peOUIVY0Ua
	S9LSx0USA8E=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3A0A6354A;
	Mon, 20 Dec 2010 19:30:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4D9143549; Mon, 20 Dec 2010
 19:30:40 -0500 (EST)
In-Reply-To: <AANLkTinP4SArMkjvTXOEG=tf=8EcEdP9fPAB7F=iitSc@mail.gmail.com>
 (Linus Torvalds's message of "Mon\, 20 Dec 2010 10\:31\:05 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8B8E05E0-0C99-11E0-94E3-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164020>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I just noticed this, and I wonder if it has bitten me before without
> me noticing: "git am --abort" can be really dangerous.
>
> What happened today was that I had been doing a pull or two, and then
> applied an emailed patch with "git am" as usual. But as sometimes
> happens, I actually had a previous "git am" that had failed - in fact,
> it was the same patch that I applied today that had had an earlier
> version that no longer applied.

I never got into this as I use bash completion in my PS1 in the real life,
but I've seen this happen while playing around, and I can see myself
easily getting hurt by this behaviour without status in PS1.

> Maybe "git am" should actually save the last commit ID that it did,
> and only do the "reset" if the current HEAD matches the rebase-apply
> state and warns if it doesn't? Or maybe we could just introduce a new
> "git am --clean" that just flushes any old pending state (ie does that
> "clean_abort" thing, which is basically just the "rm -rf" I've done by
> hand). Or both?

I sometimes wanted "--clean" myself, so it is a no-brainer to decide that
it would be a good thing to add.

The last time I thought about this issue, I wasn't sure about "compare
with the last commit"---mostly because it wasn't clear what ramifications
it would have.  When you get refusal from "am --abort", how would you
recover from it?

Back then my tentative conclusion was actually to get rid of "am --abort"
and give "am --clean", making the final "reset HEAD~$n" the responsiblity
of the user.  But I forgot to pursue it.
