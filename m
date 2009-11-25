From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] shortlog: respect commit encoding
Date: Wed, 25 Nov 2009 15:00:52 +0100
Message-ID: <20091125140052.GA5565@pengutronix.de>
References: <20091111141342.GA1849@pengutronix.de> <1259075555-7831-1-git-send-email-u.kleine-koenig@pengutronix.de> <7vfx8376hd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 15:01:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDIQq-0004cb-PO
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 15:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934665AbZKYOAw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 09:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758779AbZKYOAw
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 09:00:52 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35168 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758476AbZKYOAv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 09:00:51 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1NDIQT-0001LG-1y; Wed, 25 Nov 2009 15:00:57 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1NDIQO-0003t5-SA; Wed, 25 Nov 2009 15:00:52 +0100
Content-Disposition: inline
In-Reply-To: <7vfx8376hd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133643>

Hello Junio,

On Tue, Nov 24, 2009 at 05:12:14PM -0800, Junio C Hamano wrote:
> Uwe Kleine-K=F6nig  <u.kleine-koenig@pengutronix.de> writes:
>=20
> > Before this change the author was taken from the raw commit without
> > reencoding.
>=20
> I see people often begin with "before this change" and stop the log
> message after making a statement of a fact.  I mildly dislike this st=
yle,
> especially when the resulting message does not state that it is bad (=
and
> if necessary why it is bad) nor state in what way the code after the
> change is good.
>=20
> 	Don't take the author name information without re-encoding
>         from the raw commit object buffer.
>=20
> is easier to read, at least for me.
Yes, that's better.  Thanks.
=20
> >  	while (*buffer && *buffer !=3D '\n') {
> >  		const char *eol =3D strchr(buffer, '\n');
> > =20
> > -		if (eol =3D=3D NULL)
> > +		if (eol =3D=3D NULL) {
> >  			eol =3D buffer + strlen(buffer);
> > -		else
> > +		} else
> >  			eol++;
> >  		if (!prefixcmp(buffer, "author "))
>=20
> What is this hunk for?
This is just a left-over from debugging.  Removed.
=20
> > @@ -157,20 +162,20 @@ void shortlog_add_commit(struct shortlog *log=
, struct commit *commit)
> >  		die("Missing author: %s",
> >  		    sha1_to_hex(commit->object.sha1));
> >  	if (log->user_format) {
> > -		struct strbuf buf =3D STRBUF_INIT;
> >  		struct pretty_print_context ctx =3D {0};
> >  		ctx.abbrev =3D DEFAULT_ABBREV;
> >  		ctx.subject =3D "";
> >  		ctx.after_subject =3D "";
> >  		ctx.date_mode =3D DATE_NORMAL;
> > +		pretty_print_commit(CMIT_FMT_USERFORMAT, commit, &ufbuf, &ctx);
> > +		buffer =3D ufbuf.buf;
> > +
> > +	} else if (*buffer)
> >  		buffer++;
> > +
>=20
> You probably wanted to add an extra pair of {} around this "else
> if" clause instead, not the earlier one.
I removed the new line (the last changed line you quoted) instead.
Good?
=20
> > diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
> > index 405b971..118204b 100755
> > --- a/t/t4201-shortlog.sh
> > +++ b/t/t4201-shortlog.sh
> > @@ -51,5 +51,29 @@ git log HEAD > log
> >  GIT_DIR=3Dnon-existing git shortlog -w < log > out
> > =20
> >  test_expect_success 'shortlog from non-git directory' 'test_cmp ex=
pect out'
> > +iconvfromutf8toiso885915() {
> > +	printf "%s" "$@" | iconv -f UTF-8 -t ISO-8859-15
> > +}
>=20
> A bad use of "$@" that expands to $# individual words; you meant
> to say "$*".
OK.
=20
> Could we please have the following inside its own test, so that
> any failure while preparing the test data is caught as an error?
I put it in the test itself.  Isn't it ugly to have a test saying
something like
=09
*   ok 3: prepare shortlog encoding test

?  Or is it better to see where a failure occurs?

> > +git reset --hard "$commit"
> > +git config --unset i18n.commitencoding
> > +echo 2 > a1
> > +git commit --quiet -m "set a1 to 2 and some non-ASCII chars: =C4=DF=
=F8" --author=3D"J=F6h=E4nn=EBs \"Dsch=F6\" Schind=EBlin <Johannes.Schi=
ndelin@gmx.de>" a1
> > +
> > +git config i18n.commitencoding "ISO-8859-15"
> > +echo 3 > a1
> > +git commit --quiet -m "$(iconvfromutf8toiso885915 "set a1 to 3 and=
 some non-ASCII chars: =E1=E6=EF")" --author=3D"$(iconvfromutf8toiso885=
915 "J=F6h=E4nn=EBs \"Dsch=F6\" Schind=EBlin <Johannes.Schindelin@gmx.d=
e>")" a1
> > +git config --unset i18n.commitencoding
> > +
> > +git shortlog HEAD~2.. > out
> > +
> > +cat > expect << EOF
> > +J=F6h=E4nn=EBs "Dsch=F6" Schind=EBlin (2):
> > +      set a1 to 2 and some non-ASCII chars: =C4=DF=F8
> > +      set a1 to 3 and some non-ASCII chars: =E1=E6=EF
> > +
> > +EOF
> > +
> > +test_expect_success 'shortlog encoding' 'test_cmp expect out'
>=20
> t3900-i18n-commit already uses 8859-1 so if it is not too much to
> ask, it would be much nicer to have these test work between UTF-8
> and 8859-1, not -15.
>=20
> That way, I do not have to worry about breaking tests for people
> who were able to run existing iconv tests because they do not have
> working 8859-15.
OK.

Below is the updated patch.

Best regards
Uwe

------------------>8----------------------
=46rom: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] shortlog: respect commit encoding

Don't take the author name information without re-encoding from the raw
commit object buffer.

Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
Cc: Jiri Kosina <jkosina@suse.cz>
---
 builtin-shortlog.c  |   20 ++++++++++++--------
 t/t4201-shortlog.sh |   23 +++++++++++++++++++++++
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 8aa63c7..263adc1 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -139,8 +139,13 @@ static void read_from_stdin(struct shortlog *log)
 void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 {
 	const char *author =3D NULL, *buffer;
+	struct strbuf buf =3D STRBUF_INIT;
+	struct strbuf ufbuf =3D STRBUF_INIT;
+	struct pretty_print_context ctx =3D {0};
=20
-	buffer =3D commit->buffer;
+	pretty_print_commit(CMIT_FMT_RAW, commit, &buf, &ctx);
+
+	buffer =3D buf.buf;
 	while (*buffer && *buffer !=3D '\n') {
 		const char *eol =3D strchr(buffer, '\n');
=20
@@ -157,20 +162,19 @@ void shortlog_add_commit(struct shortlog *log, st=
ruct commit *commit)
 		die("Missing author: %s",
 		    sha1_to_hex(commit->object.sha1));
 	if (log->user_format) {
-		struct strbuf buf =3D STRBUF_INIT;
 		struct pretty_print_context ctx =3D {0};
 		ctx.abbrev =3D DEFAULT_ABBREV;
 		ctx.subject =3D "";
 		ctx.after_subject =3D "";
 		ctx.date_mode =3D DATE_NORMAL;
-		pretty_print_commit(CMIT_FMT_USERFORMAT, commit, &buf, &ctx);
-		insert_one_record(log, author, buf.buf);
-		strbuf_release(&buf);
-		return;
-	}
-	if (*buffer)
+		pretty_print_commit(CMIT_FMT_USERFORMAT, commit, &ufbuf, &ctx);
+		buffer =3D ufbuf.buf;
+
+	} else if (*buffer)
 		buffer++;
 	insert_one_record(log, author, !*buffer ? "<none>" : buffer);
+	strbuf_release(&ufbuf);
+	strbuf_release(&buf);
 }
=20
 static void get_from_rev(struct rev_info *rev, struct shortlog *log)
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 405b971..03b6950 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -52,4 +52,27 @@ GIT_DIR=3Dnon-existing git shortlog -w < log > out
=20
 test_expect_success 'shortlog from non-git directory' 'test_cmp expect=
 out'
=20
+iconvfromutf8toiso88591() {
+	printf "%s" "$*" | iconv -f UTF-8 -t ISO-8859-1
+}
+
+cat > expect << EOF
+J=F6h=E4nn=EBs "Dsch=F6" Schind=EBlin (2):
+      set a1 to 2 and some non-ASCII chars: =C4=DF=F8
+      set a1 to 3 and some non-ASCII chars: =E1=E6=EF
+
+EOF
+
+test_expect_success 'shortlog encoding' '
+git reset --hard "$commit" &&
+git config --unset i18n.commitencoding &&
+echo 2 > a1 &&
+git commit --quiet -m "set a1 to 2 and some non-ASCII chars: =C4=DF=F8=
" --author=3D"J=F6h=E4nn=EBs \"Dsch=F6\" Schind=EBlin <Johannes.Schinde=
lin@gmx.de>" a1 &&
+git config i18n.commitencoding "ISO-8859-1" &&
+echo 3 > a1 &&
+git commit --quiet -m "$(iconvfromutf8toiso88591 "set a1 to 3 and some=
 non-ASCII chars: =E1=E6=EF")" --author=3D"$(iconvfromutf8toiso88591 "J=
=F6h=E4nn=EBs \"Dsch=F6\" Schind=EBlin <Johannes.Schindelin@gmx.de>")" =
a1 &&
+git config --unset i18n.commitencoding &&
+git shortlog HEAD~2.. > out &&
+test_cmp expect out'
+
 test_done
--=20
1.6.5.3

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
