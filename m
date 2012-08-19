From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 0/3] Reflogs for deleted refs: fix breakage and suggest
 namespace change
Date: Sun, 19 Aug 2012 09:27:36 -0700
Message-ID: <7vlihaq22v.fsf@alter.siamese.dyndns.org>
References: <20120719213311.GA20385@sigill.intra.peff.net>
 <1345310086-20089-1-git-send-email-mhagger@alum.mit.edu>
 <7vboi8rl2q.fsf@alter.siamese.dyndns.org> <5030E7D6.8020206@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Alexey Muranov <alexey.muranov@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Aug 19 18:27:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T38Lp-0006u7-HX
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 18:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653Ab2HSQ1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 12:27:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943Ab2HSQ1j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 12:27:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B97456F1;
	Sun, 19 Aug 2012 12:27:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xKQ2j/7xUkzbOqhcGifbHetIyZU=; b=t+eWp4
	2cp/+mUh5VklvvdOw3A4Ov+v2oYsjyXB0Ckw36xcB58KxIrpTP6VY+kQwvmE2S6T
	dNJpewSPHGNPnmqk8HCPvQuL2l33/9LTaIWHfXoNswzKkOBOAoxoYzSt5rz6hSe4
	ej1Z9asnCZig6g5WjKjykM4TfdsTxUi8SpZxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rdofIzwDrU7iDOqsHD7nJnhnTXhduXhm
	/U/xrAkzW2eKKnl/wu+EnkNBYVJAyxkgXW/t+pJJgwO1NEi1UJH2Q6SVhfqTKKBY
	EtwH+BKeBhU2mDDpnCmf2b2DyNb3vd/lFaExWoFYJpxnm/GK6deprlHXsNN0zmPZ
	XtBJBF2Fp0A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5875056F0;
	Sun, 19 Aug 2012 12:27:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEBED56EF; Sun, 19 Aug 2012
 12:27:37 -0400 (EDT)
In-Reply-To: <5030E7D6.8020206@alum.mit.edu> (Michael Haggerty's message of
 "Sun, 19 Aug 2012 15:19:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA05B63C-EA1A-11E1-A0E3-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203722>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It's been a wish of mine, but it's pretty low priority.  I've also
> brainstormed about some other changes that could be connected with a new
> repo format:
>
> * Allow "deleted" loose references (for example denoted by value 0{40})
> that override packed references with the same name.  This would remove
> the need to rewrite the packed-refs file when a reference is deleted.
> (A prerequisite for this change would be to allow next and next/foo at
> the same time.)

We would need to think the performance implications through of the
approach; it tempts us to accumulate the loose "removed" markers in
the hope that it would be an improvement than having to rewrite the
packed-refs over and over, and without numbers to back that theory
up, we may be worsening the system without knowing.

Having said that, it is an interesting idea. I wouldn't use 0{40} as
the sentinel value but rather use letters outside [0-9a-f], though.

> * Push HEAD and its friends down out of $GIT_DIR into a
> reference-specific directory.

Not going to happen for several years, I am afraid, as I think many
casual tools do an equivalent of "test -f $DIR/HEAD" to see if $DIR
is a repository; even our own gitweb does so.

We should advertise an easy way for scripted Porcelains to directly
ask is_git_directory().

> * Rename lock files to look less like reference names (e.g., something
> like "refs/foo~lock" instead of "refs/foo.lock").

If you do the ~d/~f thing, foo.lock becomes a non-issue, no?

> * Somehow munge reference names in a way to avoid other filesystem
> limitations -- e.g., case insensitivity, filenames like "com" and "prn"
> or with multiple dots under Windows.

Very interesting.  I however am afraid that the users and the
projects will learn to avoid the problematic names a lot sooner than
such a change will be implemented to make the issue go away (or they
have already learned long time ago), and the end result may end up
solving a non-issue only to make the output from "find .git/refs"
even more unreadable.

> * ...or maybe a packed-refs file that can (usually) be updated in-place,
> and get rid of loose references entirely.

I find this equally intriguing as your "deleted" one above.
