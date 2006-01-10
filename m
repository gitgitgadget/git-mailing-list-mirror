From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Mon, 09 Jan 2006 18:52:42 -0800
Message-ID: <7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
	<1136849810.11717.518.camel@brick.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 03:52:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew9cu-0005r4-7H
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 03:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWAJCwp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 21:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWAJCwp
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 21:52:45 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:19921 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750742AbWAJCwo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 21:52:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060110025053.OAQ17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 Jan 2006 21:50:53 -0500
To: Michal Ostrowski <mostrows@watson.ibm.com>
In-Reply-To: <1136849810.11717.518.camel@brick.watson.ibm.com> (Michal
	Ostrowski's message of "Mon, 09 Jan 2006 18:36:50 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14398>

Michal Ostrowski <mostrows@watson.ibm.com> writes:

> Calls to git_setup_exec_path() are inserted on paths that will execute
> other git programs. git_setup_exec_path() will ensure that the git
> installation directories are in the path.

About fetch-clone.c (which is shared by fetch-pack and
clone-pack), it runs "git-index-pack" from finish_pack and
"git-unpack-objects" from unpack_pack, so spelling these exec
with execlp("git", "git", "index-pack", ...) might be cleaner,
since "git" is required to be in users' PATH even though git-*
may be moved out of the PATH in later versions of git.  I
dunno...

In send-pack.c, I wonder why you didn't do a setup_exec_path()
at the beginning of main() instead of having two calls close to
exec*() call site.

The same comment applies for run-command.c; you do it once for
each child, but calling it once at the beginning of receive-pack
would be good enough.  The same thing for daemon.c.

I suspect you are trying to limit the extent of damage, but I do
not think of a downside if we just call setup_exec_path() once
at the beginning of main().  $GIT_EXEC_PATH _could_ have a
private copy of broken "diff" to confuse diff-* family, but you
cannot say "git diff" in such a setup anyway because "git" does
the PATH prefixing already, so it would be a moot point.

Here is the list my "nm | grep ' exec[vlpe]*\($\|@@\)'" found
that use some variant of exec* family (except "git-diff-*"):

	clone-pack
        daemon
        fetch-pack
        merge-index
        peek-remote
        receive-pack
        send-pack
        shell
        ssh-fetch/ssh-pull
        ssh-upload/ssh-push
        upload-pack

I do not care too much about ssh-* commit walkers (users can say
e.g. GIT_SSH_PUSH themselves).

Anyway, thanks for starting this.  I need a bit more thought and
a bit of list discussion to convince myself this is a good
change.
