From: Junio C Hamano <junkio@cox.net>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 02:00:13 -0700
Message-ID: <7vac8lidwi.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	<46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
	<46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
	<Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
	<9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com>
	<Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
	<9e4733910606091921o1d07826w8292dc22b1872345@mail.gmail.com>
	<87y7w5lowc.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0606092001590.5498@g5.osdl.org>
	<e6dvds$oes$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 10 11:00:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FozKN-0007X5-48
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 11:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWFJJAQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 05:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWFJJAQ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 05:00:16 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:43180 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751421AbWFJJAO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 05:00:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060610090014.XGZI6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Jun 2006 05:00:14 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e6dvds$oes$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	10 Jun 2006 10:21:27 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21603>

Jakub Narebski <jnareb@gmail.com> writes:

> Couldn't it be solved by enhancing initial handshake to send from puller
> (object receivier) to pullee (object sender) the contents of graft file, or
> better the contents of cauterizing graft file - without splitting graft
> file we better have an option to send graft file or not, when graft file is
> used to join historical repository line of development not to cauterize
> history.
>
> Then the sender would use sent cauterizing history graft file for
> calculating which objects to sedn _only_, "in memory" cauterizing it's own
> history.
>
> Now I guess you would tell me why this very simple idea is stupid...

It is not stupid at all; what you said is actually on a correct
track.  You indeed just reinvented a half of what I've outlined
earlier for implementing shallow clone (the other half you
missed is that the graft exchange needs to happen both ways,
limiting the commit ancestry graph the both ends walk to the
intersection of the fake view of the ancestry graph both ends
have, but that is a minor detail).

The problem is that what Linus described as "fundamentally hard"
is not the initial "shallow clone" stage, but lies elsewhere.
Namely, what to do after you create such a shallow clone and
when you want to unplug an earlier cauterization points.

In order to unplug a cauterization point (a commit we faked to
be parentless earlier, whose parents and associated objects we
ought to have but we do not because we made a shallow clone),
the downloader needs to re-fetch that commit while temporarily
pretending that it does not have any objects that are newer,
perhaps defining another earlier point as a new cauterization
point at the same time.  Git format allows for that, and the
protocol exchange certainly can be extensible to support
something like that, but the design work would be quite
involved.
