From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-daemon problem
Date: Tue, 11 Jul 2006 16:04:35 -0700
Message-ID: <7vac7f3fr0.fsf@assigned-by-dhcp.cox.net>
References: <E1G0QeX-0003hG-0I@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 12 01:04:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0RHU-00049b-SH
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 01:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWGKXEh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 19:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWGKXEh
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 19:04:37 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:47782 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751340AbWGKXEg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 19:04:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060711230436.KFAM554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Jul 2006 19:04:36 -0400
To: git@vger.kernel.org
In-Reply-To: <E1G0QeX-0003hG-0I@moooo.ath.cx> (Matthias Lederhofer's message
	of "Wed, 12 Jul 2006 00:24:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23747>

Matthias Lederhofer <matled@gmx.net> writes:

> A few weeks ago upgrading from 1.3.x to 1.4.1 I had a problem with
> git-daemon.  I started git-daemon on a terminal but did not redirect
> stdin/stdout/stderr to /dev/null (actually using daemon(8) on freebsd
> without -f but just disowning the process and closing the terminal
> works fine too, nothing freebsd/daemon(8) specific).  After closing
> the terminal I was not able to use the git-daemon anymore with some
> versions of the git. So now I took some time and tried to find what
> was the reason for that.
>
> It seems to be related to the client version too (git without version
> appendix is the current next (028cfcba78c3e4).
>
> 583b7ea31b7c16~1 (last good):
> $ git clone git://host:9419/foo
> $ git1.3.2 clone git://host:9419/foo.git
> (cloned successfully, both no output)
>
> 583b7ea31b7c16 (first bad):
> $ git clone git://host:9420/foo
> Generating pack...
> Done counting 6 objects.
> Deltifying 6 objects.
>  100% (6/6) done
>  Total 6, written 6 (delta 0), reused 0 (delta 0)
> $ git1.3.2 clone git://host:9420/foo.git
> fatal: cannot mmap packfile '/somewhere/foo/.git/objects/pack/tmp-VX82qz': Invalid argument
> error: git-fetch-pack: unable to read from git-index-pack
> error: git-index-pack died with error code 128
> fetch-pack from 'git://host:9420/foo.git' failed.
> [1]    13267 exit 1     git1.3.2 clone git://host:9420/foo.git
> (/somewhere is the cwd on the client)
>
> I tried to find which part of the patch caused the problem and came
> out with the patch below.  With this I can clone with git1.3.2 again
> but then git 1.4.x does not show any statistics about packing, its
> just a starting point to look at.  Perhaps someone has an idea why
> this happens.  I've got to sleep now :)
>
> ---
>  upload-pack.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index 7b86f69..94f0d85 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -249,7 +249,7 @@ static void create_pack_file(void)
>  				sz = read(pe_pipe[0], progress,
>  					  sizeof(progress));
>  				if (0 < sz)
> -					send_client_data(2, progress, sz);
> +					write(2, progress, sz);
>  				else if (sz == 0) {
>  					close(pe_pipe[0]);
>  					pe_pipe[0] = -1;

This breaks the newer clients that knows how to do side-band
doesn't it?
