From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
Date: Wed, 20 Oct 2010 22:44:38 +0200
Message-ID: <201010202244.39728.jnareb@gmail.com>
References: <20101018051702.GD22376@kytes> <m3bp6pkrf0.fsf@localhost.localdomain> <1287582160.2673.25.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 22:44:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8fWp-0003lL-2U
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 22:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618Ab0JTUos (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 16:44:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59300 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262Ab0JTUor (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Oct 2010 16:44:47 -0400
Received: by fxm4 with SMTP id 4so3087380fxm.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 13:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=iUFC2r8JYrbJ69W18Aq9IRp6k1t7Gb/4rchHIFPqzq0=;
        b=Qvk2rtHUcCUan5YAPP2cU90tBYB0S+2/638954zU/RTG1P7nm/6STDTmJgReC/Ld0r
         CiRbVvhZjuvQox/Vx4cTLQt6kPkzhGCOURucxhAzB7zSdXSTUkJeLHn4ygEG83OUSHbJ
         ntXDFdCR+zPlWguUXPlqpHc7bM2a0EcAdPrPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pGsID85PKwpT9FRJmE3/GLwJyaa/NMhikyWfnxyX7wCqQ5GPPcZX81RRgcTllEr+2s
         NSLoyn9l2zE/6MmJKsUvk/2mCGJ0ER7JWpC4OB05t3nXx3Xz1Sxqm6wxoFMstlo1c0et
         ddV9aEevkxHqpx79T1Ch/dxNrZWf6NC/pw3xU=
Received: by 10.102.219.16 with SMTP id r16mr5989915mug.85.1287607486390;
        Wed, 20 Oct 2010 13:44:46 -0700 (PDT)
Received: from [192.168.1.13] (abvx10.neoplus.adsl.tpnet.pl [83.8.221.10])
        by mx.google.com with ESMTPS id 10sm421586fax.42.2010.10.20.13.44.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 Oct 2010 13:44:44 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1287582160.2673.25.camel@wpalmer.simply-domain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159438>

On Wed, 20 Oct 2010, Will Palmer wrote:
> On Wed, 2010-10-20 at 04:59 -0700, Jakub Narebski wrote:
>> Will Palmer <wmpalmer@gmail.com> writes:
>>> On Tue, 2010-10-19 at 12:12 +0530, Ramkumar Ramachandra wrote:
>>>> Stephen Bash writes:
>>> ...
>>>>> 
>>>>> I have 32 SVN revs in my history that touch multiple Git commit
>>>>> objects.  The simplest example is
>>>>>   svn mv svn://svnrepo/branches/badBranchName svn://svnrepo/branches/goodBranchName
>>>>> which creates a single SVN commit that touches two branches
>>>>> (badBranchName will have all it's contents deleted, goodBranchName
>>>>> will have an "empty commit" as described above).  The more devious
>>>>> version is the SVN rev where a developer checked out / (yes, I'm not
>>>>> kidding) and proceeded to modify a single file on all branches in
>>>>> one commit.  In our case, that one SVN rev touches 23 git commit
>>>>> objects.  And while the latter is somewhat a corner case, the former
>>>>> is common and probably needs to be dealt with appropriately (it's
>>>>> kind of a stupid operation in Git-land, so maybe it can just be
>>>>> squashed).
>>>> 
>>>> Ouch! Thanks for the illustrative example- I understand now. We have
>>>> to bend backwards to perform a one-to-one mapping. It's finally struck
>>>> me- one-to-one mapping is nearly impossible to achieve, and I don't
>>>> know if it makes sense to strive for it anymore. Looks like Jonathan
>>>> got it earlier.
>>> 
>>> It's been a while since I was involved in this discussion, so maybe the
>>> design has changed by now, but I was under the impression that there
>>> would be one "one-to-one" mapping branch (which would never be checked
>>> out), containing the history of /, and that the "real" git branches,
>>> tags, etc, would be based on the trees originally referenced by the root
>>> checkout, with git-notes (or similar) being used to track the weirdness
>>> in mappings. How does the "multiple branches touched in a single commit"
>>> complicate anything other than the heuristics for automatic branch
>>> detection (which I assume nobody is at the stage of talking about yet).
>> 
>> I think there might be a problem in that in git commit is defined by
>> its parents and its final state, while revision in Subversion is IIRC
>> defined by change.  Isn't it?
> 
> A "change" is a delta between one state and another, so each revision is
> dependent on those which came before it just as much as a a git commit
> is. An svn "revision" is a snapshot, regardless of how it is stored, ie,
> the "svn stores changes, git stores snapshots" is an implementation
> detail. It's a detail which makes a lot of things easier/faster in git
> than they would be in svn, but a mere detail none the less.

Thanks for the correction, and for explanation.

The problem with one-to-one [SVN revision]<->[Git commit] mapping in the
situation of Subversion mishandling described by Stephen Bash persist,
though the problem is not because "svn stores changes, git stores
snapshots", but because of widely different model of branches.


Subversion uses the inter-file branching model (Wikipedia says it was
"borrowed" from Perforce) to handle branches and tags.  It uses "branches
are copies (folders)" paradigm, and technically it doesn't have separate
namespace for branches but have projects, branches, and projects' 
filesystem hierarchy mixed together; what part of path is branch name
is defined by convention only.  This model makes it easy to mess up
repository (because there are no technological barriers for going 
against conventions, like mentioned all-branches change, or changing
tags, or reversed hierarchy or branches and projects).

Because (from what I understand) revisions in Subversion are whole
project all-branches snapshots, and because revision identifiers are
monotonically incrementing numbers, there is no inherent notion of
_parent_ of commit, like there is in Git.  (I think that was the reason
why merge tracking was absent from Subversion until version 1.5, and
why mergeinfo is per-file rather than per-commit/per-revision property).


In Git commits store snapshot of top level of a project (contrary to
revisions in Subversion being snapshot of top level of repository tree,
all branches and tags in it).  Each commit in Git also stores its parent
or parents.  Those commit-to-parent links make up DAG (Directed Acyclic
Graph) of revisions.  Branches in Git reside in separate namespace,
and are live pointers (like e.g. top pointer in stack implementations)
to commits; commit that branch points to (the tip of branch) marks out
subset of DAG of revisions: all descendants of given commits - this form
a line of development i.e. branch.

What is important here is that commit is defined by the snapshot of
top tree, and by its parents.  Different top tree and/or different
parent(s) means that commit must be different.


Now take a look at the situation described by Stephen Bash.  Lets
assume that we have branches in our Subversion repository branches
'foo' and 'bar' that diverged at revision number 1, that revision
2 was only on branch 'foo', revision 3 was only on branch 'bar',
and that revision 4 is mishandled edit of file across all branches.

Let's try to draw it on ASCII-art diagram (fixed-width font required).

  --- [1]-----[2]---|||---[ ]----|||----|||---[7]       <=== foo
        \                 [4]
         \----|||---[3]---[ ]----[5]----[6]             <=== bar

I marked by '|||' here that given revision doesn't change anything
on given branch (in given subdirectory of repository tree).

Now, from what I understand of Subversion model, when one asks for
history of branch 'foo' in Subversion, it would return all revisions
that modify 'project/branch/foo' or 'branch/foo/project', and only
those that modify it (similarly to how path limiting in 
`git log <path>` works).  For branch 'foo' it would be revisions
1, 2, 4, 7; for branch 'bar' it would be revisions 1, 3, 4, 5, 6.

Am I understanding it correctly?


Now in Git we don't have 'project/branch/foo/xxx', we have only
top tree of a project.  Therefore we cannot represent revision
4 as single git commit.  To have similar situation, i.e. commits
1, 2, 4', 7 on branch 'foo', and commits 1, 3, 4'', 5, 6 on branch
'bar', we would have to have the following graph of revisions


  --- 1--<--2--<--4'---<--7            <=== foo
       \
        -<--3--<--4''--<--5--<--6      <=== bar

I uses --<-- here to denote that it is actual directed link.

Commits 4' and 4'' can have different trees, and have different 
parents.


So to have the same results for 'svn log' when on branchs 'foo' and
'bar' (however you switch branches in subversion), or 
'svn log <foo URL>' and 'svn log <bar URL>' like for 'git log foo'
and 'git log bar' in the [mishandling] situation described above
you have to map single all-branches revision 4 in Subversion into
two commits 4' and 4'' in Git.


Please correct me if I am wrong about Subversion model.

> 
> The difference of course is that the "name" of an svn revision stays the
> same even if aspects of that revision (for example, the commit message)
> are changed, while the "name" of a git commit is dependent on everything
> that makes up a commit. In git terms, changing a commit message is
> considered to be history rewriting, whereas in svn terms it is merely
> something which happens occasionally as part of regularly maintained
> repository.
> 
> the git Philosophy is ingrained in its object model: If you change
> something which led to a state, you change the state itself. I don't
> think there should be an attempt to work-around that philosophy when
> talking to external repositories. That is to say: if a commit message
> (or other revprop) in history changes, we want to treat it as if we were
> recovering from an upstream rebase. Of course, a problem in that could
> very well be "how would we know about it?", which is a good question,
> but one not directly related to [revision+directory]<->[commit]
> mappings, afaik ;)

Better solution, actually proposed in separate subthread, is to make use
of new 'git replace' / 'refs/replaces/*' feature in Git, creating 
replacement for revision which changed some property retroactively...

...if Subversion actually offer any way to ask for changed properties.
Thankfully from what I understand from comments in this thread this
feature of being able to change revision properties like commit message
or authorship is by default turned off in Subversion.

-- 
Jakub Narebski
Poland
