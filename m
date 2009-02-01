From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Sun, 1 Feb 2009 20:45:05 +0300
Organization: St.Petersburg State University
Message-ID: <20090201174505.GA14181@roro3.zxlink>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 18:45:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTgNa-0002Mc-Nk
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 18:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794AbZBARnn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Feb 2009 12:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbZBARnn
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 12:43:43 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:1864 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbZBARnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 12:43:42 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id 9FCF717B65E; Sun,  1 Feb 2009 20:43:40 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3.zxlink>)
	id 1LTgNV-0002NZ-OU; Sun, 01 Feb 2009 20:45:05 +0300
Content-Disposition: inline
In-Reply-To: <7vwscej26i.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107985>

On Wed, Jan 28, 2009 at 06:06:45PM -0800, Junio C Hamano wrote:

[...]

> * ks/maint-mailinfo-folded (Tue Jan 13 01:21:04 2009 +0300) 4 commits
>  + mailinfo: tests for RFC2047 examples
>  + mailinfo: add explicit test for mails like '<a.u.thor@example.com>
>    (A U Thor)'
>  + mailinfo: 'From:' header should be unfold as well
>  + mailinfo: correctly handle multiline 'Subject:' header
>=20
> I just got tired of waiting and cleaned up the series myself.

Sorry about that. Here is the missing bit (based on master)

--- 8< ---

Subject: [PATCH] mailinfo: cleanup extra spaces for complex 'From:'

currently for cases like

    From: A U Thor <a.u.thor@example.com> (Comment)

mailinfo extracts the following 'Author:' field:

    Author: A U Thor   (Comment)
                     ^^
which has two extra spaces left in there after removed email part.

I think this is wrong so here is a fix.

Signed-off-by: Kirill Smelkov <kirr@landau.phys.spbu.ru>
---
 builtin-mailinfo.c        |   19 +++++++++++++++----
 t/t5100/info0001          |    2 +-
 t/t5100/rfc2047-info-0004 |    2 +-
 t/t5100/sample.mbox       |    4 ++--
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index d4dc23a..2789ccd 100644
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
@@ -109,11 +112,19 @@ static void handle_from(const struct strbuf *from=
)
 	strbuf_add(&email, at, el);
 	strbuf_remove(&f, at - f.buf, el + (at[el] ? 1 : 0));
=20
-	/* The remainder is name.  It could be "John Doe <john.doe@xz>"
-	 * or "john.doe@xz (John Doe)", but we have removed the
-	 * email part, so trim from both ends, possibly removing
-	 * the () pair at the end.
+	/* The remainder is name.  It could be
+	 *
+	 * - "John Doe <john.doe@xz>"			(a), or
+	 * - "john.doe@xz (John Doe)"			(b), or
+	 * - "John (zzz) Doe <john.doe@xz> (Comment)"	(c)
+	 *
+	 * but we have removed the email part, so
+	 *
+	 * - remove extra spaces which could stay after email (case 'c'), and
+	 * - trim from both ends, possibly removing the () pair at the end
+	 *   (cases 'a' and 'b').
 	 */
+	cleanup_space(&f);
 	strbuf_trim(&f);
 	if (f.buf[0] =3D=3D '(' && f.len && f.buf[f.len - 1] =3D=3D ')') {
 		strbuf_remove(&f, 0, 1);
diff --git a/t/t5100/info0001 b/t/t5100/info0001
index 8c05277..f951538 100644
--- a/t/t5100/info0001
+++ b/t/t5100/info0001
@@ -1,4 +1,4 @@
-Author: A U Thor
+Author: A (zzz) U Thor (Comment)
 Email: a.u.thor@example.com
 Subject: a commit.
 Date: Fri, 9 Jun 2006 00:44:16 -0700
diff --git a/t/t5100/rfc2047-info-0004 b/t/t5100/rfc2047-info-0004
index 0ca7ff0..f67a90a 100644
--- a/t/t5100/rfc2047-info-0004
+++ b/t/t5100/rfc2047-info-0004
@@ -1,4 +1,4 @@
-Author: Nathaniel Borenstein   (=D7=9D=D7=95=D7=9C=D7=A9 =D7=9F=D7=91 =
=D7=99=D7=9C=D7=98=D7=A4=D7=A0)
+Author: Nathaniel Borenstein (=D7=9D=D7=95=D7=9C=D7=A9 =D7=9F=D7=91 =D7=
=99=D7=9C=D7=98=D7=A4=D7=A0)
 Email: nsb@thumper.bellcore.com
 Subject: Test of new header generator
=20
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index 85df55f..c5ad206 100644
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
1.6.1.284.g5dc13

--- 8< ---


Thanks,
Kirill
