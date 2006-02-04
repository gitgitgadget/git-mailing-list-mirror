From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Tracking and committing back to Subversion?
Date: Fri, 3 Feb 2006 21:40:57 -0800
Message-ID: <20060204054056.GB24314@Muzzle>
References: <1138834301.21899.40.camel@wilber.wgtn.cat-it.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 04 06:41:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5GAT-0005Tm-8o
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 06:41:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946310AbWBDFk7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 00:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946311AbWBDFk7
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 00:40:59 -0500
Received: from hand.yhbt.net ([66.150.188.102]:37346 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S1946310AbWBDFk7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 00:40:59 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by mail.yhbt.net (Postfix) with SMTP id 8BF9B2DC033;
	Fri,  3 Feb 2006 21:40:57 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Fri,  3 Feb 2006 21:40:57 -0800
To: Sam Vilain <sam@vilain.net>
Content-Disposition: inline
In-Reply-To: <1138834301.21899.40.camel@wilber.wgtn.cat-it.co.nz>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15570>

Sam Vilain <sam@vilain.net> wrote:
> Hi all,
> 
> Has anyone done any work on bidirectional access to SVN repositories?
> ie, tracking and committing.

AFAIK, Not yet.  But it's something that's been on the back of my mind
for a while.  I've attempted similar things with Arch <-> SVN in the
past but didn't get anything extremely robust going from Arch -> SVN
although I'm pretty satisfied with my SVN -> Arch product
(svn-arch-mirror).

> That would be porcelain that behaves like SVK (http://svk.elixus.org)
> 
> Ideally it would probably need to link against the Subversion RA (remote
> access) library, neon.

I prefer to use git-svnimport for pulling from svn since it's pretty
good at what it does.  That already depends on SVN::Core and SVN::Ra.
SVK is really nice tool, just a bit slow after I've been using git for a
while.

> I can see forsee two potential issues;
> 
>   1. file properties - such as mime type, ignores and custom properties.
>      Linus, when I asked you about this in Dunedin, you mentioned that
>      there is a place at the end of the directory entry where this could
>      fit without breaking backwards compatibility.  Perhaps this could
>      be an optional pointer to another directory node;

Mostly ignore-able, imho.  svn:executable is the one that makes the most
sense (and is easiest) to support.

svn:ignore <-> .gitignore mapping are pretty close (identical, save for
recursive properties that svn gets very wrong.  I don't think svn:ignore
is affected by line order, whereas .gitignore is a plain file and line
order does matter.

svn:external is almost definitely better off ignored entirely when
interfacing with other RCSes

svn:keywords: I don't think there's a way to disable this like there
is with CVS, is there?  keywords are evil imho.

I don't use or know much about the other properties...

>   2. "forensic" file movement history - as opposed to the uncached,
>      (and unversioned), automatic "analytical" file movement history.
> 
>      It would be easy for a tool to provide 100% interface compatibility
>      with SVN client/SVK using properties, but properties that hang off
>      the head rather than the file itself (so that they don't stuff up
>      the ability to merge identical trees reached via independent
>      paths).  SVN calls these "revision properties".  If a good
>      convention is adopted for this, it could be used as a nice way to
>      supplement git's automatic analysis of the revision history.

Just parsing the output of diff-tree -C and marking them in SVN as
copies/renames should be sufficient for letting SVN do its thing.

Doing this kind of file movement history on the git side sounds like
overkill to me.  I was a _huge_ fan of logical file-identities in GNU
Arch in the past, but the complexity destroyed it from both a UI and
performance perspective.

-- 
Eric Wong
