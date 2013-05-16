From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] fetch: add --allow-local option
Date: Thu, 16 May 2013 08:58:54 -0700
Message-ID: <7v61yi9arl.fsf@alter.siamese.dyndns.org>
References: <1368689474-28911-1-git-send-email-felipe.contreras@gmail.com>
	<1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 17:59:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud0a7-00007r-0Z
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 17:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807Ab3EPP66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 11:58:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42418 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812Ab3EPP65 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 11:58:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13A2D1EA7A;
	Thu, 16 May 2013 15:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XPPb9yERJz8hQiVW2xew5fVNQq0=; b=THrxS7
	JL7i8+QF2XjLr+8df9tGuelxVGYGjNr4MJwL2Z282oIU/Q9LVxs5PzyPPmO5vpI8
	gnhYTFhiIGebb1Kcbkrx5ilJo392C39F7L4fMmmD1YsjBgq7hwPRlXHb0Mzy7juD
	7/J2S9lLW5wK0e7X5FSI5rSNss2IFVgpkx5lw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oqmVZJ4t+9OkPoLqAGQrggmDo+HSt5hr
	+xbR6IuvhhR6/kVOOoP1GCU96vSHu0Lek9AE7xbW3eKDQ/LBqkdY82h8vvYlMVhC
	9H5/nk8sI9v6D1lsm0D/tCM/Xsynn+GjvPAKItPcBfKqE5kE82AfCfGBCQWcj5iy
	/jLDW1e7pEc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AFA71EA79;
	Thu, 16 May 2013 15:58:57 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 484AC1EA77;
	Thu, 16 May 2013 15:58:56 +0000 (UTC)
In-Reply-To: <1368689474-28911-2-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 16 May 2013 02:31:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 838295A8-BE41-11E2-892F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224588>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> So that it becomes possible to override the behavior when the remote
> tracked is '.'; if it is, we default back to 'origin'.

I know I was the stupid one who originally suggested this, but I
think this is a wrong direction to go.  I do not think it solves
your "I do not want to say 'git fetch origin'" problem.

You do "git checkout -t -b mywork master" because you want to later
be able to conveniently rebase mywork on top of your local master
(i.e. make @{u} notation work for you) [*1*].

What "git checkout -t -b $branch $up" does is to declare that branch
builds on top of $up, which often is some remote tracking branch.
And "git pull [--rebase]" on that $branch is to

    (1) make sure $up is available and up to date; and

    (2) integrate with $up.  The first step is "git fetch" and it
        has to go to the repository $up comes from.

If $up is in your local repository (the original "fork mywork from
master in my repository"), the first step ought to be a no-op, and
"git fetch" from the current repository may seem wasteful, but I
think we already have an optimization to make this no-op not to
transfer anything network-wise.  There is no justification for it to
go to 'origin' or any other random remote that is different from the
reopsitory $up comes from.

I _think_ the real reason you want a "git fetch" while on "mywork"
to go to 'origin' is because you are building your "master" off of
somebody else's work that comes from 'origin', and you want to check
what has changed to see what you need to rebuild both your "master"
and "mywork" branches on top of.  If 'master' were forked from a
remote that is not 'origin', then making "git fetch" ignore '.' and
instead go to 'origin' would not solve anything.  For an updated
behaviour to be useful in that workflow, it needs to follow the
inter-branch relationship ("mywork is a fork of master which is a
fork of frotz branch from a remote xyzzy") to see the first remote
repository and fetch from there, instead of blindly fetching from
the 'origin'.

Having said all that, I am not all that sure that it is a good idea
to introduce such an exception for "git fetch" to ignore '.',
regardless of where it goes instead, either the 'origin' or the
first remote repository it finds by recursively finding its
upstreams, to break the consistency at the UI level.  It is dubious
if the benefit of convenience to fetch from remote 'xyzzy' that is
an eventual remote of 'mywork' without having to say so outweighs
the cost of additional UI inconsistency, making things harder to
explain to both new and old people.


[Footnote]

*1* Another side effect this has is that in a triangular workflow,
    the place you push to may not be the place the branch you
    integrate with (i.e. 'master') lives (i.e. '.', your local
    repository), and the name you want to push it as may not be the
    same as the branch you integrate with (i.e. 'master'), either.

    Ram's branch.mywork.pushremote can solve the former (i.e. where
    it goes), but not the latter (i.e. to which branch it is pushed),
    and that is a valid issue that may need to be addressed.
