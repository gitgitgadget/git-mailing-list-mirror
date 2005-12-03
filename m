From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] daemon whitelist handling (Re: git pull aborts in 50% of cases)
Date: Sat, 03 Dec 2005 11:30:51 -0800
Message-ID: <7vzmnivuz8.fsf_-_@assigned-by-dhcp.cox.net>
References: <20051202190412.GA10757@mipter.zuzino.mipt.ru>
	<43909963.60901@zytor.com>
	<20051202211250.GA11384@mipter.zuzino.mipt.ru>
	<4390B64E.20601@zytor.com>
	<Pine.LNX.4.63.0512030316520.19086@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vu0dq29wg.fsf@assigned-by-dhcp.cox.net> <43911D9E.5030803@zytor.com>
	<7vpsoezf6y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 20:31:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eid62-00087g-04
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 20:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVLCTax (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 14:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbVLCTax
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 14:30:53 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:54656 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750764AbVLCTax (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2005 14:30:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051203193004.QRCG20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Dec 2005 14:30:04 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <7vpsoezf6y.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 03 Dec 2005 01:45:57 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13163>

Having slept over the patch I am responding to, I tend to think
this is more trouble than its worth.  Validating the
directory enter_repo() chdir()'ed into and validated to be a
good git repository should be done on its canonical name as
getcwd() returns, not with a userland aliasing avoidance.

As an administrator, being able to say /pub/scm on the
whitelist, knowing /pub to be a symbolic link points at
somewhere today but maybe at different place tomorrow, and not
having to adjust the whitelist whenever that happens, is indeed
nice.  We do not allow the remote requestor to say /../ in the
path, so we trap him within the directories the whitelist
describes.

Not.

For example, I can by mistake create a symbolic link:

	ln -s /home /pub/scm/git/git.git/oops

now accesses /pub/scm/git/oops/hpa/secret.git/ is not
restricted.  We could hand-resolve the each level from the
request to see if no "funny" symbolic links are involved, but
what is the definition of "funny"?  When we see /pub pointing at
somewhere in /mnt/disk47/slice31, we should not complain.  When
we see "oops" under git in the above example, we would want to
complain.  These things are hard to get right.

I tend to say that the 0.99.9k (and the current master) rule to
make validation always work on what getcwd() gives back is
easier to understand (which generally means safer).  Can I talk
you into adjusting your whitelist on kernel.org machines?
