From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 10/17] trailer: if no input file is passed, read from stdin
Date: Thu, 30 Jan 2014 07:49:13 +0100
Message-ID: <20140130064921.7504.57934.chriscool@tuxfamily.org>
References: <20140130064217.7504.473.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 08:38:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8mCj-0005JB-Qp
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 08:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbaA3HiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 02:38:24 -0500
Received: from [194.158.98.14] ([194.158.98.14]:38489 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752793AbaA3HiU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 02:38:20 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id DA61368;
	Thu, 30 Jan 2014 08:37:48 +0100 (CET)
X-git-sha1: 8ab19845af30d1363c07f20d929cd6ec2fc23122 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140130064217.7504.473.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241249>

It is simpler and more natural if the "git interpret-trailers"
is made a filter as its output already goes to sdtout.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/interpret-trailers.c  |  2 +-
 t/t7513-interpret-trailers.sh |  7 +++++++
 trailer.c                     | 15 +++++++++------
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 04b0ae2..ae8e561 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -23,7 +23,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 
 	struct option options[] = {
 		OPT_BOOL(0, "trim-empty", &trim_empty, N_("trim empty trailers")),
-		OPT_FILENAME(0, "infile", &infile, N_("use message from file")),
+		OPT_FILENAME(0, "infile", &infile, N_("use message from file, instead of stdin")),
 		OPT_END()
 	};
 
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 8be333c..f5ef81f 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -205,4 +205,11 @@ test_expect_success 'using "ifMissing = doNothing"' '
 	test_cmp expected actual
 '
 
+test_expect_success 'with input from stdin' '
+	cat complex_message_body >expected &&
+	printf "Bug #42\nFixes: \nAcked-by= \nAcked-by= Junio\nAcked-by= Peff\nReviewed-by: \nSigned-off-by: \n" >>expected &&
+	git interpret-trailers "review:" "fix=53" "cc=Linus" "ack: Junio" "fix=22" "bug: 42" "ack: Peff" < complex_message >actual &&
+	test_cmp expected actual
+'
+
 test_done
diff --git a/trailer.c b/trailer.c
index 8681aed..73a65e0 100644
--- a/trailer.c
+++ b/trailer.c
@@ -464,8 +464,13 @@ static struct strbuf **read_input_file(const char *infile)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	if (strbuf_read_file(&sb, infile, 0) < 0)
-		die_errno(_("could not read input file '%s'"), infile);
+	if (infile) {
+		if (strbuf_read_file(&sb, infile, 0) < 0)
+			die_errno(_("could not read input file '%s'"), infile);
+	} else {
+		if (strbuf_read(&sb, fileno(stdin), 0) < 0)
+			die_errno(_("could not read from stdin"));
+	}
 
 	return strbuf_split(&sb, '\n');
 }
@@ -530,10 +535,8 @@ void process_trailers(const char *infile, int trim_empty, int argc, const char *
 
 	git_config(git_trailer_config, NULL);
 
-	/* Print the non trailer part of infile */
-	if (infile) {
-		process_input_file(infile, &infile_tok_first, &infile_tok_last);
-	}
+	/* Print the non trailer part of infile (or stdin if infile is NULL) */
+	process_input_file(infile, &infile_tok_first, &infile_tok_last);
 
 	arg_tok_first = process_command_line_args(argc, argv);
 
-- 
1.8.5.2.201.gacc5987
