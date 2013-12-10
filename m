From: Dominik Vogt <vogt@linux.vnet.ibm.com>
Subject: Re: Setting file timestamps to commit time (git-checkout)
Date: Tue, 10 Dec 2013 09:46:22 +0100
Message-ID: <20131210084622.GC4087@linux.vnet.ibm.com>
References: <20131209112528.GA5309@linux.vnet.ibm.com>
 <20131209204815.GV29959@google.com>
Reply-To: vogt@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 10 09:47:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqIyp-0005Bn-Tm
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 09:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557Ab3LJIro (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 03:47:44 -0500
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:40682 "EHLO
	e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab3LJIrn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 03:47:43 -0500
Received: from /spool/local
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <git@vger.kernel.org> from <vogt@linux.vnet.ibm.com>;
	Tue, 10 Dec 2013 08:47:41 -0000
Received: from d06dlp02.portsmouth.uk.ibm.com (9.149.20.14)
	by e06smtp11.uk.ibm.com (192.168.101.141) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
	Tue, 10 Dec 2013 08:47:39 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
	by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5028E219006A
	for <git@vger.kernel.org>; Tue, 10 Dec 2013 08:47:38 +0000 (GMT)
Received: from d06av06.portsmouth.uk.ibm.com (d06av06.portsmouth.uk.ibm.com [9.149.37.217])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id rBA8kBkN64291060
	for <git@vger.kernel.org>; Tue, 10 Dec 2013 08:46:11 GMT
Received: from d06av06.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id rBA8kNOl020034
	for <git@vger.kernel.org>; Tue, 10 Dec 2013 01:46:23 -0700
Received: from bl3ahm9f.de.ibm.com (dyn-9-152-212-171.boeblingen.de.ibm.com [9.152.212.171])
	by d06av06.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id rBA8kMUL020023
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 10 Dec 2013 01:46:23 -0700
Received: from dvogt by bl3ahm9f.de.ibm.com with local (Exim 4.76)
	(envelope-from <vogt@linux.vnet.ibm.com>)
	id 1VqIxS-0001M8-N3
	for git@vger.kernel.org; Tue, 10 Dec 2013 09:46:22 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20131209204815.GV29959@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-MML: disable
X-Content-Scanned: Fidelis XPS MAILER
x-cbid: 13121008-5024-0000-0000-000008166F7D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239129>

On Mon, Dec 09, 2013 at 12:48:16PM -0800, Jonathan Nieder wrote:
> Dominik Vogt wrote:
> > when I switch to one of the other branches, said file is not
> > identical anymore and stamped with the _current_ time during
> > checkout.  Although branch b and c have not changed at all, they
> > will now be rebuilt completely because the timestamp on that files
> > has changed.  I.e. a chance on one branch forces a rebuild on n
> > other branches, which can take many hours.
> >
> > I think this situation could be improved with an option to
> > git-checkout with the following logic:
> >
> > $ git checkout <new branch>
> >   FOR EACH <file> in working directory of <new branch>
> >     IF <file> is identical to the version in the <old branch>
> >       THEN leave the file untouched
> >     ELSE IF <commit timestamp> of the HEAD of the <new branch>
> >             is in the future
> >       THEN checkout the new version of <file> and stamp it with
> >            the current time
> >     ELSE (commit timestamp is current or in the past)
> >       THEN checkout the new version of <file> and stamp it with
> >            the commit timestamp of the current HEAD of <new branch>
> 
> Wouldn't that break "make"?  When you switch to an old branch, changed
> files would then a timestamp *before* the corresponding build targets,
> causing the stale (wrong function signatures, etc) build results from
> the newer branch to be reused and breaking the build.

Yes, if you share a common build directory, this logic would
utterly break the build system.  The point with gcc is, that you
do not build it in the source tree but in a separate build
directory, and it's easy to have separate build directories for
your branches.

> I suspect the simplest way to accomplish what you're looking for would
> be to keep separate worktrees for each branch you regularly build.
> It's possible to do that using entirely independent clones, clones
> sharing some objects (using "git clone --shared" from some master
> copy), or even multiple worktrees for the same clone (using the
> git-new-workdir script from contrib/workdir/).

I've tried the first two ways for separate workdirs in the past
but did not like them.  How does git-new-workdir cope with
rebasing (e.g. you have the same branch checked out in two working
trees and "rebase -i" it in one of them)?  Is it really a working
option?

> > (Please do not cc me on replies, I'm subscribed to the list.)
> 
> The convention on this list is to always reply-to-all, but I'm happy
> to make an exception. :)

It's just a hint; anyway, I guess I should remove the Reply-To
header if I don't want direct replies.  ;-)

Ciao

Dominik ^_^  ^_^

-- 

Dominik Vogt
IBM Germany
