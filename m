From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Additional merge-base tests
Date: Tue, 04 Jul 2006 03:38:56 -0700
Message-ID: <7vsllhhcxr.fsf@assigned-by-dhcp.cox.net>
References: <44A9E6AE.10508@gmail.com>
	<7v3bdhoraa.fsf@assigned-by-dhcp.cox.net> <44AA0DAE.1060308@gmail.com>
	<7vpsgllsnp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0607041019580.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 12:39:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxiJ3-0005NO-7q
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 12:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWGDKi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 06:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWGDKi6
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 06:38:58 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:35517 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932149AbWGDKi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 06:38:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060704103857.KYQO11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 4 Jul 2006 06:38:57 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23278>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> We could introduce a time.maximumSkew variable, and just walk only 
> that much further when traversing the commits.
>
> So, if you do not trust your clients to have a proper ntp setup, just say 
> "I trust my peers to be off at most 1 day". That would save lots vs 
> traverse-everything.

The problem ALASCM's example demonstrates does rely on clock
skews.  The timestamps used in the example looked like this:


   1   1
  /  \/  \
 4  -1   4
 |   |   |
 3  -2   3
 |   |   |
 2  -3   2
   \ |  /
     0

The crucial clock skew the case relies on is that the tip of the
middle branch (-1) is older than the common commit (0).  But the
topmost commits with timestamp 1 could be with timestamp 5 to
correct the clock skew and still make the example "fail".

   5   5
  /  \/  \
 4  -1   4
 |   |   |
 3  -2   3
 |   |   |
 2  -3   2
   \ |  /
     0

However, I am not sure how you are going to use that maximumSkew
variable.  The evil owner of the middle branch may have started
running a "git am" to commit 4-patch series just when the
machine's clock jumped back by 3 seconds, at the pace of 1 patch
a second.  Then he pushes '0' out on "master" branch, and the
three commits on top of that on "next" branch.

Two days later, two friends build left and right strands of
pearls based on the "master" branch of the evil owner of the
middle branch.  Maybe they do that one patch a day.  On the
fifth day, they both merge the "next" branch.

The point is that it does not require a very large clock skew to
trigger this.
