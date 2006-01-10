From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Remember and use GIT_EXEC_PATH on exec()'s
Date: Mon, 09 Jan 2006 18:53:19 -0800
Message-ID: <7vfynwbxpc.fsf@assigned-by-dhcp.cox.net>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
	<1136849754.11717.517.camel@brick.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 03:53:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew9dV-0005wd-6c
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 03:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWAJCxW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 21:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbWAJCxV
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 21:53:21 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:46289 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750815AbWAJCxV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 21:53:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060110025130.OMT17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 Jan 2006 21:51:30 -0500
To: Michal Ostrowski <mostrows@watson.ibm.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14400>

Michal Ostrowski <mostrows@watson.ibm.com> writes:

> If git-upload-pack is invoked by ssh, it may have been invoked because
> ssh was explicitly told which program to execute on the remote end
> (i.e. --exec had been used with git-clone-pack).  In this case, the
> git suite may not be in the PATH, and so subsequent exec's by
> git-upload-pack (i.e. git-rev-list, git-pack-objects) will fail.

True.

> +.environment.GIT_EXEC_PATH:
> +	@(test -e $@ && grep -h -e '^$(bindir)$$' $@) || echo $(bindir) > $@

Hmph.

  * I did not know "test -e" was portable (it is in POSIX.1),
    but since you are creating the file yourself anyway,
    wouldn't "test -f" look more familiar?

  * Perhaps grep -F (--fixed-strings), not as regexp?

  * I do not get the point of using "grep -h" here (it's not in
    POSIX.1).  Perhaps just >/dev/null?

But I like the timestamp trick here that uses ||.  Maybe I
should borrow it for GIT-VERSION-GEN.  Maybe not.

> --- a/environment.c
> +++ b/environment.c
> @@ -9,6 +9,10 @@
>   */
>  #include "cache.h"
>  
> +#ifndef GIT_EXEC_PATH
> +#define GIT_EXEC_PATH NULL
> +#endif

I wonder if not having GIT_EXEC_PATH defined should be an error here.

> +void git_setup_exec_path(void)
> +{
>...
> +}

Maybe move git.c::prepend_to_path() to a single library file and
use it here?
