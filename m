From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Porting git to HP NonStop
Date: Fri, 10 Aug 2012 17:04:06 +0200
Message-ID: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <rsbecker@nexbridge.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 17:04:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szqla-0003sO-5p
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 17:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759205Ab2HJPEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 11:04:40 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:60948 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758269Ab2HJPEj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 11:04:39 -0400
Received: from DualCore (dsdf-4db5242c.pool.mediaWays.net [77.181.36.44])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MCTBN-1Sqk4X2Wyf-0098V0; Fri, 10 Aug 2012 17:04:16 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac13CUAtWb1d+Z55SJq6mW4i9g8D5Q==
Content-Language: de
X-Provags-ID: V02:K0:ZTroTMyR6JQoApkrbgwuCPSKlvwNDrxx05s8aa29MYs
 INrqTneAbjAtUeIhCVDgiuYXrn5dQhyMUxZ1VMnLFL3LfG88b8
 whHPf7DGYhIh7lwuxzmWO+vrxbHo3KA0lAx4qVD2IQrbuuu/kn
 NqzpLFvfJ0WLY21j01HgLVwxir4v6+WgrlLM2ZW0asFY++Duf6
 KDYTY0PjRVJxcW05Sk51S7qZhls9B9jhkrQ9ow9GM/yQi26dZh
 gJWz8ZRjEkmlRORSt/B1F8qNSDLWq4HUkB66OzVsbytJV91st8
 SYQ8SKOAga09Q2Vo8Jx81F6CnHCZdaCMzNb4/evbLWeQVLbccS
 0/lKOiAUs++ZYPrTbyNsUkSuFcGhWlDcGpvmuk0rD28EXPdUgu
 jBypu6Lq0y1Jg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203223>

> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Joachim Schmitz
> Sent: Friday, August 10, 2012 5:01 PM
> To: git@vger.kernel.org
> Cc: rsbecker@nexbridge.com
> Subject: RE: [PATCH v2] add tests for 'git rebase --keep-empty'
> 
> Hi folks
> 
> I'm a brand new subscriper of this mailing list, so please forgive if I
violate
> some protocol or talk about things that had been discussed to death
earlier.

Ahrgl, 1st mistake: wrong subject, sorry

> I'm currently in the process of porting git (1.7.11.4 for now) to the HP
NonStop
> platform and found several issues:
> 
> - HP NonStop is lacking poll(), git is making quite some use of it.
> My Solution: I 'stole' the implementation from GNUlib, which implements
> poll() using select().
> Git should either provide its own poll(), not use it at all or resort to
using
> GNUlib, what do you think?.
> 
> - HP NonStop is lacking getrlimit(), fsync(), setitimer() and memory
mapped IO.
> For now I've commented out the part that used getrlimit() and use a home
> brewed implementation for fsync(), setitimer() and mmap().
> 
> - git makes use of some C99 features or at least feature that are not
availabe in
> C89, like 'inline'
> C89 is the default compiler on HP NonStop, but we also habe a c99
compiler, so
> telling configure to search for c99  should help here.
> 
> - libintl and libiconv sem to get linked in the wrong order, resulting in
> unresolved symbols.
> I've just moved the "ifndef NO_GETTEXT" section of Makefile to above the
> "ifdef NEEDS_LIBICONF" section.
> 
> - HP NonStop doesn't have stat.st_blocks, this is used in
builtin/count-objects.c
> around line 45, not sure yet how to fix that.
> 
> - HP NonStop doesn't have stat.st_?time.nsec, there are several places
what an
> "#ifdef USE_NSEC" is missing, I can provide a diff if needed (offending
> files: builtin/fetch-pack.c and read-cache.c).
> 
> - HP NonStop doesn't know SA_RESTART
> I fixed that with a "#define SA_RESTART 0" in the 3 files affected
(builtin/log.c,
> fast-import.c and progress.c)
> 
> - using C99 but not using #include <strings.h> results in compiler errors
due to
> a missing prototype for strcasecmp() I fixed it by adding that to
git-compat-
> util.h
> 
> - HP NonStop doesn't have intptr_t and uintpr_t (in its stdint.h) I added
them to
> git-compat-util.h
> 
> - HP NonStop doesn't need the " #define _XOPEN_SOURCE 600", just like
> __APPLE__, __FreeBSD__ etc, so I added a "&& !defined(__TANDEM) in git-
> compat-util.h
> 
> - there seems to be an issue with compat/fnmatch/fnmatch.c not including
> string.h, seems that HAVE_STRING_H is not #define'd anywhere.
> 
> 
> - Once compiled and installed, a simple jojo@\hpitug:/home/jojo/GitHub $
git
> clone git://github.com/git/git.git fails with:
> /home/jojo/GitHub/git/.git/branches/: No such file or directory After
creating
> those manually it fails because the directory isn't empty,
> catch-22
> After some trial'n'error I found that the culprit seems to be the
subdirectories
> branches, hook and info in /usr/local/share/git-core/templates/, if I
> remove/rename those, the above command works fine.
> I have no idea why that is nor how to properly fix it, anyone out there?
> 
> Bye, Jojo
