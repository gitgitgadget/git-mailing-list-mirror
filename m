From: Sean <seanlkml@sympatico.ca>
Subject: Re: Questions about git-fast-import for cvs2svn
Date: Sun, 15 Jul 2007 12:01:49 -0400
Message-ID: <20070715120149.3271b736.seanlkml@sympatico.ca>
References: <469A2B1D.2040107@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 15 18:05:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA6an-000686-Az
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 18:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762061AbXGOQEJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 12:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761805AbXGOQEI
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 12:04:08 -0400
Received: from bay0-omc3-s29.bay0.hotmail.com ([65.54.246.229]:17263 "EHLO
	bay0-omc3-s29.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760491AbXGOQEH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jul 2007 12:04:07 -0400
Received: from BAYC1-PASMTP07.bayc1.hotmail.com ([65.54.191.167]) by bay0-omc3-s29.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 09:04:06 -0700
X-Originating-IP: [65.93.40.159]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.40.159]) by BAYC1-PASMTP07.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sun, 15 Jul 2007 09:05:02 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IA6Zo-0000iM-II; Sun, 15 Jul 2007 12:04:04 -0400
In-Reply-To: <469A2B1D.2040107@alum.mit.edu>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.11; i686-pc-linux-gnu)
X-OriginalArrivalTime: 15 Jul 2007 16:05:02.0593 (UTC) FILETIME=[E6DFC710:01C7C6F9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 15 Jul 2007 16:11:41 +0200
Michael Haggerty <mhagger@alum.mit.edu> wrote:

Hi Michael,

Will take a stab at answering your questions...

> 1. Is it a problem to create blobs that are never referenced?  The
> easiest point to create blobs is when the RCS files are originally
> parsed, but later we discard some CVS revisions, meaning that the
> corresponding blobs would never be needed.  Would this be a problem?

Not a problem.  Running "git gc" later will cleanup any unused objects.

> 2. It appears that author/committer require an email address.  How
> important is a valid email address here?

It's not necessary for the operation of Git itself; it's up to you to
decide how important the information is to your project.  You should
be able to set an empty email address for author or committer in
git fast-import as "name <>".

>    a. CVS commits include a username but not an email address.  If an
> email address is really required, then I suppose the person doing the
> conversion would have to supply a lookup table mapping username -> email
> address.

Yes, take a look at the format supported by git-cvsimport and git-svnimport,
which can map each username into an appropriate name and email addy for Git.

>    b. CVS tag/branch creation events do not even include a username.
> Any suggestions for what to use here?

Perhaps just use your own username or one specifically created to
run the conversion process.

> 3. I expect we should set 'committer' to the value determined from CVS
> and leave 'author' unused.  But I suppose another possibility would be
> to set the 'committer' to 'cvs2svn' and the 'author' to the original CVS
> author.  Which one makes sense?

Another option is to just allow Git to set author and committer to the
same value.  As noted in the man page: "If author is omitted then
fast-import will automatically use the committer's information for
the author portion of the commit".

> 4. It appears that a commit can only have a single 'from', which I
> suppose means that files can only be added to one branch from a single
> source branch/revision in a single commit.  But CVS branches and tags
> can include files from multiple source branches and/or revisions.  What
> would be the most git-like way to handle this situation?  Should the
> branch be created in one commit, then have files from other sources
> added to it in other commits?  Or should (is this even possible?) all
> files be added to the branch in a single commit, using multiple "merge"
> sources?

Git supports the ability to merge from multiple branches at once (known
as an octopus merge).  So it's possible to start a new branch, drawing
in files from more than one source branch in a single commit.  As i
understand it, fast-import allows only a single "from" line for a commit,
but allows multiple "merge" lines for additional parentage info. 

> 5. Is there any significance at all to the order that commits are output
> to git-fast-import?  Obviously, blobs have to be defined before they are
> used, and '<committish>'s have to be defined before they are referenced.
>  But is there any other significance to the order of commits?

Don't think so, except perhaps for the packfile optimization issues
mentioned in the man page.

HTH,
Sean
