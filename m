From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: [PATCH] Reintroduce svn pools to solve the memory leak.
Date: Mon, 27 Mar 2006 13:26:01 +0200
Message-ID: <8aa486160603270326i3a8ddcfau61ca84cdac036ff9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 27 13:26:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNprT-0003b5-3T
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 13:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWC0L0E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 27 Mar 2006 06:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWC0L0E
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 06:26:04 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:41814 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750900AbWC0L0C convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 06:26:02 -0500
Received: by xproxy.gmail.com with SMTP id t10so835469wxc
        for <git@vger.kernel.org>; Mon, 27 Mar 2006 03:26:01 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OyO2/umS48zmFRlSy1v5t+bvky+Le2CpexUOSQxZum7nOUaHJEr7sXWmQxLq4oy9jpzThxeERR5doxMt9XhXhCagWq2/G+XfJp9W0agz9h+DOKaXemqSEmEZ2e6qvfbfdk2Y8YkdbWIhn2TZWDLRmE7W+tn+Li39py8epdskbZQ=
Received: by 10.70.16.15 with SMTP id 15mr3733520wxp;
        Mon, 27 Mar 2006 03:26:01 -0800 (PST)
Received: by 10.70.46.19 with HTTP; Mon, 27 Mar 2006 03:26:01 -0800 (PST)
To: "Jan-Benedict Glaw" <jbglaw@lug-owl.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18080>

On 3/24/06, Santi B=E9jar <sbejar@gmail.com> wrote:
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
> Author: Karl  Hasselstr=F6m <kha@treskal.com>
> Date:   Sun Feb 26 06:11:27 2006 +0100
>
>     svnimport: Convert executable flag
>
>     Convert the svn:executable property to file mode 755 when convert=
ing
>     an SVN repository to GIT.
>
>     Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>
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

Signed-off-by: Santi B=E9jar <sbejar@gmail.com>
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
