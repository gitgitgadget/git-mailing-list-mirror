From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 3/3] archive-zip: support more than 65535 entries
Date: Sat, 22 Aug 2015 21:06:45 +0200
Message-ID: <55D8C845.3090908@web.de>
References: <20150811104056.16465.58131@localhost> <55CBA140.7050301@web.de>
 <20150813022545.30116.44787@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Johannes Schauer <josch@debian.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 21:07:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTE89-0002yY-6q
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 21:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbbHVTHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2015 15:07:00 -0400
Received: from mout.web.de ([212.227.15.4]:49632 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753310AbbHVTG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2015 15:06:59 -0400
Received: from [192.168.178.36] ([79.253.186.87]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0MNP6P-1ZMubR1A41-006tMy; Sat, 22 Aug 2015 21:06:48
 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <20150813022545.30116.44787@localhost>
X-Provags-ID: V03:K0:Sd3R4FrkCktYauRjtDmVArfH7vezOvZxVo0cUFhgAfnYMpSQai9
 KnRV1S5miZFrGsLNK15QlPXlnrHZ8jStz+KPhei06kqX0CMM3+EcaXZq9n8hxcAJEYXHebM
 1QZUp5YAcDgzuvTqHsxFNsnvXM+I26e3FNclVQBpLPyY5WdU4CmMsFwehiFlNLsaJc6luo2
 lgMKIU2swde2mVEDyQuPQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0NzBKy2ixho=:WFVUm9DJdyqiMzCCx6LXcV
 nY4iHqA0O+4vUR4BCy+Izq3e+0sgUWVy/f8+ob0Fj4jbvhqApZ3CnSAHjeCJWEdw6+V0aPkLk
 QYSk3wIjzVB2hVIfTSsZwOVse42mGtk+nI6JURTeBjeBWQlI+Ib3/JpNd4KxAEtdrmgJMOMXH
 u2FbpXZDY0xeYADV5IK42r8Hs05Kv8f1D9N3c70Q/WvWTlVcwQJmZfbB0rblNILEctNmDs41R
 cy4MrzgMrlw+GiMyiOsA6BQ5HqZ80i2s2prCzOcV4RSq5vV7Juy4y7StGNyvZJ+xegZOBfWV2
 Z9nsLRTcFBg5wrDHMtjoIOerb8UAFh+2J4YdJTrqMIu/rBWOONCBJnAZdSzNolKiYShl4Va9I
 XW82GTPTxQL9Lp/1OZEetNhNOdK27dmNiW04D4Dilg5Zn2AjPma7UG7wpFBEeBwCr67bKvRNS
 81CBjqsOq+4DWIVuj1xrMTTW2xcF4Ozsc+st0GRKqQsbbkML700rWuD34KQjazXNVGlvZB2Jw
 YVYLUg/xL3kxs4qQh90vopXHRzcHju+cAEehIk/zqIzwD3fr8oZXZrT7wK64OWLd40Nr4GgN5
 8+dJ9EsZmZHvHcLpHsGlj3lVfaemldOjnAeF9vD8tWaKGIZA7k3zwHxvRElUjRGveL6xy51WV
 /alt0hotIxJ+q5kRWyuG4AnQlaw2aC7o4LuYia0J+IVoZjwjGVmd0gcTzsr1dmkTpFGEPa7ii
 LAwPgiV/BP1/cnQymr1WoJh7T9ko9kMy2ezRfA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276395>

Support more than 65535 entries cleanly by writing a "zip64 end of
central directory record" (with a 64-bit field for the number of
entries) before the usual "end of central directory record" (which
contains only a 16-bit field).  InfoZIP's zip does the same.
Archives with 65535 or less entries are not affected.

Programs that extract all files like InfoZIP's zip and 7-Zip
ignored the field and could extract all files already.  Software
that relies on the ZIP file directory to show a list of contained
files quickly to simulate to normal directory like Windows'
built-in ZIP functionality only saw a subset of the included files.

Windows supports ZIP64 since Vista according to
https://en.wikipedia.org/wiki/Zip_%28file_format%29#ZIP64.

Suggested-by: Johannes Schauer <josch@debian.org>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 archive-zip.c                   | 93 +++++++++++++++++++++++++++++++++++++++--
 t/t5004-archive-corner-cases.sh |  2 +-
 2 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 2a76156..9db4735 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -16,7 +16,9 @@ static unsigned int zip_dir_size;
 
 static unsigned int zip_offset;
 static unsigned int zip_dir_offset;
-static unsigned int zip_dir_entries;
+static uint64_t zip_dir_entries;
+
+static unsigned int max_creator_version;
 
 #define ZIP_DIRECTORY_MIN_SIZE	(1024 * 1024)
 #define ZIP_STREAM	(1 <<  3)
@@ -86,6 +88,28 @@ struct zip_extra_mtime {
 	unsigned char _end[1];
 };
 
+struct zip64_dir_trailer {
+	unsigned char magic[4];
+	unsigned char record_size[8];
+	unsigned char creator_version[2];
+	unsigned char version[2];
+	unsigned char disk[4];
+	unsigned char directory_start_disk[4];
+	unsigned char entries_on_this_disk[8];
+	unsigned char entries[8];
+	unsigned char size[8];
+	unsigned char offset[8];
+	unsigned char _end[1];
+};
+
+struct zip64_dir_trailer_locator {
+	unsigned char magic[4];
+	unsigned char disk[4];
+	unsigned char offset[8];
+	unsigned char number_of_disks[4];
+	unsigned char _end[1];
+};
+
 /*
  * On ARM, padding is added at the end of the struct, so a simple
  * sizeof(struct ...) reports two bytes more than the payload size
@@ -98,6 +122,12 @@ struct zip_extra_mtime {
 #define ZIP_EXTRA_MTIME_SIZE	offsetof(struct zip_extra_mtime, _end)
 #define ZIP_EXTRA_MTIME_PAYLOAD_SIZE \
 	(ZIP_EXTRA_MTIME_SIZE - offsetof(struct zip_extra_mtime, flags))
+#define ZIP64_DIR_TRAILER_SIZE	offsetof(struct zip64_dir_trailer, _end)
+#define ZIP64_DIR_TRAILER_RECORD_SIZE \
+	(ZIP64_DIR_TRAILER_SIZE - \
+	 offsetof(struct zip64_dir_trailer, creator_version))
+#define ZIP64_DIR_TRAILER_LOCATOR_SIZE \
+	offsetof(struct zip64_dir_trailer_locator, _end)
 
 static void copy_le16(unsigned char *dest, unsigned int n)
 {
@@ -113,6 +143,31 @@ static void copy_le32(unsigned char *dest, unsigned int n)
 	dest[3] = 0xff & (n >> 030);
 }
 
+static void copy_le64(unsigned char *dest, uint64_t n)
+{
+	dest[0] = 0xff & n;
+	dest[1] = 0xff & (n >> 010);
+	dest[2] = 0xff & (n >> 020);
+	dest[3] = 0xff & (n >> 030);
+	dest[4] = 0xff & (n >> 040);
+	dest[5] = 0xff & (n >> 050);
+	dest[6] = 0xff & (n >> 060);
+	dest[7] = 0xff & (n >> 070);
+}
+
+static uint64_t clamp_max(uint64_t n, uint64_t max, int *clamped)
+{
+	if (n <= max)
+		return n;
+	*clamped = 1;
+	return max;
+}
+
+static void copy_le16_clamp(unsigned char *dest, uint64_t n, int *clamped)
+{
+	copy_le16(dest, clamp_max(n, 0xffff, clamped));
+}
+
 static void *zlib_deflate_raw(void *data, unsigned long size,
 			      int compression_level,
 			      unsigned long *compressed_size)
@@ -282,6 +337,9 @@ static int write_zip_entry(struct archiver_args *args,
 				sha1_to_hex(sha1));
 	}
 
+	if (creator_version > max_creator_version)
+		max_creator_version = creator_version;
+
 	if (buffer && method == 8) {
 		out = deflated = zlib_deflate_raw(buffer, size,
 						  args->compression_level,
@@ -439,20 +497,49 @@ static int write_zip_entry(struct archiver_args *args,
 	return 0;
 }
 
+static void write_zip64_trailer(void)
+{
+	struct zip64_dir_trailer trailer64;
+	struct zip64_dir_trailer_locator locator64;
+
+	copy_le32(trailer64.magic, 0x06064b50);
+	copy_le64(trailer64.record_size, ZIP64_DIR_TRAILER_RECORD_SIZE);
+	copy_le16(trailer64.creator_version, max_creator_version);
+	copy_le16(trailer64.version, 45);
+	copy_le32(trailer64.disk, 0);
+	copy_le32(trailer64.directory_start_disk, 0);
+	copy_le64(trailer64.entries_on_this_disk, zip_dir_entries);
+	copy_le64(trailer64.entries, zip_dir_entries);
+	copy_le64(trailer64.size, zip_dir_offset);
+	copy_le64(trailer64.offset, zip_offset);
+
+	copy_le32(locator64.magic, 0x07064b50);
+	copy_le32(locator64.disk, 0);
+	copy_le64(locator64.offset, zip_offset + zip_dir_offset);
+	copy_le32(locator64.number_of_disks, 1);
+
+	write_or_die(1, &trailer64, ZIP64_DIR_TRAILER_SIZE);
+	write_or_die(1, &locator64, ZIP64_DIR_TRAILER_LOCATOR_SIZE);
+}
+
 static void write_zip_trailer(const unsigned char *sha1)
 {
 	struct zip_dir_trailer trailer;
+	int clamped = 0;
 
 	copy_le32(trailer.magic, 0x06054b50);
 	copy_le16(trailer.disk, 0);
 	copy_le16(trailer.directory_start_disk, 0);
-	copy_le16(trailer.entries_on_this_disk, zip_dir_entries);
-	copy_le16(trailer.entries, zip_dir_entries);
+	copy_le16_clamp(trailer.entries_on_this_disk, zip_dir_entries,
+			&clamped);
+	copy_le16_clamp(trailer.entries, zip_dir_entries, &clamped);
 	copy_le32(trailer.size, zip_dir_offset);
 	copy_le32(trailer.offset, zip_offset);
 	copy_le16(trailer.comment_length, sha1 ? GIT_SHA1_HEXSZ : 0);
 
 	write_or_die(1, zip_dir, zip_dir_offset);
+	if (clamped)
+		write_zip64_trailer();
 	write_or_die(1, &trailer, ZIP_DIR_TRAILER_SIZE);
 	if (sha1)
 		write_or_die(1, sha1_to_hex(sha1), GIT_SHA1_HEXSZ);
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index c6bd729..cca2338 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -122,7 +122,7 @@ test_lazy_prereq ZIPINFO '
 	test "x$n" = "x0"
 '
 
-test_expect_failure ZIPINFO 'zip archive with many entries' '
+test_expect_success ZIPINFO 'zip archive with many entries' '
 	# add a directory with 256 files
 	mkdir 00 &&
 	for a in 0 1 2 3 4 5 6 7 8 9 a b c d e f
-- 
2.5.0
