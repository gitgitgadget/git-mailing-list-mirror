From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [ANNOUNCE] git-as-svn: subversion frontend server for git
 repository
Date: Tue, 9 Sep 2014 22:57:11 +0400
Message-ID: <20140909185711.GA14554@seldon>
References: <20140909111903.GA13137@seldon>
 <xmqqy4tsloxs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bozaro@yandex.ru, marat@slonopotamus.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 20:57:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRQbS-000709-7E
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 20:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbaIIS5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 14:57:18 -0400
Received: from seldon.slonopotamus.org ([94.242.204.247]:53039 "EHLO
	slonopotamus.org" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbaIIS5R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 14:57:17 -0400
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XRQbH-0003oF-JZ; Tue, 09 Sep 2014 22:57:11 +0400
Content-Disposition: inline
In-Reply-To: <xmqqy4tsloxs.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256700>

On Tue, Sep 09, 2014 at 09:49:03AM -0700, Junio C Hamano wrote:
> Marat Radchenko <marat@slonopotamus.org> writes:
> 
> > Some time ago I complained [1] about troubles using Git
> > on a project with high ratio of non-programmers.
> > ...
> > Then, a lost'n'forgotten git_svn_server [4] was found.
> > ...
> 
> Interesting.

Actually, no. As I said, git_svn_server made several ineffective
architectural choices. It can be viewed as a proof-of-concept work though.

> > Current limitations:
> > ...
> >   * You must not do 'inverted merges'. Old HEAD must be reachable from
> >     new HEAD by first-parent traversal.
> 
> I am not sure what you mean by this to properly assess how
> significant this limitation is.  Care to draw a simple picture?

SVN doesn't support nonlinear history (except merge-info crutch).

Thus, we only expose "main" history line to SVN where "main" means
"reachable through first-parent traversal from branch tip".

To keep SVN history consistent, commits that once became visible to SVN
have to remain visible. This limitation will be removed when git-as-svn
gets persistent storage and will be able to remember what *was* main line.

Imagine you had following history:

--- time --->

A -- B -- C

Now you merge (via Git) a feature branch:

A -- B -- C -- G
 \            /
  D -- E --- F

For SVN, history will look this way:

A -- B -- C -- F

We might introduce merge-info support for this one day.

And now the *bad* case. You have the same initial history but do *inverted merge*:

A -- D -- E -- F -- G'
 \                 /
  B -- C ---------/
       ^
       |
    Previous branch tip

That's where things brake because for SVN, history transforms from

A -- B -- C

to

A -- D -- E -- F -- G'

And all users who checked out revisions B & C get their working copies screwed.

This also means that push --force also must not be performed.

Quoting my initial post [1] about inverted merges (you might call them
"merges with swapped parents").

> I call it "swapped/reverse merge problem".
>
> In short:
> 1. Hack, hack, hack
> 2. Commit
> 3. Push, woops, reject (non-ff)
> 4. Pull
> 5. Push
>
> The root of evil is step #4 that creates a merge commit with "swapped" parents - 
> local commits become first parent, remote commits become second. If one would want to 
> make proper parent order, he would have to: 1. git fetch
> 2. git checkout origin/master -b tmp
> 3. git merge master
> 4. git push
> 5. git checkout master
> 6. git merge origin/master
> 7. git branch -d tmp
> 
> And all this branch dance produces exactly the same commit (content-wise) as simple
> "pull, push" sequence with the only difference in parent order. And things become
> even worse if comeone pushes more commits to remote repo while you perform this
> dance.
>
> We can't expect all developers (especially, designers and artist) to do it. They
> don't want to use branches and just work on mainline. This is especially important on
> early development stages when new features (that designers' work depends upon) are
> added every day.
>
> Additionally, many git-related tools depend on first-parent convention and show wrong
> graphs/diffs.

[1] http://marc.info/?l=git&m=139866660018802
