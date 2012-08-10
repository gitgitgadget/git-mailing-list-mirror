From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Porting git to HP NonStop
Date: Fri, 10 Aug 2012 19:32:35 +0200
Message-ID: <004701cd771e$21b7cbb0$65276310$@schmitz-digital.de>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de> <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <rsbecker@nexbridge.com>
To: "'Shawn Pearce'" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 19:32:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szt4w-0005u7-8g
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 19:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757597Ab2HJRct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 13:32:49 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:54289 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058Ab2HJRcr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 13:32:47 -0400
Received: from DualCore (dsdf-4db5242c.pool.mediaWays.net [77.181.36.44])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LbTPL-1TSwQH02Zf-00lDDR; Fri, 10 Aug 2012 19:32:46 +0200
In-Reply-To: <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJtb+yK82c1fE/4VXt1krEuodTb9QKmN7Eflf4hv7A=
Content-Language: de
X-Provags-ID: V02:K0:GPbKfO9Sh0AspqrURFpjYw4ugH3e1MXNvG0QlnodOLY
 g1WKS9TDicywfUwWPQL+JNxjRv8pyB2SQivFULR+pCMPUANGka
 jiVBPzOZqVO3rxh3K2UemxNBj6juPI4XaQH422hXGzk64MQQDS
 DYVHwidusHo4ImOi5DwQwOSzwAsP1vhf3m0AX1HltdQ7Fj3Mmi
 z10XyTLfQ5hL45z8JFV0jdokqK2eHPR+SYvU3n2M6rfWG69eME
 DpaQ9k/GG+nfKpXlu4dad7Zlbf2PeN5SkaNXEp+FuGFIt+0lPO
 lGYN5RbBY9roAbzzC9Stg5B/mPLmC1PI9qjHbq0tufhHwpRbih
 jyuaNlfbHeIZfNQXolWh5Pl4GDDc12CI2iIwPt6E5kddxKKz26
 YfhgWOUa4k2VQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203236>

> From: Shawn Pearce [mailto:spearce@spearce.org]
> Sent: Friday, August 10, 2012 6:28 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org; rsbecker@nexbridge.com
> Subject: Re: Porting git to HP NonStop
> 
> On Fri, Aug 10, 2012 at 8:04 AM, Joachim Schmitz <jojo@schmitz-digital.de>
> wrote:
> >>
> >> - HP NonStop is lacking poll(), git is making quite some use of it.
> >> My Solution: I 'stole' the implementation from GNUlib, which
> >> implements
> >> poll() using select().
> >> Git should either provide its own poll(), not use it at all or resort
> >> to
> > using
> >> GNUlib, what do you think?.
> 
> poll() is usually better than select() because you don't need to worry
about
> FD_SETSIZE. That said, the compat/ directory contains implementations of
> some functions. You could contribute a fake poll that uses select if it
was under
> the GPLv2.

This is what I did. Just to see now that compat/win32/poll.c has exacly the
same stuff...
 
> >> - HP NonStop is lacking getrlimit(), fsync(), setitimer() and memory
> > mapped IO.
> >> For now I've commented out the part that used getrlimit() and use a
> >> home brewed implementation for fsync(), setitimer() and mmap().
> 
> There is no need to define your own mmap(). Define NO_MMAP=1 in the
> Makefile. Git already has its own fake mmap and knows how to write it back
to
> disk when making changes.

Ah, excellent. Esp. as our home brewed implementation is pretty primitive.

> >> - git makes use of some C99 features or at least feature that are not
> > availabe in
> >> C89, like 'inline'
> >> C89 is the default compiler on HP NonStop, but we also habe a c99
> > compiler, so
> >> telling configure to search for c99  should help here.
> 
> You could also disable inline by #define inline /**/, but this will
probably result
> in a slower binary.

Even our C99 compiler doesn't inline, it merly recognizes the keyword and
then warns about (unable to inline...)
But there are other C99 features used too.

> >> - HP NonStop doesn't have stat.st_blocks, this is used in
> > builtin/count-objects.c
> >> around line 45, not sure yet how to fix that.
> 
> IIRC the block count is only used to give the user some notion of how much
disk
> was wasted by the repository. You could hack a macro that redefines this
as
> st_size.

OK, thanks, will try that.

> >> - HP NonStop doesn't have stat.st_?time.nsec, there are several
> >> places
> > what an
> >> "#ifdef USE_NSEC" is missing, I can provide a diff if needed
> >> (offending
> >> files: builtin/fetch-pack.c and read-cache.c).
> 
> I think this would be appreciated by anyone else that has a similar
problem
> where the platform lacks nsec.

Will do.
 
> >> - Once compiled and installed, a simple
> >> jojo@\hpitug:/home/jojo/GitHub $
> > git
> >> clone git://github.com/git/git.git fails with:
> >> /home/jojo/GitHub/git/.git/branches/: No such file or directory After
> > creating
> >> those manually it fails because the directory isn't empty,
> >> catch-22
> >> After some trial'n'error I found that the culprit seems to be the
> > subdirectories
> >> branches, hook and info in /usr/local/share/git-core/templates/, if I
> >> remove/rename those, the above command works fine.
> >> I have no idea why that is nor how to properly fix it, anyone out
there?
> 
> This sounds like the templates directory was not created correctly during
> installation, or is being copied incorrectly during the git init process.
I would
> start by comparing the structure and permissions of the templates
directory on
> your HP NonStop system to one on a Linux system and see if there was a
> mistake made during the installation process. If the directory matches, I
would

jojo@\hpitug:/usr/local/share/git-core/templates $ ls -laR
total 41
drwxr-xr-x    1 SUPER.SUPER        SUPER       4096 Aug 10 12:10 .
drwxr-xr-x    1 SUPER.SUPER        SUPER       4096 Aug 10 08:19 ..
drwxr-xr-x    1 SUPER.SUPER        SUPER       4096 Aug 10 07:26 branches
drwxr-xr-x    1 SUPER.SUPER        SUPER       4096 Aug 10 07:26 hooks
drwxr-xr-x    1 SUPER.SUPER        SUPER       4096 Aug 10 07:26 info
-rw-r--r--    1 SUPER.SUPER        SUPER         73 Aug 10 07:26 description

./branches:
total 16
drwxr-xr-x    1 SUPER.SUPER        SUPER       4096 Aug 10 07:26 .
drwxr-xr-x    1 SUPER.SUPER        SUPER       4096 Aug 10 12:10 ..

./hooks:
total 43
drwxr-xr-x    1 SUPER.SUPER        SUPER       4096 Aug 10 07:26 .
drwxr-xr-x    1 SUPER.SUPER        SUPER       4096 Aug 10 12:10 ..
-rwxr-xr-x    1 SUPER.SUPER        SUPER        452 Aug 10 07:26
applypatch-msg.sample
-rwxr-xr-x    1 SUPER.SUPER        SUPER        896 Aug 10 07:26
commit-msg.sample
-rwxr-xr-x    1 SUPER.SUPER        SUPER        189 Aug 10 07:26
post-update.sample
-rwxr-xr-x    1 SUPER.SUPER        SUPER        398 Aug 10 07:26
pre-applypatch.sample
-rwxr-xr-x    1 SUPER.SUPER        SUPER       1704 Aug 10 07:26
pre-commit.sample
-rwxr-xr-x    1 SUPER.SUPER        SUPER       4957 Aug 10 07:26
pre-rebase.sample
-rwxr-xr-x    1 SUPER.SUPER        SUPER       1251 Aug 10 07:26
prepare-commit-msg.sample
-rwxr-xr-x    1 SUPER.SUPER        SUPER       3611 Aug 10 07:26
update.sample

./info:
total 17
drwxr-xr-x    1 SUPER.SUPER        SUPER       4096 Aug 10 07:26 .
drwxr-xr-x    1 SUPER.SUPER        SUPER       4096 Aug 10 12:10 ..
-rw-r--r--    1 SUPER.SUPER        SUPER        240 Aug 10 07:26 exclude
jojo@\hpitug:/usr/local/share/git-core/templates $

SUPER.SUPER on NonStop is equivalent to root in UNIX. Everything is readable
to everybody. Looks OK to me?

> then use `git init --bare` in a new directory to copy in the templates,
and see if
> its the template copying code that is making an incorrect copy.

"git init --bare" gives the same error. It isn't copying any of the
subdirectories, only the file 'description'

Bye, Jojo
