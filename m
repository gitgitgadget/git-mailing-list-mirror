From: Junio C Hamano <junkio@cox.net>
Subject: Re: clone: I'm only doing a max of 256 requests
Date: Wed, 05 Oct 2005 14:16:04 -0700
Message-ID: <7vhdbvk6ln.fsf@assigned-by-dhcp.cox.net>
References: <20051005191300.GC17475@hexapodia.org>
	<7virwbu4wz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 05 23:18:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENGcZ-00048R-FI
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 23:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbVJEVQH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 17:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbVJEVQH
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 17:16:07 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:30187 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030264AbVJEVQG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 17:16:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051005211559.PIVP4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Oct 2005 17:15:59 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9732>

Junio C Hamano <junkio@cox.net> writes:

> Andy Isaacson <adi@hexapodia.org> writes:
>
>> ...  (And how should I be starting to
>> debug this?  The git programs don't seem to have a useful --verbose
>> option.  It would be nice if "git -v clone" would tell me what it is
>> doing.)
>
> $ git grep -n 'max of .* requests'
> upload-pack.c:141:			die("I'm only doing a max of %d requests", MAX_NEEDS);
>
> I suspect that the repository you are cloning has too many
> branch heads and tags under .git/refs/.

We can do three things, the first two being short term, the last
one a bit longer term.

1. As a stop gap measure, so that your Linux kernel work can
   continue, please bump MAX_NEEDS definition in upload-pack.c
   from 256 to a bit higher.  That controls the number of
   40-letter SHA1 given to underlying rev-list via execvp(), so
   it cannot be _too_ big like 1M, lest it exceeds the exec
   argument buffer limit.

2. We can add '--all' flag to git-rev-list, and have upload-pack
   use it instead, when it sees more than MAX_NEEDS refs.  I
   have a patch to do this that I am currently testing.

3. In addition, upload-pack should probably be taught to detect
   "I do not have anything.  Please give me objects reachable
   from all your refs" requests, and cache the resulting pack
   somewhere (invalidate whenever any ref changes), so that next
   'clone' request can just send it out instead of rerunning
   rev-list and pack-objects.
