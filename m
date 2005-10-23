From: Junio C Hamano <junkio@cox.net>
Subject: Re: User-relative paths
Date: Sun, 23 Oct 2005 12:56:11 -0700
Message-ID: <7v1x2cyplw.fsf@assigned-by-dhcp.cox.net>
References: <435ABB99.5020908@op5.se>
	<7vll0l6pn7.fsf@assigned-by-dhcp.cox.net> <435B5AE0.1060400@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 23 21:57:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETlx2-0006v4-IJ
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 21:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVJWT4O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 15:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVJWT4O
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 15:56:14 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:59272 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750727AbVJWT4N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2005 15:56:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051023195544.VADC29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Oct 2005 15:55:44 -0400
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10504>

Andreas Ericsson <ae@op5.se> writes:

> Junio C Hamano wrote:
>> Andreas Ericsson <ae@op5.se> writes:
>> ...
>> At one point, Linus posted an outline of "restricted login shell
>> for use with git over ssh".  I think you could start from there,
>> perhaps extend it so that it checks the binaries *and* pathnames
>> the user can specify (e.g. only under your own $HOME is allowed,
>> and no /../ in them, or something silly like that).
>>
>
> I found this in the archives:
> http://article.gmane.org/gmane.comp.version-control.git/5784/match=restricted+login
>
> Is that what you're referring to?

No, it is this one:

    http://marc.theaimsgroup.com/?l=git&m=112681457828137&w=2

But it is orthogonal to what you are doing in this patch.

> Let me know if you want things done differently.

I think srvside_chdir() should not do the userdir expansion
under --strict (otherwise you would need a matching change in
daemon.c as well, but I would rather not).

The --strict flag in upload-pack is to make sure git-daemon can
see what is being accessed and make its policy decision even
before it calls upload-pack.  In a pathological case, somebody
can create a directory "/~foo/bar/.git", where the "/~foo"
directory is different from "/home/foo", and have git-daemon
check that the former is OK and call your upload-pack.  Your
upload-pack uses srvside_chdir() and exposes /home/foo/bar/.git;
this circumvents git-daemon's policy decision, doesn't it?

I also agree with everything Pasky already said.

 * In a URL, a colon after hostname means "port number
   follows".  So it was a good intention to make these
   consistent:

        git fetch ssh://kernel.org:git
        git fetch kernel.org:git

   it should not be done.  IOW, if I wanted to use the former
   form (which I do not think I'd use myself), I should say either one
   of:

        git fetch ssh://kernel.org:~/git
        git fetch ssh://kernel.org:~junio/git

   Oh, I just noticed you do not handle the former, because you
   did not have to, but now you need to.

 * Use of "extern const char *__progname" is questionable.  I
   could be easily talked into:

    - have "extern const char *git_program_name" in cache.h or
      somewhere;

    - convert programs (gradually) to set that at the beginning
      of main();

    - update die() and error() to use that variable when
      reporting (both callers and implementation) -- this is
      optional.
