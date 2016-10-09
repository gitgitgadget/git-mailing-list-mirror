Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0E9E20986
	for <e@80x24.org>; Sun,  9 Oct 2016 09:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932262AbcJIJ5n (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 05:57:43 -0400
Received: from mout.web.de ([212.227.15.3]:60544 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753513AbcJIJ5i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 05:57:38 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MfqSa-1bYK393lye-00NDgI; Sun, 09 Oct 2016 11:56:55
 +0200
From:   tboegi@web.de
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v1 2/2] convert.c: stream and early out
Date:   Sun,  9 Oct 2016 11:56:54 +0200
Message-Id: <20161009095654.1964-1-tboegi@web.de>
X-Mailer: git-send-email 2.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:93GJ32Tq9B0sQTrsmBKlVVJtX0yLMkwCVQIR2ap+d7ycP2R1WiW
 q9eL7H5FYpr2TZPcxYMLXcVVaTkL5yA1Yq7hPsapKKPRddg4+NcXExBq8gTCFL/Rxm49Rxu
 swN/Kup39s61I8aR3Zcd46Zo+3KzDgvB8YupEvqJzkOycqRUOjNThEcmpvNk9xwz9KlHo61
 2aV6UtD+GELFjQIrzfpfw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DtAQMdk0/jQ=:+/RtFSpsgLxnSRRoMP2Kxm
 SmkU5rIxOICdddxfa58gHOxd1I6VWgeeZkn1HVkE018pzXatpECXI1bxckVmQX9aWWGeiK2xz
 J3iNUMm0AqnF9pPjzjmcq5jWscdSIF7U2BFFzKAE3ECbz2+8FHD84P+N02qfMhUaqxM0wHanz
 xbnzv7wsed4QWIyqG2tuU3WW/MKdbI8nR6gwNm5dRIQWJXyl5afYwaD5PW4An5KYG9x/B1vHV
 ohZ8fbdmxvk3QC1SQwyQ7p4ixa1Fsk5NAS4F19BL6iJXrycfvyGgcyOkL0L/Xm++i2U7FZKRU
 QRqJNDiR+H9XJlgQEDDlwcPUvJ0fB5PfZV9sEfjWQNDGiWbwFTiSxLwhOIGP3vgIxx1pTCc4X
 r8fBcKZfkYJjsgH4Sl+n5A/VBnxTCYdnJgJUwcxyfbJ5NfqwJYIV0qaHwtbYD5w6XtHKGXTiA
 bIQ0AScaN908qbl7WAliMM7yYdczooxRjly1K1tagvFqxsui+1Nfve8MBnv/ejypYiyRBLZpc
 vrm+GxYMs/clkgnS/mRmUDSvZa5y5yFyYPA3Bdu2jh72Nh/ikv6bdNHSjJAsCZniuzDE6pBfx
 MNzS8nNGhy5YT7RmMjCdF/aJpNljoFoKeJsz7IIXJe4T5IHPRuA8LGVzNJaFIreEvBTRL4YPZ
 ytjw7P6exW3s2M2YMgOrGMh1M4/WDcC9cbixHFYXvKGdRCVAVBiBcUrfnO88dqScM9YQHeiqq
 y4laWfPT9MomfJZJ/1oeHRk/80FpwfEkqvM0kYTFNEUjLbtOAOU1e+PGW8g6gV7FaxwhiUWce
 IJzp1d5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

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
---
 convert.c | 195 +++++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 130 insertions(+), 65 deletions(-)

diff --git a/convert.c b/convert.c
index 077f5e6..6a625e5 100644
--- a/convert.c
+++ b/convert.c
@@ -3,6 +3,7 @@
 #include "run-command.h"
 #include "quote.h"
 #include "sigchain.h"
+#include "streaming.h"
 
 /*
  * convert.c - convert a file when checking it out and checking it in.
@@ -13,10 +14,10 @@
  * translation when the "text" attribute or "auto_crlf" option is set.
  */
 
-/* Stat bits: When BIN is set, the txt bits are unset */
 #define CONVERT_STAT_BITS_TXT_LF    0x1
 #define CONVERT_STAT_BITS_TXT_CRLF  0x2
 #define CONVERT_STAT_BITS_BIN       0x4
+#define CONVERT_STAT_BITS_ANY_CR    0x8
 
 enum crlf_action {
 	CRLF_UNDEFINED,
@@ -31,30 +32,36 @@ enum crlf_action {
 
 struct text_stat {
 	/* NUL, CR, LF and CRLF counts */
-	unsigned nul, lonecr, lonelf, crlf;
+	unsigned stat_bits, lonecr, lonelf, crlf;
 
 	/* These are just approximations! */
 	unsigned printable, nonprintable;
 };
 
-static void gather_stats(const char *buf, unsigned long size, struct text_stat *stats)
+static void gather_stats_partly(const char *buf, unsigned long len,
+				struct text_stat *stats, unsigned earlyout)
 {
 	unsigned long i;
 
-	memset(stats, 0, sizeof(*stats));
-
-	for (i = 0; i < size; i++) {
+	if (!buf || !len)
+		return;
+	for (i = 0; i < len; i++) {
 		unsigned char c = buf[i];
 		if (c == '\r') {
-			if (i+1 < size && buf[i+1] == '\n') {
+			stats->stat_bits |= CONVERT_STAT_BITS_ANY_CR;
+			if (i+1 < len && buf[i+1] == '\n') {
 				stats->crlf++;
 				i++;
-			} else
+				stats->stat_bits |= CONVERT_STAT_BITS_TXT_CRLF;
+			} else {
 				stats->lonecr++;
+				stats->stat_bits |= CONVERT_STAT_BITS_BIN;
+			}
 			continue;
 		}
 		if (c == '\n') {
 			stats->lonelf++;
+			stats->stat_bits |= CONVERT_STAT_BITS_TXT_LF;
 			continue;
 		}
 		if (c == 127)
@@ -67,7 +74,7 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
 				stats->printable++;
 				break;
 			case 0:
-				stats->nul++;
+				stats->stat_bits |= CONVERT_STAT_BITS_BIN;
 				/* fall through */
 			default:
 				stats->nonprintable++;
@@ -75,10 +82,12 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
 		}
 		else
 			stats->printable++;
+		if (stats->stat_bits & earlyout)
+			break; /* We found what we have been searching for */
 	}
 
 	/* If file ends with EOF then don't count this EOF as non-printable. */
-	if (size >= 1 && buf[size-1] == '\032')
+	if (len >= 1 && buf[len-1] == '\032')
 		stats->nonprintable--;
 }
 
@@ -86,41 +95,62 @@ static void gather_stats(const char *buf, unsigned long size, struct text_stat *
  * The same heuristics as diff.c::mmfile_is_binary()
  * We treat files with bare CR as binary
  */
-static int convert_is_binary(unsigned long size, const struct text_stat *stats)
+static void convert_nonprintable(struct text_stat *stats)
 {
-	if (stats->lonecr)
-		return 1;
-	if (stats->nul)
-		return 1;
 	if ((stats->printable >> 7) < stats->nonprintable)
-		return 1;
-	return 0;
+		stats->stat_bits |= CONVERT_STAT_BITS_BIN;
 }
 
-static unsigned int gather_convert_stats(const char *data, unsigned long size)
+static void gather_stats(const char *buf, unsigned long size,
+			 struct text_stat *stats, unsigned earlyout)
 {
+	memset(stats, 0, sizeof(*stats));
+	gather_stats_partly(buf, size, stats, earlyout);
+	convert_nonprintable(stats);
+}
+
+
+static unsigned get_convert_stats_sha1(unsigned const char *sha1,
+				       unsigned earlyout)
+{
+	struct git_istream *st;
 	struct text_stat stats;
-	int ret = 0;
-	if (!data || !size)
-		return 0;
-	gather_stats(data, size, &stats);
-	if (convert_is_binary(size, &stats))
-		ret |= CONVERT_STAT_BITS_BIN;
-	if (stats.crlf)
-		ret |= CONVERT_STAT_BITS_TXT_CRLF;
-	if (stats.lonelf)
-		ret |=  CONVERT_STAT_BITS_TXT_LF;
+	enum object_type type;
+	unsigned long sz;
 
-	return ret;
+	if (!sha1)
+		return 0;
+	memset(&stats, 0, sizeof(stats));
+	st = open_istream(sha1, &type, &sz, NULL);
+	if (!st) {
+		return 0;
+	}
+	if (type != OBJ_BLOB)
+		goto close_and_exit_i;
+	for (;;) {
+		char buf[2*1024];
+		ssize_t readlen = read_istream(st, buf, sizeof(buf));
+		if (readlen < 0)
+			break;
+		if (!readlen)
+			break;
+		gather_stats_partly(buf, (unsigned long)readlen, &stats, earlyout);
+		if (stats.stat_bits & earlyout)
+			break; /* We found what we have been searching for */
+	}
+close_and_exit_i:
+	close_istream(st);
+	convert_nonprintable(&stats);
+	return stats.stat_bits;
 }
 
-static const char *gather_convert_stats_ascii(const char *data, unsigned long size)
+static const char *convert_stats_ascii(unsigned convert_stats)
 {
-	unsigned int convert_stats = gather_convert_stats(data, size);
-
+	const unsigned mask = CONVERT_STAT_BITS_TXT_LF |
+		CONVERT_STAT_BITS_TXT_CRLF;
 	if (convert_stats & CONVERT_STAT_BITS_BIN)
 		return "-text";
-	switch (convert_stats) {
+	switch (convert_stats & mask) {
 	case CONVERT_STAT_BITS_TXT_LF:
 		return "lf";
 	case CONVERT_STAT_BITS_TXT_CRLF:
@@ -132,24 +162,45 @@ static const char *gather_convert_stats_ascii(const char *data, unsigned long si
 	}
 }
 
+static unsigned get_convert_stats_wt(const char *path)
+{
+	struct text_stat stats;
+	unsigned earlyout = CONVERT_STAT_BITS_BIN;
+	int fd;
+	memset(&stats, 0, sizeof(stats));
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return 0;
+	for (;;) {
+		char buf[2*1024];
+		ssize_t readlen = read(fd, buf, sizeof(buf));
+		if (readlen < 0)
+			break;
+		if (!readlen)
+			break;
+		gather_stats_partly(buf, (unsigned long)readlen, &stats, earlyout);
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
-	void *data = read_blob_data_from_cache(path, &sz);
-	ret = gather_convert_stats_ascii(data, sz);
-	free(data);
-	return ret;
+	unsigned convert_stats;
+	unsigned earlyout = CONVERT_STAT_BITS_BIN;
+	convert_stats = get_convert_stats_sha1(get_sha1_from_cache(path),
+					       earlyout);
+	return convert_stats_ascii(convert_stats);
 }
 
 const char *get_wt_convert_stats_ascii(const char *path)
 {
-	const char *ret = "";
-	struct strbuf sb = STRBUF_INIT;
-	if (strbuf_read_file(&sb, path, 0) >= 0)
-		ret = gather_convert_stats_ascii(sb.buf, sb.len);
-	strbuf_release(&sb);
-	return ret;
+	unsigned convert_stats;
+	convert_stats = get_convert_stats_wt(path);
+	return convert_stats_ascii(convert_stats);
 }
 
 static int text_eol_is_crlf(void)
@@ -213,16 +264,10 @@ static void check_safe_crlf(const char *path, enum crlf_action crlf_action,
 
 static int has_cr_in_index(const char *path)
 {
-	unsigned long sz;
-	void *data;
-	int has_cr;
-
-	data = read_blob_data_from_cache(path, &sz);
-	if (!data)
-		return 0;
-	has_cr = memchr(data, '\r', sz) != NULL;
-	free(data);
-	return has_cr;
+	unsigned convert_stats;
+	convert_stats = get_convert_stats_sha1(get_sha1_from_cache(path),
+					       CONVERT_STAT_BITS_ANY_CR);
+	return convert_stats & CONVERT_STAT_BITS_ANY_CR;
 }
 
 static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
@@ -234,13 +279,13 @@ static int will_convert_lf_to_crlf(size_t len, struct text_stat *stats,
 	if (!stats->lonelf)
 		return 0;
 
-	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_AUTO_INPUT || crlf_action == CRLF_AUTO_CRLF) {
+	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_AUTO_CRLF) {
 		/* If we have any CR or CRLF line endings, we do not touch it */
 		/* This is the new safer autocrlf-handling */
 		if (stats->lonecr || stats->crlf)
 			return 0;
 
-		if (convert_is_binary(len, stats))
+		if (stats->stat_bits & CONVERT_STAT_BITS_BIN)
 			return 0;
 	}
 	return 1;
@@ -253,7 +298,8 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 {
 	struct text_stat stats;
 	char *dst;
-	int convert_crlf_into_lf;
+	int has_crlf_to_convert;
+	unsigned earlyout = 0;
 
 	if (crlf_action == CRLF_BINARY ||
 	    (src && !len))
@@ -266,12 +312,16 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 	if (!buf && !src)
 		return 1;
 
-	gather_stats(src, len, &stats);
+	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_AUTO_INPUT || crlf_action == CRLF_AUTO_CRLF)
+		earlyout = CONVERT_STAT_BITS_BIN;
+
+	gather_stats(src, len, &stats, earlyout);
+
 	/* Optimization: No CRLF? Nothing to convert, regardless. */
-	convert_crlf_into_lf = !!stats.crlf;
+	has_crlf_to_convert = !!stats.crlf;
 
 	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_AUTO_INPUT || crlf_action == CRLF_AUTO_CRLF) {
-		if (convert_is_binary(len, &stats))
+		if (stats.stat_bits & CONVERT_STAT_BITS_BIN)
 			return 0;
 		/*
 		 * If the file in the index has any CR in it, do not convert.
@@ -280,24 +330,35 @@ static int crlf_to_git(const char *path, const char *src, size_t len,
 		if (checksafe == SAFE_CRLF_RENORMALIZE)
 			checksafe = SAFE_CRLF_FALSE;
 		else if (has_cr_in_index(path))
-			convert_crlf_into_lf = 0;
+			has_crlf_to_convert = 0;
 	}
 	if (checksafe && len) {
 		struct text_stat new_stats;
 		memcpy(&new_stats, &stats, sizeof(new_stats));
 		/* simulate "git add" */
-		if (convert_crlf_into_lf) {
+		if (has_crlf_to_convert) {
 			new_stats.lonelf += new_stats.crlf;
 			new_stats.crlf = 0;
+			/* all crlf, if any, are gone. Update the bits */
+			new_stats.stat_bits = stats.stat_bits & CONVERT_STAT_BITS_BIN;
+			if (new_stats.lonelf)
+				new_stats.stat_bits |= CONVERT_STAT_BITS_TXT_LF;
+			if (new_stats.lonecr)
+				new_stats.stat_bits |= CONVERT_STAT_BITS_ANY_CR;
 		}
 		/* simulate "git checkout" */
 		if (will_convert_lf_to_crlf(len, &new_stats, crlf_action)) {
 			new_stats.crlf += new_stats.lonelf;
 			new_stats.lonelf = 0;
+			new_stats.stat_bits = stats.stat_bits & CONVERT_STAT_BITS_BIN;
+			if (new_stats.crlf)
+				new_stats.stat_bits |= CONVERT_STAT_BITS_TXT_CRLF | CONVERT_STAT_BITS_ANY_CR;
+			if (new_stats.lonecr)
+				new_stats.stat_bits |= CONVERT_STAT_BITS_ANY_CR;
 		}
 		check_safe_crlf(path, crlf_action, &stats, &new_stats, checksafe);
 	}
-	if (!convert_crlf_into_lf)
+	if (!has_crlf_to_convert)
 		return 0;
 
 	/*
@@ -338,11 +399,15 @@ static int crlf_to_worktree(const char *path, const char *src, size_t len,
 {
 	char *to_free = NULL;
 	struct text_stat stats;
+	unsigned earlyout = 0;
 
 	if (!len || output_eol(crlf_action) != EOL_CRLF)
 		return 0;
 
-	gather_stats(src, len, &stats);
+	if (crlf_action == CRLF_AUTO || crlf_action == CRLF_AUTO_CRLF)
+		earlyout = CONVERT_STAT_BITS_ANY_CR | CONVERT_STAT_BITS_BIN;
+
+	gather_stats(src, len, &stats, earlyout);
 	if (!will_convert_lf_to_crlf(len, &stats, crlf_action))
 		return 0;
 
-- 
2.10.0

