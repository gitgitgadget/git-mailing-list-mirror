From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fast-import: Don't barf if import-marks file is missing
Date: Tue, 11 Jan 2011 11:51:02 -0600
Message-ID: <20110111175102.GB15133@burratino>
References: <7vwrmd7kxe.fsf@alter.siamese.dyndns.org>
 <1294766058-29739-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 18:51:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PciNQ-0007lB-Hd
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 18:51:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517Ab1AKRvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 12:51:20 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48699 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932442Ab1AKRvS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 12:51:18 -0500
Received: by qwa26 with SMTP id 26so21221891qwa.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 09:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rJkMwqQgJqV72CXTypXmSMUgnDjIb3bZ1svKgcP5yPc=;
        b=ikjZIOILhiUUocmP/ccoPLB0I7z0xVTNCt1Q1Ka114mevCPAxCRVcXZA+2l7IpT8AU
         jUdmOmU+9wq+isY9MxisKq5YuNagYSM6YBCj/thBxQPCgKsOvV73tfLgsemQB3YzASKH
         kF1E219PHnXmxzhiAgjTSAK9mO9voqb0zNnSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=v2EqmwH7XLcyNpDM6/c9y0+MWRMJivBTaLM6SRhdR49REHU3G7f1Flt1yJrR8PXYJN
         v7HSG0oPmhAep3Hy6Iek+5AWjMawS8AyVRZX8BlWO9pAng0Ng/nPMXYIgv32wpve9a+U
         Q6dlp6bYDIGNSKuAsbiRJlm87ci4qAUMVZRgI=
Received: by 10.224.67.141 with SMTP id r13mr24237661qai.268.1294768277523;
        Tue, 11 Jan 2011 09:51:17 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id q12sm18473086qcu.18.2011.01.11.09.51.15
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 09:51:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1294766058-29739-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164962>

Ramkumar Ramachandra wrote:

> The --import-marks option used to barf when the specified marks file
> doesn't exist.

Micronit: change descriptions should contrast present behavior

	The --import-marks options errors out when the marks file is
	missing.

with user requirements

	But if a frontend is just using a marks file to ensure its state
	persists between runs, it would be simpler if missing marks
	files were tolerated.  In some cases the frontend cannot even
	check for the existence of the marks file itself because with
	--relative-marks, the location of the marks file is
	backend-dependent.

and the proposed solution

	Change the meaning of --import-marks to "read marks file if it
	exists so such frontends don't have to use a different command
	line when bootstrapping.

I.e., the preferred style is to use present tense for the description
of present behavior, so the patch can be read as a bug report.

> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -72,7 +72,7 @@ OPTIONS
>  
>  --import-marks=<file>::
>  	Before processing any input, load the marks specified in
> -	<file>.  The input file must exist, must be readable, and
> +	<file>, if it exists.

This means removing a typo detection facility.

	git fast-import --import-marks=something-like-a-real-marks-file.marks

would be accepted and result in an empty marks table instead of an
error message.  Is that considered worth it?  (My hunch is no, but
either way, I think it ought to be mentioned in the change
description.)

> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1795,7 +1795,11 @@ static void read_marks(void)

Nice implementation.  Maybe something like this on top?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-fast-import.txt |    6 +++-
 fast-import.c                     |   12 ++++++--
 t/t9300-fast-import.sh            |   55 +++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 94fbe54..32a062c 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -72,12 +72,16 @@ OPTIONS
 
 --import-marks=<file>::
 	Before processing any input, load the marks specified in
-	<file>, if it exists.  The input file must be readable, and
+	<file>.  The input file must exist, must be readable, and
 	must use the same format as produced by \--export-marks.
 	Multiple options may be supplied to import more than one
 	set of marks.  If a mark is defined to different values,
 	the last file wins.
 
+--import-marks-if-exists=<file>::
+	Like --import-marks but instead of erroring out, silently
+	skips the file if it does not exist.
+
 --relative-marks::
 	After specifying --relative-marks= the paths specified
 	with --import-marks= and --export-marks= are relative
diff --git a/fast-import.c b/fast-import.c
index cbd5124..c525fda 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -329,6 +329,7 @@ static struct mark_set *marks;
 static const char *export_marks_file;
 static const char *import_marks_file;
 static int import_marks_file_from_stream;
+static int import_marks_file_ignore_missing;
 static int relative_marks_paths;
 
 /* Our last blob */
@@ -1797,7 +1798,7 @@ static void read_marks(void)
 	FILE *f = fopen(import_marks_file, "r");
 	if (f)
 		;
-	else if (errno == ENOENT)
+	else if (import_marks_file_ignore_missing && errno == ENOENT)
 		return; /* Marks file does not exist */
 	else
 		die_errno("cannot read '%s'", import_marks_file);
@@ -2865,7 +2866,8 @@ static char* make_fast_import_path(const char *path)
 	return strbuf_detach(&abs_path, NULL);
 }
 
-static void option_import_marks(const char *marks, int from_stream)
+static void option_import_marks(const char *marks,
+					int from_stream, int ignore_missing)
 {
 	if (import_marks_file) {
 		if (from_stream)
@@ -2879,6 +2881,7 @@ static void option_import_marks(const char *marks, int from_stream)
 	import_marks_file = make_fast_import_path(marks);
 	safe_create_leading_directories_const(import_marks_file);
 	import_marks_file_from_stream = from_stream;
+	import_marks_file_ignore_missing = ignore_missing;
 }
 
 static void option_date_format(const char *fmt)
@@ -2978,7 +2981,10 @@ static int parse_one_feature(const char *feature, int from_stream)
 	if (!prefixcmp(feature, "date-format=")) {
 		option_date_format(feature + 12);
 	} else if (!prefixcmp(feature, "import-marks=")) {
-		option_import_marks(feature + 13, from_stream);
+		option_import_marks(feature + 13, from_stream, 0);
+	} else if (!prefixcmp(feature, "import-marks-if-exists=")) {
+		option_import_marks(feature + strlen("import-marks-if-exists="),
+					from_stream, 1);
 	} else if (!prefixcmp(feature, "export-marks=")) {
 		option_export_marks(feature + 13);
 	} else if (!strcmp(feature, "cat-blob")) {
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 222d105..870e55b 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1706,6 +1706,61 @@ test_expect_success \
     'cat input | git fast-import --export-marks=other.marks &&
     grep :1 other.marks'
 
+test_expect_success 'R: catch typo in marks file name' '
+	test_must_fail git fast-import --import-marks=nonexistent.marks </dev/null &&
+	echo "feature import-marks=nonexistent.marks" |
+	test_must_fail git fast-import
+'
+
+test_expect_success 'R: import and output marks can be the same file' '
+	rm -f io.marks &&
+	blob=$(echo hi | git hash-object --stdin) &&
+	cat >expect <<-EOF &&
+	:1 $blob
+	:2 $blob
+	EOF
+	git fast-import --export-marks=io.marks <<-\EOF &&
+	blob
+	mark :1
+	data 3
+	hi
+
+	EOF
+	git fast-import --import-marks=io.marks --export-marks=io.marks <<-\EOF &&
+	blob
+	mark :2
+	data 3
+	hi
+
+	EOF
+	test_cmp expect io.marks
+'
+
+test_expect_success 'R: --import-marks=foo --output-marks=foo to create foo fails' '
+	rm -f io.marks &&
+	test_must_fail git fast-import --import-marks=io.marks --export-marks=io.marks <<-\EOF
+	blob
+	mark :1
+	data 3
+	hi
+
+	EOF
+'
+
+test_expect_success 'R: --import-marks-if-exists' '
+	rm -f io.marks &&
+	blob=$(echo hi | git hash-object --stdin) &&
+	echo ":1 $blob" >expect &&
+	git fast-import --import-marks-if-exists=io.marks --export-marks=io.marks <<-\EOF &&
+	blob
+	mark :1
+	data 3
+	hi
+
+	EOF
+	test_cmp expect io.marks
+'
+
 cat >input << EOF
 feature import-marks=marks.out
 feature export-marks=marks.new
-- 
1.7.4.rc1
