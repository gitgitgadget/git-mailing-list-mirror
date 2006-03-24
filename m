From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Fri, 24 Mar 2006 20:35:19 +0100
Message-ID: <87fyl7k554.fsf@gmail.com>
References: <20060322133337.GU20746@lug-owl.de>
	<20060324182504.GI31387@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 20:32:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMs1C-0007G7-4G
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 20:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWCXTcE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 24 Mar 2006 14:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWCXTcB
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 14:32:01 -0500
Received: from ifae-s0.ifae.es ([192.101.162.68]:45974 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S964801AbWCXTcA (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 14:32:00 -0500
Received: from bela (caronte.ifae.es [192.101.162.199])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k2OJVsF30294;
	Fri, 24 Mar 2006 20:31:55 +0100
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20060324182504.GI31387@lug-owl.de> (Jan-Benedict Glaw's message
	of "Fri, 24 Mar 2006 19:25:04 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17939>

Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:

> On Wed, 2006-03-22 14:33:37 +0100, Jan-Benedict Glaw <jbglaw@lug-owl.=
de> wrote:
>
> Since it seems nobody looked at the GCC import run (which means to us=
e
> the svnimport), I ran it again, under strace control:
>
>> GCC
>> ~~~
>> $ /home/jbglaw/bin/git svnimport -C gcc -v svn://gcc.gnu.org/svn/gcc
>
>> Committed change 3936:/ 1993-03-31 05:44:03)
>> Commit ID ceff85145f8671fb2a9d826a761cedc2a507bd1e
>> Writing to refs/heads/origin
>> DONE: 3936 origin ceff85145f8671fb2a9d826a761cedc2a507bd1e
>> ... 3937 trunk/gcc/final.c ...
>> Can't fork at /home/jbglaw/bin/git-svnimport line 379.
>

I have the same (?) problem with one of my svn repository. It worked
before (I've redone the import with the -r flag), so I bisected it.
The problematic commit seems to be:

diff-tree 4802426... (from 525c0d7...)
Author: Karl  Hasselstr=C3=B6m <kha@treskal.com>
Date:   Sun Feb 26 06:11:27 2006 +0100

    svnimport: Convert executable flag

    Convert the svn:executable property to file mode 755 when convertin=
g
    an SVN repository to GIT.

    Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
    Signed-off-by: Junio C Hamano <junkio@cox.net>

:100755 100755 ee2940f... 6603b96... M  git-svnimport.perl

I think it has a memory leak, it used up to 140m of memory.

$ git reset --hard 4802426^
$ time ../git-svnimport.perl file:///path/
Use of uninitialized value in string eq at ../git-svnimport.perl line 4=
63.
Use of uninitialized value in substitution (s///) at ../git-svnimport.p=
erl line 466.
real    0m55.801s
user    0m30.578s
sys     0m23.084s

$ git reset --hard 4802426
$ time ../git-svnimport.perl file:///path/
Use of uninitialized value in string eq at ../git-svnimport.perl line 4=
63.
Use of uninitialized value in substitution (s///) at ../git-svnimport.p=
erl line 466.
Can't fork at /home/santi/usr/src/scm/git/git-svnimport.perl line 331.
real    6m2.163s
user    0m20.332s
sys     0m50.180s

and it didn't finished. Hope it helps.

Santi
