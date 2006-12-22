From: Junio C Hamano <junkio@cox.net>
Subject: Re: newbie question - git-pull and local branch merge
Date: Fri, 22 Dec 2006 12:43:16 -0800
Message-ID: <7vwt4jy84b.fsf@assigned-by-dhcp.cox.net>
References: <6bb9c1030612220227h2dc83a78u2e31e0f4e6801412@mail.gmail.com>
	<7vejqs1a3r.fsf@assigned-by-dhcp.cox.net>
	<6bb9c1030612220326w6ce88d0ar1ca5ca49b306c71e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 21:43:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxrEf-0007ip-3Z
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 21:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbWLVUnS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 15:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752647AbWLVUnS
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 15:43:18 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:45141 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752646AbWLVUnR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 15:43:17 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222204316.FGAL9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 15:43:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1wia1W0051kojtg0000000; Fri, 22 Dec 2006 15:42:34 -0500
To: "Pelle Svensson" <pelle2004@gmail.com>
In-Reply-To: <6bb9c1030612220326w6ce88d0ar1ca5ca49b306c71e@mail.gmail.com>
	(Pelle Svensson's message of "Fri, 22 Dec 2006 12:26:50 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35213>

"Pelle Svensson" <pelle2004@gmail.com> writes:

> Problem is that git-pull failed to merge closed to what you describe in case 2
> and I really like to know hat has been done between the 2 last versions
> on the Linus side.

Let me have a set of illustrations (I cannot think without one
X-<).  You forked off of Linus's tip some time ago (time flows
from left to right):

      x---x---x---x Pelle
     /
 ---o Linus

in the meantime Linus's tip progressed:

      x---x---x---x   Pelle
     /
 ---o---*---*---*---* Linus

and you are trying to create a merge 'M' by pulling from him:


      x---x---x---x...M    Pelle
     /               / 
 ---o---*---*---*---*      Linus

The 'pull' conflicted so you do not have 'M' commit yet.

In such a situation, a command that helps to view what happened
to the files that got conflicted is:

	$ git log -p --merge

By default it uses the "unmreged" files (in your case,
arch/arm/mach-ep93xx/core.c and include/asm-arm/system.h).  You
can limit the output by giving specific paths:

	$ git log -p --merge include/asm-arm/system.h

This would show changes from both sides (i.e. commits marked
with 'x' and '*').

> The problematic file is include/asm-arm/system.h
>
> I attached some output below. Last (D) is a file diff between the time when
> I first pulled the Linus tree and a copy of that which I'm now working in.
> I think the resolve/edit part is easy because Linus tree seem to added
> an extern declaration of 'adjust_cr' closed to line 152 and the other
> conflict code (++<<<...) should be removed.

> But is it not possible to show changes/diff version by version of
> what has been done in the Linus tree?

I think "log --merge" is what you want, but if you do not want
to see your own changes, you can:

	$ git log -p ..MERGE_HEAD -- include/asm-arm/system.h

The notation "..MERGE_HEAD" in the above is a short-hand for
"HEAD..MERGE_HEAD", and "A..B" means "show commits reachable
from B but I am not interested in the ones reachable from A", so
it shows what are in MERGE_HEAD but not in your HEAD, which I
think is exactly what you want.  And paths on the command line
limits the commits considered by the command to only those that
touch the specified paths.

> A. git-status output
> B. git-diff output
> C. And if I do git-pull again
> D. diff output between file stamp 12-dec and 21-dec
>
> A. git-status output
> ============
>
> # On branch refs/heads/ep93xx-pmp
> #
> # Updated but not checked in:
> #   (will commit)
> #
> #	modified: Documentation/block/biodoc.txt
> #     ...
> #	modified: sound/usb/usbaudio.c

These are list of paths that got changed on Linus's side and
either you did not change at all, or had changes that were
cleanly merged.

> #
> #
> # Changed but not updated:
> #   (use git-update-index to mark for commit)
> #
> #	unmerged: arch/arm/mach-ep93xx/core.c
> #	modified: arch/arm/mach-ep93xx/ep93xx_devices.c
> #	modified: drivers/net/arm/ep93xx_eth.c
> #	modified: drivers/video/ep93xxfb.c
> #	unmerged: include/asm-arm/system.h
> #	modified: include/asm-arm/system.h

I thought you had local modification to two paths, but this
shows four 'modified:' files.  Please make sure these four
'modified' files were not modified on the Linus's side
(e.g. "git log -p ..MERGE_HEAD -- drivers/video/ep93xxfb.c" as
shown above), and only contains your own changes.

Two 'unmerged' paths are what you changed and committed in some
of the 'x' commits in the above picture and also had
modifications on Linus's side.

> B. git-diff output
> ==========
>
> diff --cc include/asm-arm/system.h
> index 04d6d2c,aa223fc..0000000
> --- a/include/asm-arm/system.h
> +++ b/include/asm-arm/system.h
> @@@ -170,31 -178,6 +178,34 @@@
>  	  : : "r" (val) : "cc");
>  }
>
> ++<<<<<<< HEAD/include/asm-arm/system.h
> +extern unsigned long cr_no_alignment;	/* defined in entry-armv.S */
> +extern unsigned long cr_alignment;	/* defined in entry-armv.S */
> ...

You added this section and Linus's side did not have it.

> ...
> +	raw_local_irq_restore(flags);
> +}
> +#endif
> +
> ++=======
> ++>>>>>>> 9bfb18392ef586467277fa25d8f3a7a93611f6df/include/asm-arm/system.h
>  #define UDBG_UNDEFINED	(1 << 0)
>  #define UDBG_SYSCALL	(1 << 1)
>  #define UDBG_BADABORT	(1 << 2)

So as you said, it seems appropriate to just keep your changes.
by removing the conflict markers.

> C. And if I do git-pull again
> =================
>
> Trying really trivial in-index merge...
> arch/arm/mach-ep93xx/core.c: needs merge
> arch/arm/mach-ep93xx/ep93xx_devices.c: needs update
> drivers/net/arm/ep93xx_eth.c: needs update
> drivers/video/ep93xxfb.c: needs update
> include/asm-arm/system.h: needs merge
> Nope.
> Merging HEAD with 3e67c0987d7567ad666641164a153dca9a43b11d
> Merging:
> 87d627b097b52c47610037bfb890940752fbf4c8 added .orig to gitignore
> 3e67c0987d7567ad666641164a153dca9a43b11d [PATCH] truncate: clear page
> dirtiness before running try_to_free_buffers()
> found 1 common ancestor(s):
> f238085415c56618e042252894f2fcc971add645 Merge branch 'for-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid

Was this the end of the output?  I hope you hit this message:

	die("Entry '%s' not uptodate. Cannot merge.", ce->name);

and the second pull did not make any change.  At least that is
how it ought to work.  You might have spotted a bug that was
uncovered only because no git old timers would even imagine
running 'pull' again after getting conflicts from the first
attempt, but I suspect that the above quoted output is not
showing the end of the output.
