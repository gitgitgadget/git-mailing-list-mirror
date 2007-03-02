From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] add commit --interactive
Date: Fri, 02 Mar 2007 13:47:17 +0100
Message-ID: <87hct3zuay.fsf@morpheus.local>
References: <es6bgl$t3f$1@sea.gmane.org> <7v649ki3h1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 13:53:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN7GI-00065T-4U
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 13:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945910AbXCBMxU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 2 Mar 2007 07:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945912AbXCBMxU
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 07:53:20 -0500
Received: from main.gmane.org ([80.91.229.2]:44402 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945910AbXCBMxT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 07:53:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HN7EE-00079P-BK
	for git@vger.kernel.org; Fri, 02 Mar 2007 13:51:19 +0100
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 13:51:18 +0100
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 13:51:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:zrecgHcamSUq0uzFv7QLMuwl0UA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41203>

Junio C Hamano <junkio@cox.net> writes:

> Probably the operation would go like this.  I'll describe them
> in terms of lower level operations, and leave the scripting to
> others.
>
> * Stashing the current state

[...]

> * Switch to the commit you want to apply part of what was

[...]

> * Trickle some of the stashed changes in, perhaps interactively:

[...]

> * Review and test the change in the working tree.  This does not

[...]

> * Then this is the tricky and interesting part.  We need to
>   subtract the change we already used to advance HEAD from
>   "stashed changes".  I do not think we currently have a single
>   command to do this step, but it would probably go like this.

What I would want to do here is to simply restore the original "stash"
tree, so something like "git checkout stash -- ." would probably work.

The reason is that what I would consider a common scenario is that I
realize that some of the changes I made should be commited first, and
I extract them the way you describe, and maybe update them to erase
traces of things I don't want to commit, perhaps on the same source
lines.

But then I want to continue where I was, and reintroduce the things I
cleaned away in the previous step.

This is also much simpler to do.  So let's make two scripts
"git-stash" and "git-unstash"

    # git-stash:
    git-commit -m "temporary stash"
    git-tag stash
    git-reset --hard HEAD^

    # git-unstash:
    git-checkout stash -- .
    # or possibly:
    #current=3D$(git-rev-parse HEAD)
    #git-checkout stash
    #git-reset --mixed $current
    git-tag -d stash

Then I would do this:

  [ ... hack hack ... ]
  $ git stash
  $ git pick stash
  [ ... cleanup ... ]
  $ git commit -a -m "first change"
  $ git unstash

--=20
David K=C3=A5gedal
