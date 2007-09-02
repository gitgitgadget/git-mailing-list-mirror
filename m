From: Pierre Habouzit <madcoder@debian.org>
Subject: strbuf API
Date: Mon, 03 Sep 2007 00:42:13 +0200
Message-ID: <20070902224213.GB431@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="A6N2fC+uXW/VQSAv";
	protocol="application/pgp-signature"; micalg=SHA1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 03 00:42:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRy96-0006RO-RV
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 00:42:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734AbXIBWmR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 18:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754683AbXIBWmQ
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 18:42:16 -0400
Received: from pan.madism.org ([88.191.52.104]:60146 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754674AbXIBWmP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 18:42:15 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 705A51D993
	for <git@vger.kernel.org>; Mon,  3 Sep 2007 00:42:14 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C1D6C7B9; Mon,  3 Sep 2007 00:42:13 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57397>


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


  I read the recent thread Timo Sirainen raised about string APIs in
git. ANd I went read the strbuf.[hc] module.

  I believe that the choice made in that module are wrong and could be
made better. I actually use to work with a string buffer API (that
interested readers can look at on [0]), that work almost the same
(except for the eof flag, but it's trivial to keep), but have
two significant differences:

  First, and that's the most important one: the buffer is always NUL
terminated, after its official "len". That means, in terms of strbuf
API, that "alloc" is always greater or equal to len+1 to be able to
store the ending NUL[1]. The advantages are obvious: you can pass the
buffer to any legacy C string function without any fear of read
overflow.  strtol comes to mind, and atm, git has to explicitely use
strbuf_end to put that ending nul to be able to call legacy
applications. But once done, the NUL is accounted into the string (aka
it's in "len") which makes it a non C-string (I mean you cannot append
any more data in it anymore). So current implementations tries to
workaround an issue (the non systematical NUL-termination) but IMHO the
wrong way.

  The other shortcoming is that you cannot tell the buffer "Hey, it's
very likely that you'll end up being _that_ long. That's why, in some
parts of the code (see write_tar_entry in archive-tar.c e.g.) the
programmer actually messes with the buffer allocation, outside from the
strbuf module, which makes it well, useless. In my API, I have a
"buffer_ensure" call, that is supposed to do that: "please ensure that
this buffer still has _this_ amount of free and allocated space to put
more data".


  So my question is, do people think I raise a valid point, and would
patches that would refactor the strbuf module to have those functions,
and would fix the code that uses strbuf's to interact properly, be
accepted ?

  Also, the efficiency of the buffer module API I use has a lot to do
with the fact that copying functions, and length tests are inlined in
the .h, so that the compiler can optimize the ones it already tested 10
calls before. I'm not sure if this is frowned upon or if it makes sense.


  [0] http://git.madism.org/?p=3Dpfixtools.git;a=3Dblob;f=3Dbuffer.h;hb=3DH=
EAD
      http://git.madism.org/?p=3Dpfixtools.git;a=3Dblob;f=3Dbuffer.c;hb=3DH=
EAD

  [1] Of course, ensuring the NUL-termination has a cost, though it's
      often benign, and for performance-critical places where characters
      are copied one by one, it's always possible to use an "unsafe"
      addch (that would not maintain the invariant), and then call an
      equivalent of strbuf_end (that would not append a \0 like it does
      now, but just would fix the invariant that for any strbuf,
      buf->buf[buf->len] =3D=3D '\0') explicitely. For places where the
      invariant generate negligible cost (like concatenating two paths
      parts with a middle '/' e.g.) then we gain safety without even
      having to think about it.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG2zxFvGr7W6HudhwRAkcuAJ43DNtGzfUC7UoJR7lVBkkkufn78ACgkDz2
eC3B2GRkTk0Zpfdvaj5vbfc=
=MsCI
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
