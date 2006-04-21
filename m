From: Auke Kok <sofar@foo-projects.org>
Subject: PATCH RESEND: git-svnimport memory leak plug
Date: Fri, 21 Apr 2006 2:12:12 +0000
Message-ID: <19fdff02f87c86575bfb6a4016aea8a4@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Apr 21 04:12:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWl88-0002FP-W4
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 04:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWDUCMQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 20 Apr 2006 22:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbWDUCMQ
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 22:12:16 -0400
Received: from espresso.foo-projects.org ([193.43.91.203]:13540 "EHLO
	espresso.foo-projects.org") by vger.kernel.org with ESMTP
	id S1750729AbWDUCMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 22:12:16 -0400
Received: by espresso.foo-projects.org (Postfix, from userid 25)
	id 2267B1F7089; Fri, 21 Apr 2006 02:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by espresso.foo-projects.org (Postfix) with ESMTP id 053981F7085
	for <git@vger.kernel.org>; Fri, 21 Apr 2006 02:12:13 +0000 (UTC)
To: git@vger.kernel.org
X-Sender: sofar@foo-projects.org
User-Agent: RoundCube Webmail/0.1b
X-Spam-Checker-Version: SpamAssassin 2.64 (2004-01-11) on 
	espresso.foo-projects.org
X-Spam-Level: 
X-Spam-Status: No, hits=0.0 required=5.0 tests=none autolearn=ham version=2.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19013>


I was unable with todays git-svnimport to convert a modest 140mb svn re=
pository to git using svn-git-import. the process would bomb out after =
2000 revisions and I have 20000. It consumed over 1.5gb vm space on my =
1gb machine, and died with a 'cannot fork error'. this also killed my p=
roject server today after I discivered it the wrong way.

The original patch send earlier by Santi Bejar fixes the problem. I inc=
lude the patch again here so it can be merged. my mailer probably will =
nuke it so here's the link to the archive post:

http://marc.theaimsgroup.com/?l=3Dgit&m=3D114345884526971&w=3D2


Please include this patch.

Cheers,

Auke



On 3/24/06, Santi B=C3=A9jar <sbejar@gmail.com> wrote:
> Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:
>
> > On Wed, 2006-03-22 14:33:37 +0100, Jan-Benedict Glaw <jbglaw@lug-ow=
l.de> wrote:
> >
> > Since it seems nobody looked at the GCC import run (which means to =
use
> > the svnimport), I ran it again, under strace control:
> >
> >> GCC
> >> ~~~
> >> $ /home/jbglaw/bin/git svnimport -C gcc -v svn://gcc.gnu.org/svn/g=
cc
> >
> >> Committed change 3936:/ 1993-03-31 05:44:03)
> >> Commit ID ceff85145f8671fb2a9d826a761cedc2a507bd1e
> >> Writing to refs/heads/origin
> >> DONE: 3936 origin ceff85145f8671fb2a9d826a761cedc2a507bd1e
> >> ... 3937 trunk/gcc/final.c ...
> >> Can't fork at /home/jbglaw/bin/git-svnimport line 379.
> >
>
> I have the same (?) problem with one of my svn repository. It worked
> before (I've redone the import with the -r flag), so I bisected it.
> The problematic commit seems to be:
>
> diff-tree 4802426... (from 525c0d7...)
> Author: Karl  Hasselstr=C3=B6m <kha@treskal.com>
> Date:   Sun Feb 26 06:11:27 2006 +0100
>
>     svnimport: Convert executable flag
>
>     Convert the svn:executable property to file mode 755 when convert=
ing
>     an SVN repository to GIT.
>
>     Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
>     Signed-off-by: Junio C Hamano <junkio@cox.net>
>
> :100755 100755 ee2940f... 6603b96... M  git-svnimport.perl
>
> I think it has a memory leak, it used up to 140m of memory.
>
> $ git reset --hard 4802426^
> $ time ../git-svnimport.perl file:///path/
> Use of uninitialized value in string eq at ../git-svnimport.perl line=
 463.
> Use of uninitialized value in substitution (s///) at ../git-svnimport=
=2Eperl line 466.
> real    0m55.801s
> user    0m30.578s
> sys     0m23.084s
>
> $ git reset --hard 4802426
> $ time ../git-svnimport.perl file:///path/
> Use of uninitialized value in string eq at ../git-svnimport.perl line=
 463.
> Use of uninitialized value in substitution (s///) at ../git-svnimport=
=2Eperl line 466.
> Can't fork at /home/santi/usr/src/scm/git/git-svnimport.perl line 331=
=2E
> real    6m2.163s
> user    0m20.332s
> sys     0m50.180s
>
> and it didn't finished. Hope it helps.

And this patch fixes my problems.

---

Introduced in 4802426.

Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 git-svnimport.perl |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-svnimport.perl b/git-svnimport.perl
index 639aa41..f2cf062 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -135,8 +135,10 @@

        print "... $rev $path ...\n" if $opt_v;
        my (undef, $properties);
+       my $pool =3D SVN::Pool->new();
        eval { (undef, $properties)
-                  =3D $self->{'svn'}->get_file($path,$rev,$fh); };
+                  =3D $self->{'svn'}->get_file($path,$rev,$fh,$pool); =
};
+       $pool->clear;
        if($@) {
                return undef if $@ =3D~ /Attempted to get checksum/;
                die $@;
