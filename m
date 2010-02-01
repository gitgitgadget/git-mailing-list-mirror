From: Jeff King <peff@peff.net>
Subject: Re: Problem listing GIT repository with accents
Date: Mon, 1 Feb 2010 07:19:33 -0500
Message-ID: <20100201121933.GA9995@coredump.intra.peff.net>
References: <7E88665723814E46BCBA1A39E84C27A5@elrond>
 <20100201113213.GA22663@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?RWxsacOp?= Computing Open Source Program 
	<opensource@elliecomputing.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 13:19:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbvFm-0003jZ-U6
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 13:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984Ab0BAMTh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Feb 2010 07:19:37 -0500
Received: from peff.net ([208.65.91.99]:43832 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054Ab0BAMTg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 07:19:36 -0500
Received: (qmail 24832 invoked by uid 107); 1 Feb 2010 12:19:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 01 Feb 2010 07:19:39 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Feb 2010 07:19:33 -0500
Content-Disposition: inline
In-Reply-To: <20100201113213.GA22663@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138604>

On Mon, Feb 01, 2010 at 06:32:13AM -0500, Jeff King wrote:

> The patch below fixes it for me. This is the first time I've ever loo=
ked
> at this code, though, so an extra set of eyes is appreciated. I'm als=
o
> not sure of the "!p[len]" termination that the loop uses (quoted in t=
he
> context below). The string is explicitly not NUL-terminated, so why
> would that matter? I think that may have been covering up the bug in
> some cases.

OK, I see now. Callers can pass "-1" for the length to indicate that th=
e
name is NUL-terminated. So my initial patch does work, but it ends up
decrementing the "-1", which happens to work because next_quote_pos jus=
t
checks that it is negative.

Here is an updated patch. The two changes are:

  1. A test in t3902.

  2. It converts the "-1" into strlen(name) before doing any work, whic=
h
     means we can lose the test for a NUL-terminator. I think this make=
s
     it much easier to see what is going on. And arguably we are fixing
     a "bug" where embedded NULs in a length-bounded string erroneously
     marked the end-of-string. In practice, I don't think it matters as
     we are quoting paths, and NUL is not a valid character there.

     It does come at the slight expense of running an extra strlen()
     instead of discovering the length as we progress through the loop.
     It's possible to fix that, but it makes the code a bit harder to
     read.

Junio, I think this bug goes back to v1.5.4, which makes the fix
appropriate for 'maint'.

-- >8 --
Subject: [PATCH] fix invalid read in quote_c_style_counted

This function did not work on strings that were not
NUL-terminated. It reads through a length-bounded string,
searching for characters in need of quoting. After we find
one, we output the quoted character, then advance our
pointer to find the next one. However, we never decremented
the length, meaning we ended up looking at whatever random
junk was stored after the string.

On top of this, callers can pass in "-1" as the length to
indicate a NUL-terminated string, and we would also end our
loop upon seeing a NUL. To keep the code simple, let's just
convert "-1" cases into "strlen(name)".

This bug was not found by the existing tests because most
code paths feed a NUL-terminated string. The notable
exception is a directory name being fed by ls-tree.

Signed-off-by: Jeff King <peff@peff.net>
---
 quote.c           |    6 +++++-
 t/t3902-quoted.sh |   19 ++++++++++++++++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/quote.c b/quote.c
index acb6bf9..e35ae50 100644
--- a/quote.c
+++ b/quote.c
@@ -209,11 +209,14 @@ static size_t quote_c_style_counted(const char *n=
ame, ssize_t maxlen,
 	size_t len, count =3D 0;
 	const char *p =3D name;
=20
+	if (maxlen < 0)
+		maxlen =3D strlen(name);
+
 	for (;;) {
 		int ch;
=20
 		len =3D next_quote_pos(p, maxlen);
-		if (len =3D=3D maxlen || !p[len])
+		if (len =3D=3D maxlen)
 			break;
=20
 		if (!no_dq && p =3D=3D name)
@@ -223,6 +226,7 @@ static size_t quote_c_style_counted(const char *nam=
e, ssize_t maxlen,
 		EMIT('\\');
 		p +=3D len;
 		ch =3D (unsigned char)*p++;
+		maxlen -=3D len + 1;
 		if (sq_lookup[ch] >=3D ' ') {
 			EMIT(sq_lookup[ch]);
 		} else {
diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index 5868052..14da45f 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -25,7 +25,7 @@ for_each_name () {
 	for name in \
 	    Name "Name and a${LF}LF" "Name and an${HT}HT" "Name${DQ}" \
 	    "$FN$HT$GN" "$FN$LF$GN" "$FN $GN" "$FN$GN" "$FN$DQ$GN" \
-	    "With SP in it"
+	    "With SP in it" "caract=C3=A8re sp=C3=A9cial/file"
 	do
 		eval "$1"
 	done
@@ -33,6 +33,7 @@ for_each_name () {
=20
 test_expect_success setup '
=20
+	mkdir "caract=C3=A8re sp=C3=A9cial" &&
 	for_each_name "echo initial >\"\$name\""
 	git add . &&
 	git commit -q -m Initial &&
@@ -50,6 +51,7 @@ Name
 "Name and an\tHT"
 "Name\""
 With SP in it
+"caract\303\250re sp\303\251cial/file"
 "\346\277\261\351\207\216\t\347\264\224"
 "\346\277\261\351\207\216\n\347\264\224"
 "\346\277\261\351\207\216 \347\264\224"
@@ -63,6 +65,7 @@ Name
 "Name and an\tHT"
 "Name\""
 With SP in it
+caract=C3=A8re sp=C3=A9cial/file
 "=E6=BF=B1=E9=87=8E\t=E7=B4=94"
 "=E6=BF=B1=E9=87=8E\n=E7=B4=94"
 =E6=BF=B1=E9=87=8E =E7=B4=94
@@ -97,6 +100,13 @@ test_expect_success 'check fully quoted output from=
 diff-tree' '
=20
 '
=20
+test_expect_success 'check fully quoted output from ls-tree' '
+
+	git ls-tree --name-only -r HEAD >current &&
+	test_cmp expect.quoted current
+
+'
+
 test_expect_success 'setting core.quotepath' '
=20
 	git config --bool core.quotepath false
@@ -130,4 +140,11 @@ test_expect_success 'check fully quoted output fro=
m diff-tree' '
=20
 '
=20
+test_expect_success 'check fully quoted output from ls-tree' '
+
+	git ls-tree --name-only -r HEAD >current &&
+	test_cmp expect.raw current
+
+'
+
 test_done
--=20
1.7.0.rc1.16.g21332.dirty
