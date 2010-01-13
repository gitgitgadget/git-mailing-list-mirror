From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Bug? git-svn clone dies with "fatal: ambiguous argument '...':
	unknown revision or path not in the working tree."
Date: Tue, 12 Jan 2010 21:29:58 -0800
Message-ID: <20100113052958.GA23182@dcvr.yhbt.net>
References: <36366a981001121558v5324f2fbucf096e4c82402912@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Andrew Myrick <amyrick@apple.com>
To: Eric Hanchrow <eric.hanchrow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 06:30:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUvo0-0003Ln-7k
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 06:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500Ab0AMFaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 00:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402Ab0AMF37
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 00:29:59 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:54085 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296Ab0AMF37 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 00:29:59 -0500
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3C4E1F50B;
	Wed, 13 Jan 2010 05:29:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <36366a981001121558v5324f2fbucf096e4c82402912@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136769>

Eric Hanchrow <eric.hanchrow@gmail.com> wrote:
> I have been using git-svn happily for many months, updating git from
> git://git.kernel.org/pub/scm/git/git.git every once in a while.  I
> just updated to c0eb604330e1288300d915f25868d1eed88d3038, and tried to
> clone the same svn repo that I've been using for a long time:
> 
> $ git svn clone http://svn/repos/cozi/kits --stdlayout
> 
> It chugged along happily for a while, but then died like this:
> 
> fatal: ambiguous argument
> '2d2df13977551168a54ffa9b706484242a58736a^..d038748d49a0de5802fe3c13f46d0e080d064290':

Hi Eric,

I suspect you're hitting a bug with the newly-added mergeinfo support.

As we see below, d038748d49a0de5802fe3c13f46d0e080d064290 is a merge
commit.  So I'll Cc Sam and Andrew on this since they know their way
around the mergeinfo stuff far better than I do and will hopefully have
some insight into things.

Since it's probably related to the new mergeinfo handling, reverting to
a version without it (1.6.5.7) might be the best way to go for now.

Thanks for the report!

> unknown revision or path not in the working tree.
> Use '--' to separate paths from revisions
> rev-list 2d2df13977551168a54ffa9b706484242a58736a^..d038748d49a0de5802fe3c13f46d0e080d064290:
> command returned error: 128
> 
> "git show 2d2df13977551168a54ffa9b706484242a58736a" shows that the
> commit in question corresponds to a commit in svn that created an
> empty directory:
> 
> 15:56:46 [COZIGROUP\erich@ubuntu64-erich kits] (master)$  git show -w
> 2d2df13977551168a54ffa9b706484242a58736a
> commit 2d2df13977551168a54ffa9b706484242a58736a
> Author: cozigroup\erich <cozigroup\erich@1248e456-dc32-5a46-b6cc-76877e1dc968>
> Date:   Wed Jan 14 18:35:00 2009 +0000
> 
>     This branch will hold work I've done to refactor the vcs backend
> stuff, and add support for Mercurial.
> 
> 
>     git-svn-id: http://svn/repos/cozi/kits/branches/vcs-refactor@18735
> 1248e456-dc32-5a46-b6cc-76877e1dc968
> 
> 
> 15:41:01 [COZIGROUP\erich@ubuntu64-erich hmm]$ svn log --limit=1
> -vr18735 http://svn/repos/cozi
> ------------------------------------------------------------------------
> r18735 | cozigroup\erich | 2009-01-14 10:35:00 -0800 (Wed, 14 Jan
> 2009) | 2 lines
> Changed paths:
>    A /kits/branches/vcs-refactor
> 
> This branch will hold work I've done to refactor the vcs backend
> stuff, and add support for Mercurial.
> 
> If I recall correctly, that commit was a mistake: I'd forgotten that
> the proper way to create a branch in svn is to copy the trunk, and not
> to create an empty directory first.
> 
> Here I am creating that branch the proper way:
> 
> r18736 | cozigroup\erich | 2009-01-14 10:35:30 -0800 (Wed, 14 Jan
> 2009) | 2 lines
> Changed paths:
>    D /kits/branches/vcs-refactor
> 
> D'oh.  We branch by _copying_, not making empty directories :-|
> 
> ------------------------------------------------------------------------
> r18737 | cozigroup\erich | 2009-01-14 10:36:37 -0800 (Wed, 14 Jan
> 2009) | 2 lines
> Changed paths:
>    A /kits/branches/vcs-refactor (from /kits/trunk:18671)
> 
> Refactoring the version-control stuff, and adding Mercurial support.
> 
> ------------------------------------------------------------------------
> 
> 15:56:51 [COZIGROUP\erich@ubuntu64-erich kits] (master)$ git show -w
> d038748d49a0de5802fe3c13f46d0e080d064290
> commit d038748d49a0de5802fe3c13f46d0e080d064290
> Merge: 5108824 a370f0b
> Author: cozigroup\erich <cozigroup\erich@1248e456-dc32-5a46-b6cc-76877e1dc968>
> Date:   Tue Jan 20 18:34:26 2009 +0000
> 
>     Merged from trunk.
> 
> 
>     git-svn-id: http://svn/repos/cozi/kits/branches/vcs-refactor@18920
> 1248e456-dc32-5a46-b6cc-76877e1dc968
> 
> And here is (what might be) the first attempt to modify stuff in that directory:
> 
> 15:52:52 [COZIGROUP\erich@ubuntu64-erich kits] (master)$ svn log
> --limit=1 -vr18920 http://svn/repos/cozi
> ------------------------------------------------------------------------
> r18920 | cozigroup\erich | 2009-01-20 10:34:26 -0800 (Tue, 20 Jan
> 2009) | 2 lines
> Changed paths:
>    M /kits/branches/vcs-refactor
>    A /kits/branches/vcs-refactor/lib/CoziPlatform/cozi/resources.py
> (from /kits/trunk/lib/CoziPlatform/cozi/resources.py:18919)
>    M /kits/branches/vcs-refactor/lib/CoziSecurity/cozi/authorize.py
>    M /kits/branches/vcs-refactor/lib/CoziSecurity/cozi/eguidtests.py
>    M /kits/branches/vcs-refactor/lib/CoziVaultRESTServices/cozi/screen_saver_api.py
>    M /kits/branches/vcs-refactor/lib/CoziVaultRESTServices/cozi/screen_saver_calendar_xml.tmpl
>    M /kits/branches/vcs-refactor/lib/CoziVaultRESTServices/cozi/web_client.py
> 
> Merged from trunk.
> 
> 
> Anyway -- I suspect that my svn repos layout is ... er ... unusual,
> and has hit some sorta edge case in git-svn.  Is there some workaround
> I can use, or is this a bug?
>
> Thanks
> --
