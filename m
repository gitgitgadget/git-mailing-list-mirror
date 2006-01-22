From: Junio C Hamano <junkio@cox.net>
Subject: Re: What is in git.git
Date: Sat, 21 Jan 2006 18:44:06 -0800
Message-ID: <7v64odj821.fsf@assigned-by-dhcp.cox.net>
References: <7v3bjiuhxb.fsf@assigned-by-dhcp.cox.net>
	<200601211636.02340.lan@ac-sw.com>
	<7vek31mkyg.fsf@assigned-by-dhcp.cox.net>
	<200601220033.26321.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 03:44:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0VDJ-00037M-Tz
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 03:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWAVCoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 21:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWAVCoI
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 21:44:08 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:14547 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751247AbWAVCoH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 21:44:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060122024126.XRCV17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 21:41:26 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200601220033.26321.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Sun, 22 Jan 2006 00:33:25 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15035>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> The original gitlink proposal did exactly this: it recorded
> the place where a subproject is bound by putting a gitlink into
> a tree. This way, the binding point can be changed, and is subject to
> versioning itself.
>
> I just realized that this is not currently possible with the bind lines.
> What about the following usage szenario:
> - in a superproject, I use a subproject X implementing some lib by 
>   binding it at X/. My Makefile recurses into X/ for this.
>   This is recorded at commit point (A)
> - later on, I realize I need another lib from a probject Y; I want
>   to put the libs X and Y into subdirectory lib/ of my superproject;
>   i.e. I bind Y at lib/Y/ and move the binding point of X to lib/X/.
>   The Makefile is changed accordingly to build the subprojects.
>   This is recorded at commit point (B)

The original gitlink proposal records commit object name in the
link object itself, so do bind lines in the commit object in
bound commit proposal.  In either way, you need to deal with the
subproject relocation at the Porcelain level.

I was hoping that, upon seeing these two commits (let's say we
are dealing with two-way merge aka "checkout"):

	In commit 1:
		bind xxxxx... X/

	In commit 2:
		bind yyyyy... lib/X/
                bind zzzzz... lib/Y/

the tool could notice that xxxxx... and yyyyy... are related in
their ancestry chain, detect the relocation of subprojects, and
update the $GIT_DIR/bind file (maybe with some help from the end
user).  We can do something similar in gitlink approach as well.

> A $GITDIR/bind alone will no work, as moving back to (A) would keep
> the binding point of subproject, and make is broken.

I do not see why.  $GIT_DIR/bind can be adjusted by the tool
upon checkout to reflect the reorganized tree.

> What about putting $GITDIR/bind information directly into reference files?
>
>  $HOME/gitproj> cat .git/refs/heads/master
>  92347432598...
>  bind main=/
>  bind subpro=sub/

I think that would also work.  Although I do not immediately see
major difference in expressiveness either way, that may be a
cleaner way to achieve what we want to do.
