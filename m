From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Wed, 15 May 2013 15:20:27 -0700
Message-ID: <7vzjvvanro.fsf@alter.siamese.dyndns.org>
References: <5193efe6.c42ab60a.0319.5f2c@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 00:20:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uck3n-0000Ri-VC
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 00:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648Ab3EOWUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 18:20:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58053 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354Ab3EOWUb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 18:20:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0025A1FA45;
	Wed, 15 May 2013 22:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kxWBnD9ODPz072RP8j3ZEw9cFY4=; b=WX19QD
	cvCwQxs50iMVDotwzQuEp1WG9r2caktnLnIEbloVF+MGH0zwDG7lCVF45QyYB+Gr
	mAPOliUx1Lb/UE2y/zYHPfDBKMGtsbNVt95yvZq3OpQdJAYOEhARAG7qgLXwgyNs
	Tbo2FdFFi87iDLqtfEdHbtkHjeT51df+CH/9c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I/nFbU73li3us0XGAIeMueFtF4Wc1YTO
	WDcRYyakzzEIQvVCt4ErN4sS7iWCLTfLKwiX1mgfbc5beXVd3OvRZkdAl253roW9
	PhAl5UJIC7QPAAJKF+KRptPjudsBpeYoDWB9PYlz7JUTHYHmuePRp/Egifey/iQ/
	dVmv+qqqVEc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECC001FA41;
	Wed, 15 May 2013 22:20:29 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 504821FA32;
	Wed, 15 May 2013 22:20:29 +0000 (UTC)
In-Reply-To: <5193efe6.c42ab60a.0319.5f2c@mx.google.com> (Felipe Contreras's
	message of "Wed, 15 May 2013 13:28:22 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A667F87C-BDAD-11E2-9461-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224450>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The 'base' branch will be set each time you create a branch from another;
> 'git checkout -b foobar master' sets 'master' as the 'base' of 'foobar'.

"git checkout -t -b foobar mastee" would instead set 'upstream' of
'foobar' to the branch 'master' of remote '.' (the current one).
This 'base' is a new mechanism to explicitly say "The upstream of
this branch lives locally" by not setting "branch.foobar.remote".

> Then you can do 'git rebase foobar@{base}' or simply 'git rebase', and Git will
> pick the right branch to rebase unto, even if you have no 'upstream'
> configured.

Surely you can teach rebase to pay attention to 'base' and achieve
that.  But you can already do so with upstream, so this is not an
advertisement of a 'plus', but rather a lack of 'minus' (which is
not a bad thing at all).

> This way 'git fetch' will keep picking 'origin', and other commands that make
> use of 'upstrem' would be undisturbed.

And this is the true plus, because 'git fetch' with the current
"setting a local base using the same upstream mechanism to point at
a branch of _this_ repository, indirectly setting the upstream
_repository_ for this branch to the current repository" will end up
making you fetch from yourself, which is not very interesting.

So I think I understand your itch and I agree that it is a valid
one.

I however am not yet convinced if that direction is what you really
want go in, though.  What should your 'git pull' on that branch do,
for example?

When you are on foobar and want to integrate with the branch you
based your work on (i.e. local 'master'), you can do one of these:

    $ git pull
    $ git pull --rebase

to "fetch the upstream branch and integrate with it", without having
to even care if that upstream branch is from the remote, or happens
to be truly local.  By making 'git fetch' to go to the remote origin
site, what will you be merging (or rebasing on) when you do the
above two?

Incidentally, I suspect you can do exactly the same thing without
introducing a new concept "base" and instead special casing a remote
whose URL is "."; you essentially declare that "The upstream of this
branch whose branch.$name.remote is set to '.' lives locally", which
is not all that different from saying "The upstream of this branch
whose branch.$name.base exists lives locally", which is what you
seem to be proposing.  One of the things this alternative approach
would "special case" such remote is probably to cause "git fetch" to
ignore such a branch.$name.remote setting and instead go fetch from
'origin', just like your "if there is branch.$name.base, but no
branch.$name.remote, fetch will go to 'origin'" does.

But it has exactly the same "what happens when you do 'git pull'"
problem, so even though it is conceptually a lot simpler, it has the
same brokenness.
