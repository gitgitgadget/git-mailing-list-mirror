From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Sun, 19 Oct 2014 21:30:15 +0200
Message-ID: <54441147.5080204@web.de>
References: <1413090791-14428-1-git-send-email-max@max630.net> <CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com> <543D58D9.5060606@web.de> <xmqqoatezhnx.fsf@gitster.dls.corp.google.com> <20141014183431.GA8157@wheezy.local> <543D7EBA.4040206@web.de> <20141014221509.GA10580@wheezy.local> <543EC390.4000709@web.de> <20141016205453.GA8441@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sun Oct 19 21:30:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XfwBP-0004ak-F5
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 21:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbaJSTaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2014 15:30:24 -0400
Received: from mout.web.de ([212.227.17.11]:53601 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210AbaJSTaX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2014 15:30:23 -0400
Received: from [192.168.178.41] ([79.193.78.112]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M6V1T-1Y59yF00Bn-00yPY0; Sun, 19 Oct 2014 21:30:16
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141016205453.GA8441@wheezy.local>
X-Provags-ID: V03:K0:cun0ulWsm2gX/pLKKkMgV5iG+KNYdZpQbSOsBqASt7pPOukcxfM
 YS06WPR0ng3iUiPq5XiecWbtjTd5VXeMk8GptqvezdODLIDrsHKddOP8M7hAdH+pW5ncM3p
 HKji6yc0qHSCdNe/2dBIkeuGHjHiiPhUNCZKZy0k1vBQPFYlv9cTnZ6v10XOpk9Ccw1y3Ke
 EgeXQdEIwNczRmCVEv+Xw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 16.10.2014 um 22:54 schrieb Max Kirillov:
> On Wed, Oct 15, 2014 at 08:57:20PM +0200, Jens Lehmann wrote:
>> Am 15.10.2014 um 00:15 schrieb Max Kirillov:
>>> I think the logic can be simple: it a submodule is not
>>> checked-out in the repository "checkout --to" is called
>>> from, then it is not checked-out to the new one also. If it
>>> is, then checkout calls itself recursively in the submodule
>>> and works like being run in standalone repository.
>>
>> But when I later decide to populate the submodule in a
>> "checkout --to" work tree, should it automagically also
>> use the central storage, creating the modules/<name>
>> directory there if it doesn't exist yet? I think that'd
>> make sense to avoid having the work tree layout depend
>> on the order commands were ran in. And imagine new
>> submodules, they should not be handled differently from
>> those already present.
>
> Like place the common directory to
> $MAIN_REPO/.git/modules/$SUB/ and worktree-specific part to
> $MAIN_REPO/.git/worktrees/$WORKTREE/modules/$SUB, rather
> than placing all into the socond one? It would make sense to
> make, but then it would be imposible to checkout a diferent
> repository into the same submodule in different superproject
> checkouts. However stupid is sounds, there could be cases
> if, for example, at some moment submodule is being replaced
> by another one, and older worktrees should work with older
> submodule, while newer uses the newer submodule.

Yes, but I believe that the user must be careful to not
reuse the same submodule name for a different repo anyways,
no matter if shared or not. Currently you'll get a warning
about that when trying to add a submodule whose name is
already found in .git/modules to avoid such confusion.

> Maybe, there could be some options to tell the command which
> populates submodules (which commands that are? "submodule update"
> and other submodule subcommands? or there is something
> else?) to use the curent checkout space or the main one. But
> I would still leave it depend on what user explicitly calls
> and where the initial submodule update is executed.

Currently only "submodule update" populates submodules, but
I'm currently working hard on teaching commands like checkout
(and lots of others) to do the same. I agree that the user
should be able to choose and for our CI server I would also
like to see a solution that could share submodules across
different superprojects. So having another environment
variable to decide where to put the work tree independent
parts of the .git/modules directory might make sense here.

> Also, could you clarify the usage of the /modules/
> directory. I did not notice it to affect anything after the
> submofule is placed there. Submodule operations use the
> submodule repositories directly (through the git link, which
> can point anywhere), or in .gitmodules file, or maybe in
> .git/config. So there is actually no need to have that
> gitdir there. Is it correct?

Nope. When submodules are cloned their git directory is
placed under .git/modules/<submodule name>, the .git file
in the work tree points there and the core.worktree setting
points back from there to the work tree.
