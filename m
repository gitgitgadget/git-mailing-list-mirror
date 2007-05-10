From: Junio C Hamano <junkio@cox.net>
Subject: Re: git rebase chokes on directory -> symlink -> directory
Date: Wed, 09 May 2007 23:44:57 -0700
Message-ID: <7vmz0dmb2u.fsf@assigned-by-dhcp.cox.net>
References: <463FCD7C.4020009@zytor.com> <20070508215009.GA2670@steel.home>
	<46413565.3090503@zytor.com>
	<81b0412b0705090050i644a18c2g12c74462ab88163a@mail.gmail.com>
	<4641FDAF.3090608@zytor.com> <20070509213902.GA2593@steel.home>
	<46424ECC.6030907@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu May 10 08:45:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm2Oy-0005xr-Lm
	for gcvg-git@gmane.org; Thu, 10 May 2007 08:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758174AbXEJGpA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 02:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758036AbXEJGpA
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 02:45:00 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:60744 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758174AbXEJGo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 02:44:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510064458.XZTF24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 10 May 2007 02:44:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xJkx1W00F1kojtg0000000; Thu, 10 May 2007 02:44:58 -0400
In-Reply-To: <46424ECC.6030907@zytor.com> (H. Peter Anvin's message of "Wed,
	09 May 2007 15:44:28 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46829>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Applying 'Revert "x86-64: Make arch/x86-64/boot a symlink to
> arch/i386/boot"'
>
> Adds trailing whitespace.
> .dotest/patch:117:FDARGS =
> Adds trailing whitespace.
> .dotest/patch:350: * Page 0 is deliberately kept safe, since System
> Management Mode code in
> Adds trailing whitespace.
> .dotest/patch:352: * useful for future device drivers that either access
> the BIOS via VM86
> Adds trailing whitespace.
> .dotest/patch:648: *
> Adds trailing whitespace.
> .dotest/patch:649: * This is a collection of several routines from
> gzip-1.0.3
> error: arch/x86_64/boot/.gitignore: already exists in working directory
> error: arch/x86_64/boot/Makefile: already exists in working directory
> error: arch/x86_64/boot/compressed/Makefile: already exists in working
> directory
> error: arch/x86_64/boot/compressed/head.S: already exists in working
> directory
> error: arch/x86_64/boot/compressed/misc.c: already exists in working
> directory
> error: arch/x86_64/boot/compressed/vmlinux.lds: already exists in
> working directory
> error: arch/x86_64/boot/compressed/vmlinux.scr: already exists in
> working directory
> error: arch/x86_64/boot/install.sh: already exists in working directory
> error: arch/x86_64/boot/mtools.conf.in: already exists in working directory
> error: arch/x86_64/boot/tools/.gitignore: already exists in working
> directory
> error: arch/x86_64/boot/tools/build.c: already exists in working directory

Ahh.

 * The tree state before this patch is applied has arch/x86_64/boot
   as a symlink pointing at ../i386/boot/

 * The patch tries to remove arch/x86_64/boot symlink, and
   create bunch of files there: .gitignore, Makefile, etc.

This is unfortunately a bit deeper than just git-rebase.  You
exposed a nasty corner case problem in the stock git-apply,
probably one of the most important tool the kernel project uses
every day.

git-apply tries to be careful while applying patches; it never
touches the working tree until it is convinced that the patch
would apply cleanly.  One of the check it does is that when it
knows a path is going to be created by the patch (in your
example, arch/x86_64/boot/.gitignore), it runs lstat() on the
path to make sure it does not exist.

This leads to a false alarm.  Because we do not touch the
working tree before all the check passes, when we try to make
sure that arch/x86_64/boot/.gitignore does not exist yet, we
haven't removed the arch/x86_64/boot symlink.  The lstat() check
ends up seeing arch/i386/boot/.gitignore through the
yet-to-be-removed symlink, and says "Hey, you already have a
file there, but what you fed me is a patch to create a new
file. I am not going to clobber what you have in the working
tree."

We have similar checks to see a file we are going to modify does
exist and match the preimage of the diff, which is done by
directly opening and reading the file.

For a file we are going to delete, we make sure that it does
exist and matches what is going to be removed (a removal patch
records the full preimage, so we check what you have in your
working tree matches it in full -- otherwise we would risk
losing your local changes), which again is done by directly
opening and reading the file.

These checks need to be adjusted so that they are not fooled by
symlinks in the middle.

 - To make sure something does not exist, first lstat().  If it
   does not exist, it does not, so be happy.  If it _does_, we
   might be getting fooled by a symlink in the middle, so break
   leading paths and see if there are symlinks involved.  When
   we are checking for a path a/b/c/d, if any of a, a/b, a/b/c
   is a symlink, then a/b/c/d does _NOT_ exist, for the purpose
   of our test.

   This would fix this particular case you saw, and would not
   add extra overhead in the usual case.

 - To make sure something already exists, first lstat().  If it
   does not exist, barf (up to this, we already do).  Even if it
   does seem to exist, we might be getting fooled by a symlink
   in the middle, so make sure leading paths are not symlinks.

   This would make the normal codepath much more expensive for
   deep trees, which is a bit worrisome.

When the code writes out the result after the checks pass, we
first delete all the paths that are going to be deleted, and
also delete all the paths that are being modified.  Then in the
second pass, we create all the paths that are being created and
also modified by writing their final contents out, while
creating leading directories as needed.  Because of this, a
patch that removes a symlink and then makes it a directory to
hold new files would first remove the symlink and then create
the directory at the right location and deposit newly created
files there.  So I do not expect any change is needed in the
writeout codepath.

By the way, I noticed a few things while diagnosing this.

 * It was very considerate of you to leave "rebase-1" branch for
   my postmortem in the repository.  You know what are needed
   for debugging very well.

 * git-rebase with -m is dog slow.  There were people who
   advocated to make it the default, but they probably are
   either working in a very small project, or working on a
   filesystem that even git-apply is slow that the speed
   difference does not matter to them.
