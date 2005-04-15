From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: Re: Re: Re: Remove need to untrack before tracking new branch
Date: Fri, 15 Apr 2005 07:45:14 +0200
Message-ID: <1113543914.23299.151.camel@nosferatu.lan>
References: <20050412132307.GH22614@pasky.ji.cz>
	 <20050413092656.GO16489@pasky.ji.cz>
	 <1113394537.23299.51.camel@nosferatu.lan>
	 <20050413221936.GI25711@pasky.ji.cz>
	 <1113461754.23299.68.camel@nosferatu.lan>
	 <1113467335.23299.77.camel@nosferatu.lan>
	 <1113467905.23299.81.camel@nosferatu.lan>
	 <20050414091106.GX25711@pasky.ji.cz>
	 <1113471609.23299.95.camel@nosferatu.lan>
	 <1113472557.23299.99.camel@nosferatu.lan>
	 <81b0412b0504141535793cc235@mail.gmail.com>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-A4Ts6BnmCKgliukue6QP"
Content-Transfer-Encoding: 8bit
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 07:38:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMJWx-0002hw-71
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 07:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVDOFlg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 01:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVDOFlg
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 01:41:36 -0400
Received: from ctb-mesg3.saix.net ([196.25.240.75]:59134 "EHLO
	ctb-mesg3.saix.net") by vger.kernel.org with ESMTP id S261734AbVDOFla
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 01:41:30 -0400
Received: from gateway.lan (wblv-146-239-208.telkomadsl.co.za [165.146.239.208])
	by ctb-mesg3.saix.net (Postfix) with ESMTP id 17F852152;
	Fri, 15 Apr 2005 07:41:27 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id 719573A26DA;
	Fri, 15 Apr 2005 07:47:33 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14163-15; Fri, 15 Apr 2005 07:47:28 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 2C4323A26DB;
	Fri, 15 Apr 2005 07:47:28 +0200 (SAST)
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0504141535793cc235@mail.gmail.com>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-A4Ts6BnmCKgliukue6QP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-15 at 00:35 +0200, Alex Riesen wrote:
> On 4/14/05, Martin Schlemmer <azarah@nosferatu.za.org> wrote:
> > +               if (update_mode && changed & MODE_CHANGED)
> > +                       chmod(ce->name, ce->st_mode);
>=20
> it's "if ((update_mode && changed) & MODE_CHANGED)"
> Did you really mean that?
>=20

No, '&' have a higher priority (weight?) than '&&'.  Although, yes, it
might be better style to add brackets.

But just to make you happy, let me prove it:

-----
$ cat foo1.c
int main() {
        int foo, bar;

        if (foo && bar & 1)
                return 1;

        return 0;
}
$ cat foo2.c
int main() {
        int foo, bar;

        if (foo && (bar & 1))
                return 1;

        return 0;
}
$ cat foo3.c
int main() {
        int foo, bar;

        if ((foo && bar) & 1)
                return 1;

        return 0;
}
$ gcc -c -S foo1.c -o foo1.S
$ gcc -c -S foo2.c -o foo2.S
$ gcc -c -S foo3.c -o foo3.S
$ diff -u foo1.S foo2.S
--- foo1.S      2005-04-15 07:42:27.000000000 +0200
+++ foo2.S      2005-04-15 07:42:32.000000000 +0200
@@ -1,4 +1,4 @@
-       .file   "foo1.c"
+       .file   "foo2.c"
        .text
 .globl main
        .type   main, @function
$ diff -u foo1.S foo3.S
--- foo1.S      2005-04-15 07:42:27.000000000 +0200
+++ foo3.S      2005-04-15 07:42:35.000000000 +0200
@@ -1,4 +1,4 @@
-       .file   "foo1.c"
+       .file   "foo3.c"
        .text
 .globl main
        .type   main, @function
@@ -9,9 +9,14 @@
        andl    $-16, %esp
        movl    $0, %eax
        subl    %eax, %esp
+       movl    $0, -16(%ebp)
        cmpl    $0, -4(%ebp)
-       je      .L2
-       movl    -8(%ebp), %eax
+       je      .L3
+       cmpl    $0, -8(%ebp)
+       je      .L3
+       movl    $1, -16(%ebp)
+.L3:
+       movl    -16(%ebp), %eax
        andl    $1, %eax
        testl   %eax, %eax
        je      .L2
-----


--=20
Martin Schlemmer


--=-A4Ts6BnmCKgliukue6QP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCX1TqqburzKaJYLYRAum6AKCOYxz2Ub2R28OI9to8nbqgi7HtvQCcC+fk
MQ9/p46krnyVsNNfrFfBOoY=
=cacT
-----END PGP SIGNATURE-----

--=-A4Ts6BnmCKgliukue6QP--

