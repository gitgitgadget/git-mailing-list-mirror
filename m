From: Jeff King <peff@peff.net>
Subject: Re: Bug#553296: gitignore broken completely
Date: Fri, 30 Oct 2009 13:38:38 -0400
Message-ID: <20091030173838.GB18583@coredump.intra.peff.net>
References: <20091029233458.GA32764@ikki.ethgen.de>
 <20091030162857.26604.qmail@67b7e3b41a17c8.315fe32.mid.smarden.org>
 <20091030165903.GA10671@ikki.ethgen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: 553296@bugs.debian.org, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Klaus Ethgen <Klaus@Ethgen.de>
X-From: git-owner@vger.kernel.org Fri Oct 30 18:38:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3vR6-0000Y9-8O
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 18:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932721AbZJ3Rim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 13:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbZJ3Ril
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 13:38:41 -0400
Received: from peff.net ([208.65.91.99]:34072 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932720AbZJ3Ril (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 13:38:41 -0400
Received: (qmail 1816 invoked by uid 107); 30 Oct 2009 17:42:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Oct 2009 13:42:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2009 13:38:38 -0400
Content-Disposition: inline
In-Reply-To: <20091030165903.GA10671@ikki.ethgen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131719>

[cc'ing git@vger and quoting excessively to give those readers context]

On Fri, Oct 30, 2009 at 05:59:03PM +0100, Klaus Ethgen wrote:

> Am Fr den 30. Okt 2009 um 17:28 schrieb Gerrit Pape:
> > > The most recent git in debian has a broken ignore handling. Let me
> > > show
> > > it on a example:
> > >  > mkdir gittest
> > >  > cd gittest
> > >  > git init
> > >  > touch a
> > >  > git add a
> > >  > git commit -m commit
> > >  > git ls-files -i --exclude-standard
> > > 
> > > The last command will show the file a (as it would show every file as
> > > being ignored, every which is in the index!). But that command should
> > > show nothing at that point.
> > 
> > Hi Klaus, it looks like upstream did that on purpose
> > 
> >  http://git.kernel.org/?p=git/git.git;a=commit;h=b5227d80
> > 
> > $ git describe --contains b5227d80
> > v1.6.5.2~2^2^2

It was not exactly on purpose. The point of that change was that "git
ls-files" should also show things mentioned in the .gitignore, because
.gitignore has nothing to do whatsoever with tracked files.

But I simply forgot about "git ls-files -i", so changing it was an
unintended side effect (and sadly, we don't seem to have any regression
tests for it).

> That makes the whole sense of -i ad absurdum (I do not know how to tell
> "ad absurdum" in english). With that patch there is no way anymore to
> see if some ignored files are accidentally committed.

Yes, with the current code "-i" serves no purpose unless you are using
"-o".

> I have to use git often as frontend for that broken design (svn). So to
> hold the ignores up2date I use "git svn show-ignore > .gitignore" But
> many, many repositories have broken ignores so I have to check it with
> "git ls-files -i --exclude-standard" to see if there is accidentally
> ignored files. Well, that patch makes that impossible at all!

Just to be clear: nothing is actually broken about ignores that cover
tracked files. Ignores are (and have been since long before this patch)
purely about untracked files. So there is no problem at all with:

  $ echo content >foo
  $ git add foo
  $ echo foo >.gitignore
  $ git commit

The _only_ thing that respected such ignores was "git ls-files", and the
point of the patch in question was to fix that.

> So I think, this patch is a bug at all!
> 
> I add Jeff (and Junio as he did the commit) to the Cc. @Jeff and or
> Junio: could you please revoke that patch?

I am not sure simply reverting is the best choice; the patch does do
something useful. And while it strictly breaks backwards compatibility
on the output without "-i", the old behavior was considered a bug. But
the "-i" behavior is useless now, so we need to figure out how to
proceed. We can:

  1. Revert and accept that the behavior is historical. Callers need to
     work around it by dropping --exclude* when invoking ls-files.

  2. Declare "-i" useless, deprecate and/or remove. Obviously this is
     also breaking existing behavior, but again, I don't think that
     using "-i" actually accomplishes anything.

  3. Revert for now, and then reinstate the patch during a major version
     bump when we are declaring some compatibility breakages.

  4. Re-work "-i" to show tracked but ignored files, but still show all
     files when "-i" is not given at all.

I think (4) preserves the benefit of the patch in question, but still
allows your usage ("git ls-files -i --exclude-standard"). I do question
whether that usage is worth supporting. Certainly I wouldn't implement
it if I were writing git-ls-files from scratch today, but we do in
general try to maintain backwards compatibility, especially for plumbing
like ls-files.

Junio, what do you want to do?

-Peff
