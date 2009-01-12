From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: [BUG PATCH RFC] mailinfo: correctly handle multiline
	'Subject:' header
Date: Tue, 13 Jan 2009 01:34:47 +0300
Organization: St.Petersburg State University
Message-ID: <20090112223447.GA5948@roro3.zxlink>
References: <20090108100813.GA15640@myhost> <1230316721-14339-1-git-send-email-kirr@mns.spb.ru> <20090107224342.GB4946@roro3> <7vy6xm5i6h.fsf@gitster.siamese.dyndns.org> <7vy6xm42l3.fsf@gitster.siamese.dyndns.org> <1230316721-14339-1-git-send-email-kirr@mns.spb.ru> <20090107224342.GB4946@roro3> <7vy6xm5i6h.fsf@gitster.siamese.dyndns.org> <20090108231135.GB4185@roro3> <7veizatxo9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexander Potashev <aspotashev@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 23:36:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMVNy-00015N-FB
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 23:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760109AbZALWdg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jan 2009 17:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760108AbZALWdf
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 17:33:35 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:4951 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760097AbZALWde (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 17:33:34 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id 2F0C917B684; Tue, 13 Jan 2009 01:33:32 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3.zxlink>)
	id 1LMVMt-0003bY-S4; Tue, 13 Jan 2009 01:34:47 +0300
Content-Disposition: inline
In-Reply-To: <7veizatxo9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105405>

On Sat, Jan 10, 2009 at 05:54:14PM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@landau.phys.spbu.ru> writes:
>=20
> >     [but I'm not sure whether testresult with Nathaniel Borenstein
> >      (=D7=9D=D7=95=D7=9C=D7=A9 =D7=9F=D7=91 =D7=99=D7=9C=D7=98=D7=A4=
=D7=A0) is correct -- see rfc2047-info-0004]
> > ...
> > diff --git a/t/t5100/rfc2047-info-0004 b/t/t5100/rfc2047-info-0004
> > new file mode 100644
> > index 0000000..850f831
> > --- /dev/null
> > +++ b/t/t5100/rfc2047-info-0004
> > @@ -0,0 +1,5 @@
> > +Author: Nathaniel Borenstein =20
> > +     ([somethig that could be detected as spam])
> > +Email: nsb@thumper.bellcore.com
> > +Subject: Test of new header generator
> > +
>=20
> That does look wrong.  If you can fix this, please do so; otherwise p=
lease
> mark the test that deals with this entry with test_expect_failure, un=
til
> somebody else does.

Yes, I think I've dealt with it -- we weren't unfolding 'From' header,
and we were not skipping comments in rfc822 headers, so:

=46rom: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH] mailinfo: 'From:' header should be unfold as well

At present we do headers unfolding (see RFC822 3.1.1. LONG HEADER FIELD=
S) for
all fields except 'From' (always) and 'Subject' (when keep_subject is s=
et)

Not unfolding 'From' is a bug -- see above-mentioned RFC link.

Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>

---
 builtin-mailinfo.c  |    1 +
 t/t5100/sample.mbox |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index f7c8c08..6d72c1b 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -860,6 +860,7 @@ static void handle_info(void)
 			}
 			output_header_lines(fout, "Subject", hdr);
 		} else if (!memcmp(header[i], "From", 4)) {
+			cleanup_space(hdr);
 			handle_from(hdr);
 			fprintf(fout, "Author: %s\n", name.buf);
 			fprintf(fout, "Email: %s\n", email.buf);
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 4bf7947..d465685 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -2,7 +2,10 @@
 =09
    =20
 From nobody Mon Sep 17 00:00:00 2001
-From: A U Thor <a.u.thor@example.com>
+From: A
+      U
+      Thor
+      <a.u.thor@example.com>
 Date: Fri, 9 Jun 2006 00:44:16 -0700
 Subject: [PATCH] a commit.
=20
--=20
tg: (1562445..) t/mail-from-unfold (depends on: master)




=46rom: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: [PATCH] mailinfo: more smarter removal of rfc822 comments from=
 'From'

As described in RFC822 (3.4.3 COMMENTS, and  A.1.4.), comments, as e.g.

    John (zzz) Doe <john.doe@xz> (Comment)

should "NOT [be] included in the destination mailbox"

We need this functionality to pass all RFC2047 based tests in the next =
commit.

Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>

---
 builtin-mailinfo.c  |   30 ++++++++++++++++++++++++++++++
 t/t5100/sample.mbox |    4 ++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 6d72c1b..c0b1ab4 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -29,6 +29,9 @@ static struct strbuf **p_hdr_data, **s_hdr_data;
 #define MAX_HDR_PARSED 10
 #define MAX_BOUNDARIES 5
=20
+static void cleanup_space(struct strbuf *sb);
+
+
 static void get_sane_name(struct strbuf *out, struct strbuf *name, str=
uct strbuf *email)
 {
 	struct strbuf *src =3D name;
@@ -120,6 +123,33 @@ static void handle_from(const struct strbuf *from)
 		strbuf_setlen(&f, f.len - 1);
 	}
=20
+	/* This still could not be finished for emails like
+	 *
+	 *	"John (zzz) Doe <john.doe@xz> (Comment)"
+	 *
+	 * The email part had already been removed, so let's kill comments as
+	 * well -- RFC822 says comments should not be present in destination
+	 * mailbox (3.4.3. Comments  and  A.1.4.)
+	 */
+	while (1) {
+		char *ta;
+
+		at =3D strchr(f.buf, '(');
+		if (!at)
+			break;
+		ta =3D strchr(at, ')');
+		if (!ta)
+			break;
+
+		strbuf_remove(&f, at - f.buf, ta-at + (*ta ? 1 : 0));
+	}
+
+	/* and let's finally cleanup spaces that were around (possibly
+	 * internal) comments
+	 */
+	cleanup_space(&f);
+	strbuf_trim(&f);
+
 	get_sane_name(&name, &f, &email);
 	strbuf_release(&f);
 }
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index d465685..42e02f3 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -2,10 +2,10 @@
 =09
    =20
 From nobody Mon Sep 17 00:00:00 2001
-From: A
+From: A (zzz)
       U
       Thor
-      <a.u.thor@example.com>
+      <a.u.thor@example.com> (Comment)
 Date: Fri, 9 Jun 2006 00:44:16 -0700
 Subject: [PATCH] a commit.
=20
--=20
tg: (b798ad9..) t/mail-from-comments (depends on: t/mail-from-unfold)



All these patches + original one (trivially adapted) could be pulled fr=
om

    git://repo.or.cz/git/kirr.git  for-junio



Kirill Smelkov (3):
      mailinfo: 'From:' header should be unfold as well
      mailinfo: more smarter removal of rfc822 comments from 'From'
      mailinfo: correctly handle multiline 'Subject:' header


builtin-mailinfo.c           |   58 +++++++++++++++++++++++++++++++++++=
+------
t/t5100-mailinfo.sh          |   24 ++++++++++++++++-
t/t5100/info0012             |    5 +++
t/t5100/msg0012              |    7 +++++
t/t5100/patch0012            |   30 +++++++++++++++++++++
t/t5100/rfc2047-info-0001    |    4 +++
t/t5100/rfc2047-info-0002    |    4 +++
t/t5100/rfc2047-info-0003    |    4 +++
t/t5100/rfc2047-info-0004    |    4 +++
t/t5100/rfc2047-info-0005    |    2 +
t/t5100/rfc2047-info-0006    |    2 +
t/t5100/rfc2047-info-0007    |    2 +
t/t5100/rfc2047-info-0008    |    2 +
t/t5100/rfc2047-info-0009    |    2 +
t/t5100/rfc2047-info-0010    |    2 +
t/t5100/rfc2047-info-0011    |    2 +
t/t5100/rfc2047-samples.mbox |   48 ++++++++++++++++++++++++++++++++++
t/t5100/sample.mbox          |   57 +++++++++++++++++++++++++++++++++++=
+++++-
18 files changed, 249 insertions(+), 10 deletions(-)


Thanks,
Kirill
