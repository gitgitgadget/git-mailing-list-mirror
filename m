From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [irq/urgent]: created 3786fc7: "irq: make variable static"
Date: Sun, 26 Oct 2008 17:04:19 +0100
Message-ID: <49049503.5080402@lsrfire.ath.cx>
References: <20081022061730.GA5749@elte.hu> <adf1fd3d0810220039g51d61e92l5ba254b57723d3b6@mail.gmail.com> <20081022075639.GA1284@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>,
	git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sun Oct 26 17:06:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ku88T-0005aZ-MC
	for gcvg-git-2@gmane.org; Sun, 26 Oct 2008 17:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976AbYJZQEZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Oct 2008 12:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754695AbYJZQEZ
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Oct 2008 12:04:25 -0400
Received: from india601.server4you.de ([85.25.151.105]:38791 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038AbYJZQEY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2008 12:04:24 -0400
Received: from [10.0.1.101] (p57B7F906.dip.t-dialin.net [87.183.249.6])
	by india601.server4you.de (Postfix) with ESMTPSA id 25F7C2F804C;
	Sun, 26 Oct 2008 17:04:22 +0100 (CET)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <20081022075639.GA1284@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99169>

Ingo Molnar schrieb:
> The most useful angle would be if git log --format had a way to print=
=20
> the reverse name. Then i could do a git-log-line script like:
>=20
>   git log --pretty=3Dformat:"%h: %20N %s" $@
>=20
> where %N prints the reverse name.
>=20
> While at it: it would be nice if git log had a way to crop string=20
> output. For example i'd love to use:
>=20
>   git log --pretty=3Dformat:"%h: %60s" $@
>=20
> which would print out at most 60 characters from the first commit lin=
e.
>=20
> That way i can see it properly on an 80 width terminal and can paste =
it=20
> into email without linewraps, etc. But --pretty=3Dformat does not see=
m to=20
> know width restrictions.

You don't need support for format string cropping in git for the latter
example, you can use cut instead:

   git log --pretty=3Dformat:%h:\ %s $@ | cut -b-70

But I only realized that after I had written the following patch. :)
Would this feature still be useful?

Thanks,
Ren=E9

---
 Documentation/pretty-formats.txt |    5 +++++
 pretty.c                         |   30 ++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
index f18d33e..cc76c45 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -128,6 +128,11 @@ The placeholders are:
 - '%n': newline
 - '%x00': print a byte from a hex code
=20
++
+You can also specify a maximum width for each field after the '%', e.g=
=2E
+'%60s' will show the first sixty characters of the subject (or less if
+it's shorter).
+
 * 'tformat:'
 +
 The 'tformat:' format works exactly like 'format:', except that it
diff --git a/pretty.c b/pretty.c
index 1e79943..74e8932 100644
--- a/pretty.c
+++ b/pretty.c
@@ -498,8 +498,8 @@ static void format_decoration(struct strbuf *sb, co=
nst struct commit *commit)
 		strbuf_addch(sb, ')');
 }
=20
-static size_t format_commit_item(struct strbuf *sb, const char *placeh=
older,
-                               void *context)
+static size_t do_format_commit_item(struct strbuf *sb, const char *pla=
ceholder,
+		void *context)
 {
 	struct format_commit_context *c =3D context;
 	const struct commit *commit =3D c->commit;
@@ -621,6 +621,32 @@ static size_t format_commit_item(struct strbuf *sb=
, const char *placeholder,
 	return 0;	/* unknown placeholder */
 }
=20
+static size_t format_commit_item(struct strbuf *sb, const char *placeh=
older,
+		void *context)
+{
+	size_t digits =3D 0;
+	size_t maxlen =3D 0;
+	size_t consumed;
+
+	if (isdigit(placeholder[0])) {
+		do {
+			digits++;
+			maxlen *=3D 10;
+			maxlen +=3D placeholder[0] - '0';
+			placeholder++;
+		} while (isdigit(placeholder[0]));
+		maxlen +=3D sb->len;
+	}
+
+	consumed =3D do_format_commit_item(sb, placeholder, context);
+	if (!consumed)
+		return 0;
+
+	if (digits && sb->len > maxlen)
+		strbuf_setlen(sb, maxlen);
+	return digits + consumed;
+}
+
 void format_commit_message(const struct commit *commit,
 			   const void *format, struct strbuf *sb,
 			   enum date_mode dmode)
--=20
1.6.0.3.514.g2f91b
