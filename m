From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Fri, 09 Apr 2010 21:39:22 -0700
Message-ID: <7vsk73zzt1.fsf@alter.siamese.dyndns.org>
References: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com>
 <20100410042609.GA24295@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 10 06:39:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0STw-0004gO-2P
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 06:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189Ab0DJEjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 00:39:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54374 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab0DJEjj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 00:39:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BA2E8A9242;
	Sat, 10 Apr 2010 00:39:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=01ir+2jZNTrrvoAh7D0VDOlFeF8=; b=kQM4i3
	Az79IIo87RkLeFY9zbR2tg050LZ+y+yOWkUfqQh8Xz/lUo+fPFx6w+bYLNaOuw6U
	LW2coFPjuEwOtNJ4ePlurmKR/n5q5I0UaXJkO9jixoRSLyEg3ox/szhdBg+dCyow
	fT5qQpNjvbP3bFGRHYsb2qMTWqlUMQjTnr/N0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GwiltHOWZ8gQFJrcb4U/1lU9+n7tRRSv
	2K/GVnd24n7KBAbXu/ip9gk+qUd1pt49t0zku9iq9BgSBHxIEyI6+12Sda1Av9JQ
	ZEMLQ5AkMDTuePVJIgbCEPHJkMDazJwBZD7B5Li6mEKWLunUmB8Lt731dyoYQa6S
	HqOVvj26Pgg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A0B21A923B;
	Sat, 10 Apr 2010 00:39:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73377A9238; Sat, 10 Apr
 2010 00:39:23 -0400 (EDT)
In-Reply-To: <20100410042609.GA24295@coredump.intra.peff.net> (Jeff King's
 message of "Sat\, 10 Apr 2010 00\:26\:09 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0DE162BA-445B-11DF-B81A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144503>

Jeff King <peff@peff.net> writes:

> So no, it's not a bug. Yes, it's a terrible interface. There is really
> no reason IMHO for rebase to take a "which branch to operate on"
> argument at all. It should just operate on HEAD, like merge does. If you
> want to merge on a different branch, you "git checkout" that branch
> first.

I guess it's my turn to say "sorry it was my fault made in pre-maintainer
days around 59e6b23 ([PATCH] git-rebase-script: rebase local commits to
new upstream head., 2005-06-25).

I used to religiously rebase slushy topics that are not in any stable
integration branches (we used to have only 'master' and 'pu'), and

	git rebase master foo
        git rebase master bar
        git rebase master baz

was far easier to type than

	git checkout foo && git rebase master
	git checkout bar && git rebase master
	git checkout baz && git rebase master

when you have many topics.  Especially because the exact keystroke
sequences are:

	git rebase master foo ENTER
	^P (recall the last line) ^W (delete the last word) bar ENTER
	^P ^W baz ENTER

for the former.  Of course, I can do the same with the latter interface

	sh -c 'git checkout "$1" && git rebase master' - foo ENTER
	^P (recall the last line) ^W (delete the last word) bar ENTER
	^P ^W baz ENTER

so that is not a very good excuse, but at least now people know where it
came from ;-)
