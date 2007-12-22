From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Problem with git-svn
Date: Fri, 21 Dec 2007 20:29:24 -0800
Message-ID: <20071222042924.GA18812@soma>
References: <4764FE2C.1010103@obry.net> <20071219082751.GA17787@muzzle> <47690031.7090409@obry.net> <20071220183007.GA26767@untitled> <476AD1AB.8040406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Pascal Obry <pascal.obry@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 05:29:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5vzj-0001X3-El
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 05:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbXLVE31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 23:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751631AbXLVE31
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 23:29:27 -0500
Received: from hand.yhbt.net ([66.150.188.102]:43518 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751167AbXLVE31 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 23:29:27 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 20B6C7DC122;
	Fri, 21 Dec 2007 20:29:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <476AD1AB.8040406@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69118>

Pascal Obry <pascal.obry@gmail.com> wrote:
> Eric,
> 
> > Ah, oops, I was off-by-one with the revision number.  But git-svn does
> > look to be doing the right thing here, because it followed history into
> > /importfromcvs/trunk/ and file.el was part of it.
> 
> Yes part of it but before the creation of the /importfromcvs/trunk/ that
> was moved later as /trunk/PROJ.
> 
> < I meant moved as /trunk/PROJ1 then /trunk/PROJ2... and so on.
>
> In /importfromcvs/trunk/ there was many projects imported. One per one,
> each time moving it into /trunk/PROJ.
> 
> If I look at history of /trunk/PROJ:
> 
>    $ svn log svn+ssh://myserver/trunk/PROJ
> 
> The last revision is 45775, so I think git-svn should not look past this
> revision. So I'm very surprised by the current behavior and think it is
> a bug to import file.el at revision 9458. Note that the workaround for
> me is to use:

Since r48468 was where /importfromcvs/trunk got renamed into /trunk/PROJ
(from your previous message http://mid.gmane.org/4764FE2C.1010103@obry.net)

/importfromcvs/trunk exists at r45775, but /trunk/PROJ does not; and
git-svn at least follows that (which is what I suppose everybody wants).

However...

Did /importfromcvs/trunk exist all the way between r9458 and r48468?  Or
was that directory replaced entirely by something else along the way?

git-svn may be following copy history too aggressively, in this case.

On the other hand, this was somewhat intended because it could also
be a way to track merges as "moving" tags[1].

>    $ git svn clone svn+ssh://myserver/trunk/PROJ --revision=45775:HEAD
> 
> But it would be lot cleaner to have git-svn handling this properly I think.

Does --no-follow-parent work in your case?  Or does it go too far
in stopping at r48468 (probably).

[1] - I follow a project that has a RELEASE branch that is occasionally
deleted and replaced with the contents of trunk.   git-svn will actually
import this as a merge commit with two parents:

  1. trunk (obviously)
  2. the previous RELEASE, which was deleted

This allows old (but deleted) history to still be visible, which is what
*I* always want.  However, it could cause undesired behavior in your
case...

Note that running 'svn log <URL of #2 case>' will NOT show what git-svn
log will show for two; and I think it's nice that git-svn will track
history that is harder to find with SVN

(which would require svn log -v <URL of #2 case>@<rev>).

Maybe another switch should be added (--merge-foster-parent?)

-- 
Eric Wong
