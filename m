From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question on GIT tutorial.
Date: Thu, 17 Nov 2005 23:24:02 -0800
Message-ID: <7vd5kyo1v1.fsf@assigned-by-dhcp.cox.net>
References: <cda58cb80511140220n26da3edm@mail.gmail.com>
	<7vlkznt5tc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 08:53:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed0bP-0005rK-Sk
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 08:24:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932560AbVKRHYF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 02:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932562AbVKRHYE
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 02:24:04 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:35049 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932560AbVKRHYD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 02:24:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118072308.QMSB17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 02:23:08 -0500
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <7vlkznt5tc.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 17 Nov 2005 11:47:27 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12207>

Junio C Hamano <junkio@cox.net> writes:

>> """
>> Copy over the packed files from "project lead" public repository to
>> your public repository.
>> """
>>
>> Why is it needed ?
>
> That was a remnant from the days some transports did not
> understand objects/info/alternates; I think we do not need that
> step anymore.

After re-reading that section, I take it back.  What I meant to
say there was this:

   You are the subsystem maintainer, so your tree would have
   many overlapping objects with your project lead.  So in step
   2, you prepare an empty repository first, and then in step
   3., copy the packs from the project lead.  Then pushing into
   that repository in step 4 would prevent the objects you
   inherited from your project lead from getting expanded in
   your public repository.

But these days, there is a more efficient way *if* your public
repository resides on the same machine as the public repository
of your project lead.  First, on the public repository side:

   pub$ export GIT_DIR=/pub/my.git
   pub$ HIS_GIT=/pub/his.git
   pub$ git-init-db
   pub$ echo "$HIS_GIT/objects" >"$GIT_DIR/objects/info/alternates"
   pub$ (cd "$HIS_GIT/refs" && tar - heads tags) |
        (cd "$GIT_DIR/refs" && mkdir j.u.n.k && cd j.u.n.k && tar xf -)

This makes your repository to have the same refs as your
project lead has but under funny names.  Then from your primary
development repository, you push into your public repository:

   home$ git-send-pack --all ssh://pub.repo.xz/pub/my.git/

Thanks to the funny refs you stole from your project lead when
you prepared your public repository, this transfer sends only
objects the project lead does not have, and your refs.  After
this is done, you can get rid of the funny refs you stole from
your project lead:

   pub$ cd "$GIT_DIR/refs" && rm -fr j.u.n.k

If your public repository is not on the same machine as your
project lead's, objects/info/alternates trick cannot be used, so
what we have in the tutorial section still applies.
