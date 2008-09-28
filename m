From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] Implement a textconv filter for "git diff"
Date: Sun, 28 Sep 2008 04:06:56 +0200
Message-ID: <1222567618-22156-4-git-send-email-Matthieu.Moy@imag.fr>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr>
 <1222567618-22156-2-git-send-email-Matthieu.Moy@imag.fr>
 <1222567618-22156-3-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 28 04:10:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjlkN-0004Jm-Kw
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 04:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130AbYI1CJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 22:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbYI1CJr
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 22:09:47 -0400
Received: from imag.imag.fr ([129.88.30.1]:60051 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927AbYI1CJo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 22:09:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m8S26xIV026011
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 28 Sep 2008 04:06:59 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1KjlgY-0001dd-8A; Sun, 28 Sep 2008 04:06:58 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1KjlgY-00060O-5a; Sun, 28 Sep 2008 04:06:58 +0200
X-Mailer: git-send-email 1.6.0.2.312.g1ef81a
In-Reply-To: <1222567618-22156-3-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 28 Sep 2008 04:07:00 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96934>

That feature is similar to the custom diff driver, but the user only has
to provide a text filter (a command to convert a file into a plain-text
representation). Git takes care of diffing, mode change, ...

For example, with

[textconv "odt2txt"]
          command=odt2txt

*.ods textconv=odt2txt
*.odp textconv=odt2txt
*.odt textconv=odt2txt

One can use "git diff" on OpenOffice files (including "git diff --color"
and friends).

This could be extended so that "git blame" can use it also.
---
 diff.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 6917981..7cbc42b 100644
--- a/diff.c
+++ b/diff.c
@@ -181,6 +181,12 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		if (ep != var + 4 && !strcmp(ep, ".command"))
 			return parse_ll_command(var, var + 5, ep, value, DIFF_DRIVER);
 	}
+	if (!prefixcmp(var, "textconv.")) {
+		const char *ep = strrchr(var, '.');
+
+		if (ep != var + 8 && !strcmp(ep, ".command"))
+			return parse_ll_command(var, var + 9, ep, value, TEXTCONV_DRIVER);
+	}
 
 	return git_diff_basic_config(var, value, cb);
 }
@@ -262,6 +268,10 @@ static struct diff_tempfile {
 
 /* Forward declarations */
 static int run_command_to_buf(const char **argv, char **buf, size_t * size);
+static const char *external_cmd_attr(const char *name, int driver_index);
+static void prepare_temp_file(const char *name,
+			      struct diff_tempfile *temp,
+			      struct diff_filespec *one);
 /* End forward declarations */
 
 static int count_lines(const char *data, int size)
@@ -1511,6 +1521,52 @@ static int run_command_to_buf(const char **argv, char **buf, size_t * size)
 	return 0;
 }
 
+static int textconv_two_files(const char *textconv,
+			      const char *name_a,
+			      const char *name_b,
+			      mmfile_t *mf1,
+			      mmfile_t *mf2,
+			      struct diff_filespec *one,
+			      struct diff_filespec *two)
+{
+	const char *spawn_arg[3];
+	const char **arg = &spawn_arg[0];
+	struct diff_tempfile *temp = diff_temp;
+	char *buf_a, *buf_b;
+	size_t size_a, size_b;
+	prepare_temp_file(name_a, &temp[0], one);
+	*arg++ = textconv;
+	*arg++ = temp[0].name;
+	*arg++ = NULL;
+	/*
+	 * Run both commands before touching arguments to make sure we
+	 * do all or nothing.
+	 */
+	if(run_command_to_buf(spawn_arg, &buf_a, &size_a))
+		return -1;
+
+	prepare_temp_file(name_b, &temp[1], two);
+	spawn_arg[1] = temp[1].name;
+	if(run_command_to_buf(spawn_arg, &buf_b, &size_b))
+		return -1;
+
+	mf1->ptr = buf_a;
+	mf1->size = (long)size_a;
+	one->data = mf1->ptr;
+	one->size = mf1->size;
+	one->should_free = 1;
+	one->should_munmap = 1;
+
+	mf2->ptr = buf_b;
+	mf2->size = (long)size_b;
+	two->data = mf2->ptr;
+	two->size = mf2->size;
+	two->should_free = 1;
+	two->should_munmap = 1;
+	return 0;
+}
+
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -1574,6 +1630,18 @@ static void builtin_diff(const char *name_a,
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
+	const char * textconv = external_cmd_attr(name_a, TEXTCONV_DRIVER);
+	const char * textconvb = external_cmd_attr(name_b, TEXTCONV_DRIVER);
+
+	/*
+	 * Only use the textconv driver if it is set, and is the same
+	 * for source and destination file.
+	 */
+	if (textconv && textconvb && !strcmp(textconv, textconvb))
+		if(textconv_two_files(textconv, name_a, name_b, &mf1, &mf2, one, two))
+			fprintf(stderr, "warning: textconv filter failed, "
+				"falling back to plain diff\n");
+
 	if (!DIFF_OPT_TST(o, TEXT) &&
 	    (diff_filespec_is_binary(one) || diff_filespec_is_binary(two))) {
 		/* Quite common confusing case */
-- 
1.6.0.2.312.g1ef81a
