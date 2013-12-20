From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 00/12] Hard coded string length cleanup
Date: Fri, 20 Dec 2013 02:06:07 +0100
Message-ID: <52B397FF.4050808@web.de>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com> <52B38213.2070702@web.de> <CACsJy8Bb4+V1DEdEmRwj10Oozi8U430ZHDCj_UhnXZcaR-wQ=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 20 02:06:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtoXg-0001iC-Fo
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 02:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756796Ab3LTBGM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Dec 2013 20:06:12 -0500
Received: from mout.web.de ([212.227.17.11]:61753 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756516Ab3LTBGL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 20:06:11 -0500
Received: from [192.168.178.27] ([79.253.137.64]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MSJH1-1W45RC1z6B-00TYLM for <git@vger.kernel.org>;
 Fri, 20 Dec 2013 02:06:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <CACsJy8Bb4+V1DEdEmRwj10Oozi8U430ZHDCj_UhnXZcaR-wQ=g@mail.gmail.com>
X-Provags-ID: V03:K0:tRlavLZrGk1BFlxYJu0se9p2O84EGJ0MP6b9fU3l7lv2inuFARe
 z8zjmWH6Vh3B3EaAYpXvY+N4HDPdAe4ybW5FxzbDvvl/grXGccDhCplbecdBZi+xRCgP5qW
 gQTXGgKhN+EfrdU34FKylfPC3cbaMQLbIbjmi9ph1UvwAAsnc5YNRX4QTCZpg8kNwc1NkYE
 ldVjOe+SdKTVV6iW9+mCg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239561>

Am 20.12.2013 00:50, schrieb Duy Nguyen:
> On Fri, Dec 20, 2013 at 6:32 AM, Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>> Seeing that skip_prefix_defval is mostly used in the form
>> skip_prefix_defval(foo, prefix, foo) I wonder if it makes sense to
>> first change skip_prefix to return the full string instead of NULL
>> if the prefix is not matched.  Would the resulting function cover
>> most use cases?  And would it still be easily usable?
>=20
> That was skip_prefix_gently() that I forgot to replace in a commit
> message, before I turned it into _defval variant. The reason for
> _defval is it could be use to chain expression together without addin=
g
> temporary variables, e.g.
>=20
> -       if (starts_with(line->buf, ">From") && isspace(line->buf[5]))=
 {
> +       if (isspace(*skip_prefix_defval(line->buf, ">From", "NOSPACE"=
))) {
>=20
> Without _defval, one would need to do if ((p =3D skip_prefix(..)) &&
> isspace(*p)). I'm not entirely sure this is a good thing though as it
> could make it a bit harder to read.

That usage is quite rare compared to occurrences of
skip_prefix_defval(foo, prefix, foo), no?  Adding a temporary variable
for them wouldn't be that bad if we can simplify the API to a single
function -- if that one is usable, that is.

On the other hand, we could add a special function for that example
and we'd already have three users in the tree (patch below).  I think
that's too narrow a use case for a library function, though.  Doing
the following instead in the three cases doesn't seem to be too bad:

	rest =3D skip_prefix(line->buf, ">From");
	if (rest !=3D line->buf && isspace(*rest)) {

---
 builtin/apply.c    | 2 +-
 builtin/mailinfo.c | 4 ++--
 git-compat-util.h  | 1 +
 strbuf.c           | 9 +++++++++
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index b0d0986..b96befd 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -433,7 +433,7 @@ static unsigned long linelen(const char *buffer, un=
signed long size)
=20
 static int is_dev_null(const char *str)
 {
-	return !memcmp("/dev/null", str, 9) && isspace(str[9]);
+	return skip_prefix_and_space(str, "/dev/null") !=3D str;
 }
=20
 #define TERM_SPACE	1
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 2c3cd8e..2575989 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -328,11 +328,11 @@ static int check_header(const struct strbuf *line=
,
 	}
=20
 	/* for inbody stuff */
-	if (starts_with(line->buf, ">From") && isspace(line->buf[5])) {
+	if (skip_prefix_and_space(line->buf, ">From") !=3D line->buf) {
 		ret =3D 1; /* Should this return 0? */
 		goto check_header_out;
 	}
-	if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7])) {
+	if (skip_prefix_and_space(line->buf, "[PATCH]") !=3D line->buf) {
 		for (i =3D 0; header[i]; i++) {
 			if (!memcmp("Subject", header[i], 7)) {
 				handle_header(&hdr_data[i], line);
diff --git a/git-compat-util.h b/git-compat-util.h
index dcb92c4..a083918 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -355,6 +355,7 @@ extern int prefixcmp(const char *str, const char *p=
refix);
 extern int ends_with(const char *str, const char *suffix);
 extern int suffixcmp(const char *str, const char *suffix);
 extern const char *skip_prefix(const char *str, const char *prefix);
+extern const char *skip_prefix_and_space(const char *str, const char *=
prefix);
=20
 #if defined(NO_MMAP) || defined(USE_WIN32_MMAP)
=20
diff --git a/strbuf.c b/strbuf.c
index 222df13..768331f 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -47,6 +47,15 @@ const char *skip_prefix(const char *str, const char =
*prefix)
 			return str;
 }
=20
+const char *skip_prefix_and_space(const char *str, const char *prefix)
+{
+	const char *p =3D skip_prefix(str, prefix);
+	if (((p !=3D str) || !*prefix) && isspace(*p))
+		return p + 1;
+	else
+		return str;
+}
+
 /*
  * Used as the default ->buf value, so that people can always assume
  * buf is non NULL and ->buf is NUL terminated even for a freshly
--=20
1.8.5.2
