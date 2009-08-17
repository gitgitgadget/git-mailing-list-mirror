From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Mon, 17 Aug 2009 15:35:40 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171524150.4991@intel-tinevez-2-302>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>  <200908142223.07994.jnareb@gmail.com> <7veird4yyi.fsf@alter.siamese.dyndns.org>  <200908160137.30384.jnareb@gmail.com> <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de> 
 <alpine.DEB.1.00.0908171101090.4991@intel-tinevez-2-302> <fcaeb9bf0908170549w26b008bdhe67f113a58ecb4eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-578110909-1250516141=:4991"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 15:36:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md2Nv-0004rq-SD
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 15:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbZHQNfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 09:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751875AbZHQNfl
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 09:35:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:56932 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751572AbZHQNfk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 09:35:40 -0400
Received: (qmail invoked by alias); 17 Aug 2009 13:35:41 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 17 Aug 2009 15:35:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+qtn0YMLqq+szUBnWgum0H19MjqMrWaGHRZuDSj+
	r3WJpGAe6jpqBR
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <fcaeb9bf0908170549w26b008bdhe67f113a58ecb4eb@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126180>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-578110909-1250516141=:4991
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 17 Aug 2009, Nguyen Thai Ngoc Duy wrote:

> On Mon, Aug 17, 2009 at 4:08 PM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
> > Turns out that somebody on IRC had a problem that requires to have 
> > sparse'd out files which _do_ have working directory copies.
> >
> > So just having the assume-changed bit may not be enough.
> >
> > The scenario is this: the repository contains a file that users are 
> > supposed to change, but not commit to (only the super-intelligent 
> > inventor of this scenario is allowed to).  As this repository is 
> > originally a subversion one, there is no problem: people just do not 
> > switch branches.
> >
> > But this guy uses git-svn, so he does switch branches, and to avoid 
> > committing the file by mistake, he marked it assume-unchanged.
> 
> Hmm.. never thought of this use before. If he does not want to commit by 
> mistake, should he add to-be-committed changes to index and do "git 
> commit" without "-a" (even better, do "git diff --cached" first)?

You probably agree that this would be a _very_ fragile setup.  Very easy 
to make mistakes.

But we try to get away from that, don't we?  Git had a reputation to be 
easy fsck up for long enough.

> > Only that a branch switch overwrites the local changes.
> 
> I don't think branch switch overwrites changes in this case. Whenever
> Git is to touch worktree files, it ignores assumed-unchanged bit and
> does lstat() to make sure worktree files are up to date.

Well, it does there, thankyouverymuch.

The problem of course is that the other branch has an ancient version of 
that file (which should _not_ overwrite the current, modified version!), 
i.e. "git diff HEAD..other -- file" does not come empty.

As 'file' is assume-unchanged, zinnnng, the file gets "updated".

> > I suggested the use of the sparse feature, and mark this file (and 
> > this file alone) as sparse'd-out.
> 
> Sparse checkout only removes a file if its assume-unchanged bit
> changes from 0 to 1.

The problem is not removing, but overwriting.

And in this respect, 'assume-unchanged' is a very different beast from 
'sparse'.  I am growing more and more convinced that you cannot just reuse 
the assume-unchanged bit.

> If it's already 1, it does not care whether there is a corresponding 
> file in worktree. So something like this should work:
> 
> git checkout my-branch
> git update-index --assume-unchanged that-special-file
> echo that-special-file > .git/info/sparse
> # edit that-special-file
> git commit -a
> # do whatever you want, git pull/checkout/read-tree... won't touch
> that-special-file because it's assume-unchanged already

... except if you changed .git/info/sparse and a formerly sparse'd-out 
file is overwritten by "pull".  Not good.

> Anyway I would not recommend this. the versions of that-special-file in 
> worktree and and in index will diverse. When you unmark assume-unchanged 
> (be it sparse checkout or plain assume-unchanged), you may have already 
> forgot what changes you made to this file and "git diff" would not help.

My point is that we should take the current implementation as Dictated By 
The Dear Lord, but change it if the limitation is too severe.

And I do contend that 'assume-unchanged' is dissimilar enough from 
'sparse' to merit a change.

> > Is this an intended usage scenario?  Then we cannot reuse the 
> > assume-changed bit [*1*].
> 
> It'd be great if people tell us all the scenarios they have. My use 
> could be too limited.

The use case I would have is where a collaborator wants to work only on 
one subdirectory and the top-level directory.  All other subdirectories 
are of no interest to him.

Another use case: documentation.  I do not have that use case yet, but I 
know about people who do.  Specifying what you _want_ to have checked out 
is much more straight-forward here than the opposite.

Ciao,
Dscho


--8323329-578110909-1250516141=:4991--
