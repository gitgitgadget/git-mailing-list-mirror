From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: support remote branches in guess_ref DWIM
Date: Tue, 27 Oct 2009 15:33:16 -0700
Message-ID: <7vaazc31sj.fsf@alter.siamese.dyndns.org>
References: <20091026213353.GA27871@sigio.peff.net>
 <7v8wexn34i.fsf@alter.siamese.dyndns.org>
 <20091027014525.GA29583@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 27 23:34:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2uc5-0006mN-Vd
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 23:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755465AbZJ0WdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 18:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755426AbZJ0WdX
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 18:33:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442AbZJ0WdV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 18:33:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 253C469273;
	Tue, 27 Oct 2009 18:33:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZNCfsCoDA3lZ7S6t20LU3yi2yMg=; b=QrY2md
	J1aiSfsFDD9fucjA0wNYo40GwT2VIQjW7ptefKIuh7Pgco+fjA8dZI786f2rGU2I
	rK4kDxBkD4MiMEaZ2jcA8ZSFiEH059P9sWZHMFPdpxIGIH+zkbzYyAYE1hDfwiU3
	ObFiMfgtUt81xxH4IGWsPMNZQSZ4h+Dj84wrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nw/+hO1fmAZ7rISW3ZFrduZQB3jqAOA6
	KIMJtweNEO1xkgt2qJQv7+WB/QWxogteJ2Ry3DEL6esmbL7DlEB0uhDBEndyhM6c
	1FmnjuKFaB5avWPVAWHGV0vqTNdRO449E8gcXvPDMS+H2VPdbWIW+cLQcrXD/NvL
	1p0ojUtlFdA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B1A1869272;
	Tue, 27 Oct 2009 18:33:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3EE96926F; Tue, 27 Oct
 2009 18:33:17 -0400 (EDT)
In-Reply-To: <20091027014525.GA29583@sigio.peff.net> (Jeff King's message of
 "Mon\, 26 Oct 2009 21\:45\:25 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BACE62F0-C348-11DE-9499-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131384>

Jeff King <peff@peff.net> writes:

> On Mon, Oct 26, 2009 at 04:31:57PM -0700, Junio C Hamano wrote:
>
>> As _our_ origin can never be _their_ origin if we are clone of them, I do
>> not think anybody sane would expect it to push into refs/remotes/origin/
>> to begin with.
>
> OK, I agree.
>
>> But "not in refs/remotes/" does not automatically mean "the only sensible
>> place is refs/heads", does it?  "We do not know what kind of mistake the
>> user is trying to make" could be more plausible answer, and in that case,
>> "complain and die" may be a more valid course of action.
>
> The thing is that I can't think of another sensible place. And this
> sensible place is useful for one particular action: renaming a remote
> branch, like this:
>
>   $ git fetch ;# presumably gets origin/branch
>   $ git push origin/branch:renamed-branch
>
> which is much nicer than exposing clueless users to
> ":refs/heads/renamed-branch".

You would need to expose ":refs/heads/branch" to make this a rename, not a
copy, wouldn't you?

>> For example,
>> 
>>     git push origin origin/master:refs/heads/master
>> 
>> is most likely to be a mistake.  The only situation something similar to
>> this makes sense is where you pushed out a bogus commit earlier and are
>> trying to correct it perhaps with
>
> I'm not sure why it's likely to be a mistake.
> ...
> Am I missing some part of your argument?

I do not see much point (other than your "rename" example) in pushing what
you got from the other end without changing anything yourself back to the
same remote.

There was a thread in which people argued that the primary thing that is
dangerous in this sequence

    $ git checkout origin/next; work-commit; work-commit; ...

is when you leave the detached HEAD state without saving it to a local
branch.  I think what is more dangerous is that it will not give the user
a solid understanding that these commits do _not_ change origin/next in
any way.  After doing the above, it is understandable that a novice would
mistakenly think: "I started from origin/next and built some, let's push
the result".

	Side note: This is the reason why I think Dscho's "git checkout
        next" that dwims to "-t -b next origin/next" is OK (perhaps on the
        right side of the borderline), because it is more clear that this
        is about creating and using your own "next", compared to the
        existing "-t origin/next" shorthand.  The latter risks imprinting
        a misconception on an uninitiated that we are somehow working on
        origin/next.

With such a misconception, you will see the likely mistake here, too:

    $ git push origin origin/next:refs/heads/next

If "rename" is the _only_ valid reason you might want to push what you got
from there back to the same remote, _and_ if "rename" is something very
often needed, I think we would prefer to have a way to support that
operation directly, instead of more general DWIM that would risk passing
mistakes like the above unwarned.

> ...  But I'm not sure why
> you would accidentally provide something in refs/remotes, or not want to
> be pushing to refs/heads. Where _else_ do you push, except for tags?

The above "checking out origin/next" illustrates the mistake on the $src
side, not on the $dst side.  That's why my alternative solution in the
previous message was to see the type of $src and push commits to local
branches, exactly because "where else do you push".  

IOW, it's between "prevent push with dubious $src from happening in the
first place" vs "give them rope".  Historically I always sided with the
latter camp, but I am trying to play a devil's advocate for a change ;-).
