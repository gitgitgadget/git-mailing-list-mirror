From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH] unpack-trees.c: assume submodules are clean during
 check-out
Date: Sun, 05 Aug 2007 15:55:29 +0200
Message-ID: <20070805135529.GA999MdfPADPa@greensroom.kotnet.org>
References: <20070717182828.GA4583MdfPADPa@greensroom.kotnet.org>
 <7vy7he6ufj.fsf@assigned-by-dhcp.cox.net>
 <20070801140532.GC31114MdfPADPa@greensroom.kotnet.org>
 <7v643vj316.fsf@assigned-by-dhcp.cox.net>
 <8c5c35580708040441ue1c3ef8qc022912a5af4883e@mail.gmail.com>
 <20070717182828.GA4583MdfPADPa@greensroom.kotnet.org>
 <7vy7he6ufj.fsf@assigned-by-dhcp.cox.net>
 <20070801140532.GC31114MdfPADPa@greensroom.kotnet.org>
 <7v643vj316.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Eran Tromer <git2eran@tromer.org>
To: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 15:55:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHgZy-0000ec-RX
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 15:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757013AbXHENzc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 09:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbXHENzc
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 09:55:32 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:41954 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbXHENzb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 09:55:31 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMB00BR400HJ3@psmtp08.wxs.nl> for git@vger.kernel.org; Sun,
 05 Aug 2007 15:55:30 +0200 (MEST)
Received: (qmail 9144 invoked by uid 500); Sun, 05 Aug 2007 13:55:29 +0000
In-reply-to: <8c5c35580708040441ue1c3ef8qc022912a5af4883e@mail.gmail.com>
 <7v643vj316.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55019>

On Fri, Aug 03, 2007 at 10:13:09PM -0700, Junio C Hamano wrote:
> Let me understand the problem first.  If your first checkout
> does not check out the submodule, switching between revisions
> that has different commit of the submodule there would not fail,
> but once you checkout the submodule, switching without updating
> the submodule would be Ok (because by design updating the
> submodule is optional) but then further switching out of that
> state will fail because submodule in the supermodule tree and
> checked-out submodule repository are now out of sync.  Is that
> the problem?

Yes.

> In any case, I doubt ce_compare_gitlink() is the right layer to
> work this around -- it is not about "can we switch" but is about
> "is it different".  It is at too low a level.

You are right.  I followed the logic down to ce_compare_gitlink,
but I should have backed up again.

> The current policy is to consider it is perfectly normal that
> checked-out submodule is out-of-sync wrt the supermodule index,
> if I am reading you right.  I think it is a good policy, at
> least until we introduce a superproject repository configuration
> option that says "in this repository, I do care about this
> submodule and at any time I move around in the superproject,
> recursively check out the submodule to match".  The most extreme
> case of this policy is that the superproject index knows about
> the submodule but the subdirectory does not even have to be
> checked out, which is what we have now.

Yes.  Alex Riesen convinced me that having the submodule checked
out is a good indication that you care about the submodule being
in sync (although you then apparently convinced him that this is
not a good idea).  You didn't take any patch that implements this
yet, so I'll probably try again after you release 1.5.3.

Since some people seem to like the current situation, I'd only do
the updating of checked-out submodules if some "autoUpdateSubmodules"
is set.

> How about doing something like this instead?

Works like a charm.

On Sat, Aug 04, 2007 at 01:41:06PM +0200, Lars Hjemli wrote:
> Btw: I've applied your patch to rc-4 and tested the result in my cgit
> repo: very nice, and very ack'd ;-)

If it matters, a definite

Acked-by: Sven Verdoolaege <skimo@kotnet.org>

too.

skimo
