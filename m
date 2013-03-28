From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] use refnames instead of "left"/"right" in dirdiffs
Date: Thu, 28 Mar 2013 14:19:45 +0000
Message-ID: <20130328141944.GW2286@serenity.lan>
References: <1364422397.8091.1.camel@heisenberg.scientia.net>
 <20130327230715.GU2286@serenity.lan>
 <1364474776.11891.9.camel@heisenberg.scientia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
X-From: git-owner@vger.kernel.org Thu Mar 28 15:20:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULDgl-0006Wn-58
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 15:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756274Ab3C1OTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 10:19:54 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:53033 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756126Ab3C1OTx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 10:19:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id D9DBACDA5C6;
	Thu, 28 Mar 2013 14:19:52 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wgoRLHR7u1zz; Thu, 28 Mar 2013 14:19:51 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 57DCECDA5CE;
	Thu, 28 Mar 2013 14:19:46 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <1364474776.11891.9.camel@heisenberg.scientia.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219399>

On Thu, Mar 28, 2013 at 01:46:16PM +0100, Christoph Anton Mitterer wrote:
> On Wed, 2013-03-27 at 23:07 +0000, John Keeping wrote: 
> > That's not going to work well on Windows, is it?
>
> Uhm Winwhat? No seriously... doesn't dir-diff fail ther anway? The mkdir
> right now also uses mkpath with "/"... and I could read in it's
> documentation that it would automatically translate this, does it?

I believe Windows generally accepts '/' as a directory separator in
place of '\'.  In a recent thread Johannes Sixt reported a difftool test
failure on Windows, so it does work (and we do have code to implicitly
set --no-symlinks when running on Windows).

> >  Anything with two dots
> > in is already forbidden so we don't need to worry about that
>
> Sure about this? I mean they're forbidden as refnames, but is this
> really checked within git-difftool before?

We've already run git-diff by this point, and that should have
complained if the refs are invalid, causing difftool to die.

> > ; I'm not
> > sure we need to remove forward slashes at all
>
> Mhh could be... seems that the cleanup happens via completely removing
> the $tmpdir path.
> And for the actual diff it shouldn't matter when there's a partentdir
> more.
> 
> >  until we consider the
> > "commit containing" syntax ':/fix nasty bug' or 'master^{/fix bug}'.
>
> Phew... don't ask me... I'm not that into the git source code... from
> the filename side, these shouldn't bother, only / an NUL is forbidden
> (in POSIX,... again I haven't checked win/mac which might not adhere to
> the standards).

Filenames on Windows cannot contain any of the following[1]:

    \ / : * ? " < > |

but it's also potentially annoying that '^' and '{' have special meaning
in some shells and would need escaping (although I suppose we don't
really expect users to by typing these directory names in themselves).

> > I'm more concerned with specifiers containing '^', '@', '{', ':' - see
> > 'SPECIFYING REVISIONS' in git-rev-parse(1) for the full details of
> > what's acceptable.
>
> Mhh there are likely more problems... I just noted that $ldir/$rdir are
> used in a call to system() so... that needs to be shell escaped to
> prevent any bad stuff

Are there really non-list calls to system?  Providing the only calls
provide each of the arguments separately (instead of in a single string)
I think we're OK, but I'm also not a Perl expert.

> And if perl (me not a perl guy) interprets any such characters specially
> in strings, it must be handled either.
> 
> > At some point I think it may be better to fall back
> > to the SHA1 of the relevant commit.
> Think that would be quite a drawback...

It depends where that happens.  I suspect most people use relatively
simple ref specifiers which wouldn't get to this stage, but do you
really want to turn the following into a directory name?

    origin/master@{3 weeks ago}^{/Merge branch 'jk/}^2

I admit it's something of a contrived example but I hope it illustrates
my point that sometimes naming the directory after the ref specifier may
be less useful than just using "left" or the SHA1.


[1] http://support.microsoft.com/kb/177506


John
