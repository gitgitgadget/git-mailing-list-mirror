From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git reset --hard" == "git checkout HEAD" == "git reset --hard
 HEAD" ???
Date: Sat, 03 Jan 2009 02:15:37 -0800
Message-ID: <7vprj4ae5y.fsf@gitster.siamese.dyndns.org>
References: <20090102195724.GA23119@seberino.org>
 <7v4p0hcp3w.fsf@gitster.siamese.dyndns.org>
 <slrngltvrd.63u.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 03 11:17:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJ3Z9-0004O0-4Z
	for gcvg-git-2@gmane.org; Sat, 03 Jan 2009 11:17:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756540AbZACKPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2009 05:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753013AbZACKPs
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jan 2009 05:15:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752439AbZACKPr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2009 05:15:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9BF2D1BA95;
	Sat,  3 Jan 2009 05:15:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 52A921BA94; Sat, 
 3 Jan 2009 05:15:38 -0500 (EST)
In-Reply-To: <slrngltvrd.63u.sitaramc@sitaramc.homelinux.net> (Sitaram
 Chamarty's message of "Sat, 3 Jan 2009 06:02:21 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7A42F402-D97F-11DD-9D44-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104457>

Sitaram Chamarty <sitaramc@gmail.com> writes:

>>> It seems we have 2 ways to blow away work we haven't
>>> checked in yet then right?
>>
>> Wrong.
>
> Strictly as asked, yes, but what if he adds a "-f" to the
> middle command, making it "git checkout -f HEAD"?  Wouldn't
> that be the same as the others then?

Yeah, but comparing reset and checkout misses a whole _dimension_ in the
revision space continuum.

"git checkout <branch>" is primarily about checking out a different
branch, aka "switching branches".

When you switch branches, you generally do not want to lose your pending
changes, but would want to take them with you.  A typical scenario is that
you start looking at one issue, you fiddle a few lines here and twiddle a
few lines there, and as you dig deeper, you realize that whatever the
final shape of the change you are going to make will be either (1) big
enough to deserve its own branch created anew, or (2) better done as an
extension to an existing branch.  You realize that you are in the latter
situation by noticing that the modification you were making will be helped
by something you have implemented in the other branch but not yet
available in the current one (typically the latter is 'master').

In such a case, you will "git checkout <the-appropriate-topic>" to switch
to the branch, and you would want to take the change you already made to
your work tree files when you do so.

On the other hand, "git checkout -f <branch>" blows away your changes, but
it still _is_ about switching to a different branch.

Whether you use -f or not, you are allowed to ask to switch to the current
branch by (1) naming the branch explicitly, i.e. "git checkout -f master",
(2) using HEAD to mean the current one instead, or (3) omitting <branch>
altogether.  But that is there merely for consistency and, even though
there may not make much sense to do so (because it is largely no-op except
that you would get the "you are ahead by N" notice), there is no strong
reason to forbid asking for a no-op.

For that reason, "git checkout -f HEAD" is "blow away my changes".  But it
is merely a degenerated case of "switching to the current branch while
blowing away my changes."

"git reset --hard <commit>" is different.  "reset" is primarily about
pointing the tip of the current branch to somewhere else.  While "git
checkout <branch>" never changes what commit sits at the tip of any
branch, "git reset <commit>" modifies it for the current branch (--hard
variant matches the work tree files to the contents recorded by the
resetted-to commit while at it).

Again, you are allowed to ask to reset to the current HEAD by saying
"reset --hard HEAD".  That is a degenerated case of "resetting the tip of
the current branch, while blowing away my changes".  More general case
would be "reset --hard <some-commit>" and it won't just blow away your
changes (relative to the commit you started out with), but also blows away
the history leading to the commit the branch tip used to point at.

"checkout -f" and "reset --hard" work on different dimensions, and what
they do intersect when (and only when) the <branch>/<commit> argument
happen to be HEAD.  "checkout -f <another>" and "reset --hard <another>"
will do quite different things.
