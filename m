From: tboegi@web.de
Subject: [PATCH v6 06/10] convert.c: stream and early out
Date: Fri, 22 Apr 2016 16:53:51 +0200
Message-ID: <1461336831-5224-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 16:50:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atcPc-0003rx-0p
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 16:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369AbcDVOuC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Apr 2016 10:50:02 -0400
Received: from mout.web.de ([212.227.17.12]:51628 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754104AbcDVOtn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 10:49:43 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MKrPw-1atcOr2Er2-0000th; Fri, 22 Apr 2016 16:49:41
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:2PydfzhDYPeqi1Imz0BvOlSZBlnhAisQv21Js4kMCC2z/kyZEfr
 yt2z471mB2uy+fqrUq9VGh79mHwn23FEr7xXW0slHek+oqgRqTmlPjLUpBTcYf8UMq7g8Hw
 aV3fNUtetcNPzsw9KoIWAfWvvSGVQ/q744LtkS+tlv/Dwc5QFdfm3lcZ9IG8u5JqwtSBrSw
 95OgubixHVv2dcbKxHotg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZL38CPJMgiA=:BSAh5rvyZtSeobvc7OvrQI
 ZvMaKNepAs/84fhMMjodiMU6WqGm7ekufwUW84sK8uLRX6dB57no7jlqAGHK029B5F4SNjfcV
 dQOzGchBWvMRa51vkoDCtRrpqGYTCRLTPaNWkCz+w+tdkCbU+oIIWv1FQgyt84zdwnDanOfL2
 p3rv+oRYspyK6cL/MFZc9H2Z2i74oFTgzT5HFChgxpWPiPngZvgjtUZc2nCQanY1mhuev/Wm9
 o499VEvGyDVfZyDiLh7R1lwIFcd3Pu8iGKZXmJNdrZgBAOAfAx//G2wjBZgiXMpSjBTOgR4ix
 KlOHhXbDmjX5w+jav95wMkPN/DLlfgeZv2eE63hickz5/OFkuPJkozDvzYznYdoz6oyBTQ72U
 NFDqEh6WCrXqwwk8V7whzUaVGNWYgZUlTqcNHC6T9gIyV4ODyTkRDJSr7XFEXkX8tcAGecU+m
 nRgaROhDyYXJTRcALuhgwtC11uQhV/w9M4QOxrtzo7HZ2ueQVQowf7TI6udBigHXAPq86zTI3
 haZ6plbmulrMSm0PoeulxZe0FWfAMOSubTQ2gf3WFW4bHH/lwL1hMCMkssgvbe7slMP6PBgtW
 kkIxwGw9otFYV0C6NU6T0B105fvyNNRndpOqz9EZI/jekuqaN3bC7hhxTPzXI35Qnr7VKgii4
 tCJFhnHmhm4lvpoHIvq25kCzMUVhdgGO+aQp/fcb2f/ZkbHblWUQL7dGvyfeIYZXV/5DFz2o3
 v+qpIuw4Lia5CUXzQfdNKlf4512pF5lMjhSKXQinMbT2k+JLEIdZcp0BkoB1ZPZbBmabb+uv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292219>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

When statistics are done for the autocrlf handling, the search in
the content can be stopped, if e.g
- a search for binary is done, and a NUL character is found
- a search for CRLF is done, and the first CRLF is found.

Similar when statistics for binary vs non-binary are gathered:
Whenever a lone CR or NUL is found, the search can be aborted.

When checking out files in "auto" mode, any file that has a "lone CR"
or a CRLF will not be converted, so the search can be aborted early.

Add the new bit, CONVERT_STAT_BITS_ANY_CR,
which is set for either lone CR or CRLF.

Many binary files have a NUL very early (within the first few bytes,
latest within the first 1..2K).
It is often not necessary to load the whole content of a file or blob
into memory.

Use a streaming handling for blobs and files in the worktree.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 convert.c | 159 ++++++++++++++++++++++++++++++++++++++++--------------=
--------
 1 file changed, 103 insertions(+), 56 deletions(-)

diff --git a/convert.c b/convert.c
index b1614bf..24ab095 100644
--- a/convert.c
+++ b/convert.c
@@ -3,6 +3,7 @@
 #include "run-command.h"
 #include "quote.h"
 #include "sigchain.h"
+#include "streaming.h"
=20
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -13,10 +14,10 @@
  * translation when the "text" attribute or "auto_crlf" option is set.
  */
=20
-/* Stat bits: When BIN is set, the txt bits are unset */
 #define CONVERT_STAT_BITS_TXT_LF    0x1
 #define CONVERT_STAT_BITS_TXT_CRLF  0x2
 #define CONVERT_STAT_BITS_BIN       0x4
+#define CONVERT_STAT_BITS_ANY_CR    0x8
=20
 enum crlf_action {
 	CRLF_UNDEFINED,
@@ -31,30 +32,36 @@ enum crlf_action {
=20
 struct text_stat {
 	/* NUL, CR, LF and CRLF counts */
-	unsigned nul, lonecr, lonelf, crlf;
+	unsigned stat_bits, lonecr, lonelf, crlf;
=20
 	/* These are just approximations! */
 	unsigned printable, nonprintable;
 };
=20
-static void gather_stats(const char *buf, unsigned long size, struct t=
ext_stat *stats)
+static void do_gather_stats(const char *buf, unsigned long size,
+			    struct text_stat *stats, unsigned earlyout)
 {
 	unsigned long i;
=20
-	memset(stats, 0, sizeof(*stats));
-
+	if (!buf || !size)
+		return;
 	for (i =3D 0; i < size; i++) {
 		unsigned char c =3D buf[i];
 		if (c =3D=3D '\r') {
+			stats->stat_bits |=3D CONVERT_STAT_BITS_ANY_CR;
 			if (i+1 < size && buf[i+1] =3D=3D '\n') {
 				stats->crlf++;
 				i++;
-			} else
+				stats->stat_bits |=3D CONVERT_STAT_BITS_TXT_CRLF;
+			} else {
 				stats->lonecr++;
+				stats->stat_bits |=3D CONVERT_STAT_BITS_BIN;
+			}
 			continue;
 		}
 		if (c =3D=3D '\n') {
 			stats->lonelf++;
+			stats->stat_bits |=3D CONVERT_STAT_BITS_TXT_LF;
 			continue;
 		}
 		if (c =3D=3D 127)
@@ -67,7 +74,7 @@ static void gather_stats(const char *buf, unsigned lo=
ng size, struct text_stat *
 				stats->printable++;
 				break;
 			case 0:
-				stats->nul++;
+				stats->stat_bits |=3D CONVERT_STAT_BITS_BIN;
 				/* fall through */
 			default:
 				stats->nonprintable++;
@@ -75,6 +82,8 @@ static void gather_stats(const char *buf, unsigned lo=
ng size, struct text_stat *
 		}
 		else
 			stats->printable++;
+		if (stats->stat_bits & earlyout)
+			break; /* We found what we have been searching for */
 	}
=20
 	/* If file ends with EOF then don't count this EOF as non-printable. =
*/
@@ -86,41 +95,62 @@ static void gather_stats(const char *buf, unsigned =
long size, struct text_stat *
  * The same heuristics as diff.c::mmfile_is_binary()
  * We treat files with bare CR as binary
  */
-static int convert_is_binary(unsigned long size, const struct text_sta=
t *stats)
+static void convert_nonprintable(struct text_stat *stats)
 {
-	if (stats->lonecr)
-		return 1;
-	if (stats->nul)
-		return 1;
 	if ((stats->printable >> 7) < stats->nonprintable)
-		return 1;
-	return 0;
+		stats->stat_bits |=3D CONVERT_STAT_BITS_BIN;
+}
+
+static void gather_stats(const char *buf, unsigned long size,
+			 struct text_stat *stats, unsigned earlyout)
+{
+	memset(stats, 0, sizeof(*stats));
+	do_gather_stats(buf, size, stats, earlyout);
+	convert_nonprintable(stats);
 }
=20
-static unsigned int gather_convert_stats(const char *data, unsigned lo=
ng size)
+
+static unsigned get_convert_stats_sha1(unsigned const char *sha1,
+				       unsigned earlyout)
 {
+	struct git_istream *st;
 	struct text_stat stats;
-	int ret =3D 0;
-	if (!data || !size)
-		return 0;
-	gather_stats(data, size, &stats);
-	if (convert_is_binary(size, &stats))
-		ret |=3D CONVERT_STAT_BITS_BIN;
-	if (stats.crlf)
-		ret |=3D CONVERT_STAT_BITS_TXT_CRLF;
-	if (stats.lonelf)
-		ret |=3D  CONVERT_STAT_BITS_TXT_LF;
+	enum object_type type;
+	unsigned long sz;
=20
-	return ret;
+	if (!sha1)
+		return 0;
+	memset(&stats, 0, sizeof(stats));
+	st =3D open_istream(sha1, &type, &sz, NULL);
+	if (!st) {
+		return 0;
+	}
+	if (type !=3D OBJ_BLOB)
+		goto close_and_exit_i;
+	for (;;) {
+		char buf[1024];
+		ssize_t readlen =3D read_istream(st, buf, sizeof(buf));
+		if (readlen < 0)
+			break;
+		if (!readlen)
+			break;
+		do_gather_stats(buf, (unsigned long)readlen, &stats, earlyout);
+		if (stats.stat_bits & earlyout)
+			break; /* We found what we have been searching for */
+	}
+close_and_exit_i:
+	close_istream(st);
+	convert_nonprintable(&stats);
+	return stats.stat_bits;
 }
=20
-static const char *gather_convert_stats_ascii(const char *data, unsign=
ed long size)
+static const char *convert_stats_ascii(unsigned convert_stats)
 {
-	unsigned int convert_stats =3D gather_convert_stats(data, size);
-
+	unsigned mask =3D CONVERT_STAT_BITS_TXT_LF |
+		CONVERT_STAT_BITS_TXT_CRLF;
 	if (convert_stats & CONVERT_STAT_BITS_BIN)
 		return "-text";
-	switch (convert_stats) {
+	switch (convert_stats & mask) {
 	case CONVERT_STAT_BITS_TXT_LF:
 		return "lf";
 	case CONVERT_STAT_BITS_TXT_CRLF:
@@ -132,24 +162,45 @@ static const char *gather_convert_stats_ascii(con=
st char *data, unsigned long si
 	}
 }
=20
+static unsigned get_convert_stats_wt(const char *path)
+{
+	struct text_stat stats;
+	unsigned earlyout =3D CONVERT_STAT_BITS_BIN;
+	int fd;
+	memset(&stats, 0, sizeof(stats));
+	fd =3D open(path, O_RDONLY);
+	if (fd < 0)
+		return 0;
+	for (;;) {
+		char buf[1024];
+		ssize_t readlen =3D read(fd, buf, sizeof(buf));
+		if (readlen < 0)
+			break;
+		if (!readlen)
+			break;
+		do_gather_stats(buf, (unsigned long)readlen, &stats, earlyout);
+		if (stats.stat_bits & earlyout)
+			break; /* We found what we have been searching for */
+	}
+	close(fd);
+	convert_nonprintable(&stats);
+	return stats.stat_bits;
+}
+
 const char *get_cached_convert_stats_ascii(const char *path)
 {
-	const char *ret;
-	unsigned long sz;
-	void *data =3D read_blob_data_from_cache(path, &sz);
-	ret =3D gather_convert_stats_ascii(data, sz);
-	free(data);
-	return ret;
+	unsigned convert_stats;
+	unsigned earlyout =3D CONVERT_STAT_BITS_BIN;
+	convert_stats =3D get_convert_stats_sha1(get_sha1_from_cache(path),
+					       earlyout);
+	return convert_stats_ascii(convert_stats);
 }
=20
 const char *get_wt_convert_stats_ascii(const char *path)
 {
-	const char *ret =3D "";
-	struct strbuf sb =3D STRBUF_INIT;
-	if (strbuf_read_file(&sb, path, 0) >=3D 0)
-		ret =3D gather_convert_stats_ascii(sb.buf, sb.len);
-	strbuf_release(&sb);
-	return ret;
+	unsigned convert_stats;
+	convert_stats =3D get_convert_stats_wt(path);
+	return convert_stats_ascii(convert_stats);
 }
=20
 static int text_eol_is_crlf(void)
@@ -219,16 +270,10 @@ static void check_safe_crlf(const char *path, enu=
m crlf_action crlf_action,
=20
 static int has_cr_in_index(const char *path)
 {
-	unsigned long sz;
-	void *data;
-	int has_cr;
-
-	data =3D read_blob_data_from_cache(path, &sz);
-	if (!data)
-		return 0;
-	has_cr =3D memchr(data, '\r', sz) !=3D NULL;
-	free(data);
-	return has_cr;
+	unsigned convert_stats;
+	convert_stats =3D get_convert_stats_sha1(get_sha1_from_cache(path),
+					       CONVERT_STAT_BITS_ANY_CR);
+	return convert_stats & CONVERT_STAT_BITS_ANY_CR;
 }
=20
 static int crlf_to_git(const char *path, const char *src, size_t len,
@@ -249,10 +294,10 @@ static int crlf_to_git(const char *path, const ch=
ar *src, size_t len,
 	if (!buf && !src)
 		return 1;
=20
-	gather_stats(src, len, &stats);
+	gather_stats(src, len, &stats, CONVERT_STAT_BITS_BIN);
=20
 	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {
-		if (convert_is_binary(len, &stats))
+		if (stats.stat_bits & CONVERT_STAT_BITS_BIN)
 			return 0;
=20
 		if (crlf_action =3D=3D CRLF_AUTO_INPUT || crlf_action =3D=3D CRLF_AU=
TO_CRLF) {
@@ -309,11 +354,13 @@ static int crlf_to_worktree(const char *path, con=
st char *src, size_t len,
 {
 	char *to_free =3D NULL;
 	struct text_stat stats;
+	unsigned earlyout =3D CONVERT_STAT_BITS_TXT_CRLF | CONVERT_STAT_BITS_=
BIN;
+
=20
 	if (!len || output_eol(crlf_action) !=3D EOL_CRLF)
 		return 0;
=20
-	gather_stats(src, len, &stats);
+	gather_stats(src, len, &stats, earlyout);
=20
 	/* No "naked" LF? Nothing to convert, regardless. */
 	if (!stats.lonelf)
@@ -327,7 +374,7 @@ static int crlf_to_worktree(const char *path, const=
 char *src, size_t len,
 				return 0;
 		}
=20
-		if (convert_is_binary(len, &stats))
+		if (stats.stat_bits & CONVERT_STAT_BITS_BIN)
 			return 0;
 	}
=20
--=20
2.8.0.rc2.2.g1a4d45a.dirty
