From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fall back to three-way merge when applying a patch.
Date: Thu, 06 Oct 2005 00:33:56 -0700
Message-ID: <7vmzln9k0r.fsf@assigned-by-dhcp.cox.net>
References: <7vd5mk7pv6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510042155090.31407@g5.osdl.org>
	<7vslvg1mcs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510050725510.31407@g5.osdl.org>
	<7vslvfcy0g.fsf@assigned-by-dhcp.cox.net>
	<m1mzln9zi1.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0510051909390.31407@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 09:34:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENQGT-0000Z6-Kt
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 09:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVJFHd7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 03:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVJFHd7
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 03:33:59 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:33723 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750705AbVJFHd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 03:33:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051006073351.YBDI9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 6 Oct 2005 03:33:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510051909390.31407@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 5 Oct 2005 19:18:41 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9764>

Linus Torvalds <torvalds@osdl.org> writes:

> ... But I doubt it works very well to rely on 
> commit-level SHA1's - it's more likely to work if you try the "last few 
> tagged releases etc", since patches that don't apply are often against the 
> previous release (and if they don't apply there either, then it's probably 
> not worth fighting over anyway).

Yes.  That is the current heuristics git-applypatch in the
proposed updates branch tries to attempt.  Recorded tree if
exists (which is not very interesting), last few commits, and
then tagged releases.

Ideally, if we had the path following git-rev-list you talked
about, we could first ask git-apply the set of paths the patch
touches, and instead of trying every commits from the HEAD, try
only commits that touch one (or more) of the given paths.

Another possible git-rev-list enhancement that might be useful
is to pop commits not based on time but based on the depth from
branch heads.  Then we could:

    git-rev-list --depth-order --max-count=$N --all \
    	$(git-apply --show-files $patch | sed -e 's/^[^ ]* [^ ]* //p')

to obtain list of last few commits that touch the paths
involved, in the order that is closer-to-tip first.  This would
give us set of more useful commits than the current behaviour.
