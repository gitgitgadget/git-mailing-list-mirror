From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] sanity check in add_packed_git()
Date: Wed, 21 Dec 2005 17:42:08 -0800
Message-ID: <7v7j9xvrf3.fsf@assigned-by-dhcp.cox.net>
References: <1135208829.15567.18.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Dec 22 02:42:36 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpFTW-0003K2-91
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 02:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbVLVBmL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 20:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbVLVBmL
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 20:42:11 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:1247 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965006AbVLVBmK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 20:42:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051222014118.LHXT20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 20:41:18 -0500
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1135208829.15567.18.camel@dv> (Pavel Roskin's message of "Wed,
	21 Dec 2005 18:47:09 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13928>

Pavel Roskin <proski@gnu.org> writes:

> add_packed_git() tries to get the pack SHA1 by parsing its name.  It may
> access uninitialized memory for packs with short names.

Thanks.

This fixes when there is ".git/objects/packs/junk-X.pack", so in
that sense it is a real fix and I'll take it.

However, I feel a bit uneasy about this whole thing.  The core
does not care how you name your packs, as long as .pack and .idx
files have the same prefix, but we started relying on the prefix
being "pack-" followed by 40 hexadecimal digits since we started
packed repository support in http-fetch, and we also allowed
sha1_pack_name() function that shares the assumption to sneak
into the real core part of the system around the same time (end
of July 2005).  git-repack and git-verify-pack stay ignorant
about this prefix convention and I think that is a good
property.  However, we might be better off if we declare that
the pack files *must* be named following that convention
(currently nobody enforces it, but as long as the user uses "git
repack" to create packs, the packs automatically follow that
convention), and make check_packed_git_idx() reject a packfile
whose name does not begin with "pack-" or the 40 hexdigits that
follow does not match the hash of the object names the index
records.  If we go that route, then this patch becomes unneeded;
more extensive check needs to be done in check_packed_git_idx().

Thoughts?
