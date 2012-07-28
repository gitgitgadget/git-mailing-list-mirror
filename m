From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: t1450-fsck (sometimes/often) failes on Mac OS X
Date: Sat, 28 Jul 2012 18:00:52 +0200
Message-ID: <87hasrdgej.fsf@thomas.inf.ethz.ch>
References: <5001644F.10901@web.de> <87y5mkm935.fsf@thomas.inf.ethz.ch>
	<899A52DB-E548-44CD-8624-A715DDB17032@web.de>
	<20120728154320.GA98893@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Torsten B?gershausen <tboegi@web.de>,
	Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Jul 28 18:01:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv9SP-0005K7-0f
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 18:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386Ab2G1QA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 12:00:57 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:16153 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316Ab2G1QA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 12:00:56 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 28 Jul
 2012 18:00:50 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (46.126.8.85) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 28 Jul
 2012 18:00:52 +0200
In-Reply-To: <20120728154320.GA98893@book.hvoigt.net> (Heiko Voigt's message
	of "Sat, 28 Jul 2012 17:43:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202447>

Heiko Voigt <hvoigt@hvoigt.net> writes:

>         if (!git_index_file) {
> -               git_index_file = xmalloc(strlen(git_dir) + 7);
> +               git_index_file = xmalloc(strlen(git_dir) + 7 + 8);
>                 sprintf(git_index_file, "%s/index", git_dir);
>         }
[...]
> -       if (!memcmp(ent->base, objdir, pfxlen)) {
> +       objdirlen = strlen(objdir);
> +       if (!memcmp(ent->base, objdir, pfxlen > objdirlen ? objdirlen : pfxlen)) {
[...]
> Initialized empty Git repository in /Users/hvoigt/Repository/git/t/trash directory.t1450-fsck/another/.git/
> ==42686== Invalid read of size 8
> ==42686==    at 0x100625064: bcmp (in /usr/lib/libSystem.B.dylib)
> ==42686==    by 0x100112846: link_alt_odb_entries (in /Users/hvoigt/Repository/git/t/valgrind/../../git)
> ==42686==    by 0x1001129C0: read_info_alternates (in /Users/hvoigt/Repository/git/t/valgrind/../../git)
[...]
> ==42686==  Address 0x100faca78 is 8 bytes inside a block of size 13 alloc'd
> ==42686==    at 0x10029C679: malloc (vg_replace_malloc.c:266)
> ==42686==    by 0x1001349CD: xmalloc (in /Users/hvoigt/Repository/git/t/valgrind/../../git)
> ==42686==    by 0x1000C23F5: setup_git_env (in /Users/hvoigt/Repository/git/t/valgrind/../../git)

To me that looks just like a false positive.  memcmp (which seems to be
the same as bcmp) can load 8 bytes from an aligned address even if these
are only partially within the block being compared, since an aligned
load can never partially fault (it must all be within the same page).
Valgrind normally substitutes its own routines for memcmp etc. to
correctly handle this, but this does not seem to happen in your case for
some reason.

Then again I am not entirely sure how you could verify that this theory
is correct :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
