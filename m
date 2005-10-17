From: Junio C Hamano <junkio@cox.net>
Subject: Re: [kernel.org users] Re: auto-packing on kernel.org? please?
Date: Mon, 17 Oct 2005 13:08:03 -0700
Message-ID: <7v3bmzzz30.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510131422161.23590@g5.osdl.org>
	<435264B1.2010204@de.bosch.com>
	<Pine.LNX.4.63.0510161122570.23242@iabervon.org>
	<20051016161244.GE5509@reactrix.com> <43527E86.8000907@didntduck.org>
	<7vzmp9xuwe.fsf@assigned-by-dhcp.cox.net>
	<20051016213341.GF5509@reactrix.com>
	<7vwtkd6rik.fsf@assigned-by-dhcp.cox.net>
	<20051017060659.GH5509@reactrix.com>
	<7voe5o366d.fsf@assigned-by-dhcp.cox.net>
	<20051017174123.GI5509@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 17 22:09:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERbHo-0004I3-Qr
	for gcvg-git@gmane.org; Mon, 17 Oct 2005 22:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbVJQUIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 16:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVJQUIF
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 16:08:05 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:42135 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751135AbVJQUIE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 16:08:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051017200749.GWUI9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 17 Oct 2005 16:07:49 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051017174123.GI5509@reactrix.com> (Nick Hengeveld's message of
	"Mon, 17 Oct 2005 10:41:23 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10191>

Nick Hengeveld <nickh@reactrix.com> writes:

> Gotcha - I'm still thinking in terms of content distribution, where
> you only need a specific version of a tree to be available locally
> and explicitly don't want to transfer history.

In other words, you'd want to also support CVS-like "working
tree has the specific version, and history is not kept here, but
available on demand, possibly over the network" mode of
operation.  I'd say why not.  We could aim to have "working tree
has the specific version and partial history of recent versions,
and the ancient history is available on demand, possibly over
the network" mode of operation.

It is somewhat different from the primary focus of what we have
been doing, but I think it is a natural extension.  The
invariant is that once you have a ref pointing at a specific
commit, everything reachable from it ought to be available to
you.

And we have extended the definition of "available" over time.
Initially, you needed to have individual objects, and then we
made it so they could live in packs, and now they could even be
borrowed from another repository via alternates.  We currently
do not consider "lazily fetchable over the network" as
"available", but I do not object too much to that, as long as it
is an optional feature.

This probably is a post 1.0 item, though.  Off the top of my
head, we would need:

 - a way for the user to say "unless I ask explicitly otherwise,
   do not bother me if the commits older than these ones are
   incomplete" -- an milder version of cauterizing commit chain
   via info/grafts.

 - a way for the user to say "this time I am explicitly
   overriding the above -- I am interested in older history".

 - change to fsck-objects, fetch- and probably upload-pack on
   the other end, and commit walkers to honor the above two.

Most of these can probably be done by existing info/grafts
mechanism, but even then definitely would need a nicer user
interface.

Once this is in place, range requests to pick data for
individual objects from packs residing on a remote HTTP server
would start to make sense.
