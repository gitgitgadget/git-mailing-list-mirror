From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v2] add tests for 'git rebase --keep-empty'
Date: Fri, 10 Aug 2012 17:01:09 +0200
Message-ID: <003901cd7708$fa482c10$eed88430$@schmitz-digital.de>
References: <1344444498-29328-1-git-send-email-martin.von.zweigbergk@gmail.com> <1344526791-13539-1-git-send-email-martin.von.zweigbergk@gmail.com> <20120810132608.GA29609@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 17:01:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szqih-0007Mr-VV
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 17:01:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758927Ab2HJPBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 11:01:43 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:55509 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758269Ab2HJPBm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 11:01:42 -0400
Received: from DualCore (dsdf-4db5242c.pool.mediaWays.net [77.181.36.44])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MPKs8-1T4GZ60itE-00534u; Fri, 10 Aug 2012 17:01:20 +0200
In-Reply-To: <20120810132608.GA29609@hmsreliant.think-freely.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJHr2cA9VHKYTIzC/tsBXVJAGXt/AGsh1lhAh0jVpGWQFRNQA==
Content-Language: de
X-Provags-ID: V02:K0:b8c4k0hmln1MP5k5fJdbB8y8mZPmu7fltm7CESceGAx
 +CPIauLEDjmyiVATeHhMSVlCrvsBIomxtNknDH/BFlapsy9byW
 J4FmjlUmCYo+jt3tokgclO/D8JSaE63RexObFnXopmdavw/Hrx
 5rVruMJRHVmQIaXZIUPZwP9hwnE+w8MYaALf4RtWu5MNGOQrAY
 gYw0dwb6hxIkhzfhFZwGLrGpE1gjygCeBG149kkFed+QSE3qZ+
 Pvecp8acA2+l0swFyapztPBnpN+kWcP8OrZr9p9y/HW27HcRP8
 OP+soGUhYO3ZILpxi1OJ3jdTT4QkIVN52oLPjfnJg9x17rVNLH
 S/rotz7nSe/9W0Yo5nPyCkOyRmrTuNp1mq9xTjgnXV+w9z4PCE
 CKk8BrxMaF6YA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203222>

Hi folks

I'm a brand new subscriper of this mailing list, so please forgive if I
violate some protocol or talk about things that had been discussed to death
earlier.

I'm currently in the process of porting git (1.7.11.4 for now) to the HP
NonStop platform and found several issues:

- HP NonStop is lacking poll(), git is making quite some use of it.
My Solution: I 'stole' the implementation from GNUlib, which implements
poll() using select().
Git should either provide its own poll(), not use it at all or resort to
using GNUlib, what do you think?.

- HP NonStop is lacking getrlimit(), fsync(), setitimer() and memory mapped
IO.
For now I've commented out the part that used getrlimit() and use a home
brewed implementation for fsync(), setitimer() and mmap().

- git makes use of some C99 features or at least feature that are not
availabe in C89, like 'inline'
C89 is the default compiler on HP NonStop, but we also habe a c99 compiler,
so telling configure to search for c99  should help here.

- libintl and libiconv sem to get linked in the wrong order, resulting in
unresolved symbols.
I've just moved the "ifndef NO_GETTEXT" section of Makefile to above the
"ifdef NEEDS_LIBICONF" section.

- HP NonStop doesn't have stat.st_blocks, this is used in
builtin/count-objects.c around line 45, not sure yet how to fix that.

- HP NonStop doesn't have stat.st_?time.nsec, there are several places what
an "#ifdef USE_NSEC" is missing, I can provide a diff if needed (offending
files: builtin/fetch-pack.c and read-cache.c). 

- HP NonStop doesn't know SA_RESTART
I fixed that with a "#define SA_RESTART 0" in the 3 files affected
(builtin/log.c, fast-import.c and progress.c)

- using C99 but not using #include <strings.h> results in compiler errors
due to a missing prototype for strcasecmp()
I fixed it by adding that to git-compat-util.h

- HP NonStop doesn't have intptr_t and uintpr_t (in its stdint.h)
I added them to git-compat-util.h

- HP NonStop doesn't need the " #define _XOPEN_SOURCE 600", just like
__APPLE__, __FreeBSD__ etc, so I added a "&& !defined(__TANDEM) in
git-compat-util.h

- there seems to be an issue with compat/fnmatch/fnmatch.c not including
string.h, seems that HAVE_STRING_H is not #define'd anywhere.


- Once compiled and installed, a simple 
jojo@\hpitug:/home/jojo/GitHub $ git clone git://github.com/git/git.git
fails with:
/home/jojo/GitHub/git/.git/branches/: No such file or directory
After creating those manually it fails because the directory isn't empty,
catch-22
After some trial'n'error I found that the culprit seems to be the
subdirectories branches, hook and info in
/usr/local/share/git-core/templates/, if I remove/rename those, the above
command works fine.
I have no idea why that is nor how to properly fix it, anyone out there?

Bye, Jojo
