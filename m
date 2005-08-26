From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: Storing state in $GIT_DIR
Date: Fri, 26 Aug 2005 08:26:58 -0600
Message-ID: <m13bowu631.fsf@ebiederm.dsl.xmission.com>
References: <46a038f905082420323b025e3b@mail.gmail.com>
	<Pine.LNX.4.58.0508251053000.3317@g5.osdl.org>
	<46a038f905082518306e9d7d2a@mail.gmail.com>
	<Pine.LNX.4.58.0508252051400.3317@g5.osdl.org>
	<46a038f90508252115415acc04@mail.gmail.com>
	<m17je9tcj0.fsf@ebiederm.dsl.xmission.com>
	<46a038f90508260008d1013ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, GIT <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 16:29:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8fBl-0003Pw-I9
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 16:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbVHZO12 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 10:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbVHZO12
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 10:27:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38864 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751589AbVHZO11 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 10:27:27 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j7QER3OY010893;
	Fri, 26 Aug 2005 08:27:03 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j7QEQwjm010892;
	Fri, 26 Aug 2005 08:26:58 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90508260008d1013ea@mail.gmail.com> (Martin Langhoff's
 message of "Fri, 26 Aug 2005 19:08:47 +1200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7812>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> On 8/26/05, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Thinking about it going from arch to git should be just a matter
>> of checking sha1 hashes, possibly back to the beginning of the
>> arch tree.
>
> Yup, though actually replaying the tree to compute the hashes is
> something I just _won't_ do ;)

I guess if you have the tla branch names it won't be necessary.
If you are careful how you do the import you can have two parallel
imports of the same data and produce exactly the same git tree.
That is largely why I care about a stable algorithm for the hashes.

>> Going from git to arch is the trickier mapping, because you
>> need to know the full repo--category--branch--version--patch
>> mapping.
>
> My plan doesn't include git->arch support... yet...

One of my interests, and if I get the time to worry about it
is to get a scm that is a sufficient superset of what other
scms do so it can serve as a bidirectional gateway.

git is fairly close to what is needed to implement that.

Hmm.  I wonder if a git metadata branch in general is sufficient to
store information that does not map to git natively?

>> Hmm.  Thinking about arch from a git perspective arch tags every
>> commit.  So the really sane thing to do (I think) is to create
>> a git tag object for every arch commit.
>
> Now I like that interesting idea. It doesn't solve all my problems,
> but is a reasonable mapping point. Will probably do it.
>
>> With patch trading (Martin I think I know what you are refering to)
>> arch does seem to have a concept that does not map very well to git,
>> and this I think is a failing in git.
>
> I won't get into _that_ flamewar ;)

<pouts> No flamewar </pouts>

> My plan for merges is to detect when two branches up until what point
> branches are fully merged, and mark that in git -- because that is
> what git considers a merge. The rest will be known to the importer,
> but nothing else.

I looked at least back to the StGit announcement and it helped to
clarify my thinking.  A patch is equivalent to a branch with
just one change. This makes cherry picking a single patch roughly
equivalent to describing that patch as a single commit branch
at the fork point from the common ancestor of the two branches,
and then having the single commit merged.

The fact that the original branch that was cherry picked from
can really only be represented as a an graft.  Like the original
linux kernel history.

The shortcoming I see in git-applypatch is that it doesn't attempt
to find the original base of a patch and instead simply assumes it
is against the current tree.

There is a similar short coming in git-diff-tree where it reports
the commit that you are on when take the diff, but it does not
report the commit the diff is against. 

......

Thinking a little more there is also a connection with reverting
patches.  Cherry picking changes from a branch may also be thought of
as reverting all of the other changes from a branch and then merging
the branch.

The practical impact of all of these things is there a form that
will allow future merges to realize the same change has already
been applied so it can skip it the second time.

Inter-operating with darcs, tla, quilt, and raw diff/patch brings up
these issues.

So my practical questions are:
- What information can a current git merge algorithms and more
  sophisticated merge algorithms use to avoid having conflicts when
  the same changes are merged into the same branch multiple times?

- Is the git meta data sufficient to represent the history
  sophisticated merge algorithms can use.

- Is the git meta data sufficient to represent the result
  of sufficient meta data operations.

- Is the current representation of a reverted change sufficient
  for the merge algorithms, or could they do a better job if
  they new a change was revert of a previous change.

I'm just trying to think through the issues that working with patch
based systems bring up.

Eric
