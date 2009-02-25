From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-archive: add --output=<file> to send output to a
 file
Date: Tue, 24 Feb 2009 22:13:09 -0800
Message-ID: <7v4oyjdoy2.fsf@gitster.siamese.dyndns.org>
References: <599636D7828020419E3AB2DE5CCC8130036BF8B1E4@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Carlos Manuel Duclos Vergara <carlos.duclos@nokia.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 07:14:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcD2e-0006KM-1M
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 07:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbZBYGNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 01:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbZBYGNV
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 01:13:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55724 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbZBYGNU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 01:13:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A5FD21EDE;
	Thu, 26 Feb 2009 01:13:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F203C1EDC; Thu,
 26 Feb 2009 01:13:14 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8F194D64-03CC-11DE-9076-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111374>

When archiving a repository there is no way to specify a file as output.
This patch adds a new option "--output" that redirects the output to a
file instead of stdout.

Signed-off-by: Carlos Manuel Duclos Vergara <carlos.duclos@nokia.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * I've fixed it up slightly; especially the tests, which were not making
   sure the results match what are expected.

   Thanks.

 Documentation/git-archive.txt |    3 +++
 archive.c                     |   19 +++++++++++++++++++
 t/t5000-tar-tree.sh           |    8 ++++++++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 41cbf9c..5bde197 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -47,6 +47,9 @@ OPTIONS
 --prefix=<prefix>/::
 	Prepend <prefix>/ to each filename in the archive.
 
+--output=<file>::
+	Write the archive to <file> instead of stdout.
+
 <extra>::
 	This can be any options that the archiver backend understand.
 	See next section.
diff --git a/archive.c b/archive.c
index e6de039..c6aea83 100644
--- a/archive.c
+++ b/archive.c
@@ -239,6 +239,19 @@ static void parse_treeish_arg(const char **argv,
 	ar_args->time = archive_time;
 }
 
+static void create_output_file(const char *output_file)
+{
+	int output_fd = open(output_file, O_CREAT | O_WRONLY | O_TRUNC, 0666);
+	if (output_fd < 0)
+		die("could not create archive file: %s ", output_file);
+	if (output_fd != 1) {
+		if (dup2(output_fd, 1) < 0)
+			die("could not redirect output");
+		else
+			close(output_fd);
+	}
+}
+
 #define OPT__COMPR(s, v, h, p) \
 	{ OPTION_SET_INT, (s), NULL, (v), NULL, (h), \
 	  PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, (p) }
@@ -253,6 +266,7 @@ static int parse_archive_args(int argc, const char **argv,
 	const char *base = NULL;
 	const char *remote = NULL;
 	const char *exec = NULL;
+	const char *output = NULL;
 	int compression_level = -1;
 	int verbose = 0;
 	int i;
@@ -262,6 +276,8 @@ static int parse_archive_args(int argc, const char **argv,
 		OPT_STRING(0, "format", &format, "fmt", "archive format"),
 		OPT_STRING(0, "prefix", &base, "prefix",
 			"prepend prefix to each pathname in the archive"),
+		OPT_STRING(0, "output", &output, "file",
+			"write the archive to this file"),
 		OPT__VERBOSE(&verbose),
 		OPT__COMPR('0', &compression_level, "store only", 0),
 		OPT__COMPR('1', &compression_level, "compress faster", 1),
@@ -294,6 +310,9 @@ static int parse_archive_args(int argc, const char **argv,
 	if (!base)
 		base = "";
 
+	if (output)
+		create_output_file(output);
+
 	if (list) {
 		for (i = 0; i < ARRAY_SIZE(archivers); i++)
 			printf("%s\n", archivers[i].name);
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index c942c8b..b7e3628 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -86,6 +86,10 @@ test_expect_success \
     'git archive vs. the same in a bare repo' \
     'test_cmp b.tar b3.tar'
 
+test_expect_success 'git archive with --output' \
+    'git archive --output=b4.tar HEAD &&
+    test_cmp b.tar b4.tar'
+
 test_expect_success \
     'validate file modification time' \
     'mkdir extract &&
@@ -172,6 +176,10 @@ test_expect_success \
     'git archive --format=zip vs. the same in a bare repo' \
     'test_cmp d.zip d1.zip'
 
+test_expect_success 'git archive --format=zip with --output' \
+    'git archive --format=zip --output=d2.zip HEAD &&
+    test_cmp d.zip d2.zip'
+
 $UNZIP -v >/dev/null 2>&1
 if [ $? -eq 127 ]; then
 	echo "Skipping ZIP tests, because unzip was not found"
-- 
1.6.2.rc2
