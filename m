From: tboegi@web.de
Subject: [PATCH v1 7/7] convert.c: more safer crlf handling with text attribute
Date: Tue, 29 Mar 2016 15:25:40 +0200
Message-ID: <1459257940-17428-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 15:23:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aktbm-0001Jv-Qj
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 15:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018AbcC2NWz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 09:22:55 -0400
Received: from mout.web.de ([212.227.15.3]:53208 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752746AbcC2NWu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 09:22:50 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0LZeYO-1a1hwx2THg-00lVA3; Tue, 29 Mar 2016 15:22:47
 +0200
X-Mailer: git-send-email 2.8.0.rc2.2.g1a4d45a.dirty
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:eO45h6tSmEC5lFCEkMgIUd/2Q2rKT7V9GGTidu4VRpShbIwvwe3
 Ryws+eMbDod500ZXHMyQF9FsTGB7DBdyCi08KxRDzr2towSpXwu16hEUDzyxyYq3IsOAhbS
 8RtcP/JWAQeAGvDhD6IrSwLl90qkr3EzTxdaCi/7J2FPf0GKa9heKoq9FuF1wQQQ+MAiqXL
 LUv7PikM8bD+ONqam1L6g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DiFK16lBJAI=:/UQ1naam+yc8765vCsnQep
 oxSby4NqzP77syjZSoamScLXxSbvB3JQm/UtGFZQVDEkw81Y+ANgviHWHZGu1uMRwTX1i0Bw6
 W5bDGXpJglXmCC+56RePmbQHrSAd+vuQsaZVbvOe+0j7I1tZaw286QoqGojjWhe5R7MITPDgk
 LtIKr3Nf7kDE12Ctc9EJyxbs89TVa9YSLHwiaUBVIjmyp8CMcYOvOcXajJqPXYoaBwP8fYsQm
 L7Io1zmK9okUKZcYWTXLSrWusf+Ht6HnrNxf2d8Ehnks6Woj3B0Op0TVYKhyW9KUHeBTDS2XZ
 XpB7AoCC5ILdQBDH5+dmjcwpWDVXMcIJ91Ef9PaGfjw+cz3Ys/9yieXLaycRNSPI8teWbDn1U
 M0xvMSdVCpCWigM+rGkziFAkOExt6DOmXNeUCRlFSePD7PXzxbw2LblWGWDYg+E3Ud1aURvWK
 oRv60Je/MeERx334Oj4zaBHgWgx0N0NzanhK4aJ4I6Hzv46EQt1vgiTbl2NrmcIb3k77jRzgL
 e+KwbzgQS7bMwBrvtv2IYRdNyufQ8bllY9sqKh//vKtKdMSV87gWHm+/1CTPg8Hp/c8ByQ79G
 iG6VhkF/vT9YHSJvjwu9Wbh7WmgOu4at2phRRNQYsvYhXXv1aLrhWusV+PNl8Zmh8lPM1bgX6
 rx1tq1tdRKFEN4uvxUxfoDj7JuWjU4cK3q/89uUeR6H7+Zy0mAIRVnTt0LyFXvPh5yh8QHZ6U
 MJokWULmS11arE+DqNjQlbShoBEvwbNu/jRAmm+Vfk0+99K7kA5HnkKaY766o5u31CzIsBkc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290130>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

A follow-up after a discussion how to fix the flaky execution
of t0025, gmane/$284352.

This patch extends the work done in commit c480539:
"Make it work also for un-normalized repositories". Make sure that CRLF
can be converted round trip, or don't convert them at all.

The old handling would treat a file as unchanged after checkout,
as long as it is not touched in the work tree and mtime matches the val=
ue
recorded in the index.
When the mtime is changed in the working tree, or the inode is changed,
the file is reported as modified.

The following sequence is now handled reproducable:
$ git init
$ printf "line1\r\n" >file.bat
$ git add file.bat
$ git commit -m "Add file with CRLF" file.bat
$ echo "*.bat text eol=3Dcrlf" >.gitattributes
$ git commit -m "bat files should have CRLF"
$ git status
 # nothing to commit, working directory clean
$ git push <upstream>
$ printf "newline\r\n" >>file.bat
$ mv file.bat file.sav
$ git checkout file.bat
$ git status
 #modified:   file.bat

The new handling makes sure that after running "git reset --hard".
"git status" reports the working tree as clean regarding CRLF conversio=
n.
It makes sure that the Git-internal eol conversion is
doing roundtrip. A user can still write an external smudge/clean filter
outside Git, which doesn't do a roundtrip and the working directory is
not clean.

The functionality of has_cr_in_index() is turned into has_crlf_in_index=
(),
and the function is integrated into would_convert_crlf_at_commit().

Check for CRLF in the index instead of CR, the bit CONVERT_STAT_BITS_AN=
Y_CR
is no longer used and removed, as well as "lonecr" in struct text_stat.

Rewrite check_safe_crlf() in convert.c to simulate checkin-checkout,
to detect whether any line endings are converted.

Modify the lf_to_crlf_filter:
=46iles with LF are converted into CRLF, file with CRLF are not changed=
=2E
=46iles with mixed line endings are not converted, the filter fails, an=
d Git
falls back to the non-streaming handling, see write_entry().

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 Documentation/gitattributes.txt |  10 +-
 convert.c                       | 215 ++++++++++++++++++++++++--------=
--------
 t/t0025-crlf-auto.sh            |   8 +-
 t/t0027-auto-crlf.sh            |  38 +++----
 4 files changed, 158 insertions(+), 113 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index 43b70b5..7929880 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -110,7 +110,7 @@ repository upon 'git add' and 'git commit'.
 `text`
 ^^^^^^
=20
-This attribute enables and controls end-of-line normalization.  When a
+This attribute enables and controls end-of-line conversion.  When a
 text file is normalized, its line endings are converted to LF in the
 repository.  To control what line ending style is used in the working
 directory, use the `eol` attribute for a single file and the
@@ -120,8 +120,11 @@ Note that `core.autocrlf` overrides `core.eol`
 Set::
=20
 	Setting the `text` attribute on a path enables end-of-line
-	normalization and marks the path as a text file.  End-of-line
+	conversion and marks the path as a text file.  End-of-line
 	conversion takes place without guessing the content type.
+	Files that have been commited with CRLF before the text attribute
+	is set and commited are not normalized. No end-of-line conversion
+	is done at checkout or checkin.
=20
 Unset::
=20
@@ -132,7 +135,8 @@ Set to string value "auto"::
=20
 	When `text` is set to "auto", the path is marked for automatic
 	end-of-line normalization.  If Git decides that the content is
-	text, its line endings are normalized to LF on checkin.
+	text, and the path has no CRLF in the index,
+	its line endings are converted to LF on checkin.
=20
 Unspecified::
=20
diff --git a/convert.c b/convert.c
index 02c50da..8266d87 100644
--- a/convert.c
+++ b/convert.c
@@ -17,7 +17,6 @@
 #define CONVERT_STAT_BITS_TXT_LF    0x1
 #define CONVERT_STAT_BITS_TXT_CRLF  0x2
 #define CONVERT_STAT_BITS_BIN       0x4
-#define CONVERT_STAT_BITS_ANY_CR    0x8
=20
 enum crlf_action {
 	CRLF_UNDEFINED,
@@ -32,7 +31,7 @@ enum crlf_action {
=20
 struct text_stat {
 	/* NUL, CR, LF and CRLF counts */
-	unsigned stat_bits, lonecr, lonelf, crlf;
+	unsigned stat_bits, lonelf;
=20
 	/* These are just approximations! */
 	unsigned printable, nonprintable;
@@ -48,13 +47,10 @@ static void do_gather_stats(const char *buf, unsign=
ed long size,
 	for (i =3D 0; i < size; i++) {
 		unsigned char c =3D buf[i];
 		if (c =3D=3D '\r') {
-			stats->stat_bits |=3D CONVERT_STAT_BITS_ANY_CR;
 			if (i+1 < size && buf[i+1] =3D=3D '\n') {
-				stats->crlf++;
 				i++;
 				stats->stat_bits |=3D CONVERT_STAT_BITS_TXT_CRLF;
 			} else {
-				stats->lonecr++;
 				stats->stat_bits |=3D CONVERT_STAT_BITS_BIN;
 			}
 			continue;
@@ -136,7 +132,7 @@ static unsigned get_convert_stats_sha1(const char *=
path,
 		if (!readlen)
 			break;
 		do_gather_stats(buf, (unsigned long)readlen, &stats, earlyout);
-		if (stats.stat_bits & earlyout)
+		if ((stats.stat_bits & earlyout) =3D=3D earlyout)
 			break; /* We found what we have been searching for */
 	}
 close_and_exit_i:
@@ -147,11 +143,9 @@ close_and_exit_i:
=20
 static const char *convert_stats_ascii(unsigned convert_stats)
 {
-	unsigned mask =3D CONVERT_STAT_BITS_TXT_LF |
-		CONVERT_STAT_BITS_TXT_CRLF;
 	if (convert_stats & CONVERT_STAT_BITS_BIN)
 		return "-text";
-	switch (convert_stats & mask) {
+	switch (convert_stats) {
 	case CONVERT_STAT_BITS_TXT_LF:
 		return "lf";
 	case CONVERT_STAT_BITS_TXT_CRLF:
@@ -163,7 +157,17 @@ static const char *convert_stats_ascii(unsigned co=
nvert_stats)
 	}
 }
=20
-static unsigned get_convert_stats_wt(const char *path)
+const char *get_cached_convert_stats_ascii(const char *path)
+{
+	unsigned convert_stats;
+	unsigned earlyout =3D CONVERT_STAT_BITS_BIN;
+	convert_stats =3D get_convert_stats_sha1(path,
+					       get_sha1_from_cache(path),
+					       earlyout);
+	return convert_stats_ascii(convert_stats);
+}
+
+const char *get_wt_convert_stats_ascii(const char *path)
 {
 	struct text_stat stats;
 	unsigned earlyout =3D CONVERT_STAT_BITS_BIN;
@@ -185,24 +189,7 @@ static unsigned get_convert_stats_wt(const char *p=
ath)
 	}
 	close(fd);
 	convert_nonprintable(&stats);
-	return stats.stat_bits;
-}
-
-const char *get_cached_convert_stats_ascii(const char *path)
-{
-	unsigned convert_stats;
-	unsigned earlyout =3D CONVERT_STAT_BITS_BIN;
-	convert_stats =3D get_convert_stats_sha1(path,
-					       get_sha1_from_cache(path),
-					       earlyout);
-	return convert_stats_ascii(convert_stats);
-}
-
-const char *get_wt_convert_stats_ascii(const char *path)
-{
-	unsigned convert_stats;
-	convert_stats =3D get_convert_stats_wt(path);
-	return convert_stats_ascii(convert_stats);
+	return convert_stats_ascii(stats.stat_bits);
 }
=20
 static int text_eol_is_crlf(void)
@@ -241,53 +228,90 @@ static enum eol output_eol(enum crlf_action crlf_=
action)
 	return core_eol;
 }
=20
+static int would_convert_lf_at_checkout(unsigned convert_stats,
+					size_t len,
+					enum crlf_action crlf_action)
+{
+	if (output_eol(crlf_action) !=3D EOL_CRLF)
+		return 0;
+
+	/* No "naked" LF? Nothing to convert, regardless. */
+	if (!convert_stats & CONVERT_STAT_BITS_TXT_LF)
+		return 0;
+
+	if (crlf_action =3D=3D CRLF_AUTO ||
+	    crlf_action =3D=3D CRLF_AUTO_INPUT ||
+	    crlf_action =3D=3D CRLF_AUTO_CRLF) {
+		/* auto: binary files are not converted */
+		if (convert_stats & CONVERT_STAT_BITS_BIN)
+			return 0;
+	}
+	/* If we have any CRLF line endings, we do not touch it */
+	/* This is the new safer autocrlf-handling */
+	if (convert_stats & CONVERT_STAT_BITS_TXT_CRLF)
+		return 0;
+	return 1;
+
+}
+
+static int would_convert_crlf_at_commit(const char * path,
+					const struct text_stat *stats,
+					size_t len,
+					enum crlf_action crlf_action)
+{
+	unsigned stat_bits_index;
+	/* No CRLF? Nothing to convert, regardless. */
+	if (!(stats->stat_bits & CONVERT_STAT_BITS_TXT_CRLF))
+		return 0;
+	/*
+	 * If the file in the index has any CRLF in it, do not convert.
+	 * This is the new safer autocrlf handling.
+	 */
+	stat_bits_index =3D get_convert_stats_sha1(path,
+						 get_sha1_from_cache(path),
+						 CONVERT_STAT_BITS_TXT_CRLF);
+	if (stat_bits_index & CONVERT_STAT_BITS_TXT_CRLF)
+		return 0;
+	return 1;
+}
+
 static void check_safe_crlf(const char *path, enum crlf_action crlf_ac=
tion,
-                            struct text_stat *stats, enum safe_crlf ch=
ecksafe)
+			    enum safe_crlf checksafe,
+			    unsigned convert_stats, unsigned new_convert_stats)
 {
 	if (!checksafe)
 		return;
-
-	if (output_eol(crlf_action) =3D=3D EOL_LF) {
+	if (convert_stats & CONVERT_STAT_BITS_TXT_CRLF &&
+	    !(new_convert_stats & CONVERT_STAT_BITS_TXT_CRLF)) {
 		/*
 		 * CRLFs would not be restored by checkout:
 		 * check if we'd remove CRLFs
 		 */
-		if (stats->crlf) {
-			if (checksafe =3D=3D SAFE_CRLF_WARN)
-				warning("CRLF will be replaced by LF in %s.\nThe file will have it=
s original line endings in your working directory.", path);
-			else /* i.e. SAFE_CRLF_FAIL */
-				die("CRLF would be replaced by LF in %s.", path);
-		}
-	} else if (output_eol(crlf_action) =3D=3D EOL_CRLF) {
+		if (checksafe =3D=3D SAFE_CRLF_WARN)
+			warning("CRLF will be replaced by LF in %s.\nThe file will have its=
 original line endings in your working directory.", path);
+		else /* i.e. SAFE_CRLF_FAIL */
+			die("CRLF would be replaced by LF in %s.", path);
+	}
+	if (convert_stats & CONVERT_STAT_BITS_TXT_LF &&
+	    !(new_convert_stats & CONVERT_STAT_BITS_TXT_LF)) {
 		/*
 		 * CRLFs would be added by checkout:
 		 * check if we have "naked" LFs
 		 */
-		if (stats->lonelf) {
-			if (checksafe =3D=3D SAFE_CRLF_WARN)
-				warning("LF will be replaced by CRLF in %s.\nThe file will have it=
s original line endings in your working directory.", path);
-			else /* i.e. SAFE_CRLF_FAIL */
-				die("LF would be replaced by CRLF in %s", path);
-		}
+		if (checksafe =3D=3D SAFE_CRLF_WARN)
+			warning("LF will be replaced by CRLF in %s.\nThe file will have its=
 original line endings in your working directory.", path);
+		else /* i.e. SAFE_CRLF_FAIL */
+			die("LF would be replaced by CRLF in %s", path);
 	}
 }
=20
-static int has_cr_in_index(const char *path)
-{
-	unsigned convert_stats;
-	convert_stats =3D get_convert_stats_sha1(path,
-					       get_sha1_from_cache(path),
-					       CONVERT_STAT_BITS_ANY_CR);
-	return convert_stats & CONVERT_STAT_BITS_ANY_CR;
-}
-
 static int crlf_to_git(const char *path, const char *src, size_t len,
 		       struct strbuf *buf,
 		       enum crlf_action crlf_action, enum safe_crlf checksafe)
 {
 	struct text_stat stats;
 	char *dst;
-
+	int convert_crlf;
 	if (crlf_action =3D=3D CRLF_BINARY ||
 	    (src && !len))
 		return 0;
@@ -299,23 +323,36 @@ static int crlf_to_git(const char *path, const ch=
ar *src, size_t len,
 	if (!buf && !src)
 		return 1;
=20
-	gather_stats(src, len, &stats, CONVERT_STAT_BITS_BIN);
-
-	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {
+	if (crlf_action =3D=3D CRLF_AUTO ||
+	    crlf_action =3D=3D CRLF_AUTO_INPUT ||
+	    crlf_action =3D=3D CRLF_AUTO_CRLF) {
+		gather_stats(src, len, &stats, CONVERT_STAT_BITS_BIN);
 		if (stats.stat_bits & CONVERT_STAT_BITS_BIN)
 			return 0;
-		/*
-		 * If the file in the index has any CR in it, do not convert.
-		 * This is the new safer autocrlf handling.
-		 */
-		if (has_cr_in_index(path))
-			return 0;
+	} else {
+		gather_stats(src, len, &stats, 0);
 	}
-
-	check_safe_crlf(path, crlf_action, &stats, checksafe);
-
-	/* Optimization: No CRLF? Nothing to convert, regardless. */
-	if (!stats.crlf)
+	convert_crlf =3D would_convert_crlf_at_commit(path, &stats, len,
+						    crlf_action);
+	if (checksafe) {
+		unsigned convert_stats =3D stats.stat_bits;
+		unsigned new_convert_stats =3D convert_stats;
+		/* Simulate commit */
+		if (convert_crlf &&
+		    (new_convert_stats & CONVERT_STAT_BITS_TXT_CRLF)) {
+			new_convert_stats |=3D CONVERT_STAT_BITS_TXT_LF;
+			new_convert_stats &=3D ~CONVERT_STAT_BITS_TXT_CRLF;
+		}
+		/* Simulate checkout */
+		if (would_convert_lf_at_checkout(new_convert_stats,
+						 len, crlf_action)) {
+			new_convert_stats |=3D CONVERT_STAT_BITS_TXT_CRLF;
+			new_convert_stats &=3D ~CONVERT_STAT_BITS_TXT_LF;
+		}
+		check_safe_crlf(path, crlf_action, checksafe,
+				convert_stats, new_convert_stats);
+	}
+	if (!convert_crlf)
 		return 0;
=20
 	/*
@@ -329,7 +366,9 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
 	if (strbuf_avail(buf) + buf->len < len)
 		strbuf_grow(buf, len - buf->len);
 	dst =3D buf->buf;
-	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {
+	if (crlf_action =3D=3D CRLF_AUTO ||
+	    crlf_action =3D=3D CRLF_AUTO_INPUT ||
+	    crlf_action =3D=3D CRLF_AUTO_CRLF) {
 		/*
 		 * If we guessed, we already know we rejected a file with
 		 * lone CR, and we can strip a CR without looking at what
@@ -356,28 +395,15 @@ static int crlf_to_worktree(const char *path, con=
st char *src, size_t len,
 {
 	char *to_free =3D NULL;
 	struct text_stat stats;
-	unsigned earlyout =3D CONVERT_STAT_BITS_TXT_CRLF | CONVERT_STAT_BITS_=
BIN;
-
-
-	if (!len || output_eol(crlf_action) !=3D EOL_CRLF)
+	unsigned earlyout =3D 0; /* Need to count lonelf */
+	if (!len)
 		return 0;
=20
 	gather_stats(src, len, &stats, earlyout);
-
-	/* No "naked" LF? Nothing to convert, regardless. */
-	if (!stats.lonelf)
+	if (!would_convert_lf_at_checkout(stats.stat_bits,
+					  len, crlf_action))
 		return 0;
=20
-	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {
-		/* If we have any CR or CRLF line endings, we do not touch it */
-		/* This is the new safer autocrlf-handling */
-		if (stats.lonecr || stats.crlf )
-			return 0;
-
-		if (stats.stat_bits & CONVERT_STAT_BITS_BIN)
-			return 0;
-	}
-
 	/* are we "faking" in place editing ? */
 	if (src =3D=3D buf->buf)
 		to_free =3D strbuf_detach(buf, NULL);
@@ -1079,6 +1105,8 @@ int is_null_stream_filter(struct stream_filter *f=
ilter)
 struct lf_to_crlf_filter {
 	struct stream_filter filter;
 	unsigned has_held:1;
+	unsigned expanded_loneLF:1;
+	unsigned had_CRLF:1;
 	char held;
 };
=20
@@ -1119,7 +1147,12 @@ static int lf_to_crlf_filter_fn(struct stream_fi=
lter *filter,
 			char ch =3D input[i];
=20
 			if (ch =3D=3D '\n') {
-				output[o++] =3D '\r';
+				if (!lf_to_crlf->had_CRLF) {
+					output[o++] =3D '\r';
+					lf_to_crlf->expanded_loneLF =3D 1;
+				}
+				if (was_cr)
+					lf_to_crlf->had_CRLF =3D 1;
 			} else if (was_cr) {
 				/*
 				 * Previous round saw CR and it is not followed
@@ -1148,6 +1181,14 @@ static int lf_to_crlf_filter_fn(struct stream_fi=
lter *filter,
=20
 			was_cr =3D 0;
 			output[o++] =3D ch;
+			if (lf_to_crlf->expanded_loneLF &&
+			    lf_to_crlf->had_CRLF) {
+				/*
+				 * Mixed EOL, round trip not possible.
+				 */
+				return 1;
+			}
+
 		}
=20
 		*osize_p -=3D o;
diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index d0bee08..b5f93e2 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -39,7 +39,7 @@ test_expect_success 'default settings cause no change=
s' '
 	test -z "$LFonlydiff" -a -z "$CRLFonlydiff" -a -z "$LFwithNULdiff"
 '
=20
-test_expect_success 'crlf=3Dtrue causes a CRLF file to be normalized' =
'
+test_expect_success 'crlf=3Dtrue causes a CRLF file not to be normaliz=
ed' '
=20
 	# Backwards compatibility check
 	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
@@ -49,10 +49,10 @@ test_expect_success 'crlf=3Dtrue causes a CRLF file=
 to be normalized' '
 	# Note, "normalized" means that git will normalize it if added
 	has_cr CRLFonly &&
 	CRLFonlydiff=3D$(git diff CRLFonly) &&
-	test -n "$CRLFonlydiff"
+	test -z "$CRLFonlydiff"
 '
=20
-test_expect_success 'text=3Dtrue causes a CRLF file to be normalized' =
'
+test_expect_success 'text=3Dtrue causes a CRLF file not to be normaliz=
ed' '
=20
 	rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
 	echo "CRLFonly text" > .gitattributes &&
@@ -61,7 +61,7 @@ test_expect_success 'text=3Dtrue causes a CRLF file t=
o be normalized' '
 	# Note, "normalized" means that git will normalize it if added
 	has_cr CRLFonly &&
 	CRLFonlydiff=3D$(git diff CRLFonly) &&
-	test -n "$CRLFonlydiff"
+	test -z "$CRLFonlydiff"
 '
=20
 test_expect_success 'eol=3Dcrlf gives a normalized file CRLFs with aut=
ocrlf=3Dfalse' '
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 86175cf..3fa9be4 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -354,7 +354,7 @@ else
 	WAMIX=3DCRLF_LF
 fi
=20
-#                         attr   LF        CRLF      CRLFmixLF LFmixCR=
   CRLFNUL
+#                               attr   LF        CRLF      CRLFmixLF L=
=46mixCR   CRLFNUL
 test_expect_success 'commit files empty attr' '
 	commit_check_warn false ""     ""        ""        ""        ""      =
  "" &&
 	commit_check_warn true  ""     "LF_CRLF" ""        "LF_CRLF" ""      =
  "" &&
@@ -391,7 +391,7 @@ test_expect_success 'commit files attr=3Dcrlf' '
 	commit_check_warn input "crlf" "LF_CRLF" ""        "LF_CRLF" "LF_CRLF=
" ""
 '
=20
-#                 attr                    LF        CRLF      CRLFmixL=
=46   LF_mix_CR   CRLFNUL
+#                 attr    aeol    ceol    LF        CRLF      CRLFmixL=
=46   LF_mix_CR   CRLFNUL
 commit_chk_wrnNNO ""      ""      false   ""        ""        ""      =
    ""          ""
 commit_chk_wrnNNO ""      ""      true    LF_CRLF   ""        ""      =
    ""          ""
 commit_chk_wrnNNO ""      ""      input   ""        ""        ""      =
    ""          ""
@@ -401,20 +401,22 @@ commit_chk_wrnNNO "auto"  ""      true    LF_CRLF=
   ""        ""          ""
 commit_chk_wrnNNO "auto"  ""      input   ""        ""        ""      =
    ""          ""
 for crlf in true false input;
 do
+#                          attr aeol    ceol    LF        CRLF      CR=
LFmixLF   LF_mix_CR   CRLFNUL
 	commit_chk_wrnNNO -text ""      $crlf   ""        ""        ""       =
   ""          ""
 	commit_chk_wrnNNO -text lf      $crlf   ""        ""        ""       =
   ""          ""
 	commit_chk_wrnNNO -text crlf    $crlf   ""        ""        ""       =
   ""          ""
-	commit_chk_wrnNNO ""    lf      $crlf   ""       CRLF_LF    CRLF_LF  =
    ""         CRLF_LF
-	commit_chk_wrnNNO ""    crlf    $crlf   LF_CRLF   ""        LF_CRLF  =
   LF_CRLF     ""
+	commit_chk_wrnNNO ""    lf      $crlf   ""        ""        ""       =
   ""          ""
+	commit_chk_wrnNNO ""    crlf    $crlf   LF_CRLF   ""        ""       =
   LF_CRLF     ""
 	commit_chk_wrnNNO auto  lf    	$crlf   ""        ""        ""        =
  ""          ""
 	commit_chk_wrnNNO auto  crlf  	$crlf   LF_CRLF   ""        ""        =
  ""          ""
-	commit_chk_wrnNNO text  lf    	$crlf   ""       CRLF_LF    CRLF_LF   =
  ""          CRLF_LF
-	commit_chk_wrnNNO text  crlf  	$crlf   LF_CRLF   ""        LF_CRLF   =
  LF_CRLF     ""
+	commit_chk_wrnNNO text  lf    	$crlf   ""        ""        ""        =
  ""          ""
+	commit_chk_wrnNNO text  crlf  	$crlf   LF_CRLF   ""        ""        =
  LF_CRLF     ""
 done
=20
-commit_chk_wrnNNO "text"  ""      false   "$WILC"   "$WICL"   "$WAMIX"=
    "$WILC"     "$WICL"
-commit_chk_wrnNNO "text"  ""      true    LF_CRLF   ""        LF_CRLF =
    LF_CRLF     ""
-commit_chk_wrnNNO "text"  ""      input   ""        CRLF_LF   CRLF_LF =
    ""          CRLF_LF
+#                  attr   aeol    ceol    LF        CRLF      CRLFmixL=
=46   LF_mix_CR   CRLFNUL
+commit_chk_wrnNNO "text"  ""      false   "$WILC"   ""        ""      =
    "$WILC"     ""
+commit_chk_wrnNNO "text"  ""      true    LF_CRLF   ""        ""      =
    LF_CRLF     ""
+commit_chk_wrnNNO "text"  ""      input   ""        ""        ""      =
    ""          ""
=20
 test_expect_success 'create files cleanup' '
 	rm -f *.txt &&
@@ -455,9 +457,9 @@ do
 	check_in_repo_NNO auto  ""     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
 	check_in_repo_NNO auto  lf     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
 	check_in_repo_NNO auto  crlf   $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
-	check_in_repo_NNO text  ""     $crlf   LF  LF    LF           LF_mix_=
CR  LF_nul
-	check_in_repo_NNO text  lf     $crlf   LF  LF    LF           LF_mix_=
CR  LF_nul
-	check_in_repo_NNO text  crlf   $crlf   LF  LF    LF           LF_mix_=
CR  LF_nul
+	check_in_repo_NNO text  ""     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
+	check_in_repo_NNO text  lf     $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
+	check_in_repo_NNO text  crlf   $crlf   LF  CRLF  CRLF_mix_LF  LF_mix_=
CR  CRLF_nul
 done
 ######################################################################=
##########
 # Check how files in the repo are changed when they are checked out
@@ -478,12 +480,10 @@ done
=20
 if test_have_prereq NATIVE_CRLF
 then
-MIX_CRLF_LF=3DCRLF
 MIX_LF_CR=3DCRLF_mix_CR
 NL=3DCRLF
 LFNUL=3DCRLF_nul
 else
-MIX_CRLF_LF=3DCRLF_mix_LF
 MIX_LF_CR=3DLF_mix_CR
 NL=3DLF
 LFNUL=3DLF_nul
@@ -503,20 +503,20 @@ do
 			checkout_files "-text" "$id" "lf"   "$crlf"  "$ceol"    LF    CRLF =
 CRLF_mix_LF  LF_mix_CR    LF_nul
 			checkout_files "-text" "$id" "crlf" "$crlf"  "$ceol"    LF    CRLF =
 CRLF_mix_LF  LF_mix_CR    LF_nul
 			checkout_files "text"  "$id" "lf"   "$crlf"  "$ceol"    LF    CRLF =
 CRLF_mix_LF  LF_mix_CR    LF_nul
-			checkout_files "text"  "$id" "crlf" "$crlf"  "$ceol"    CRLF  CRLF =
 CRLF         CRLF_mix_CR  CRLF_nul
+			checkout_files "text"  "$id" "crlf" "$crlf"  "$ceol"    CRLF  CRLF =
 CRLF_mix_LF  CRLF_mix_CR  CRLF_nul
 		done
 	done
 	# text: core.autocrlf=3Dfalse uses core.eol
-	checkout_files "text"  "$id"  ""    false  crlf     CRLF  CRLF  CRLF =
        CRLF_mix_CR  CRLF_nul
+	checkout_files "text"  "$id"  ""    false  crlf     CRLF  CRLF  CRLF_=
mix_LF  CRLF_mix_CR  CRLF_nul
 	checkout_files "text"  "$id"  ""    false  lf       LF    CRLF  CRLF_=
mix_LF  LF_mix_CR    LF_nul
 	# text: core.autocrlf=3Dfalse and core.eol unset(or native) uses nati=
ve eol
-	checkout_files "text"  "$id"  ""    false  ""       $NL   CRLF  $MIX_=
CRLF_LF $MIX_LF_CR   $LFNUL
-	checkout_files "text"  "$id"  ""    false  native   $NL   CRLF  $MIX_=
CRLF_LF $MIX_LF_CR   $LFNUL
+	checkout_files "text"  "$id"  ""    false  ""       $NL   CRLF  CRLF_=
mix_LF  $MIX_LF_CR   $LFNUL
+	checkout_files "text"  "$id"  ""    false  native   $NL   CRLF  CRLF_=
mix_LF  $MIX_LF_CR   $LFNUL
=20
 	for ceol in "" lf crlf native;
 	do
 		# text: core.autocrlf =3D true overrides core.eol
-		checkout_files "text"  "$id"  ""    true   "$ceol"  CRLF  CRLF  CRLF=
         CRLF_mix_CR  CRLF_nul
+		checkout_files "text"  "$id"  ""    true   "$ceol"  CRLF  CRLF  CRLF=
_mix_LF  CRLF_mix_CR  CRLF_nul
 		# text: core.autocrlf =3D input overrides core.eol
 		checkout_files "text"  "$id"  ""    input  "$ceol"  LF    CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
 		checkout_files "auto"  "$id"  ""    input  "$ceol"  LF    CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
--=20
2.8.0.rc2.6.g3847ccb
