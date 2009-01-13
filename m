From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach format-patch to handle output directory relative
 to cwd
Date: Mon, 12 Jan 2009 17:00:30 -0800
Message-ID: <7vmydwf2a9.fsf@gitster.siamese.dyndns.org>
References: <496BBE70.9060405@cesarb.net>
 <7vab9wgmwe.fsf@gitster.siamese.dyndns.org> <496BCE55.8030407@cesarb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Cesar Eduardo Barros <cesarb@cesarb.net>
X-From: git-owner@vger.kernel.org Tue Jan 13 02:02:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMXfL-0002ts-0q
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 02:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754193AbZAMBAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 20:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753972AbZAMBAi
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 20:00:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56842 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290AbZAMBAh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 20:00:37 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 10BAF90343;
	Mon, 12 Jan 2009 20:00:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DB9AA90342; Mon,
 12 Jan 2009 20:00:32 -0500 (EST)
In-Reply-To: <496BCE55.8030407@cesarb.net> (Cesar Eduardo Barros's message of
 "Mon, 12 Jan 2009 21:12:21 -0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 962135AE-E10D-11DD-97C6-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105432>

Cesar Eduardo Barros <cesarb@cesarb.net> writes:

> Works great, only the resulting output to the screen is a bit
> ugly/confusing:
>
> drivers/net/../../../0001-sc92031-more-useful-banner-in-kernel-log.patch
> ...
> (after all, I am still inside the drivers/net directory)

Fair enough.  Here is a replacement diff.

 builtin-log.c           |   28 ++++++++++++++++++++++--
 t/t4014-format-patch.sh |   52 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 4 deletions(-)

diff --git c/builtin-log.c w/builtin-log.c
index db71e0d..16a0f11 100644
--- c/builtin-log.c
+++ w/builtin-log.c
@@ -568,6 +568,7 @@ static const char *get_oneline_for_filename(struct commit *commit,
 
 static FILE *realstdout = NULL;
 static const char *output_directory = NULL;
+static int outdir_offset;
 
 static int reopen_stdout(const char *oneline, int nr, int total)
 {
@@ -594,7 +595,7 @@ static int reopen_stdout(const char *oneline, int nr, int total)
 		strcpy(filename + len, fmt_patch_suffix);
 	}
 
-	fprintf(realstdout, "%s\n", filename);
+	fprintf(realstdout, "%s\n", filename + outdir_offset);
 	if (freopen(filename, "w", stdout) == NULL)
 		return error("Cannot open patch file %s",filename);
 
@@ -757,6 +758,27 @@ static const char *clean_message_id(const char *msg_id)
 	return xmemdupz(a, z - a);
 }
 
+static const char *set_outdir(const char *prefix, const char *output_directory)
+{
+	if (output_directory && is_absolute_path(output_directory))
+		return output_directory;
+
+	if (!prefix || !*prefix) {
+		if (output_directory)
+			return output_directory;
+		/* The user did not explicitly ask for "./" */
+		outdir_offset = 2;
+		return "./";
+	}
+
+	outdir_offset = strlen(prefix);
+	if (!output_directory)
+		return prefix;
+
+	return xstrdup(prefix_filename(prefix, outdir_offset,
+				       output_directory));
+}
+
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
 	struct commit *commit;
@@ -935,8 +957,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (!DIFF_OPT_TST(&rev.diffopt, TEXT) && !no_binary_diff)
 		DIFF_OPT_SET(&rev.diffopt, BINARY);
 
-	if (!output_directory && !use_stdout)
-		output_directory = prefix;
+	if (!use_stdout)
+		output_directory = set_outdir(prefix, output_directory);
 
 	if (output_directory) {
 		if (use_stdout)
diff --git c/t/t4014-format-patch.sh w/t/t4014-format-patch.sh
index 7fe853c..16de436 100755
--- c/t/t4014-format-patch.sh
+++ w/t/t4014-format-patch.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2006 Junio C Hamano
 #
 
-test_description='Format-patch skipping already incorporated patches'
+test_description='various format-patch tests'
 
 . ./test-lib.sh
 
@@ -230,4 +230,54 @@ test_expect_success 'shortlog of cover-letter wraps overly-long onelines' '
 
 '
 
+test_expect_success 'format-patch from a subdirectory (1)' '
+	filename=$(
+		rm -rf sub &&
+		mkdir -p sub/dir &&
+		cd sub/dir &&
+		git format-patch -1
+	) &&
+	case "$filename" in
+	0*)
+		;; # ok
+	*)
+		echo "Oops? $filename"
+		false
+		;;
+	esac &&
+	test -f "$filename"
+'
+
+test_expect_success 'format-patch from a subdirectory (2)' '
+	filename=$(
+		rm -rf sub &&
+		mkdir -p sub/dir &&
+		cd sub/dir &&
+		git format-patch -1 -o ..
+	) &&
+	case "$filename" in
+	../0*)
+		;; # ok
+	*)
+		echo "Oops? $filename"
+		false
+		;;
+	esac &&
+	basename=$(expr "$filename" : ".*/\(.*\)") &&
+	test -f "sub/$basename"
+'
+
+test_expect_success 'format-patch from a subdirectory (3)' '
+	here="$TEST_DIRECTORY/$test" &&
+	rm -f 0* &&
+	filename=$(
+		rm -rf sub &&
+		mkdir -p sub/dir &&
+		cd sub/dir &&
+		git format-patch -1 -o "$here"
+	) &&
+	basename=$(expr "$filename" : ".*/\(.*\)") &&
+	test -f "$basename"
+'
+
 test_done
