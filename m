From: Junio C Hamano <junkio@cox.net>
Subject: Re: Slow fetches of tags
Date: Wed, 24 May 2006 11:41:26 -0700
Message-ID: <7vslmz6zah.fsf@assigned-by-dhcp.cox.net>
References: <20060524131022.GA11449@linux-mips.org>
	<Pine.LNX.4.64.0605240931480.5623@g5.osdl.org>
	<20060524180813.GA32519@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 20:41:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiyIb-00021W-1v
	for gcvg-git@gmane.org; Wed, 24 May 2006 20:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWEXSl2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 14:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWEXSl2
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 14:41:28 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:12225 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932381AbWEXSl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 14:41:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060524184127.SXMO19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 24 May 2006 14:41:27 -0400
To: Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <20060524180813.GA32519@linux-mips.org> (Ralf Baechle's message
	of "Wed, 24 May 2006 19:08:13 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20698>

Ralf Baechle <ralf@linux-mips.org> writes:

>> Or is it just the "git-ls-remote" that takes forever?
>
> git-ls-remote git://www.kernel.org/pub/scm/linux/kernel/git/stable/\
> linux-2.6.16.y takes about 1.5s.

Good; that is as expected.  ls-remote over git protocol just
gets the initial "have" lines from the upload-pack and exits,
and there is no handshaking.

> Another funny thing I noticed in top is that the git-fetch-pack arguments
> got overwritten:
>
> $ cat /proc/1702/cmdline | tr '\0' ' '
> git-fetch-pack --thin git //www.kernel.org pub/scm/linux/kernel/git/stable/linux-2.6.16.y.git  efs/heads/master  efs/tags/v2.6.16.18
>
> Guess that doesn't matter.

This is also expected - fetch-pack (connect.c::path_match(), actually) 
smudges the list of refs to remember which ones the caller asked
are going to be fulfilled and which ones are not.  Not the most
beautiful part of the code ;-).

> Guess that doesn't matter.  Anyway, so I ran strace on this git-fetch-pack
> invocation:
>
> [...]
> munmap(0xb7fe5000, 229)                 = 0
> getdents(5, /* 0 entries */, 4096)      = 0
> close(5)                                = 0
> getdents(4, /* 0 entries */, 4096)      = 0
> close(4)                                = 0
> write(3, "0046want 9b549d8e1e2f16cffbb414a"..., 70) = 70
> write(3, "0000", 4)                     = 4
> write(3, "0032have 0bcf7932d0ea742e765a40b"..., 50) = 50
> write(3, "0032have 54e938a80873e85f9c02ab4"..., 50) = 50
> write(3, "0032have 2d0a9369c540519bab8018e"..., 50) = 50
> write(3, "0032have bf3060065ef9f0a8274fc32"..., 50) = 50
> write(3, "0032have 27602bd8de8456ac619b77c"..., 50) = 50
> [... another 42,000+ similar lines chopped off ...]
>
> 9b549d8e1e2f16cffbb414a is Chris Wright's tag for v2.6.16.18.  So far,
> as expected.
>
> And this is where things are getting interesting:
>
> $ git-name-rev 0bcf7932d0ea742e765a40b
> 0bcf7932d0ea742e765a40b master
> $ git-name-rev 54e938a80873e85f9c02ab4
> 54e938a80873e85f9c02ab4 34k-2.6.16.18
> $ git-name-rev 2d0a9369c540519bab8018e
> 2d0a9369c540519bab8018e 34k-2.6.16.18~1
> $ git-name-rev bf3060065ef9f0a8274fc32
> bf3060065ef9f0a8274fc32 34k-2.6.16.18~2
> $ git-name-rev 27602bd8de8456ac619b77c
> 27602bd8de8456ac619b77c 34k-2.6.16.18~3
>
> It's sending every object back to the start of history ...

Is this "master" commit 0bcf79 part of v2.6.16.18 history?  If
not, how diverged are you?  That is, what does this command tell
you?

	git rev-list b7d0617..master | wc -l

Here, b7d0617 is the name of the commit object that is pointed
by v2.6.16.18 tag.
