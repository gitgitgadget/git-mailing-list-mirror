From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Mon, 20 Oct 2014 07:11:09 +0300
Message-ID: <20141020041109.GA5784@wheezy.local>
References: <1413090791-14428-1-git-send-email-max@max630.net>
 <CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com>
 <543D58D9.5060606@web.de>
 <xmqqoatezhnx.fsf@gitster.dls.corp.google.com>
 <20141014183431.GA8157@wheezy.local>
 <543D7EBA.4040206@web.de>
 <20141014221509.GA10580@wheezy.local>
 <543EC390.4000709@web.de>
 <20141016205453.GA8441@wheezy.local>
 <54441147.5080204@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Oct 20 06:12:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xg4Kg-0002ZL-NP
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 06:12:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbaJTEMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 00:12:19 -0400
Received: from p3plsmtpa12-09.prod.phx3.secureserver.net ([68.178.252.238]:50169
	"EHLO p3plsmtpa12-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750798AbaJTEMR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2014 00:12:17 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa12-09.prod.phx3.secureserver.net with 
	id 5GC31p00K5B68XE01GC89D; Sun, 19 Oct 2014 21:12:14 -0700
Content-Disposition: inline
In-Reply-To: <54441147.5080204@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 19, 2014 at 09:30:15PM +0200, Jens Lehmann wrote:
> Am 16.10.2014 um 22:54 schrieb Max Kirillov:
>> On Wed, Oct 15, 2014 at 08:57:20PM +0200, Jens Lehmann wrote:
>>> Am 15.10.2014 um 00:15 schrieb Max Kirillov:
>>>> I think the logic can be simple: it a submodule is not
>>>> checked-out in the repository "checkout --to" is called
>>>> from, then it is not checked-out to the new one also. If it
>>>> is, then checkout calls itself recursively in the submodule
>>>> and works like being run in standalone repository.

>>> But when I later decide to populate the submodule in a
>>> "checkout --to" work tree, should it automagically also
>>> use the central storage, creating the modules/<name>
>>> directory there if it doesn't exist yet? I think that'd
>>> make sense to avoid having the work tree layout depend
>>> on the order commands were ran in. And imagine new
>>> submodules, they should not be handled differently from
>>> those already present.

>> Like place the common directory to
>> $MAIN_REPO/.git/modules/$SUB/ and worktree-specific part to
>> $MAIN_REPO/.git/worktrees/$WORKTREE/modules/$SUB, rather
>> than placing all into the socond one? It would make sense to
>> make, but then it would be imposible to checkout a diferent
>> repository into the same submodule in different superproject
>> checkouts. However stupid is sounds, there could be cases
>> if, for example, at some moment submodule is being replaced
>> by another one, and older worktrees should work with older
>> submodule, while newer uses the newer submodule.

> Yes, but I believe that the user must be careful to not
> reuse the same submodule name for a different repo anyways,
> no matter if shared or not. Currently you'll get a warning
> about that when trying to add a submodule whose name is
> already found in .git/modules to avoid such confusion.

Yes, while trying to write tests for this case I discovered
that there are warnings and the recommended way is to use
different names for different repositories even if they are
pointing to the same path. Then always placing common
directory into the .git/modules/<module> could be a good
idea, and in very special cases users could manually create
repositories with custom placement.

>> Also, could you clarify the usage of the /modules/
>> directory. I did not notice it to affect anything after the
>> submofule is placed there. Submodule operations use the
>> submodule repositories directly (through the git link, which
>> can point anywhere), or in .gitmodules file, or maybe in
>> .git/config. So there is actually no need to have that
>> gitdir there. Is it correct?

> Nope. When submodules are cloned their git directory is
> placed under .git/modules/<submodule name>, the .git file
> in the work tree points there and the core.worktree setting
> points back from there to the work tree.

I meant is the fact that gitdir is placed in modules, rather
than in any other place, is used anywhere. There are 2
places to put the gitdir of submodule in linked copy:
1. $MAIN_REPO/.git/worktrees/$WORKTREE/modules/$SUB
2. $MAIN_REPO/.git/modules/$SUB/worktrees/$SUB_WTNAME
First one is suggested by submodule way of placing gitdirs,
and the second one by worrktree way. There are reasons to
have the second one - garbage collection and check that 2
branch is not checked out twice. Are there resons to have
the 1st one? The one is to prevent use of different
repositories with the same name, anything else?

-- 
Max
