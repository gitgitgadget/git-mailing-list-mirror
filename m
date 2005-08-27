From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix pulling into the same branch.
Date: Fri, 26 Aug 2005 20:31:50 -0700
Message-ID: <7vzmr43vix.fsf@assigned-by-dhcp.cox.net>
References: <B8E391BBE9FE384DAA4C5C003888BE6F043BA469@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	<git@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Aug 27 05:32:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8rQJ-0003aN-Ev
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 05:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030291AbVH0Db7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 23:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbVH0Db7
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 23:31:59 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:16577 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030291AbVH0Db7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 23:31:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050827033153.SKTC3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 23:31:53 -0400
To: "Luck, Tony" <tony.luck@intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F043BA469@scsmsx401.amr.corp.intel.com>
	(Tony Luck's message of "Fri, 26 Aug 2005 11:13:45 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7839>

"Luck, Tony" <tony.luck@intel.com> writes:

>>In the meantime, warning the user about the issue and suggesting
>>how to do the fast-forwarding of the working tree himself in the
>>warning message might be the safest and the most sensible thing
>>to do.
>
> Yes please ... a big fat warning with coloured flashing lights
> and explosions from the sound card.

Yeah, but what to do afterwards?  I can see this as an
compromise:

 * "git fetch", just like the updated "git pull", reads
   $GIT_DIR/HEAD before it starts its work, and compares it with
   $GIT_DIR/HEAD after it is done.  If the --update-head-ok flag
   is not given on the command line, and if the HEAD changed,
   then barf and exit with non-zero status after reverting
   $GIT_DIR/HEAD to its original value.  If --update-head-ok is
   given, none of the above check and revert happens.

 * "git pull" calls "git fetch" with the extra flag, and does
   its thing the current way.

So if you are calling from the command line, "git fetch linus",
when you were still on "linus" branch (which you do not normally
do but just to prevent mistakes), it would trigger the check and
your $GIT_DIR/HEAD would stay intact.  If you stayed on your own
branch, "git fetch linus" would continue to just fast forward
"linus" head without touching the working tree.

Come to think of it, it may be cleaner to simply forbid
fast-forward fetching into the current repository (whether it is
"git fetch" or "git pull").  At least in your workflow you do
not do that ever anyway.

Johannes, what do you think, as the original advocate of "push in
reverse"?
