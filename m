From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Confused about git filter-branch results
Date: Tue, 25 Jan 2011 17:32:40 +0100
Message-ID: <201101251732.40811.trast@student.ethz.ch>
References: <20110125114840.GB9367@skull.piratehaven.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Mike Kelly <mike@piratehaven.org>
X-From: git-owner@vger.kernel.org Tue Jan 25 17:32:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Phlp3-0008P0-Ja
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 17:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025Ab1AYQcm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jan 2011 11:32:42 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:47698 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751251Ab1AYQcl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 11:32:41 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.270.1; Tue, 25 Jan
 2011 17:32:37 +0100
Received: from pctrast.inf.ethz.ch (64.134.226.220) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 25 Jan
 2011 17:32:40 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <20110125114840.GB9367@skull.piratehaven.org>
X-Originating-IP: [64.134.226.220]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165481>

Mike Kelly wrote:
> filter-branch

Before you read the explanations below, I recommend that you open
'gitk --all' and use it to see whether I'm right.

> I was fooling around with 'git filter-branch --env-filter ...' trying to
> update the timestamps on my commits (which worked), but now when I run
> 'git whatchanged -p master..' shows all changes to the entire project, not
> the differences between my branch and the master branch.

Most likely you filtered all commits on your branch, but not master,
so master now points to an entirely disjoint set of commits.

> Being a novice git user, I'm not sure how much to trust that I didn't hose
> git in some really weird way, leaving it in a state where it doesn't quite
> work the way it did before.

It's hopefully impossible to get git into a *inconsistent* state with
filter-branch (i.e., a state that the computer would refuse to
process), but it is indeed quite easy to get it into a state that
humans would call "a mess".

> The contents of .git/refs/original/refs/heads/ shows a file with my branch
> name which contains only one entry (presumably the one I updated the
> timestamp on) so I feel pretty sure that only the commit I wanted to change
> actually changed.

That's not how it works.  A branch contains the sha1 of ("is a pointer
to") its tip commit.  The refs/original/refs/heads/foo simply is the
old value of the branch, i.e., the old tip commit.

You can use it much like you could use a branch to see the difference
between them, e.g.,

   gitk refs/original/refs/heads/foo...foo

but note that if the disjoint history theory above holds, this will
not be immediately obvious from the output.

> Ultimately, my worry is that I polluted the history which I cloned, and
> pushing that would make people unhappy.

Pushing that would probably make people take a proverbial LART stick
to your office.

Assuming my "disjoint history" theory is correct, you should either
discard your rewrite along the lines of

  git branch -f foo refs/original/refs/heads/foo

and rewrite again with a range limiter, or rebase your rewritten
commits.  To illustrate the rebase, assume you had history like


   o---o---o---o---o---o  (master)
                \
                 *---*---*  (foo)

If you really rewrote all history of foo, that means you now have

   o---o---o---B---o---o  (master)
                \
                 1---2---3  (refs/heads/original/foo)

   o'--o'--o'--B'--1'--2'--3'  (foo)

where the ' indicates a rewritten copy of the original commit.  You
need to manually determine B and B'.  The former will most likely be

  git merge-base master refs/heads/original/foo

The latter will be its equivalent, so you can take Bs message and
search for its subject in the history of the (rewritten) foo.  Once
you know B', you can rebase the commits that were previously on foo
back to master with

  git rebase --onto B B' foo

That will create another series of rewritten copies of 1', like so:

   o---o---o---B---o---o  (master)
               |\
               | 1---2---3  (refs/heads/original/foo)
               |
                \
                 1''--2''--3''  (foo)

   o'--o'--o'--B'--1'--2'--3'  (foo@{1})

Confused yet? :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
