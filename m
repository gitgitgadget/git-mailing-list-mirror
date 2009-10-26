From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: support remote branches in guess_ref DWIM
Date: Mon, 26 Oct 2009 16:31:57 -0700
Message-ID: <7v8wexn34i.fsf@alter.siamese.dyndns.org>
References: <20091026213353.GA27871@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 27 00:32:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2Z2u-0005kB-Ep
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 00:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384AbZJZXcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 19:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753852AbZJZXcD
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 19:32:03 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807AbZJZXcC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 19:32:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0E50C86057;
	Mon, 26 Oct 2009 19:32:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EAHomnk7jsCNroeZVoryqud/vqw=; b=dngNtR
	Pr41SKFXndhn2uFOeBHuqiuLHTmOQfj0zABNHWnBCZO8HRO77g2rtqQPG4nQR/3+
	vDganUiauwU/ClgSo4aR8110QjqysU8ipdBwSQTGJ8HCdI5c5RJJc2u3fTdAvF3M
	BFiGrrnbiSVqElvAwMnWE2BHqL6fG7KQJyqOk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iu2vm9vLuMRLvQSoZXb+fesbKitzbfuk
	/IoPu6EnENHeJw0tkwNjbidQ51P6yCzL6r3VfBv1Z+LHT23npktojro6qqVuuZBk
	QcQt2qTtKbT3xugmf/sDirGXZi7fp8m3HwS5LLY0TqdsWZ0fUk7Edf4TVFUmJ2dc
	q/Xmbe6e7Bk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E581B86056;
	Mon, 26 Oct 2009 19:32:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3E56F86054; Mon, 26 Oct 2009
 19:31:59 -0400 (EDT)
In-Reply-To: <20091026213353.GA27871@sigio.peff.net> (Jeff King's message of
 "Mon\, 26 Oct 2009 17\:33\:53 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C464561A-C287-11DE-9A6F-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131284>

Jeff King <peff@peff.net> writes:

> When we get an unqualified dest refspec like "foo", we try
> to guess its full ref path (like "refs/heads/foo") based on
> the source ref. Commit f8aae12 mapped local heads to remote
> heads, and local tags to remote tags.
>
> This commit maps local tracking branches under
> "refs/remotes" to remote branch heads, so
>
>   git push origin origin/branch:renamed-branch
>
> pushes to refs/heads/renamed-branch.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This came from a discussion on IRC. I don't see any reason not to do
> this; would people really expect it to push into refs/remotes/ on the
> other side (right now, it complains and dies)?

As _our_ origin can never be _their_ origin if we are clone of them, I do
not think anybody sane would expect it to push into refs/remotes/origin/
to begin with.

But "not in refs/remotes/" does not automatically mean "the only sensible
place is refs/heads", does it?  "We do not know what kind of mistake the
user is trying to make" could be more plausible answer, and in that case,
"complain and die" may be a more valid course of action.

For example,

    git push origin origin/master:refs/heads/master

is most likely to be a mistake.  The only situation something similar to
this makes sense is where you pushed out a bogus commit earlier and are
trying to correct it perhaps with

	git push origin +origin/master@{1}:refs/heads/master

but you need to force it and go back in the reflog.

I know you are doing this DWIM only when $dst does not exist over there,
and the "pushing old master back to master" above is a different scenario,
but if "git push origin origin/master:master" shouldn't update their local
master, "git push origin origin/master:naster" shouldn't update their
local naster, in order to avoid confusion arising from inconsistency, no?

Another possibility is to see the type (not refname) of $src and push all
commits to refs/heads/$dst and everything else (most likely tags) to
refs/tags/$dst, to simplify the rule to make it easier to explain and
remember, but there are lightweight tags that make this idea unworkable.

> A related issue (which exists even without this patch) is that doing
> this:
>
>   master:remotes/incoming/master
>
> will create "refs/heads/remotes/incoming/master". Perhaps we should DWYM
> a little more and recognize "heads", "remotes", and "tags" as special.

Yes, it is an independent issue; I think correcting this DWIM (or at least
"warning" if not refusing to create remotes/ under refs/heads/) might be a
good idea.
