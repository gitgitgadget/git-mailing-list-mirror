From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn fix for broken symlinks
Date: Wed, 19 Dec 2007 00:48:53 -0800
Message-ID: <20071219084853.GB17787@muzzle>
References: <a74c0d680712180811m216699a4h7123039c3158c2ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Sverre Johansen <sverre.johansen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 09:50:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4ucd-0007Wq-R7
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 09:49:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbXLSIs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 03:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbXLSIs4
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 03:48:56 -0500
Received: from hand.yhbt.net ([66.150.188.102]:39616 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051AbXLSIsz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 03:48:55 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 8159C7DC122;
	Wed, 19 Dec 2007 00:48:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <a74c0d680712180811m216699a4h7123039c3158c2ed@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68866>

Sverre Johansen <sverre.johansen@gmail.com> wrote:
> Hi,
> 
> There is a bug in older versions of SVN that makes it possible to create
> symlinks where the target is not the path to the file, but instead the
> content of the target file. The bug is described here [0].
> 
> This breaks git-svn because it expects files which is marked as symlinks
> to have the content "link: <filename>".
> 
> There was a thread about this back in July, resulting in this patch [1]. Is that
> patch planned to be merged anytime soon? I'm using it, and it works great
> for me.
> 
> [0]: http://subversion.tigris.org/issues/show_bug.cgi?id=2692
> [1]: http://kerneltrap.org/mailarchive/git/2007/7/19/252025

Sverre: Thanks for the reminder, I'm quite absent-minded :/

I've pushed out the patch to http://git.bogomips.org/git-svn.git
(or git://, if you prefer) along with two others

Junio: please pull, thanks.

commit 540424b263d626aa762757a31ca9b4becc7fb513
Author: Eric Wong <normalperson@yhbt.net>
Date:   Wed Dec 19 00:31:43 2007 -0800

    git-svn: avoid warning when run without arguments
    
    While we're in the area, finish writing a halfway-written
    comment describing what that block does...
    
    Signed-off-by: Eric Wong <normalperson@yhbt.net>

commit 7fc35e0e94782bbbefb920875813519038659930
Author: Eric Wong <normalperson@yhbt.net>
Date:   Wed Dec 19 00:06:45 2007 -0800

    git-svn: workaround a for broken symlinks in SVN
    
    It's possible for bad clients to commit symlinks without the
    5-character "link " prefix in symlinks.  So guard around this
    bug in SVN and make a best effort to create symlinks if the
    "link " prefix is missing.
    
    More information on this SVN bug is described here:
      http://subversion.tigris.org/issues/show_bug.cgi?id=2692
    
    To be pedantic, there is still a corner case that neither we nor
    SVN can handle:  If somebody made a link using a broken SVN
    client where "link " is the first part of its path, e.g.
    "link sausage", then we'd end up having a symlink which points
    to "sausage" because we incorrectly stripped the "link ".
    Hopefully this hasn't happened in practice, but if it has,
    it's not our fault SVN is broken :)
    
    Thanks to Benoit Sigoure and Sverre Johansen for reporting
    and feedback.
    
    Signed-off-by: Eric Wong <normalperson@yhbt.net>

commit ad94802a7bc599ade73ec0b04c61b2f80b3c1b23
Author: Eric Wong <normalperson@yhbt.net>
Date:   Sat Dec 15 19:08:22 2007 -0800

    git-svn: avoid leaving leftover committer/author info in rebase
    
    We set the 6 environment variables for controlling
    committer/author email/name/time for every commit.
    
    We do this in the parent process to be passed to
    git-commit-tree, because open3() doesn't afford us the control
    of doing it only in the child process.  This means we leave them
    hanging around in the main process until the next revision comes
    around and all 6 environment variables are overwridden again.
    
    Unfortunately, for the last commit, leaving them hanging around
    means the git-rebase invocation will pick it up, rewriting the
    rebased commit with incorrect author information.  This should fix
    it.
    
    Signed-off-by: Eric Wong <normalperson@yhbt.net>
---

-- 
Eric Wong
