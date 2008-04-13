From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add examples section to 'git fetch' manual
Date: Sun, 13 Apr 2008 11:56:21 -0700
Message-ID: <7v63uld1nu.fsf@gitster.siamese.dyndns.org>
References: <20080413093102.GC12107@mithlond.arda.local>
 <20080413093424.GA12861@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sun Apr 13 20:57:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jl7OC-00035V-CV
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 20:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453AbYDMS4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 14:56:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbYDMS4e
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 14:56:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44665 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbYDMS4d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 14:56:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AC12025C2;
	Sun, 13 Apr 2008 14:56:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B3A1825C1; Sun, 13 Apr 2008 14:56:28 -0400 (EDT)
In-Reply-To: <20080413093424.GA12861@mithlond.arda.local> (Teemu Likonen's
 message of "Sun, 13 Apr 2008 12:34:24 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79414>

Teemu Likonen <tlikonen@iki.fi> writes:

> +EXAMPLES
> +--------
> +
> +git fetch git://host.xz/repo.git/ master:pu::
> +	Fetch branch `master` from given repository URL and store it locally
> +	as `pu`.

While this may technically be correct (and I'll say upfront that all of
your "examples" may technically be correct), I would suggest strongly
against putting this into EXAMPLES section.  People look at examples
section to look up something they need to do often; the section should
describe the best practices we can suggest them in real life.

The above command line is a _great_ way to explain what happens under the
hood when you have the matching configuration in .git/config for the
remote, so that people would know how to update .git/config entries from
what git-clone and "git-remote add" give them by default to suit their
needs (e.g. instead of storing all branches in remotes/origin/*, you can
configure to only fetch and store a few selected branches).  But, fetching
from somewhere and storing it explicitly _from the command line_ like your
example command line is something you would _never_ do in real life if you
know git.

> +git fetch git://host.xz/repo.git/ master:remotes/pu::
> +	Fetch branch `master` from given repository URL and store it locally as
> +	remote tracking branch `pu`.

And this example is even worse, as the common example is to have remote
name between "remotes" and "pu".

> +git fetch git://host.xz/repo.git/ master::
> +	Fetch branch `master` from given repository URL but do not create the
> +	branch locally. Only the temporary pointer FETCH_HEAD is set to refer
> +	to the fetched branch.

This one is a fine example of a one-shot command to look at what they
have without actually affecting your own history.  Use of this form in
real life is very sane.

> +git fetch alice master:remotes/alice/pu::
> +	Fetch branch `master` from remote named `alice` and store it locally as
> +	remote tracking branch `alice/pu`. See linkgit:git-remote[1] for more
> +	information on configuring remotes.

This is a wrong example on multiple counts (this is one of the worst one
in your change, so I'll explain in more detail than for others).

First of all, think about the reason _why_ the convention is to use a
separate namespace under remotes/ per remote.  It is to allow us to use
the names that correspond to what the remote repository uses without
having to worry about name collisions, and the reason we took pains to
implement the mechanism to allow you to use such corresponding names is to
avoid having to remember "what she calls master is what I call pu".

"I want to make sure I can tell my master and her master apart without
confusing myself, so I'd call mine master and call hers alice/master" is
the recommended use pattern which "git clone" and "git remote add" give
the user.  An EXAMPLE that deviates from it without explaining why/when it
is a good thing to do is BAD.  Remember, many people blindly copy and
paste the examples section without thinking, assuming that they suggest
the best practice.

If you have nickname "alice" defined, you are by definition interacting
with her regularly.  If you are doing a one-off with such a repository,
running "git fetch alice master" and operating on the resulting FETCH_HEAD
(and you typically use tag or local branch if you want to mark that
commit, with "git tag" or "git branch"), would be much less error prone,
less confusing, and more straightforward recommended approach.  Typically,
you would have the usual refs/heads/*:refs/remotes/alice/* fetch refspec,
so you would not even say "master" and instead run "git fetch alice" and
look at "remotes/alice/master".

Your above command line again may be a great way to explain what you could
do and what the mechanism is equipped to allow you to, but I do not think
there is any reason to use it in the real life.  It should not be in the
EXAMPLE section.

> +git fetch origin::
> +	From the remote named `origin` fetch and store all branches as
> +	configured in `remote.origin.fetch`. Usually this means fetching all
> +	branches and storing them locally as remote tracking branches
> +	`origin/*`. See linkgit:git-remote[1] for more information.

This is a valid thing to add to the examples section, although I suspect
people would already know it when they encouter this page.
