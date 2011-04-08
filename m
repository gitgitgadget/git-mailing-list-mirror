From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Fri, 8 Apr 2011 18:40:36 -0400
Message-ID: <20110408224035.GB7343@sigill.intra.peff.net>
References: <1302102336-8800-1-git-send-email-asedeno@mit.edu>
 <1302274674-4231-1-git-send-email-asedeno@mit.edu>
 <7vmxk033ic.fsf@alter.siamese.dyndns.org>
 <20110408205437.GB16540@sigill.intra.peff.net>
 <7v4o6830cc.fsf@alter.siamese.dyndns.org>
 <20110408213201.GA20348@sigill.intra.peff.net>
 <7vipuo1iuy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 00:40:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8KM8-0002Wg-I8
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 00:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757531Ab1DHWkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2011 18:40:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58161
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752256Ab1DHWkj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 18:40:39 -0400
Received: (qmail 6450 invoked by uid 107); 8 Apr 2011 22:41:26 -0000
Received: from 70-36-146-44.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.44)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Apr 2011 18:41:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Apr 2011 18:40:36 -0400
Content-Disposition: inline
In-Reply-To: <7vipuo1iuy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171171>

On Fri, Apr 08, 2011 at 03:25:09PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>=20
> > I disagree. Format-patch claims to make an mbox, so it should make =
one
> > that is valid.
>=20
> OK.  That makes sense (even though I think it would make cutting and
> pasting somewhat awkward).

Cutting and pasting is already potentially awkward, because we
rfc2047-quote in format-patch, too. But we can still get away without
quoting at all in regular "git log". The "Author:" lines, while
rfc822-looking do not have to be real header lines, and we know that
everything before the <> must be the name.

So I think this is the patch we want:

-- >8 --
Subject: [PATCH] pretty: quote rfc822 specials in email addresses

If somebody has a name that includes an rfc822 special, we
will output it literally in the "From:" header. This is
usually OK, but certain characters (like ".") are supposed
to be enclosed in double-quotes in a mail header.

In practice, whether this matters may depend on your MUA.
Some MUAs will happily take in:

   From: Foo B. Bar <author@example.com>

without quotes, and properly quote the "." when they send
the actual mail.  Others may not, or may screw up harder
things like:

  From: Foo "The Baz" Bar <author@example.com>

=46or example, mutt will strip the quotes, thinking they are
actual syntactic rfc822 quotes.

So let's quote properly, and then (if necessary) we still
apply rfc2047 encoding on top of that, which should make all
MUAs happy.

Signed-off-by: Jeff King <peff@peff.net>
---
 pretty.c                |   61 +++++++++++++++++++++++++++++++++++++++=
+++++++-
 t/t4014-format-patch.sh |   42 ++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 1 deletions(-)

diff --git a/pretty.c b/pretty.c
index e1d8a8f..8345485 100644
--- a/pretty.c
+++ b/pretty.c
@@ -208,6 +208,58 @@ int has_non_ascii(const char *s)
 	return 0;
 }
=20
+static int is_rfc822_special(char ch)
+{
+	switch (ch) {
+	case '(':
+	case ')':
+	case '<':
+	case '>':
+	case '[':
+	case ']':
+	case ':':
+	case ';':
+	case '@':
+	case ',':
+	case '.':
+	case '"':
+	case '\\':
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static int has_rfc822_specials(const char *s, int len)
+{
+	int i;
+	for (i =3D 0; i < len; i++)
+		if (is_rfc822_special(s[i]))
+			return 1;
+	return 0;
+}
+
+static void add_rfc822_quoted(struct strbuf *out, const char *s, int l=
en)
+{
+	int i;
+
+	/* just a guess, we may have to also backslash-quote */
+	strbuf_grow(out, len + 2);
+
+	strbuf_addch(out, '"');
+	for (i =3D 0; i < len; i++) {
+		switch (s[i]) {
+		case '"':
+		case '\\':
+			strbuf_addch(out, '\\');
+			/* fall through */
+		default:
+			strbuf_addch(out, s[i]);
+		}
+	}
+	strbuf_addch(out, '"');
+}
+
 static int is_rfc2047_special(char ch)
 {
 	return (non_ascii(ch) || (ch =3D=3D '=3D') || (ch =3D=3D '?') || (ch =
=3D=3D '_'));
@@ -293,7 +345,14 @@ void pp_user_info(const char *what, enum cmit_fmt =
fmt, struct strbuf *sb,
 			name_tail--;
 		display_name_length =3D name_tail - line;
 		strbuf_addstr(sb, "From: ");
-		add_rfc2047(sb, line, display_name_length, encoding);
+		if (has_rfc822_specials(line, display_name_length)) {
+			struct strbuf quoted =3D STRBUF_INIT;
+			add_rfc822_quoted(&quoted, line, display_name_length);
+			add_rfc2047(sb, quoted.buf, quoted.len, encoding);
+			strbuf_release(&quoted);
+		}
+		else
+			add_rfc2047(sb, line, display_name_length, encoding);
 		strbuf_add(sb, name_tail, namelen - display_name_length);
 		strbuf_addch(sb, '\n');
 	} else {
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index c3cdb52..dd406c4 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -793,4 +793,46 @@ test_expect_success 'format-patch wraps extremely =
long headers (rfc2047)' '
 	test_cmp expect subject
 '
=20
+check_author() {
+	echo content >>file &&
+	git add file &&
+	GIT_AUTHOR_NAME=3D$1 git commit -m author-check &&
+	git format-patch --stdout -1 >patch &&
+	grep ^From: patch >actual &&
+	test_cmp expect actual
+}
+
+cat >expect <<'EOF'
+From: "Foo B. Bar" <author@example.com>
+EOF
+test_expect_success 'format-patch quotes dot in headers' '
+	check_author "Foo B. Bar"
+'
+
+cat >expect <<'EOF'
+From: "Foo \"The Baz\" Bar" <author@example.com>
+EOF
+test_expect_success 'format-patch quotes double-quote in headers' '
+	check_author "Foo \"The Baz\" Bar"
+'
+
+cat >expect <<'EOF'
+From: =3D?UTF-8?q?"F=3DC3=3DB6o=3D20B.=3D20Bar"?=3D <author@example.co=
m>
+EOF
+test_expect_success 'rfc2047-encoded headers also double-quote 822 spe=
cials' '
+	check_author "F=C3=B6o B. Bar"
+'
+
+cat >expect <<'EOF'
+Subject: header with . in it
+EOF
+test_expect_success 'subject lines do not have 822 atom-quoting' '
+	echo content >>file &&
+	git add file &&
+	git commit -m "header with . in it" &&
+	git format-patch -k -1 --stdout >patch &&
+	grep ^Subject: patch >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
1.7.5.rc1.24.gcff72
