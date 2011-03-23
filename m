From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gsoc - Better git log --follow support
Date: Wed, 23 Mar 2011 09:58:11 -0700
Message-ID: <7v8vw5g4f0.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=n7e70UqYU+6wpG4cu95fsg39tVM6=7fpfdZFz@mail.gmail.com>
 <20110321122407.GH16334@sigill.intra.peff.net>
 <AANLkTi=woLeveur6gKnSXTRzmS8nB0o4M9HegJ+GNUCa@mail.gmail.com>
 <20110323162023.GC30337@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Micha=C5=82_=C5=81owicki?= <mlowicki@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 17:58:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2ROC-0006vW-4O
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 17:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754508Ab1CWQ61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 12:58:27 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60270 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab1CWQ60 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 12:58:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 08AD24267;
	Wed, 23 Mar 2011 13:00:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tDjeuxL2bHfOT14SFmiLamWwaWY=; b=vvGVk3
	szrl/h7IPqnV4Be9npO32KxuuytUMwflEJMQ1lxmk8Ad/Y8FCmJZxNcNovRyPaPT
	/mY0Egk4JsPlCzkj49Cf9/DyN7bvtAWNczN23Q36+9JChwTXcZ1ayJmZxPkaoh8b
	jEiIOsLK0JWK1fYsEZbK9twSSgUNopP9JN/Qs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d4SsJLucK3mhR6HcUgDGCeBJsLsFXFnY
	9G31xt+m3Bl32I4apiqQlUhCPojxZFvW6QsVm7Ai0zOyXhdRPCyY97gvWqlQZYoy
	Q1FcYy3S2nb3NI7YnfV7gBRVQY3ddTCKUTlL+WJpsEWTzOMGahd28IpYY45oX2CV
	cx8UdHlUUOk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B4C014264;
	Wed, 23 Mar 2011 13:00:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id ED7C54262; Wed, 23 Mar 2011
 12:59:54 -0400 (EDT)
In-Reply-To: <20110323162023.GC30337@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 23 Mar 2011 12:20:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FD55642A-556E-11E0-8B2A-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169854>

Jeff King <peff@peff.net> writes:

>   # Now try it with --follow. Not so pretty.
>   git log --oneline --graph --follow builtin/add.c

Is that an artifact of history simplification?

I've always thought that it was because --follow hack used a single global
pathspec that flipped at a rename boundary,regardless of which part of the
history (i.e. the branch that was before the rename or after the rename)
it is following.  So if you have two branches merged together:

        o---o---o---o---o---x---x---x
       /                   / 
   ...o---o---o---x---x---x

where commits marked with 'x' has it under the new path while commits
marked with 'o' has it under the old path, and start to dig the history
from the rightmost commit, the hack notices the rename at the transition
between the "o---x" on the upper branch and from then on keep digging the
history using the old path as the pathspec.  The commit history traversal
goes reverse-chronologically, so when inspecting the next commit, which is
the rightmost commit on the lower branch, the hack fails because it uses a
wrong pathspec (at that point it should still be using the new path as the
pathspec, but it already has switched to the old path).
