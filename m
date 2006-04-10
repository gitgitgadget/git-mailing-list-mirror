From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Implement limited context matching in git-apply.
Date: Mon, 10 Apr 2006 12:29:00 -0700
Message-ID: <7vacat9qmb.fsf@assigned-by-dhcp.cox.net>
References: <m1d5fqi23b.fsf@ebiederm.dsl.xmission.com>
	<m13bgmht9v.fsf@ebiederm.dsl.xmission.com>
	<m1irphhj1p.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 10 21:29:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FT24R-0006FZ-OQ
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 21:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWDJT3E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 15:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWDJT3E
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 15:29:04 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:36754 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932099AbWDJT3D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 15:29:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060410192901.CDIV20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Apr 2006 15:29:01 -0400
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m1irphhj1p.fsf_-_@ebiederm.dsl.xmission.com> (Eric
	W. Biederman's message of "Mon, 10 Apr 2006 03:33:06 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18592>

ebiederm@xmission.com (Eric W. Biederman) writes:

> If I just loop through all of Andrews patches in order
> and run git-apply --index -C1 I process the entire patchset
> in 1m53s or about 6 patches per second.  So running
> git-mailinfo, git-write-tree, git-commit-tree, and
> git-update-ref everytime has a measurable impact,
> and shows things can be speeded up even more.

Although I haven't "read" it, but just only "looked at" it, the
patch looks OK.  I haven't managed to start beating on it yet
for time constraints.

If you are dealing with the kernel tree, I suspect most time is
spent on write-tree.  Statistically, a typical kernel patch (I
haven't counted the ones in -mm series, but only the ones
actually reacheable from Linus tip) touches only 3 files on
average, so most of the 1,100 tree objects in a typical kernel
tree are computed but found unchanged when write-tree happens.

I suspect we could make a backward incompatible change to the
index file format to record the top-level tree object names
somewhere where normal cache-entry walker would not see.  Then
when anybody makes a modification to invalidate that tree
object, mark that tree (or split that tree to read lower level
trees lazily) to force us recompute the tree object.

Theoretically you could do that recursively to record all 1,100
tree objects but that would make the cache slightly larger (say,
by 100kB).
