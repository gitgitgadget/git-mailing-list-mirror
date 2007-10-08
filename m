From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Mon, 8 Oct 2007 05:06:48 +0400
Message-ID: <20071008010648.GB29433@potapov>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com> <20071007213817.GJ31659@planck.djpig.de> <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com> <20071007221920.GF2765@steel.home> <51419b2c0710071524q16e9c593s2722dffc826e560d@mail.gmail.com> <20071007234346.GA29433@potapov> <51419b2c0710071722k576c06d9i2f4dce730eae2059@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 03:07:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ieh5a-00016N-JY
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 03:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756735AbXJHBGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 21:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758048AbXJHBGx
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 21:06:53 -0400
Received: from smtp05.mtu.ru ([62.5.255.52]:61025 "EHLO smtp05.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757917AbXJHBGx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 21:06:53 -0400
Received: from potapov.private (ppp85-140-171-1.pppoe.mtu-net.ru [85.140.171.1])
	by smtp05.mtu.ru (Postfix) with ESMTP id 1BEFB983769;
	Mon,  8 Oct 2007 05:06:49 +0400 (MSD)
Received: from potapov.private (localhost [127.0.0.1])
	by potapov.private (8.13.8/8.13.8/Debian-3) with ESMTP id l9816men001257;
	Mon, 8 Oct 2007 05:06:48 +0400
Received: (from dpotapov@localhost)
	by potapov.private (8.13.8/8.13.8/Submit) id l9816muW001256;
	Mon, 8 Oct 2007 05:06:48 +0400
X-Authentication-Warning: potapov.private: dpotapov set sender to dpotapov@gmail.com using -f
Content-Disposition: inline
In-Reply-To: <51419b2c0710071722k576c06d9i2f4dce730eae2059@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60273>

On Sun, Oct 07, 2007 at 06:22:28PM -0600, Elijah Newren wrote:
> 
> git-filter-branch --tree-filter 'rm -f testme.txt' HEAD
> git reset --hard
> rm -rf .git/refs/original/
> vi .git/packed-refs
> # Use vi to remove the line referring to refs/original...
> git reflog expire --all --expire-unreachable=0
> git gc --prune
> 
> Seems like a wrapper is needed.  :-)

Actually, I would rather not, because you rarely need to remove anything
immediately, and 30 days delay is reasonable time to give you a chance
to recover that you removed accidentally. You can reduce it by setting
appropriate value for gc.reflogExpireUnreachable in your configuration.
The only thing you need to do is to remove .git/refs/original/heads/something
after you are sure that git-filter-branch did exactly what you wanted.

> 
> > Warning: all unreachable references will be removed!
> 
> What other scenarios could lead to unreachable references?

Any re-writing of history leads to that.

> I don't
> know how to determine whether this is safe or not (except that these
> were test repositories anyway, so I don't care what happens to them).

Git logs all your action, so even re-writing history would not be
so disastrous if you suddenly realized that you did something wrong.
The history is stored for 30 days by default. Usually, you do not
need to mess with Git internals like you did above. Your useless
files still will disappear after being unreachable for 30 days.

OTOH, if you want to have a clean repository immediately, I believe
'git clone' is a better option. After you made a local clone using
it, 'git gc' should remove old garbage.

Dmitry
