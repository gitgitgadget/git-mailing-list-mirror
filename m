From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add -C[NUM] to git-am
Date: Thu, 08 Feb 2007 15:04:25 -0800
Message-ID: <7v3b5gxnd2.fsf@assigned-by-dhcp.cox.net>
References: <7vfy9h13yu.fsf@assigned-by-dhcp.cox.net>
	<20070208135708.GD20183@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Fri Feb 09 00:04:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFIJe-0005VN-AL
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933347AbXBHXE1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 18:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933346AbXBHXE1
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:04:27 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:54375 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933347AbXBHXE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:04:26 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070208230425.BXUN21704.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Feb 2007 18:04:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MB4R1W0041kojtg0000000; Thu, 08 Feb 2007 18:04:25 -0500
In-Reply-To: <20070208135708.GD20183@mellanox.co.il> (Michael S. Tsirkin's
	message of "Thu, 8 Feb 2007 15:57:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39115>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> BTW, Junio, why is it that git-rebase calls "git am" and not "git-am"?

Not commenting on the patch itself yet in this message, but a
quick note on the above point.

At some point after 1.5.0 we might want to audit the scripts and
make sure we can still run with $(gitexecdir) set to somewhere
outside of the end user's $PATH.

In such a setting, an end user would start "git rebase" (or
whatever git program) because "git-rebase" will not be on her
$PATH.  The git wrapper would do the GIT_EXEC_PATH magic before
invoking "git-rebase", so even the call to "am" is made in
"git-am" form from our script, it will work correctly.

So in that sense, they are equivalent and does not matter from
correctness point of view. It used to matter cycle-wise because
the "git potty" was a shell script, but I do not think it
matters anymore.

Once we make sure we still correctly support $(gitexecdir) that
is different from $(bindir), we may want to update all the
invocation of "git foo" our scripts make to "git-foo", for a
different reason.

Once in-tree scripts and commands that invoke git stuff always
with git-foo syntax, I think we _could_ allow aliasing built-in
command with something else.  For example, we could allow
"[alias] foo = git-foo --my-favorite-flag" in the configuration
file and let the user say "git foo" from the command line to
mean "$GIT_EXEC_PATH/git-foo --my-favorite-flag", while not
affecting the uses of "git-foo" in *our* scripts.

I do not think we would want to change the default to use
separate bindir and gitexecdir, but the intent has always been
that we should make it easier to do if some distro wanted to 
package with gitexecdir set to /usr/libexec/git.
