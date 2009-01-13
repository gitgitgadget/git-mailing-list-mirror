From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [BUG PATCH RFC] mailinfo: correctly handle multiline 'Subject:' header
Date: Tue, 13 Jan 2009 12:39:16 +0300
Organization: St.Petersburg State University
Message-ID: <20090113093916.GA25471@landau.phys.spbu.ru>
References: <20090107224342.GB4946@roro3> <7vy6xm5i6h.fsf@gitster.siamese.dyndns.org> <7vy6xm42l3.fsf@gitster.siamese.dyndns.org> <1230316721-14339-1-git-send-email-kirr@mns.spb.ru> <20090107224342.GB4946@roro3> <7vy6xm5i6h.fsf@gitster.siamese.dyndns.org> <20090108231135.GB4185@roro3> <7veizatxo9.fsf@gitster.siamese.dyndns.org> <20090112223447.GA5948@roro3.zxlink> <7v63kkgl5b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Potashev <aspotashev@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 10:40:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMflT-0002k1-Bf
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 10:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756513AbZAMJjV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jan 2009 04:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756444AbZAMJjU
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 04:39:20 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:1073 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650AbZAMJjS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 04:39:18 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id 973CE17B661; Tue, 13 Jan 2009 12:39:16 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <7v63kkgl5b.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105480>

On Mon, Jan 12, 2009 at 03:27:44PM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:
>=20
> > diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> > index f7c8c08..6d72c1b 100644
> > --- a/builtin-mailinfo.c
> > +++ b/builtin-mailinfo.c
> > @@ -860,6 +860,7 @@ static void handle_info(void)
> >  			}
> >  			output_header_lines(fout, "Subject", hdr);
> >  		} else if (!memcmp(header[i], "From", 4)) {
> > +			cleanup_space(hdr);
> >  			handle_from(hdr);
> >  			fprintf(fout, "Author: %s\n", name.buf);
> >  			fprintf(fout, "Email: %s\n", email.buf);
> > diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
> > index 4bf7947..d465685 100644
> > --- a/t/t5100/sample.mbox
> > +++ b/t/t5100/sample.mbox
> > @@ -2,7 +2,10 @@
> >  =09
> >     =20
> >  From nobody Mon Sep 17 00:00:00 2001
> > -From: A U Thor <a.u.thor@example.com>
> > +From: A
> > +      U
> > +      Thor
> > +      <a.u.thor@example.com>
> >  Date: Fri, 9 Jun 2006 00:44:16 -0700
> >  Subject: [PATCH] a commit.
>=20
> I think this is a reasonable change.

Thanks.


> But doesn't this
>=20
> >  From nobody Mon Sep 17 00:00:00 2001
> > -From: A
> > +From: A (zzz)
> >        U
> >        Thor
> > -      <a.u.thor@example.com>
> > +      <a.u.thor@example.com> (Comment)
>=20
> regress for people who spell their names like this?
>=20
> 	From: john.doe@email.xz (John Doe)

I think everything is ok:

There is an explicit handler for such emails before my comments removal
in builtin-mailinfo.c:

        /* The remainder is name.  It could be "John Doe <john.doe@xz>"
         * or "john.doe@xz (John Doe)", but we have removed the
         * email part, so trim from both ends, possibly removing
         * the () pair at the end.
         */
        strbuf_trim(&f);
        if (f.buf[0] =3D=3D '(' && f.len && f.buf[f.len - 1] =3D=3D ')'=
) {
                strbuf_remove(&f, 0, 1);
                strbuf_setlen(&f, f.len - 1);
        }


http://repo.or.cz/w/git.git?a=3Dblob;f=3Dbuiltin-mailinfo.c;h=3Df7c8c08=
b320c99d8bf96443ae57aa33c1de7e8c0;hb=3DHEAD#l112


And only a test for this is missing



=46rom 77316ad6db2c3b0f4be238c4ba855b2f785b50d6 Mon Sep 17 00:00:00 200=
1
=46rom: Kirill Smelkov <kirr@mns.spb.ru>
Date: Tue, 13 Jan 2009 12:33:48 +0300
Subject: [PATCH] mailinfo: add explicit test for mails like '<a.u.thor@=
example.com> (A U Thor)'

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 t/t5100-mailinfo.sh |    2 +-
 t/t5100/info0013    |    5 +++++
 t/t5100/sample.mbox |    5 +++++
 3 files changed, 11 insertions(+), 1 deletions(-)
 create mode 100644 t/t5100/info0013
 create mode 100644 t/t5100/msg0013
 create mode 100644 t/t5100/patch0013

diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 625c204..e70ea94 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -11,7 +11,7 @@ test_expect_success 'split sample box' \
 	'git mailsplit -o. "$TEST_DIRECTORY"/t5100/sample.mbox >last &&
 	last=3D`cat last` &&
 	echo total is $last &&
-	test `cat last` =3D 12'
+	test `cat last` =3D 13'
=20
 for mail in `echo 00*`
 do
diff --git a/t/t5100/info0013 b/t/t5100/info0013
new file mode 100644
index 0000000..bbe049e
--- /dev/null
+++ b/t/t5100/info0013
@@ -0,0 +1,5 @@
+Author: A U Thor
+Email: a.u.thor@example.com
+Subject: a patch
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+
diff --git a/t/t5100/msg0013 b/t/t5100/msg0013
new file mode 100644
index 0000000..e69de29
diff --git a/t/t5100/patch0013 b/t/t5100/patch0013
new file mode 100644
index 0000000..e69de29
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 4f80b82..c5ad206 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -556,3 +556,8 @@ index 3fd3afb..0ee807e 100644
  #. =D0=BF=E2=95=AB=D0=BF=E2=95=9F =D1=8F=E2=94=82=D0=BF=E2=95=A1=D0=BF=
=E2=95=AC=D0=BF=E2=95=A3=D0=BF=E2=95=A7 =D0=BF=E2=95=AA=D0=BF=E2=95=9F=D1=
=8F=E2=94=AC=D0=BF=E2=95=A6=D0=BF=E2=95=AB=D0=BF=E2=95=A3: =D0=BF=E2=95=
=AC=D1=8F=E2=94=8C=D1=8F=E2=94=80=D0=BF=E2=95=A3=D0=BF=E2=95=A2=D0=BF=E2=
=95=9F=D0=BF=E2=95=A8=D1=8F=E2=94=8C=D0=BF=E2=95=A6=D1=8F=E2=94=80=D0=BF=
=E2=95=AC=D0=BF=E2=95=A1=D0=BF=E2=95=9F=D1=8F=E2=94=8C=D1=8F=E2=96=84 /=
etc/sudoers (=D0=BF=E2=95=A8=D0=BF=E2=95=AC=D0=BF=E2=95=AA=D0=BF=E2=95=9F=
=D0=BF=E2=95=AB=D0=BF=E2=95=A2=D0=BF=E2=95=9F ``visudo``) =D0=BF=C2=A9=D1=
=8F=E2=94=80=D0=BF=E2=95=A6=D0=BF=E2=95=AA=D0=BF=E2=95=A3=D1=8F=E2=94=80=
=D0=BF=E2=95=AB=D0=BF=E2=95=AC =D1=8F=E2=94=82=D0=BF=E2=95=A9=D0=BF=E2=95=
=A3=D0=BF=E2=95=A2=D1=8F=E2=94=90=D1=8F=E2=96=8C=D1=8F=E2=94=B4=D0=BF=E2=
=95=A6=D0=BF=E2=95=AA =D0=BF=E2=95=AC=D0=BF=E2=95=A0=D1=8F=E2=94=80=D0=BF=
=E2=95=9F=D0=BF=E2=95=A5=D0=BF=E2=95=AC=D0=BF=E2=95=AA::
 --=20
 1.5.6.5
+From nobody Mon Sep 17 00:00:00 2001
+From: <a.u.thor@example.com> (A U Thor)
+Date: Fri, 9 Jun 2006 00:44:16 -0700
+Subject: [PATCH] a patch
+
--=20
1.6.1.101.g0335
