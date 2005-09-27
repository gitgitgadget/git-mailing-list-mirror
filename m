From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] Support for partial HTTP transfers
Date: Mon, 26 Sep 2005 22:46:30 -0700
Message-ID: <7vfyrr3vwp.fsf@assigned-by-dhcp.cox.net>
References: <20050926175204.GC9410@reactrix.com>
	<7vd5mvedcs.fsf@assigned-by-dhcp.cox.net>
	<20050927000931.GA15615@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 07:47:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK8JV-0005qw-TF
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 07:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964820AbVI0Fqj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 01:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964821AbVI0Fqj
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 01:46:39 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:35313 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964820AbVI0Fqi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 01:46:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050927054636.UXMC19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Sep 2005 01:46:36 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20050927000931.GA15615@reactrix.com> (Nick Hengeveld's message
	of "Mon, 26 Sep 2005 17:09:31 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9370>

Nick Hengeveld <nickh@reactrix.com> writes:

> How about using mkstemp on the prev file to keep multiple instances
> from stepping on each other?  Since O_CREAT | O_EXCL is used to
> open the tmpfile, only one instance will be able to succeed and
> continue.

I think (O_CREAT|O_EXCL) in your code can be easily defeated by
this sequence:

    one                 	two

    unlink prevfile
    rename tmpfile, prevfile
    unlink tmpfile
    local = open tmpfile
                                unlink prevfile
                                rename tmpfile, prevfile
                                unlink tmpfile
                                local = open tmpfile
                                prevlocal = open prevfile
    write local
                                copyfile prevlocal, local
    write local
				???

Not that I think the multiple instances should be prevented at
this low level --- if they stomp on each other at this level, it
is very likely the they are doing duplicated work on the network
side as well, and should be prevented from doing so at much
higher level than this, I think.  That's why I said I do not
mind BKL upfront in git-fetch.sh.

> That's an annoying case, all right...  Would it be worth including a 
> full retry if a partial failed the SHA1 check?

Probably not.  Just failing loudly and asking the upper layer to
retry would be fine, I think.
