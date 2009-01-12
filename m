From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Teach format-patch to handle output directory relative to
 cwd
Date: Mon, 12 Jan 2009 14:49:53 -0800
Message-ID: <7vab9wgmwe.fsf@gitster.siamese.dyndns.org>
References: <496BBE70.9060405@cesarb.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Cesar Eduardo Barros <cesarb@cesarb.net>
X-From: git-owner@vger.kernel.org Mon Jan 12 23:52:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMVdQ-0006jj-14
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 23:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760983AbZALWuJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 17:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759991AbZALWuH
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 17:50:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42201 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762792AbZALWuD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 17:50:03 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B9078F796;
	Mon, 12 Jan 2009 17:49:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 13B6E8F795; Mon,
 12 Jan 2009 17:49:54 -0500 (EST)
In-Reply-To: <496BBE70.9060405@cesarb.net> (Cesar Eduardo Barros's message of
 "Mon, 12 Jan 2009 20:04:32 -0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5657F74E-E0FB-11DD-AF6C-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105408>

Without any explicit -o parameter, we correctly avoided putting the
resulting patch output to the toplevel.  We should do the same when
the user gave a relative pathname to be consistent with this case and also
with how other commands handle relative pathnames.

Noticed by Cesar Eduardo Barros.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Cesar Eduardo Barros <cesarb@cesarb.net> writes:

> If you are in a subdirectory of your working copy (for instance,
> linux-2.6/drivers/net) and use git-format-patch with -o to a sequence
> of ../ (for instance, -o ../../../) to write to the working copy's
> parent directory, it instead interprets the directory passed to -o as
> relative to the root of the working copy, instead of the expected
> current directory.

 builtin-log.c           |   13 ++++++++++-
 t/t4014-format-patch.sh |   52 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 3 deletions(-)

diff --git c/builtin-log.c w/builtin-log.c
index 4a02ee9..3e404ae 100644
--- c/builtin-log.c
+++ w/builtin-log.c
@@ -731,6 +731,15 @@ static const char *clean_message_id(const char *msg_id)
 	return xmemdupz(a, z - a);
 }
 
+static const char *set_outdir(const char *prefix, const char *output_directory)
+{
+	if (!output_directory)
+		output_directory = ".";
+	if (prefix)
+		output_directory = xstrdup(prefix_filename(prefix, strlen(prefix), output_directory));
+	return output_directory;
+}
+
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
 	struct commit *commit;
@@ -908,8 +917,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (!DIFF_OPT_TST(&rev.diffopt, TEXT) && !no_binary_diff)
 		DIFF_OPT_SET(&rev.diffopt, BINARY);
 
-	if (!output_directory && !use_stdout)
-		output_directory = prefix;
+	if (!use_stdout)
+		output_directory = set_outdir(prefix, output_directory);
 
 	if (output_directory) {
 		if (use_stdout)
diff --git c/t/t4014-format-patch.sh w/t/t4014-format-patch.sh
index 9d99dc2..5a9a63d 100755
--- c/t/t4014-format-patch.sh
+++ w/t/t4014-format-patch.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2006 Junio C Hamano
 #
 
-test_description='Format-patch skipping already incorporated patches'
+test_description='various format-patch tests'
 
 . ./test-lib.sh
 
@@ -255,4 +255,54 @@ test_expect_success 'format-patch respects -U' '
 
 '
 
+test_expect_success 'format-patch from a subdirectory (1)' '
+	filename=$(
+		rm -rf sub &&
+		mkdir -p sub/dir &&
+		cd sub/dir &&
+		git format-patch -1
+	) &&
+	case "$filename" in
+	sub/dir/*)
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
+	sub/dir/../0*)
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
