From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] archive: simplify archive format guessing
Date: Mon, 08 Feb 2010 00:30:20 +0100
Message-ID: <4B6F4D0C.2010107@lsrfire.ath.cx>
References: <20100207070811.GA26338@progeny.tock> <4B6E8FD9.7060905@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 00:30:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeGaH-00073P-BW
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 00:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457Ab0BGXa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2010 18:30:28 -0500
Received: from india601.server4you.de ([85.25.151.105]:43618 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764Ab0BGXa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2010 18:30:27 -0500
Received: from [10.0.1.100] (p57B7BA5D.dip.t-dialin.net [87.183.186.93])
	by india601.server4you.de (Postfix) with ESMTPSA id 2F75D2F804E;
	Mon,  8 Feb 2010 00:30:26 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <4B6E8FD9.7060905@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139264>

Here's my patch again, with a reformatted comment, a renamed variable and
two simple tests.
-- >8 --
The code to guess an output archive's format consumed any --format
options and built a new one.  Jonathan noticed that it does so in an
unsafe way, risking to overflow the static buffer fmt_opt.

Change the code to keep the existing --format options intact and to only
add a new one if a format could be guessed based on the output file name.
The new option is added as the first one, allowing the existing ones to
overrule it, i.e. explicit --format options given on the command line win
over format guesses, as before.

To simplify the code further, format_from_name() is changed to return the
full --format option, thus no potentially dangerous sprintf() calls are
needed any more.

Reported-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-archive.c   |   34 ++++++++++++++++------------------
 t/t5000-tar-tree.sh |   10 ++++++++++
 2 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/builtin-archive.c b/builtin-archive.c
index 3fb4136..6a887f5 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -70,7 +70,7 @@ static const char *format_from_name(const char *filename)
 		return NULL;
 	ext++;
 	if (!strcasecmp(ext, "zip"))
-		return "zip";
+		return "--format=zip";
 	return NULL;
 }
 
@@ -84,7 +84,7 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 	const char *exec = "git-upload-archive";
 	const char *output = NULL;
 	const char *remote = NULL;
-	const char *format = NULL;
+	const char *format_option = NULL;
 	struct option local_opts[] = {
 		OPT_STRING('o', "output", &output, "file",
 			"write the archive to this file"),
@@ -92,33 +92,31 @@ int cmd_archive(int argc, const char **argv, const char *prefix)
 			"retrieve the archive from remote repository <repo>"),
 		OPT_STRING(0, "exec", &exec, "cmd",
 			"path to the remote git-upload-archive command"),
-		OPT_STRING(0, "format", &format, "fmt", "archive format"),
 		OPT_END()
 	};
-	char fmt_opt[32];
 
 	argc = parse_options(argc, argv, prefix, local_opts, NULL,
 			     PARSE_OPT_KEEP_ALL);
 
 	if (output) {
 		create_output_file(output);
-		if (!format)
-			format = format_from_name(output);
+		format_option = format_from_name(output);
 	}
 
-	if (format) {
-		sprintf(fmt_opt, "--format=%s", format);
-		/*
-		 * We have enough room in argv[] to muck it in place,
-		 * because either --format and/or --output must have
-		 * been given on the original command line if we get
-		 * to this point, and parse_options() must have eaten
-		 * it, i.e. we can add back one element to the array.
-		 * But argv[] may contain "--"; we should make it the
-		 * first option.
-		 */
+	/*
+	 * We have enough room in argv[] to muck it in place, because
+	 * --output must have been given on the original command line
+	 * if we get to this point, and parse_options() must have eaten
+	 * it, i.e. we can add back one element to the array.
+	 *
+	 * We add a fake --format option at the beginning, with the
+	 * format inferred from our output filename.  This way explicit
+	 * --format options can override it, and the fake option is
+	 * inserted before any "--" that might have been given.
+	 */
+	if (format_option) {
 		memmove(argv + 2, argv + 1, sizeof(*argv) * argc);
-		argv[1] = fmt_opt;
+		argv[1] = format_option;
 		argv[++argc] = NULL;
 	}
 
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 0037f63..27bfba5 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -189,6 +189,16 @@ test_expect_success 'git archive --format=zip with --output' \
     'git archive --format=zip --output=d2.zip HEAD &&
     test_cmp d.zip d2.zip'
 
+test_expect_success 'git archive with --output, inferring format' '
+	git archive --output=d3.zip HEAD &&
+	test_cmp d.zip d3.zip
+'
+
+test_expect_success 'git archive with --output, override inferred format' '
+	git archive --format=tar --output=d4.zip HEAD &&
+	test_cmp b.tar d4.zip
+'
+
 $UNZIP -v >/dev/null 2>&1
 if [ $? -eq 127 ]; then
 	say "Skipping ZIP tests, because unzip was not found"
-- 
1.7.0.rc1
