From: Junio C Hamano <junkio@cox.net>
Subject: Re: git /objects directory created 755 by default?
Date: Thu, 22 Dec 2005 11:14:29 -0800
Message-ID: <7vwthxlzai.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
	<7vacevgwqr.fsf@assigned-by-dhcp.cox.net>
	<7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512211502130.25834@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vek465cev.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512212317400.18684@wbgn013.biozentrum.uni-wuerzburg.de>
	<43AA75D1.7040009@op5.se>
	<Pine.LNX.4.63.0512221220220.7112@wbgn013.biozentrum.uni-wuerzburg.de>
	<43AA9BE6.7000601@op5.se>
	<Pine.LNX.4.63.0512221530570.18551@wbgn013.biozentrum.uni-wuerzburg.de>
	<43AACBE9.7060201@op5.se>
	<Pine.LNX.4.63.0512221700310.18982@wbgn013.biozentrum.uni-wuerzburg.de>
	<43AAD9D7.1070503@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Dec 22 20:14:40 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpVtc-0006Cu-Gh
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 20:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbVLVTOe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 14:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbVLVTOd
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 14:14:33 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:15599 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030264AbVLVTOd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 14:14:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051222191300.TFMY17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Dec 2005 14:13:00 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <43AAD9D7.1070503@op5.se> (Andreas Ericsson's message of "Thu, 22
	Dec 2005 17:52:39 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13961>

Andreas Ericsson <ae@op5.se> writes:

> Junio said:
> "I agree the setting should not be limited to git-shell, but I do
> not think setting "umask" from git configuration is the right
> way either.  For files and directories under $GIT_DIR, maybe
> imposing the policy git configuration file has is OK, but I
> think honoring the user's umask is the right thing for working
> tree files."

I think this needs qualifying.

When we talk about "CVS-style shared repository", we know what
it is -- there is no such thing as "*the* working tree
associated with the repository" and there is no room for
disagreement.

The workflow your shared repository implies is that there is an
associated working tree with that repository, and the working
tree should allow updates by participants who are allowed to
create new things in .git/objects and update .git/refs/.  If you
assume that is the only valid use case for non-naked shared
repository, then what I said above is not needed.  It does not
make any sense to have anything stricter than 007 as umask in
such a case.  But is it the only valid use case?

I could give each of the gitsters I trust an git-shell account
on my private machine and prepare refs/heads/rcpt/js branch for
you and refs/heads/rcpt/ae for Andreas to push into (I would use
Carl's per branch push policy to make sure those "receipt
branches" are the only ones you guys can push into if I did so).

Then instead of sending "I now have this public repository and
have goodies for git improvement; please pull" e-mail to me, you
could push into your branch.  I will keep working on master (and
my own topic branches), with whatever branch checked out in the
working tree, and merge from those rcpt branches at my leisure.
You guys are not allowed to touch my working tree, though.

In such a scenario, there is no reason to forbid me from
applying umask 022 to my working tree files, even though making
sure that fan-out directories of .git/objects/ *I* lazily create
can be writable by you is essential.

I have a feeling that it might be good enough to modify
safe_create_leading_directories() to chmod(0777) after creating
a new directory under .git/ (or limit it to .git/objects/).  The
repository administrator can restrict things further by chmod
0770 .git/ as needed.
