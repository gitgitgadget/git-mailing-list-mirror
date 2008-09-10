From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFC] origin link for cherry-pick and revert, and more about
 porcelain-level metadata
Date: Wed, 10 Sep 2008 11:35:18 +0200
Message-ID: <48C794D6.20001@gnu.org>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080909230525.GC10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Sep 10 11:36:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdM7x-0000ys-5q
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 11:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbYIJJfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 05:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbYIJJfY
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 05:35:24 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:11670 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbYIJJfW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 05:35:22 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1319462yxm.1
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 02:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding:sender;
        bh=JUIpYPuk4rvxp4OGOLKq6IuDEF0fhkeh9Lop4CVobvI=;
        b=xvbBSK1EbcLpEnO8ZtA+sOmjYthP/KEj+1iHtPSHtgrYYpo9Dgg16IEeINzH72AXSG
         /7dxgxDqB5iw6+rTcl0EITuxf8g3EwiyfuRxEsZ8rZDLDHinAqfOU7DDl9UunPwlk4WC
         gbOBJ0Vgrqwmg78MPbAqwwwRISYn0KgrmjA0k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :sender;
        b=tmDIwPQA+pN7agbpVnll8NlrnPc3zDlEQgEOe2YUfI3UE6mcon8XaapRxPS0R3BZhF
         MqFgVQGeH4vhfeBq63IEImd/2RHDideOZ7U0Tgy1CGGdaOpUYPKi05k/YBP3TJeOK0PC
         mQDXYXi4f4E/6Z/O4wG9eXph1YBjpCjF7Kpds=
Received: by 10.103.17.10 with SMTP id u10mr597483mui.97.1221039320186;
        Wed, 10 Sep 2008 02:35:20 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id i5sm30462508mue.11.2008.09.10.02.35.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Sep 2008 02:35:19 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Macintosh/20080707)
In-Reply-To: <20080909230525.GC10360@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95504>


> Why do you actually *follow* the origin link at all anyway? Without its
> parents, the associated tree etc., the object is essentially useless for
> you

Stephen posed the origin links as weak, but it is not necessarily true
that you don't have the parents and the associated tree.  For example,
if you download a repository that includes a "master" branch and a few
stable branches, you *will* have the objects cherry-picked into stable
branches, because they are commits in the master branch.

Junio explained that the way achieves the same effect in git is by
forking the topic branch off the "oldest" branch where the patch will
possibly be of interest.  Then he can merge it in that branch and all
the newest ones.  That's great, but not all people are as
forward-looking (he did say that sometimes he needs to cherrypick).

Another problem is that in some projects actually there are two "maint"
branches (e.g. currently GCC 4.2 and GCC 4.3), and most developers do
not care about what goes in the older "maint" branch; they develop for
trunk and for the newer "maint" branch, and then one person comes and
cherry-picks into the older "maint" branch.  This has two problems:

1) Having to fork topic branches off the older branch would force extra
testing on the developers.

2) Besides this, topic branches are not cloned, so if I am the
integrator on the older "maint" branch, I need to dig manually in the
commits to find bugfixes.  True, I could use Bugzilla, but what if I
want to use git instead?  There is "git cherry -v ... | grep -w ^+.*PR",
except that it has too many false negatives (fixes that have already
been backported, but do show up in the list).

> And why are the notes created by git cherry-pick -x insufficient for that?

For example, these notes (or the ones created by "git revert") are
*wrong* because they talk about commits instead of changesets (deltas
between two commits).

Why is only one commit present?  Because these messages are meant for
users, not for programs.  That's easy to show: users think of commits as
deltas anyway, even though git stores them as snapshots---"git show
HEAD" shows a delta, not a snapshot.

And what does this mean for programs?  That they must resort to
commit-message scraping to distinguish the two cases. (*)

   (*) A GUI blame program, for example, would need to distinguish
   whether code added by a commit is taken from commit 4329bd8, or is
   reverting commit 4329bd8.  (In the first case, the author of that
   code is whoever was responsible for that code in 4329bd8; in the
   second case, it is whoever was responsible for that code in
   4329bd8^).  If recording changesets, you see 4329bd8^..4329bd8 in
   the first case, and 4329bd8..4329bd8^ in the second, so it is trivial
   to follow the chain.

And scraping is bad.  Imagine people that are writing commit messages in
their native language.  What if they patch git to translate the magic
notes created by "git cherry-pick -x" or "git revert" (maybe a future
version of git will do that automatically)?  Should they translate also
every program that scrapes the messages?


Whenever there is a piece of data that could be useful to programs (no
matter if plumbing or porcelain), I consider free form notes to be bad.
 Because data is data, and metadata is metadata.

If there was a generic way to put porcelain-level metadata in commit
messages (e.g. Signed-Off-By and Acknowledged-By can be already
considered metadata), I would not be so much in favor of "origin" links
being part of the commit object's format.  Now if you think about it,
commit references within this kind of metadata would have mostly the
properties that Stephen explained in his first message:

1) they would be rewritten by git-filter-branch

2) these references, albeit weak by default, could optionally be
followed when fetching (either with command-line or configuration options)

3) they would not be pruned by git-gc

4) possibly, git rev-list --topo-order would sort commits by taking into
account metadata references too.

So the implementation effort would be roughly the same.

But, can you think of any other such metadata?  Personally I can't, so
while I understand the opposition to a new commit header field that
would be there from here to eternity (or until the LHC starts), I do
think it is the simplest thing that can possibly work.

Paolo
