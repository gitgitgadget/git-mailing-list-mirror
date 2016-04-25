From: tboegi@web.de
Subject: [PATCH v7 08/10] convert.c: more safer crlf handling with text attribute
Date: Mon, 25 Apr 2016 18:56:38 +0200
Message-ID: <1461603398-30912-1-git-send-email-tboegi@web.de>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 18:52:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aujkT-0000Rw-8Y
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 18:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933164AbcDYQwZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 12:52:25 -0400
Received: from mout.web.de ([212.227.17.12]:54786 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933147AbcDYQwV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 12:52:21 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LaCbS-1bZ3BU2jCY-00m3DO; Mon, 25 Apr 2016 18:52:18
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:DkTd0OGRLev5FVGuKgIbMht4lK+Rw6JIsmiJWDUm9ZT9nBP7mSC
 tbZzRNkMuQ9izZ7Krq/Z8FPlSoTOYqFX4j9jYvjKXouawckZT9cXhFr+Wmc0gmL3I5hoS6e
 8D1GIOFZeHnzJDE0c3jvYwpsKj27TzfqPuwutg+iHoDUeCHqFJbkJYSxBfnMrUnVZMOdC4y
 EJxE8rQ4bBh/JL3WdV8Fg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7nzzWaYr9A0=:MTYoV/i9cUHlr+AiJZWDRg
 +4CBUFOo7HraMPY4jZKsTPn69bhg5LSz0f7zA+2rT7NN9ZvdKLqDaMAbX9rpozLxslT8tw4Qe
 H4ZdbxR1H8xoIcSsXcSUhbHi1YD+fF6mkAmZ9jqH5kv91EkXKYtMtRWR1baiby3duoKjtvR6s
 D8/3lshPHq+i+MsaRQh6Aq37lexX5HRIFxtIU8TPwSNbXVCDcspN/BboLTkEE4I4cxmnTjFwM
 yp9U+2CXEslhT7HmMXUmIgUvx9tWfN1UkFtRZQAjetnDTBbNU7hIgRyF15deK/7pbphmZGSSg
 7Rh+1FuJh0oNNJ1nE52qCPoKTyJdJxHyazkOGJxJygy4Vuj7DcJn0wUYqJDCzC4a2W+F/H4pM
 9kzWpJcZrBO70cdnG1hoQOOlGYSYqguxfwBIpalhjCSI14Qa/TUo5JOZ39dlPpnl2znI+j9o4
 9NNEi8INtLwwb9SvmgA65AZ7QWYM4OcIElzczCTQ0ck9Pxs0TlR0jKy48plQF+D34QoUxn5ue
 TAMclXGthYt17PcXOkSBQIR9shZr89a9/lNaw2BCtCaGK04uSQ3CtM8Weinn36UUjup3fX572
 2TyD8NjWgcOb0hJCv4onhf3UcRYn8Ns//kBoRX+gyTPlvqv60wIw1C1p7d7UAb/Oyg3Wa64V3
 DpVtCxuEh+SKat7wPVPAq8WmRDuI33EYrAa+dgLaW7/usjMK4mkRHntuqhtsuFtAc2rMeoeku
 sBzt4czYDKgRJAgAa49zQFFyLpc3JGKOB8jGRIFkXmQNJFFktWwUD9mE/cBhJ420c2dtzeEW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292519>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

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

Add a warning, similar to the CRLF-LF replacement, when a file is commi=
ted,
and after the next checkout the line endings are not what they should b=
e.

Modify the lf_to_crlf_filter:
=46iles with LF are converted into CRLF, file with CRLF are not changed=
=2E
=46iles with mixed line endings are not converted, the filter fails, an=
d Git
falls back to the non-streaming handling, see write_entry().

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 Documentation/gitattributes.txt |  19 ++--
 convert.c                       | 235 +++++++++++++++++++++++++-------=
--------
 t/t0025-crlf-auto.sh            |   8 +-
 t/t0027-auto-crlf.sh            |  92 ++++++++--------
 4 files changed, 213 insertions(+), 141 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
index d7a124b..836461d 100644
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
@@ -131,9 +134,9 @@ Unset::
 Set to string value "auto"::
=20
 	When `text` is set to "auto", the path is marked for automatic
-	end-of-line conversion.  If Git decides that the content is
-	text, its line endings are converted to LF on checkin.
-	When the file has been commited with CRLF, no conversion is done.
+	end-of-line normalization.  If Git decides that the content is
+	text, and the path has no CRLF in the index,
+	its line endings are converted to LF on checkin.
=20
 Unspecified::
=20
@@ -148,8 +151,10 @@ unspecified.
 ^^^^^
=20
 This attribute sets a specific line-ending style to be used in the
-working directory.  It enables end-of-line conversion without any
-content checks, effectively setting the `text` attribute.
+working directory.  It sets the `text` attribute, unless `text=3Dauto`
+is specified.
+When the file had been commited with CRLF in the index, no conversion
+is done at checkout or commit.
=20
 Set to string value "crlf"::
=20
diff --git a/convert.c b/convert.c
index 3782172..3d36c45 100644
--- a/convert.c
+++ b/convert.c
@@ -17,7 +17,8 @@
 #define CONVERT_STAT_BITS_TXT_LF    0x1
 #define CONVERT_STAT_BITS_TXT_CRLF  0x2
 #define CONVERT_STAT_BITS_BIN       0x4
-#define CONVERT_STAT_BITS_ANY_CR    0x8
+
+#define CONVERT_STAT_BITS_MIXED (CONVERT_STAT_BITS_TXT_LF | CONVERT_ST=
AT_BITS_TXT_CRLF)
=20
 enum crlf_action {
 	CRLF_UNDEFINED,
@@ -32,7 +33,7 @@ enum crlf_action {
=20
 struct text_stat {
 	/* NUL, CR, LF and CRLF counts */
-	unsigned stat_bits, lonecr, lonelf, crlf;
+	unsigned stat_bits, lonelf;
=20
 	/* These are just approximations! */
 	unsigned printable, nonprintable;
@@ -48,13 +49,10 @@ static void do_gather_stats(const char *buf, unsign=
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
@@ -135,7 +133,7 @@ static unsigned get_convert_stats_sha1(unsigned con=
st char *sha1,
 		if (!readlen)
 			break;
 		do_gather_stats(buf, (unsigned long)readlen, &stats, earlyout);
-		if (stats.stat_bits & earlyout)
+		if ((stats.stat_bits & earlyout) =3D=3D earlyout)
 			break; /* We found what we have been searching for */
 	}
 close_and_exit_i:
@@ -146,11 +144,9 @@ close_and_exit_i:
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
@@ -162,7 +158,16 @@ static const char *convert_stats_ascii(unsigned co=
nvert_stats)
 	}
 }
=20
-static unsigned get_convert_stats_wt(const char *path)
+const char *get_cached_convert_stats_ascii(const char *path)
+{
+	unsigned convert_stats;
+	unsigned earlyout =3D CONVERT_STAT_BITS_BIN;
+	convert_stats =3D get_convert_stats_sha1(get_sha1_from_cache(path),
+					       earlyout);
+	return convert_stats_ascii(convert_stats);
+}
+
+const char *get_wt_convert_stats_ascii(const char *path)
 {
 	struct text_stat stats;
 	unsigned earlyout =3D CONVERT_STAT_BITS_BIN;
@@ -170,7 +175,7 @@ static unsigned get_convert_stats_wt(const char *pa=
th)
 	memset(&stats, 0, sizeof(stats));
 	fd =3D open(path, O_RDONLY);
 	if (fd < 0)
-		return 0;
+		return NULL;
 	for (;;) {
 		char buf[1024];
 		ssize_t readlen =3D read(fd, buf, sizeof(buf));
@@ -184,23 +189,7 @@ static unsigned get_convert_stats_wt(const char *p=
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
-	convert_stats =3D get_convert_stats_sha1(get_sha1_from_cache(path),
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
@@ -239,43 +228,95 @@ static enum eol output_eol(enum crlf_action crlf_=
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
+	if (!(convert_stats & CONVERT_STAT_BITS_TXT_LF))
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
+	stat_bits_index =3D get_convert_stats_sha1(get_sha1_from_cache(path),
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
+	enum eol new_eol =3D output_eol(crlf_action);
+	const char *err_warn_msg =3D NULL;
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
+	}
+	if ((new_convert_stats & CONVERT_STAT_BITS_MIXED) =3D=3D CONVERT_STAT=
_BITS_MIXED)
+		err_warn_msg =3D "mixed eol";
+	else if (new_eol =3D=3D EOL_LF && new_convert_stats & CONVERT_STAT_BI=
TS_TXT_CRLF)
+		err_warn_msg =3D "CRLF";
+
+	if (err_warn_msg) {
+		if (checksafe =3D=3D SAFE_CRLF_WARN)
+			warning("%s will be present after commit and checkout in %s.",
+				err_warn_msg, path);
+		else
+			die("%s will be present after commit and checkout in %s",
+			    err_warn_msg, path);
 	}
-}
-
-static int has_cr_in_index(const char *path)
-{
-	unsigned convert_stats;
-	convert_stats =3D get_convert_stats_sha1(get_sha1_from_cache(path),
-					       CONVERT_STAT_BITS_ANY_CR);
-	return convert_stats & CONVERT_STAT_BITS_ANY_CR;
 }
=20
 static int crlf_to_git(const char *path, const char *src, size_t len,
@@ -284,7 +325,7 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
 {
 	struct text_stat stats;
 	char *dst;
-
+	int convert_crlf;
 	if (crlf_action =3D=3D CRLF_BINARY ||
 	    (src && !len))
 		return 0;
@@ -296,24 +337,42 @@ static int crlf_to_git(const char *path, const ch=
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
-		if (checksafe =3D=3D SAFE_CRLF_RENORMALIZE)
-			checksafe =3D SAFE_CRLF_FALSE;
-		else if (has_cr_in_index(path))
-			return 0;
+	} else {
+		gather_stats(src, len, &stats, 0);
+	}
+	if (checksafe =3D=3D SAFE_CRLF_RENORMALIZE) {
+		convert_crlf =3D 1;
+		checksafe =3D SAFE_CRLF_FALSE;
+	} else {
+		convert_crlf =3D would_convert_crlf_at_commit(path, &stats, len,
+							    crlf_action);
 	}
-	check_safe_crlf(path, crlf_action, &stats, checksafe);
=20
-	/* Optimization: No CRLF? Nothing to convert, regardless. */
-	if (!stats.crlf)
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
@@ -327,7 +386,9 @@ static int crlf_to_git(const char *path, const char=
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
@@ -354,28 +415,15 @@ static int crlf_to_worktree(const char *path, con=
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
@@ -1067,6 +1115,8 @@ int is_null_stream_filter(struct stream_filter *f=
ilter)
 struct lf_to_crlf_filter {
 	struct stream_filter filter;
 	unsigned has_held:1;
+	unsigned expanded_loneLF:1;
+	unsigned had_CRLF:1;
 	char held;
 };
=20
@@ -1107,7 +1157,12 @@ static int lf_to_crlf_filter_fn(struct stream_fi=
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
@@ -1136,6 +1191,14 @@ static int lf_to_crlf_filter_fn(struct stream_fi=
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
index 8367d0b..a16e513 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -71,10 +71,14 @@ check_warning () {
 	case "$1" in
 	LF_CRLF) echo "warning: LF will be replaced by CRLF" >"$2".expect ;;
 	CRLF_LF) echo "warning: CRLF will be replaced by LF" >"$2".expect ;;
+	CRLF)    echo "warning: CRLF will be present after commit and checkou=
t" >"$2".expect ;;
+	mixed)   echo "warning: mixed eol will be present after commit and ch=
eckout" >"$2".expect ;;
 	'')	                                                 >"$2".expect ;;
 	*) echo >&2 "Illegal 1": "$1" ; return false ;;
 	esac
-	grep "will be replaced by" "$2" | sed -e "s/\(.*\) in [^ ]*$/\1/" | u=
niq  >"$2".actual
+	egrep "will be replaced by|will be present after commit" "$2" |
+		sed -e "s/\(.*\) in [^ ]*$/\1/" |
+		uniq  >"$2".actual
 	test_cmp "$2".expect "$2".actual
 }
=20
@@ -169,7 +173,7 @@ stats_ascii () {
 # Take none (=3Dempty), one or two args
 # convert.c: eol=3DXX overrides text=3Dauto
 attr_ascii () {
-	case $1,$2 in
+	case "$1","$2" in
 	-text,*)   echo "-text" ;;
 	text,)     echo "text" ;;
 	text,lf)   echo "text eol=3Dlf" ;;
@@ -349,10 +353,12 @@ then
 	WILC=3DLF_CRLF
 	WICL=3D
 	WAMIX=3DLF_CRLF
+	Pcrlf=3D
 else
 	WILC=3D
 	WICL=3DCRLF_LF
 	WAMIX=3DCRLF_LF
+	Pcrlf=3DCRLF
 fi
=20
 #                         attr   LF        CRLF      CRLFmixLF LFmixCR=
   CRLFNUL
@@ -392,31 +398,32 @@ test_expect_success 'commit files attr=3Dcrlf' '
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
-commit_chk_wrnNNO ""      ""      true    LF_CRLF   ""        ""      =
    ""          ""
-commit_chk_wrnNNO ""      ""      input   ""        ""        ""      =
    ""          ""
+commit_chk_wrnNNO ""      ""      true    LF_CRLF   ""        mixed   =
    ""          ""
+commit_chk_wrnNNO ""      ""      input   ""        CRLF      mixed   =
    ""          ""
+
+commit_chk_wrnNNO "auto"  ""      false   "$WILC"   "$Pcrlf"  mixed   =
    ""          ""
+commit_chk_wrnNNO "auto"  ""      true    LF_CRLF   ""        mixed   =
    ""          ""
+commit_chk_wrnNNO "auto"  ""      input   ""        CRLF      mixed   =
    ""          ""
+commit_chk_wrnNNO "text"  ""      false   "$WILC"   "$Pcrlf"  mixed   =
    "$WILC"     "$Pcrlf"
+commit_chk_wrnNNO "text"  ""      true    LF_CRLF   ""        mixed   =
    LF_CRLF     ""
+commit_chk_wrnNNO "text"  ""      input   ""        CRLF      mixed   =
    ""          CRLF
+
=20
-commit_chk_wrnNNO "auto"  ""      false   "$WILC"   ""        ""      =
    ""          ""
-commit_chk_wrnNNO "auto"  ""      true    LF_CRLF   ""        ""      =
    ""          ""
-commit_chk_wrnNNO "auto"  ""      input   ""        ""        ""      =
    ""          ""
 for crlf in true false input
 do
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
-	commit_chk_wrnNNO auto  lf    	$crlf   ""        ""        ""        =
  ""          ""
-	commit_chk_wrnNNO auto  crlf  	$crlf   LF_CRLF   ""        ""        =
  ""          ""
-	commit_chk_wrnNNO text  lf    	$crlf   ""       CRLF_LF    CRLF_LF   =
  ""          CRLF_LF
-	commit_chk_wrnNNO text  crlf  	$crlf   LF_CRLF   ""        LF_CRLF   =
  LF_CRLF     ""
+	commit_chk_wrnNNO ""    lf      $crlf   ""        CRLF      mixed    =
   ""          CRLF
+	commit_chk_wrnNNO ""    crlf    $crlf   LF_CRLF   ""        mixed    =
   LF_CRLF     ""
+	commit_chk_wrnNNO auto  lf      $crlf   ""        CRLF      mixed    =
   ""          ""
+	commit_chk_wrnNNO auto  crlf    $crlf   LF_CRLF   ""        mixed    =
   ""          ""
+	commit_chk_wrnNNO text  lf      $crlf   ""        CRLF      mixed    =
   ""          CRLF
+	commit_chk_wrnNNO text  crlf    $crlf   LF_CRLF   ""        mixed    =
   LF_CRLF     ""
 done
=20
-commit_chk_wrnNNO "text"  ""      false   "$WILC"   "$WICL"   "$WAMIX"=
    "$WILC"     "$WICL"
-commit_chk_wrnNNO "text"  ""      true    LF_CRLF   ""        LF_CRLF =
    LF_CRLF     ""
-commit_chk_wrnNNO "text"  ""      input   ""        CRLF_LF   CRLF_LF =
    ""          CRLF_LF
-
 test_expect_success 'create files cleanup' '
 	rm -f *.txt &&
 	git -c core.autocrlf=3Dfalse reset --hard
@@ -456,9 +463,9 @@ do
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
@@ -479,12 +486,10 @@ done
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
@@ -492,8 +497,7 @@ fi
 export CRLF_MIX_LF_CR MIX NL
=20
 # Same handling with and without ident
-#for id in "" ident
-for id in ""
+for id in "" ident
 do
 	for ceol in lf crlf native
 	do
@@ -501,38 +505,38 @@ do
 		do
 			# -text overrides core.autocrlf and core.eol
 			# text and eol=3Dcrlf or eol=3Dlf override core.autocrlf and core.e=
ol
-			checkout_files -text "$id" ""     "$crlf" "$ceol"  LF    CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
-			checkout_files -text "$id" "lf"   "$crlf" "$ceol"  LF    CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
-			checkout_files -text "$id" "crlf" "$crlf" "$ceol"  LF    CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
+			checkout_files "-text" "$id" ""     "$crlf" "$ceol"  LF    CRLF  CR=
LF_mix_LF  LF_mix_CR    LF_nul
+			checkout_files "-text" "$id" "lf"   "$crlf" "$ceol"  LF    CRLF  CR=
LF_mix_LF  LF_mix_CR    LF_nul
+			checkout_files "-text" "$id" "crlf" "$crlf" "$ceol"  LF    CRLF  CR=
LF_mix_LF  LF_mix_CR    LF_nul
 			# text
-			checkout_files text  "$id" "lf"   "$crlf" "$ceol"  LF    CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
-			checkout_files text  "$id" "crlf" "$crlf" "$ceol"  CRLF  CRLF  CRLF=
         CRLF_mix_CR  CRLF_nul
+			checkout_files text    "$id" "lf"   "$crlf" "$ceol"  LF    CRLF  CR=
LF_mix_LF  LF_mix_CR    LF_nul
+			checkout_files text    "$id" "crlf" "$crlf" "$ceol"  CRLF  CRLF  CR=
LF_mix_LF  CRLF_mix_CR  CRLF_nul
 			# currently the same as text, eol=3DXXX
-			checkout_files auto  "$id" "lf"   "$crlf" "$ceol"  LF    CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
-			checkout_files auto  "$id" "crlf" "$crlf" "$ceol"  CRLF  CRLF  CRLF=
_mix_LF  LF_mix_CR    LF_nul
+			checkout_files auto    "$id" "lf"   "$crlf" "$ceol"  LF    CRLF  CR=
LF_mix_LF  LF_mix_CR    LF_nul
+			checkout_files auto    "$id" "crlf" "$crlf" "$ceol"  CRLF  CRLF  CR=
LF_mix_LF  LF_mix_CR    LF_nul
 		done
=20
 		# core.autocrlf false, different core.eol
-		checkout_files   ""    "$id" ""     false   "$ceol"  LF    CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
+		checkout_files   ""      "$id" ""     false   "$ceol"  LF    CRLF  C=
RLF_mix_LF  LF_mix_CR    LF_nul
 		# core.autocrlf true
-		checkout_files   ""    "$id" ""     true    "$ceol"  CRLF  CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
+		checkout_files   ""      "$id" ""     true    "$ceol"  CRLF  CRLF  C=
RLF_mix_LF  LF_mix_CR    LF_nul
 		# text: core.autocrlf =3D true overrides core.eol
-		checkout_files   auto  "$id" ""     true    "$ceol"  CRLF  CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
-		checkout_files   text  "$id" ""     true    "$ceol"  CRLF  CRLF  CRL=
=46         CRLF_mix_CR  CRLF_nul
+		checkout_files   auto    "$id" ""     true    "$ceol"  CRLF  CRLF  C=
RLF_mix_LF  LF_mix_CR    LF_nul
+		checkout_files   text    "$id" ""     true    "$ceol"  CRLF  CRLF  C=
RLF_mix_LF  CRLF_mix_CR  CRLF_nul
 		# text: core.autocrlf =3D input overrides core.eol
-		checkout_files   text  "$id" ""     input   "$ceol"  LF    CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
-		checkout_files   auto  "$id" ""     input   "$ceol"  LF    CRLF  CRL=
=46_mix_LF  LF_mix_CR    LF_nul
+		checkout_files   text    "$id" ""     input   "$ceol"  LF    CRLF  C=
RLF_mix_LF  LF_mix_CR    LF_nul
+		checkout_files   auto    "$id" ""     input   "$ceol"  LF    CRLF  C=
RLF_mix_LF  LF_mix_CR    LF_nul
 		# text=3Dauto + eol=3DXXX
 	done
 	# text: core.autocrlf=3Dfalse uses core.eol
-	checkout_files     text  "$id" ""     false   crlf     CRLF  CRLF  CR=
LF         CRLF_mix_CR  CRLF_nul
-	checkout_files     text  "$id" ""     false   lf       LF    CRLF  CR=
LF_mix_LF  LF_mix_CR    LF_nul
+	checkout_files     text    "$id" ""     false   crlf     CRLF  CRLF  =
CRLF_mix_LF  CRLF_mix_CR  CRLF_nul
+	checkout_files     text    "$id" ""     false   lf       LF    CRLF  =
CRLF_mix_LF  LF_mix_CR    LF_nul
 	# text: core.autocrlf=3Dfalse and core.eol unset(or native) uses nati=
ve eol
-	checkout_files     text  "$id" ""     false   ""       $NL   CRLF  $M=
IX_CRLF_LF $MIX_LF_CR   $LFNUL
-	checkout_files     text  "$id" ""     false   native   $NL   CRLF  $M=
IX_CRLF_LF $MIX_LF_CR   $LFNUL
+	checkout_files     text    "$id" ""     false   ""       $NL   CRLF  =
CRLF_mix_LF  "$MIX_LF_CR" "$LFNUL"
+	checkout_files     text    "$id" ""     false   native   $NL   CRLF  =
CRLF_mix_LF  "$MIX_LF_CR" "$LFNUL"
 	# auto: core.autocrlf=3Dfalse and core.eol unset(or native) uses nati=
ve eol
-	checkout_files     auto  "$id" ""     false   ""       $NL   CRLF  CR=
LF_mix_LF  LF_mix_CR    LF_nul
-	checkout_files     auto  "$id" ""     false   native   $NL   CRLF  CR=
LF_mix_LF  LF_mix_CR    LF_nul
+	checkout_files     auto    "$id" ""     false   ""       $NL   CRLF  =
CRLF_mix_LF  LF_mix_CR    LF_nul
+	checkout_files     auto    "$id" ""     false   native   $NL   CRLF  =
CRLF_mix_LF  LF_mix_CR    LF_nul
 done
=20
 # Should be the last test case: remove some files from the worktree
--=20
2.0.0.rc1.6318.g0c2c796
