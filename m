From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Mon, 30 Jan 2012 07:38:38 +0100
Message-ID: <4F263AEE.4080409@alum.mit.edu>
References: <4F24E287.3040302@alum.mit.edu> <7vwr8bvvxj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 07:38:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrktD-0001Qk-Ie
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 07:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168Ab2A3Git (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 01:38:49 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:40202 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082Ab2A3Gim (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 01:38:42 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BED4B1.dip.t-dialin.net [84.190.212.177])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q0U6ccC2015365
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Jan 2012 07:38:39 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <7vwr8bvvxj.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189324>

On 01/29/2012 07:56 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> When starting a new repo, git seems to insist that the first commit be
>> made on a branch named "master":
>>
>>     $ git --version
>>     git version 1.7.9
>>     $ git init git-test
>>     Initialized empty Git repository in /home/mhagger/tmp/git-test/.git/
>>     $ cd git-test
>>     $ git checkout -b foo
>>     fatal: You are on a branch yet to be born
>>
>> I would call this a bug; the last command should be allowed.  The
>> plumbing allows it:
>>
>>     $ git symbolic-ref HEAD refs/heads/foo
> 
> Your last sentence is nonsense.  The plumbing equivalent of that command
> is *not* what you wrote above, but is more like [*1*]:
> 
> 	git update-ref refs/heads/foo $(git rev-parse --verify HEAD) &&
>         git symbolic-ref HEAD refs/heads/foo

All that I meant is that the one command is the equivalent of *what the
user wants and expects* in the *particular* situation that I described
[1].  I should have been clearer.

> And the first step will fail the same way.  While I share the sense of
> annoyance with you, I do not think that it is a bug in "checkout -b".
> 
> When you are on an unborn branch, what the "symbolic-ref HEAD" command
> reports does *not* appear in the output from the "for-each-ref refs/heads"
> command (similarly, that branch name does not appear in the output from
> the "git branch" command).
> 
> Such a behaviour indeed is *curious* and very *different* from the normal
> case of being on an existing branch, but is that a bug?

When git behaves differently than a typical user would expect for no
good reason, that is a bug (albeit a UI bug).  The fact that somebody
who knows the internals of git can find an excuse for the inconsistency
might be an explanation for how the bug arose but it doesn't make it
less of a bug.

> You need to first admit that the state immediately after "git init" (or
> for that matter, "checkout --orphan") where you are on an unborn branch
> *is* special.  Some things that would normally make sense would not.

ISTM that this state is more special than it needs to be due to an
design flaw of git [2].  But even given the fact that this case is
special *internal* to git, there is no reason to let that specialness
leak out to the user more than necessary.

> [...]
> I am not sure "git checkout -b foo" (without explict HEAD [*1*]) should
> special case and degenerate to "symbolic-ref HEAD refs/heads/foo" when
> HEAD points to a nonexistent branch.  The mimicking does not go far enough
> to satisfy people who are pedantic enough to expect "git checkout -b foo"
> to work when you haven't even instantiated your current branch (when you
> are on an already instantiated branch, after "git checkout -b foo", "git
> branch" output will show both foo and the branch you were on, but if you
> start from an unborn branch, the behaviour will be different and a pedant
> will notice the difference).

For me, "git checkout -b foo" means "leave the old branch in its current
state and move to a new branch that is in the same state."  If the old
branch was unborn, then it should remain unborn after the command, and I
should be moved to a new unborn branch.  Since an unborn branch in git
is not a branch, I would have no expectation that the old branch exists
after the command [3].

> It may make sense to let
> 
>     $ git branch -m trunk
> 
> or even
> 
>     $ git branch -m master trunk
> 
> move away from an unborn "master'"after "git init", with a special case
> codepath.  When you start from an instanticated branch, after a successful
> such renaming, the original branch will not exist, and the new branch will
> exist.  This property would also hold true if you start from an unborn one,
> so it would be much better mimickery than "git checkout -b foo" case you
> brought up in this thread.

It makes sense that "git branch -m" can *also* be used to escape an
unborn master, but this command won't necessarily occur to people
accustomed to using "git checkout -b" for creating new branches.

Michael

[1] Of course, here "the user" means me :-) but I predict that other
users would feel the same.

[2] Namely that "orphan" commits have no parents, instead of having an
"empty repository" commit (something like "000000*") as parent.  By
contrast, when a new Subversion repository is created, it automatically
gets a pseudo "r0" commit that represents the empty repository.  The r0
commit can be used in the UI most places that a "real" commit can be
used.  If the 0000000 commit could be used in the same way in git, it
would remove a lot of special casing.  For example, an "unborn branch"
could be initialized pointing at 0000000.  Even if there is some deeper
reason why such a design wouldn't have worked, perhaps such a concept
could be faked for the user interface.

[3] If commit 0000000 were treated specially, then there would be no
unborn branches but only branches pointing at the empty commit.  In that
case, my expectation would change--the old branch should be left
pointing at 0000000.  But currently git has no concept of an unborn
branch that is not HEAD.

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
