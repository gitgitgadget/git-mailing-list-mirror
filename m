From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Sample pre-push hook can crash
Date: Fri, 11 Mar 2016 12:04:58 -0800
Message-ID: <xmqqmvq4aihh.fsf@gitster.mtv.corp.google.com>
References: <CAH8BJxHeyfpKsvjGfg5ZJ5YDQk6pzZp4ufHVEV=cFriL8j_4uw@mail.gmail.com>
	<xmqq37rydn6b.fsf@gitster.mtv.corp.google.com>
	<CAH8BJxFtHD6zq=EKb0XUsMu8uMDB6=J-F+TURha+XiWcq=V06A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stephen Morton <stephen.c.morton@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 21:05:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeTJ7-0007pN-LW
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 21:05:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbcCKUFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 15:05:07 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752042AbcCKUFD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 15:05:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A058D4C01D;
	Fri, 11 Mar 2016 15:05:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9W/6Lyur/4HrulXatNDV1n6lT5I=; b=aLrEsy
	WabKCgE2AqNXsHVdSyywb523c8MHHU1TW0HwaxazvkM1Jgc4SgSghYiz+H7GvMMv
	gZpAWy+wFVKpFbLZ9Sw0Yv6hgG6td+KewsS8Iug0kPCk/Jsp1RJ7imLPd6s7UToW
	4dxous4EK5Nn+ZEK+7JSjJU3Fq50yOqJCLve8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oJGFM5B3nCEqR/EoClbyW1+6gL0ZJHyw
	SqHTvHMOd5b5Pe8Ws9YCpY8oWT+1V86nMuTXgzApeNw7Koe+awO5pYtPfdncjtwL
	MoqT6TrAjYvXElu6y7PvoZs1oL9mY9WJlXaw00k2uyHQ6lGxBBF80OnDoeVGUf47
	KRT/wIBHN3A=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3EA604C01B;
	Fri, 11 Mar 2016 15:05:01 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1B5E84C01A;
	Fri, 11 Mar 2016 15:05:00 -0500 (EST)
In-Reply-To: <CAH8BJxFtHD6zq=EKb0XUsMu8uMDB6=J-F+TURha+XiWcq=V06A@mail.gmail.com>
	(Stephen Morton's message of "Fri, 11 Mar 2016 09:33:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 88E960E4-E7C4-11E5-A890-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288703>

Stephen Morton <stephen.c.morton@gmail.com> writes:

> That is interesting, so in the case of a non-ff push, there is no way
> for a pre-push hook to know what is being pushed in order to run?

If you were up-to-date from the other side once:

    ---A---B---C

and built one new commit on top:

    ---A---B---C---D

when you attempt to push it out, there are various possibilities.

An ff situation is simple.  They didn't do anything, so the hook
gets "we'd be updating their ref from C to D", and "rev-list C..D"
would tell you that you would need to make sure D is sane.

If your push does not fast-forward, that would mean something has
happened on the other side while you were working on D.  Perhaps
they accepted another commit that you haven't seen:

    ---A---B---C---E

and because you haven't fetched from them, even though the hook may
say "we'd be updating their ref from E to D", you haven't heard of
E, you do not know where it would be relative to the history you
have:

                  E???

    ---A---B---C---D

Or perhaps they themselves rewound their history and they now have
this E at the tip:

    ---A---B---C
            \
             E

But again, because you do not yet know where E is relative to your
history, you cannot say C is where you can stop checking your side
of the history.

Or perhaps they somehow obtained your D without you pushing into
them (e.g. you pushed to the "next" tree and they fixed your commit
and the result was merged there) and have something like this:

    ---A---B---C---D---E

In this case, D is not even a new commit from their point of view,
and updating their tip E with your old D would lose the fixup E they
made for D, but again, you do not know what E is yet, you cannot say
"they have this already, so there is no check I need to do".

In summary, you cannot even say which ones you have need to be
checked.

If you _are_ using @{u} tracking, then you would know at least they
used to have up to C in their repository to limit your check, but
you cannot unconditionally say ref@{u}.. without making sure ref@{u}
makes sense in the first place.

An obvious alternative for the sample script would be to instead let
the non-ff push pass the pre-push check (as you may have other
arrangements to forbid non-ff pushes) without actually checking
anything.  As this sample script is to serve as a sample, I think
such an advanced consideration of loosening checks depending on the
situation should be left to the end users.
