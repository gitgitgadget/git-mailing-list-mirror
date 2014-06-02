From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reset by checkout?
Date: Mon, 02 Jun 2014 14:54:47 -0700
Message-ID: <xmqqmwdv2d08.fsf@gitster.dls.corp.google.com>
References: <20140531144610.754B.B013761@chejz.com>
	<53898448.8040105@bracey.fi> <20140601132624.821C.B013761@chejz.com>
	<538AE814.2010407@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Atsushi Nakagawa <atnak@chejz.com>, git@vger.kernel.org
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Mon Jun 02 23:54:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WraC2-00043O-Oy
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 23:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbaFBVyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 17:54:55 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52970 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751000AbaFBVyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 17:54:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 97E031D850;
	Mon,  2 Jun 2014 17:54:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HGV1VTObAZX3rBMDAHHImWZaeTc=; b=Q23Acm
	p8btqyr+WbtDzrddnh9DqRWK7s/3BsdNC9tB8Fw1mgvTGuD9ICV/wygkueggmJLX
	yXGYwaFnuCuicJEmbVjDQxI/RrFsy3Bi1Qx5xskx+obU/tuOuQyHoTqOG88aVw94
	/nLPaTgas7KErWHpqmT9ID7rc4cG8dZN5sRxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=apTJvAqGDb3tRyUmn7wdcuVzWVyuAEui
	4A5++DzGLzbzCMkxjyhtSaAsZe2y5/1taN7v3IEO6VEfgO/DVppDIVIwquP/9682
	Kiq5AWWBOfj6t9GikanN4CDzj2oogYWLY3O+ok9CVb8X2jDqjhvDj21yGkYHjjaa
	Q6jLFM+fw1s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8F9321D84F;
	Mon,  2 Jun 2014 17:54:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7EFEF1D848;
	Mon,  2 Jun 2014 17:54:49 -0400 (EDT)
In-Reply-To: <538AE814.2010407@bracey.fi> (Kevin Bracey's message of "Sun, 01
	Jun 2014 11:45:08 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 84D2A952-EAA0-11E3-914E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250602>

Kevin Bracey <kevin@bracey.fi> writes:

> Maybe something like this:

I like the overall direction to re-organize the description by
operations, but the new description seem to introduce a bit of new
confusion.

> "All modes move the current branch pointer so that HEAD now points to
> the specified commit. ORIG_HEAD is set to the original HEAD
> location. The modes differ in what happens to the contents of
> ORIG_HEAD, that are no longer on the reset branch; and also what
> happens to your not-yet-committed changes.
>
> --soft
>      Retains the contents of ORIG_HEAD in the index+work area,
> leaving the difference as "changes to be committed".

This (and everything that talks about ORIG_HEAD) asks the user to
think of the working tree state as a combination of "the state the
commit you were on represents" plus "the changes you made relative
to it".

Given that everything Git records is a whole-tree snapshot, "state"
(not "changes"), and that is how tutorials teach Git, I wonder if
the "what is done to ORIG_HEAD and changes" gets the user into right
mindset to understand various modes of operations.

And with that "ORIG_HEAD and changes" mindset, a --soft reset
becomes very hard to explain.  "ORIG_HEAD and changes (you had
before you issued the 'reset --soft' command)" are left in the
index/work, "HEAD" becomes the named commit, "changes from that
updated HEAD" becomes the original changes (you had since ORIG_HEAD)
mixed with the differences between ORIG_HEAD and HEAD.

If you explain this in terms of "state", a --soft reset will keep
the state of the index and the working tree as-is and changes the
HEAD pointer to point at a different commit.

> "git reset --soft HEAD~1"
> would be the first step if you want to remove the last commit, but
> intend to recommit most or all of its changes.
>
> "git status" after reset --soft shows:
>
>   To be committed:
>        Changes in ORIG_HEAD relative to HEAD
>        (+Any initial staged changes)

There would be overlapping parts of "Any initial staged changes" and
"Changes in ORIG_HEAD relative to HEAD".  They may be mixed, they may
be partly reverted, or they may totally cancel out, depending on the
changes the user made since starting to work on ORIG_HEAD.


>   Not staged:
>        (Any initial unstaged changes)
>
> --mixed (default)
>     Retains the contents of ORIG_HEAD in the work area, leaving the
> difference as unstaged changes.

I am confused by the above the same way.  If the operation "retains
the contents of ORIG_HEAD" in the working tree, would that mean the
edit I made is somehow reverted?  No, because you say "leaving the
difference ...", but then the operation is not really retaining the
contents of ORIG_HEAD.  It is leaving the state I had in my working
tree as-is, regardless of ORIG_HEAD and/or HEAD that is updated.

Not that I can think of a better way to update these descriptions,
and not that I am opposing to update these descriptions to make it
easier for new people to learn, but I am not sure if these "treat
ORIG_HEAD and the changes since that commit as separate entities"
is a good approach to do so.

Somewhat frustrated, not by your patch but by being unable to
suggest a better way X-<.
