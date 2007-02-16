From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-unbundle - unpack objects and references for disconnected transfer
Date: Thu, 15 Feb 2007 23:24:04 -0800
Message-ID: <7vk5yia7l7.fsf@assigned-by-dhcp.cox.net>
References: <11715851974102-git-send-email-mdl123@verizon.net>
	<11715851972838-git-send-email-mdl123@verizon.net>
	<11715851973802-git-send-email-mdl123@verizon.net>
	<7vire2c00i.fsf@assigned-by-dhcp.cox.net>
	<45D54DB0.4090300@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Fri Feb 16 08:24:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHxSN-0006cW-0g
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 08:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932988AbXBPHYI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 02:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932989AbXBPHYI
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 02:24:08 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:49245 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932988AbXBPHYG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 02:24:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070216072405.LTHM1300.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 16 Feb 2007 02:24:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q7Q41W00i1kojtg0000000; Fri, 16 Feb 2007 02:24:05 -0500
In-Reply-To: <45D54DB0.4090300@verizon.net> (Mark Levedahl's message of "Fri,
	16 Feb 2007 01:22:40 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39894>

Mark Levedahl <mdl123@verizon.net> writes:

> I'm not sure I follow the logic here. Assuming the object is a
> prerequisite of the bundle and exists, it will be reachable from an
> updated reference once the bundle is applied, no?

No.  That's not the point.  Yes, the object might be reachable,
but you haven't proven that everything necessary to complete
that object is already in the object store.  We never trust
existence of an object alone when doing an operation that
updates a ref.  Having unreferenced objects in the object store
is a norm, but refs pointing at an object, some of whose
prerequisites are missing, is a crime.

For example, suppose an earlier http-fetch found that the
updated master should be at commit 'x', downloaded 'x', and you
killed the process with ^C.  It died without updating
refs/remotes/origin/master, which is good.  Then you have a
bundle to unpack that has 'x' as a boundary.

You would start with a repository like this:

  ---o---o---o...-...-...-...x
             ^origin.

where 'x' is a dangling commit, '-' are ones that you do not
have but you ought to have them in order for 'x' to be complete,
and 'o' are complete commits.  If the bundle boundary falls on
the 'x' commit, you cannot say "I have all that are needed to
complete this 'x'".  You only have 'x' but still lack its
prerequisites.  That's what it means never to trust the mere
existence of an object.

Linus's suggestion would make rev-list barf when 'x' cannot
reach any existing ref, which is a good solution for this
problem.

Also as Shawn pointed out, the script too heavily depends on GNU
tar.  Can we do something about it?  Requiring GNU tar is
probably fine if the script absolutely needs its extended
features, as long as people have ways to tweak the command name
in the script to point at their installed GNU tar (remember,
some systems have GNU tar under different name such as "gtar").

Although if we require GNU tar we might be better off placing
this under contrib/ not at the toplevel.  I dunno.
