From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Set errno to EEXIST if mkdir returns EACCES or EPERM
Date: Mon, 30 Jan 2006 12:33:51 -0800
Message-ID: <7vvew14frk.fsf@assigned-by-dhcp.cox.net>
References: <20060130193839.GA6575@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 21:34:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3fip-0000g0-Kq
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 21:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbWA3Udy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 15:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWA3Udy
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 15:33:54 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:60039 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964961AbWA3Udx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 15:33:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060130203253.CJEO3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 Jan 2006 15:32:53 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060130193839.GA6575@steel.home> (Alex Riesen's message of
	"Mon, 30 Jan 2006 20:38:39 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15296>

Alex Riesen <raa.lkml@gmail.com> writes:

> ... and the directory already exists. I.E. Cygwin is such
> a case: mkdir fail for mounts which reference directly
> to windows mounts ("drives").
>
> ---
>
> The discussion, which ended up with this patch can be read
> here: http://www.cygwin.com/ml/cygwin/2006-01/msg01276.html
>
> BTW, there is this:
> http://www.cygwin.com/ml/cygwin/2006-01/msg01380.html
> So this patch will probably be not needed soon.

Thanks for all the background information.  Although it is very
tempting for me to adopt your patch as an easy way out, I would
feel *dirty* if I did so.

Eric Blake is right in his argument in that thread.  Our code
should not depend on the Linux EEXIST behaviour.  The reason
Cygwin folks want to be as close to Linux is to work around
application bugs like this.  Which is a valid concern for them,
but it does not mean the application has license to depend on
Linux behaviour.

We, as an application, should take a different attitude -- we
should fix things to make things portable, not work things
around, if both are equally easily doable.  I do not object to
using a function that has a semantics Linux mkdir() gives us,
but calling that mkdir() does not feel quite right.  

Also the wrapper implies that in our future use of mkdir() we
cannot tell the difference between EEXIST and other errors if we
later wanted to.

So let's look at our existing uses first:

apply.c:1577:		if (mkdir(buf, 0777) < 0) {
apply.c-1578-			if (errno != EEXIST)
apply.c-1579-				break;
apply.c-1580-		}
apply.c-1581-	}

This is "we want to see buf directory exist and we would create
one if there isn't".  Instead of checking errno, we could stat
as your patch does.

entry.c:15:		if (mkdir(buf, 0777)) {
entry.c-16-			if (errno == EEXIST) {
entry.c-17-				struct stat st;
entry.c:18:				if (len > state->base_dir_len && state->force && !unlink(buf) && !mkdir(buf, 0777))
entry.c-19-					continue;
entry.c-20-				if (!stat(buf, &st) && S_ISDIR(st.st_mode))
entry.c-21-					continue; /* ok */
entry.c-22-			}

This is a bit more involved. "we want to have buf directory and
we would create it, and if force is given to have something
under that directory, we would even unlink the nondirectory that
sits there".

I asked "git-grep" where else we use mkdir(), and all other
users want the semantics of the apply.c use quoted above.

So I'd rather see us create a generic helper function like this:

	int make_directory(const char *path, int force)
        {
		struct stat st;
		int mkdir_errno;
		if (!mkdir(path, 0777))
			return 0;
                mkdir_errno = errno;
		if (!lstat(path, &st) && S_ISDIR(st.st_mode))
                	return 0;
                if (!force) {
		bad:
                	errno = mkdir_errno;
                        return -1;
                }
                if (!unlink(path, &st) && !mkdir(path, 0777))
                	return 0;
                /* we might have failed to unlink an existing symlink
		 * which happens to point at an existing directory; that
                 * directory is not what we want here.
                 */
		if (!lstat(path, &st) && S_ISDIR(st.st_mode))
                	return 0;
		goto bad;
        }

and have current callers of mkdir() use it, regardless of the
platform.  It may not worth saving mkdir_errno, though.

Then everybody but entry.c one would say force=0, and entry.c
one passes force appropriately using the condition it uses in
its current if() statement.
