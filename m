From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Check for local changes with "goto"
Date: Thu, 29 Jan 2009 04:45:12 +0100
Message-ID: <20090129034512.GD24344@diana.vm.bytemark.co.uk>
References: <20090128231305.16133.29214.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 04:46:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSNrW-0002bh-Pk
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 04:46:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbZA2DpS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jan 2009 22:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753600AbZA2DpR
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 22:45:17 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2143 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbZA2DpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 22:45:16 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LSNq4-0006VZ-00; Thu, 29 Jan 2009 03:45:12 +0000
Content-Disposition: inline
In-Reply-To: <20090128231305.16133.29214.stgit@localhost.localdomain>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107625>

On 2009-01-28 23:13:05 +0000, Catalin Marinas wrote:

> This is done by default, unless the --keep option is passed, for
> consistency with the "pop" command. The index is checked in the
> Transaction.run() function so that other commands could benefit from
> this feature (off by default).

This looks good, except for ...

> +        # Check for not clean index
> +        if check_clean and iw and not iw.index.is_clean():
> +            self.__halt('Repository not clean. Use "refresh" or '
> +                        '"status --reset"')

=2E.. this, which doesn't do what I think you think it does.

Index.is_clean() calls "git update-index --refresh", which checks for
changes in the worktree relative to the index. It's bad design to have
it in Index rather than IndexAndWorktree, but that's my fault, not
yours. ;-) But the point that breaks your patch is that it doesn't
check for changes between index and HEAD -- try it and see.

The fix I'd suggest is to move the existing is_clean() method to
IndexAndWorktree, and call it maybe worktree_clean(). And create a
method in Index() called is_clean(tree) that checks whether the index
is clean with respect to the given Tree (I think this method should
just call "git diff-index --quiet --cached <tree>".). Then call both
of these methods.

Sorry if I just keep creating more work for you. :-/

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
