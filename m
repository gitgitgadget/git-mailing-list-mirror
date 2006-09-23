From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove branch by putting a null sha1 into the ref file.
Date: Sat, 23 Sep 2006 14:49:42 -0700
Message-ID: <7veju2nthl.fsf@assigned-by-dhcp.cox.net>
References: <20060918065429.6f4de06e.chriscool@tuxfamily.org>
	<200609230645.37773.chriscool@tuxfamily.org>
	<7vu02zuhya.fsf@assigned-by-dhcp.cox.net>
	<200609231322.30214.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 23:50:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRFNe-0001DE-ND
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 23:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWIWVtn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 17:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWIWVtn
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 17:49:43 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:43698 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750764AbWIWVtn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 17:49:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923214942.LNHG13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Sep 2006 17:49:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rxph1V0021kojtg0000000
	Sat, 23 Sep 2006 17:49:41 -0400
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <200609231322.30214.chriscool@tuxfamily.org> (Christian Couder's
	message of "Sat, 23 Sep 2006 13:22:30 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27632>

Christian Couder <chriscool@tuxfamily.org> writes:

> You are right, so what about moving ".git/refs/heads/frotz" 
> to ".git/deleted-refs/heads/frotz.ref" 
> or ".git/deleted-refs/heads/frotz~ref" (because "~" is forbidden in ref 
> names).

But wouldn't it bring up the issue of locking among deleters,
updaters/creators, and traversers?

If we choose to use packed-refs.lock as the "set of all refs"
lock, the whole sequence would become something like this.  Note
that this tries to make readers lockless but I am sure there are
nasty race condition issues.  I am not sure what we would want
to do about them.

= Looking up a ref $frotz.

 - check if .git/$frotz exists, and use it if it does.

 - check if .git/deleted-refs/$frotz~ref exists, and return "no
   such ref" if it does.

 - find $frotz in .git/packed-refs.

= Looping over refs.

 - grab all .git/refs/ and subtract all .git/deleted-refs/

 - walk .git/packed-refs and the result from the above in
   parallel as in the current code.

= Storing a new value in ref $frotz.

 - acquire .git/packed-refs.lock

 - lock .git/$frotz.lock.

 - write into .git/$frotz.lock.

 - create or update .git/logs/$frotz as needed.

 - if .git/deleted-refs/$frotz~ref exists, unlink it.

 - rename .git/$frotz.lock to .git/$frotz to unlock it.

 - unlink .git/packed-refs.lock

= Deleting a ref $frotz.

 - acquire .git/packed-refs.lock

 - look up $frotz; if it does not exist either barf or return
   silent (haven't thought it through yet).

 - create .git/deleted-refs/$frotz~ref.

 - remove .git/logs/$frotz

 - unlink .git/packed-refs.lock

= Packing refs, with optional pruning.

 - lock .git/packed-refs.lock

 - loop over refs:
   - write it out to .git/packed-refs.lock unless a symref.
   - if it is a loose one (not a symref), remember it for pruning.

 - if pruning:
   - remove the entire .git/deleted-refs/ hierarchy
   - remove the remembered ones

 - rename .git/packed-refs.lock to .git/packed-refs
