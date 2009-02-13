From: <carlos.duclos@nokia.com>
Subject: [PATCH] When archiving a repository there is no way to specify a
 file as output.
Date: Fri, 13 Feb 2009 16:34:36 +0100
Message-ID: <599636D7828020419E3AB2DE5CCC8130036BF8B1D2@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 13 16:36:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY05c-00035s-Nl
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 16:36:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757872AbZBMPfC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 10:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756379AbZBMPfB
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 10:35:01 -0500
Received: from smtp.nokia.com ([192.100.122.230]:16918 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193AbZBMPfA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Feb 2009 10:35:00 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1DFYb9q002070
	for <git@vger.kernel.org>; Fri, 13 Feb 2009 17:34:55 +0200
Received: from vaebh104.NOE.Nokia.com ([10.160.244.30]) by vaebh105.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Feb 2009 17:34:43 +0200
Received: from smtp.mgd.nokia.com ([65.54.30.8]) by vaebh104.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 13 Feb 2009 17:34:38 +0200
Received: from nok-am1mhub-07.mgdnok.nokia.com (65.54.30.14) by
 NOK-AM1MHUB-04.mgdnok.nokia.com (65.54.30.8) with Microsoft SMTP Server (TLS)
 id 8.1.291.1; Fri, 13 Feb 2009 16:34:37 +0100
Received: from NOK-EUMSG-02.mgdnok.nokia.com ([65.54.30.107]) by
 nok-am1mhub-07.mgdnok.nokia.com ([65.54.30.14]) with mapi; Fri, 13 Feb 2009
 16:34:37 +0100
Thread-Topic: [PATCH] When archiving a repository there is no way to specify
 a file as output.
Thread-Index: AQHJjfCTU7l5nha7v0OoSWuzbzZScA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
X-OriginalArrivalTime: 13 Feb 2009 15:34:38.0869 (UTC) FILETIME=[9506D450:01C98DF0]
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109755>

Hi,

Short description:
To enable that I added a new option "--output" that will redirect the output to a file instead to stdout.

Long description:
When archiving a repository there is no way to send the result to a file without using redirection at shell level. Since there are situations where redirection is not available, for instance when running git inside a continuous integration system which is already redirecting the output, I added an option to write the archive to a file directly.
In order to do that I added a new option to archiver_args, int output_fd, which holds the file descriptor where the resulting archive should be written. If no option is specified in command line that option defaults to 1 and no behavior change, however if the "--output" option is specified and the file was created that file descriptor points to the new file. I also modified the write_or_die calls to use "output_fd" instead of 1, so they write to the file descriptor.

>From 10e09bf828c18f2846651262b7f647b630e09872 Mon Sep 17 00:00:00 2001
From: Carlos Manuel Duclos Vergara <carlos.duclos@trolltech.com>
Date: Fri, 13 Feb 2009 16:09:39 +0100
Subject: [PATCH] When archiving a repository there is no way to specify a file as output.
 To enable that I added a new option "--output" that will redirect the output to a file instead to stdout.

Signed-off-by: Carlos Manuel Duclos Vergara <carlos.duclos@nokia.com>

---
 archive-tar.c |   16 ++++++++++++----
 archive-zip.c |   21 ++++++++++++++-------
 archive.c     |   20 ++++++++++++++++++++
 archive.h     |    1 +
 4 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index ba890eb..4d8fc03 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -13,11 +13,13 @@ static unsigned long offset;

 static int tar_umask = 002;

+static int output_fd = 1;
+
 /* writes out the whole block, but only if it is full */
 static void write_if_needed(void)
 {
        if (offset == BLOCKSIZE) {
-               write_or_die(1, block, BLOCKSIZE);
+               write_or_die(output_fd, block, BLOCKSIZE);
                offset = 0;
        }
 }
@@ -42,7 +44,7 @@ static void write_blocked(const void *data, unsigned long size)
                write_if_needed();
        }
        while (size >= BLOCKSIZE) {
-               write_or_die(1, buf, BLOCKSIZE);
+               write_or_die(output_fd, buf, BLOCKSIZE);
                size -= BLOCKSIZE;
                buf += BLOCKSIZE;
        }
@@ -66,10 +68,10 @@ static void write_trailer(void)
 {
        int tail = BLOCKSIZE - offset;
        memset(block + offset, 0, tail);
-       write_or_die(1, block, BLOCKSIZE);
+       write_or_die(output_fd, block, BLOCKSIZE);
        if (tail < 2 * RECORDSIZE) {
                memset(block, 0, offset);
-               write_or_die(1, block, BLOCKSIZE);
+               write_or_die(output_fd, block, BLOCKSIZE);
        }
 }

@@ -234,11 +236,17 @@ static int git_tar_config(const char *var, const char *value, void *cb)
        return git_default_config(var, value, cb);
 }

+static void setup_write_backend(struct archiver_args *args)
+{
+       output_fd = args->output_fd;
+}
+
 int write_tar_archive(struct archiver_args *args)
 {
        int err = 0;

        git_config(git_tar_config, NULL);
+       setup_write_backend(args);

        if (args->commit_sha1)
                err = write_global_extended_header(args);
diff --git a/archive-zip.c b/archive-zip.c
index cf28504..dd3ba27 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -14,6 +14,8 @@ static unsigned int zip_offset;
 static unsigned int zip_dir_offset;
 static unsigned int zip_dir_entries;

+static int output_fd = 1;
+
 #define ZIP_DIRECTORY_MIN_SIZE (1024 * 1024)

 struct zip_local_header {
@@ -219,12 +221,12 @@ static int write_zip_entry(struct archiver_args *args,
        copy_le32(header.size, uncompressed_size);
        copy_le16(header.filename_length, pathlen);
        copy_le16(header.extra_length, 0);
-       write_or_die(1, &header, ZIP_LOCAL_HEADER_SIZE);
+       write_or_die(output_fd, &header, ZIP_LOCAL_HEADER_SIZE);
        zip_offset += ZIP_LOCAL_HEADER_SIZE;
-       write_or_die(1, path, pathlen);
+       write_or_die(output_fd, path, pathlen);
        zip_offset += pathlen;
        if (compressed_size > 0) {
-               write_or_die(1, out, compressed_size);
+               write_or_die(output_fd, out, compressed_size);
                zip_offset += compressed_size;
        }

@@ -246,10 +248,10 @@ static void write_zip_trailer(const unsigned char *sha1)
        copy_le32(trailer.offset, zip_offset);
        copy_le16(trailer.comment_length, sha1 ? 40 : 0);

-       write_or_die(1, zip_dir, zip_dir_offset);
-       write_or_die(1, &trailer, ZIP_DIR_TRAILER_SIZE);
+       write_or_die(output_fd, zip_dir, zip_dir_offset);
+       write_or_die(output_fd, &trailer, ZIP_DIR_TRAILER_SIZE);
        if (sha1)
-               write_or_die(1, sha1_to_hex(sha1), 40);
+               write_or_die(output_fd, sha1_to_hex(sha1), 40);
 }

 static void dos_time(time_t *time, int *dos_date, int *dos_time)
@@ -261,12 +263,17 @@ static void dos_time(time_t *time, int *dos_date, int *dos_time)
        *dos_time = t->tm_sec / 2 + t->tm_min * 32 + t->tm_hour * 2048;
 }

+static void setup_write_backend(struct archiver_args *args)
+{
+       output_fd = args->output_fd;
+}
+
 int write_zip_archive(struct archiver_args *args)
 {
        int err;

        dos_time(&args->time, &zip_date, &zip_time);
-
+       setup_write_backend(args);
        zip_dir = xmalloc(ZIP_DIRECTORY_MIN_SIZE);
        zip_dir_size = ZIP_DIRECTORY_MIN_SIZE;

diff --git a/archive.c b/archive.c
index e6de039..420b853 100644
--- a/archive.c
+++ b/archive.c
@@ -239,6 +239,16 @@ static void parse_treeish_arg(const char **argv,
        ar_args->time = archive_time;
 }

+static void create_output_file(const char *output_file, struct archiver_args *ar_args)
+{
+       int fd = -1;
+
+       fd = creat(output_file, S_IRUSR | S_IWUSR);
+       if(fd < 0)
+               die("could not create archive file");
+       ar_args->output_fd = fd;
+}
+
 #define OPT__COMPR(s, v, h, p) \
        { OPTION_SET_INT, (s), NULL, (v), NULL, (h), \
          PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, (p) }
@@ -253,6 +263,7 @@ static int parse_archive_args(int argc, const char **argv,
        const char *base = NULL;
        const char *remote = NULL;
        const char *exec = NULL;
+    const char *output = NULL;
        int compression_level = -1;
        int verbose = 0;
        int i;
@@ -262,6 +273,7 @@ static int parse_archive_args(int argc, const char **argv,
                OPT_STRING(0, "format", &format, "fmt", "archive format"),
                OPT_STRING(0, "prefix", &base, "prefix",
                        "prepend prefix to each pathname in the archive"),
+               OPT_STRING(0, "output", &output, "output file", "write the results to this file"),
                OPT__VERBOSE(&verbose),
                OPT__COMPR('0', &compression_level, "store only", 0),
                OPT__COMPR('1', &compression_level, "compress faster", 1),
@@ -294,6 +306,14 @@ static int parse_archive_args(int argc, const char **argv,
        if (!base)
                base = "";

+       if(output)
+               create_output_file(output, args);
+       else
+               /*
+                * Default to stdout
+                */
+               args->output_fd = 1;
+
        if (list) {
                for (i = 0; i < ARRAY_SIZE(archivers); i++)
                        printf("%s\n", archivers[i].name);
diff --git a/archive.h b/archive.h
index 0b15b35..67524fa 100644
--- a/archive.h
+++ b/archive.h
@@ -9,6 +9,7 @@ struct archiver_args {
        const struct commit *commit;
        time_t time;
        const char **pathspec;
+       int output_fd;
        unsigned int verbose : 1;
        int compression_level;
 };
--
1.6.0.2

>From 7cbd0a3edb1cf75b5a0644263e1755fd18a5c37d Mon Sep 17 00:00:00 2001
From: Carlos Manuel Duclos Vergara <carlos.duclos@trolltech.com>
Date: Fri, 13 Feb 2009 16:22:21 +0100
Subject: [PATCH] Updating documentation for git-archive in order to reflect the new "--output" option.

Signed-off-by: Carlos Manuel Duclos Vergara <carlos.duclos@nokia.com>

---
 Documentation/git-archive.txt |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 41cbf9c..d1a9d95 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -47,6 +47,9 @@ OPTIONS
 --prefix=<prefix>/::
        Prepend <prefix>/ to each filename in the archive.

+--output=<output file>::
+       Writes the archive to <output file> instead of stdout.
+
 <extra>::
        This can be any options that the archiver backend understand.
        See next section.
--
1.6.0.2
