From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Wed, 15 Oct 2014 01:15:09 +0300
Message-ID: <20141014221509.GA10580@wheezy.local>
References: <1413090791-14428-1-git-send-email-max@max630.net>
 <CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com>
 <543D58D9.5060606@web.de>
 <xmqqoatezhnx.fsf@gitster.dls.corp.google.com>
 <20141014183431.GA8157@wheezy.local>
 <543D7EBA.4040206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 15 00:16:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeAO9-0003ya-St
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 00:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532AbaJNWQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 18:16:14 -0400
Received: from p3plsmtpa08-02.prod.phx3.secureserver.net ([173.201.193.103]:59844
	"EHLO p3plsmtpa08-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754621AbaJNWQN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Oct 2014 18:16:13 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa08-02.prod.phx3.secureserver.net with 
	id 3AG31p00K5B68XE01AGAPG; Tue, 14 Oct 2014 15:16:12 -0700
Content-Disposition: inline
In-Reply-To: <543D7EBA.4040206@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 14, 2014 at 09:51:22PM +0200, Jens Lehmann wrote:
> Am 14.10.2014 um 20:34 schrieb Max Kirillov:
>> But here are a lot of nuances. For example, it makes
>> sense to have a superproject checkout without submodules
>> being initialized (so that they don't waste space and
>> machine time for working tree, which often is more than
>> repository data).
> 
> Hmm, I'm not sure if this is a problem. If the
> GIT_COMMON_DIR does have the submodule repo but it isn't
> initialized locally, we shouldn't have a problem (except
> for wasting some disk space if not a single checkout-to
> superproject initializes this submodule).

If initially a repository is clone without submodules, it
will not have anything in the GIT_COMMON_DIR.

> And if GIT_COMMON_DIR does not have the submodule repo
> yet, wouldn't it be cloned the moment we init the
> submodule in the checkout-to? Or would that need extra
> functionality?

I cannot say I like this. Network operations should be
caused only by clone and submodules.

I think the logic can be simple: it a submodule is not
checked-out in the repository "checkout --to" is called
from, then it is not checked-out to the new one also. If it
is, then checkout calls itself recursively in the submodule
and works like being run in standalone repository.

>> Then, a checkout copy of a submodule can be standalone
>> (for example, git and git-html-docs are submodules of
>> msysgit). Or, it can even belong to some other
>> superproject. And in that cases they still should be able
>> to be linked.
> 
> Maybe such configurations would have to be handled
> manually to achieve maximum savings. At least I could live
> with that.

To make manual handling of the cases, and to skip
checking-out a module.

I would think about the following interface:

$ git checkout --to ... - does not checkout submodules,
creates empty directory.

$ git checkout --recursive --to ... - if a submodule is
checked-out in source repository, recursed there and run
"checkout --recursive" again. If a submodule is not
checked-out, does not checkout it, creates an empty
directory.

By the way, I have found your branch
recursive_submodule_checkout. Would you like to revive it?
Then it can be done with the same option.

> Hmm, so I tend towards adding GIT_COMMON_DIR to
> local_repo_env until we figured out how to handle this.
> Without that I fear bad things will happen, at least for a
> superproject with multiple checkout-to work trees where
> the same submodule is initialized more than once ...

I learned about local_repo_env and agree it should include
GIT_COMMON_DIR. Unless it is removed at all...
