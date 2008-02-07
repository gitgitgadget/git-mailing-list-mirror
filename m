From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: what does @NNN in git-svn branch names mean?
Date: Thu, 7 Feb 2008 09:16:07 +0100
Message-ID: <20080207081607.GA18999@diana.vm.bytemark.co.uk>
References: <20080206162905.GA29432@diana.vm.bytemark.co.uk> <20080206191830.GA9654@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Peter Harris <git@peter.is-a-geek.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 09:17:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JN1wK-0003YN-LJ
	for gcvg-git-2@gmane.org; Thu, 07 Feb 2008 09:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653AbYBGIQ1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Feb 2008 03:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbYBGIQ1
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 03:16:27 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2646 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbYBGIQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 03:16:26 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JN1vT-000560-00; Thu, 07 Feb 2008 08:16:07 +0000
Content-Disposition: inline
In-Reply-To: <20080206191830.GA9654@hand.yhbt.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72907>

On 2008-02-06 11:18:30 -0800, Eric Wong wrote:

> The follow parent feature uses it, with the foo@NNN version being
> the parent branch.
>
> For example, if I'm tracking http://example.com/project/trunk, but
> it was created from http://example.com/old-project at revision 76
> (before they used the trunk/branches/tags convention), then the
> contents of http://example.com/old-project would show up as the ref
> trunk@75, and the trunk ref would start as r76 with the ref trunk@75
> as its parent.

I thought I understood (especially with Peter's answer), so I tried to
make a script that would create one of those @ branches:

    svnrepo=3Dfile://$(pwd)/svnrepo
    rm -rf svnrepo wd gs
    svnadmin create svnrepo
    svn mkdir -m c1 $svnrepo/trunk
    svn mkdir -m c2 $svnrepo/branches
    svn mkdir -m c3 $svnrepo/tags

    svn co $svnrepo/trunk wd
    (
        cd wd
        echo foo > foo.txt
        svn add foo.txt
        svn ci -m c4
    )

    svn cp -m c5 $svnrepo/trunk $svnrepo/branches/br

    (
        cd wd
        svn switch $svnrepo/branches/br
        echo foo >> foo.txt
        svn ci -m c6
        svn switch $svnrepo/trunk
        echo foobar >> foo.txt
        svn ci -m c7
    )

    svn rm -m c8 $svnrepo/branches/br
    svn cp -m c9 $svnrepo/trunk $svnrepo/branches/br

    git svn clone --stdlayout --prefix=3Dsvn/ $svnrepo gs
    (
        cd gs
        gitk --all
    )

However, this does not result in a br@N branch; instead, the
remove-and-copy is imported as a merge from trunk to br. I'm not
saying this is not correct, but it does seem that I still don't
understand under what circumstances the @N branches are created.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
