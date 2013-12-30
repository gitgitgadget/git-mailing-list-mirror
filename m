From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: Runaway "git remote" if group definition contains a remote by the same name
Date: Mon, 30 Dec 2013 11:10:31 -0800
Message-ID: <xmqqlhz2rw7s.fsf@gitster.dls.corp.google.com>
References: <AANLkTinni=VJLoZp1Hjm4dfW8faChytDObJbXsFF5iXv@mail.gmail.com>
	<CALxABCbRZ4MmiYS4JF20qf1-iubeTfa+3OLibqdb5+raekuKQg@mail.gmail.com>
	<20131229075838.GC31788@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 30 20:10:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxiEe-0003iQ-Sa
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 20:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114Ab3L3TKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 14:10:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43636 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932069Ab3L3TKe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 14:10:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 088AE5F069;
	Mon, 30 Dec 2013 14:10:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b/0MtGT3tFjECRidETLrCzE9jD8=; b=rXeBCO
	oqSXhprI38BikjGquqgDE/XR3gpbGEPaciC3Rik9wkiPO6vtZRYktTGiS6KFnTfj
	3ThwNNgYCJsl3h/5CPvRvoBiUPVxX8dHwmnkH+Fta0BRSA6DUKtq8EDzYXXdr9VL
	VnkgPeckbr8nWDf3LGVXnjx2j79Mo/qxedyZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=v9C9nsbUd6GWv2fXpKyqwkSpGGAWGo3z
	sxZolNXZYjL3SpBieNMOpf3Uf1QbEx6BWBwu07LPrDq4ss1drUQxwqhkDDNdH9o5
	pI5CF+HDm53bI/uHJAEyXlpmNMpVEaKcIGEEhlGAHpQ79AjpnEL0oTrLGkl7shRt
	Z0AlzlgrVl8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE8655F068;
	Mon, 30 Dec 2013 14:10:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5170E5F067;
	Mon, 30 Dec 2013 14:10:33 -0500 (EST)
In-Reply-To: <20131229075838.GC31788@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 29 Dec 2013 02:58:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0E762C22-7186-11E3-AD53-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239814>

Jeff King <peff@peff.net> writes:

> If they are not allowed to recurse, the problem is much easier; the
> parent fetch simply tells all of the sub-invocations not to expand the
> arguments further. However, whether it was planned or not, it has been
> this way for a long time. I would not be surprised if somebody is
> relying on the recursion to help organize their groups.
>
> So I think the sanest thing is probably:
>
>   1. Teach "fetch" to expand recursively in a single process, and then
>      tell sub-processes (via a new command-line option) not to expand
>      any further.
>
>   2. Teach "fetch" to detect cycles (probably just by a simple depth
>      counter).

I suspect that the expansion code will just accumulate remotes found
into a string-list (as part of 4. below), so deduping would be
fairly easily done without a depth counter.

>   3. Teach the group-reading code to detect groups more robustly, so
>      that a single-item group like "remotes.foo=bar" correctly recurses
>      to "bar".

A single-item remote group is somewhat annoying, but expanding it
only at some places while ignoring it at other places is even more
annoying, so this sounds like a right thing to do.

>   4. (Optional) Teach the expansion code from step 1 to cull duplicates,
>      so that we do not try to fetch from the same remote twice (e.g., if
>      it is mentioned as part of two groups, and both are specified on
>      the command line).
>
> I do not plan to work on this myself in the immediate future, but
> perhaps it is an interesting low-hanging fruit for somebody else.
>
> -Peff
