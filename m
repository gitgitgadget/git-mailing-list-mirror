From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v9 2/2] format-patch --signature-file=<file>
Date: Fri, 23 May 2014 21:08:14 -0700
Message-ID: <a09491f3ec7ccfc5176fe05e6ad5c514d0489dcb.1400904004.git.jmmahler@gmail.com>
References: <cover.1400904004.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 24 06:08:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wo3GL-000305-2K
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 06:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbaEXEIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2014 00:08:45 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:54294 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbaEXEIo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2014 00:08:44 -0400
Received: by mail-pb0-f41.google.com with SMTP id uo5so4999219pbc.14
        for <git@vger.kernel.org>; Fri, 23 May 2014 21:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=5ludiQIPYcaSUJqs4PI8jsrSeHBvgYfuzgmhw1EPm40=;
        b=CEINoi5IQf2YMDzGTWLhbt0BAG0kModraEqUZt+bTOJw21O/UOtWd7EBYr7A6c7j2i
         4SslmXY20PnT19pJbQRxTK7WF6dOfCUwkxD6xNgB5Gl7szpHhZHbstTTAioQLaYhSfgF
         9ZyTqUus5fWSRDl50DwPVIqRLo5U2iPLcQb0SVy8ZoYNP6i7kAOKZm5coozmxEG+EPnb
         2iLjSiAdVyj0tkF8mGsj9GA1xVDLUvqKWX3DHwkCXfpEOg5LR2HPIUJCTmuc8mhTF/l3
         Xe5/mNnmNXFqJgIoZQV+pdDymsWXT147Ckrj/636PjRh3juEROWg9KeYg/wrjBBMshqS
         6Beg==
X-Received: by 10.68.213.97 with SMTP id nr1mr11070119pbc.52.1400904524420;
        Fri, 23 May 2014 21:08:44 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id ko10sm7058703pbd.52.2014.05.23.21.08.41
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 23 May 2014 21:08:43 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Fri, 23 May 2014 21:08:40 -0700
X-Mailer: git-send-email 2.0.0.rc2
In-Reply-To: <cover.1400904004.git.jmmahler@gmail.com>
In-Reply-To: <cover.1400904004.git.jmmahler@gmail.com>
References: <cover.1400904004.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250054>

Add an option to format-patch for reading a signature from a file.

  $ git format-patch -1 --signature-file=$HOME/.signature

The config variable `format.signaturefile` can also be used to make
this the default.

  $ git config format.signaturefile $HOME/.signature

  $ git format-patch -1

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 Documentation/config.txt           |  4 +++
 Documentation/git-format-patch.txt |  4 +++
 builtin/log.c                      | 17 +++++++++++
 t/t4014-format-patch.sh            | 61 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1932e9b..140ed77 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1114,6 +1114,10 @@ format.signature::
 	Set this variable to the empty string ("") to suppress
 	signature generation.
 
+format.signaturefile::
+	Works just like format.signature except the contents of the
+	file specified by this variable will be used as the signature.
+
 format.suffix::
 	The default for format-patch is to output files with the suffix
 	`.patch`. Use this variable to change that suffix (make sure to
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 5c0a4ab..c0fd470 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 		   [(--attach|--inline)[=<boundary>] | --no-attach]
 		   [-s | --signoff]
 		   [--signature=<signature> | --no-signature]
+		   [--signature-file=<file>]
 		   [-n | --numbered | -N | --no-numbered]
 		   [--start-number <n>] [--numbered-files]
 		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
@@ -233,6 +234,9 @@ configuration options in linkgit:git-notes[1] to use this workflow).
 	signature option is omitted the signature defaults to the Git version
 	number.
 
+--signature-file=<file>::
+	Works just like --signature except the signature is read from a file.
+
 --suffix=.<sfx>::
 	Instead of using `.patch` as the suffix for generated
 	filenames, use specified suffix.  A common alternative is
diff --git a/builtin/log.c b/builtin/log.c
index 5acc048..56cad39 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -673,6 +673,7 @@ static void add_header(const char *value)
 static int thread;
 static int do_signoff;
 static const char *signature = git_version_string;
+static const char *signature_file;
 static int config_cover_letter;
 
 enum {
@@ -742,6 +743,8 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "format.signature"))
 		return git_config_string(&signature, var, value);
+	if (!strcmp(var, "format.signaturefile"))
+		return git_config_pathname(&signature_file, var, value);
 	if (!strcmp(var, "format.coverletter")) {
 		if (value && !strcasecmp(value, "auto")) {
 			config_cover_letter = COVER_AUTO;
@@ -1235,6 +1238,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_OPTARG, thread_callback },
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
+		OPT_FILENAME(0, "signature-file", &signature_file,
+				N_("add a signature from a file")),
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
 		OPT_END()
 	};
@@ -1452,6 +1457,18 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			cover_letter = (config_cover_letter == COVER_ON);
 	}
 
+	if (!signature) {
+		/* --no-signature inhibits all signatures */
+	} else if (signature && signature != git_version_string) {
+		/* non-default signature already set */
+	} else if (signature_file) {
+		struct strbuf buf = STRBUF_INIT;
+
+		if (strbuf_read_file(&buf, signature_file, 128) < 0)
+			die_errno(_("unable to read signature file '%s'"), signature_file);
+		signature = strbuf_detach(&buf, NULL);
+	}
+
 	if (in_reply_to || thread || cover_letter)
 		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
 	if (in_reply_to) {
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 9c80633..ae25353 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -762,6 +762,67 @@ test_expect_success 'format-patch --signature="" suppresses signatures' '
 	! grep "^-- \$" output
 '
 
+test_expect_success 'prepare mail-signature input' '
+	cat >mail-signature <<-\EOF
+
+	Test User <test.email@kernel.org>
+	http://git.kernel.org/cgit/git/git.git
+
+	git.kernel.org/?p=git/git.git;a=summary
+
+	EOF
+'
+
+test_expect_success '--signature-file=file works' '
+	git format-patch --stdout --signature-file=mail-signature -1 >output &&
+	check_patch output &&
+	sed -e "1,/^-- \$/d" <output >actual &&
+	{
+		cat mail-signature && echo
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'format.signaturefile works' '
+	test_config format.signaturefile mail-signature &&
+	git format-patch --stdout -1 >output &&
+	check_patch output &&
+	sed -e "1,/^-- \$/d" <output >actual &&
+	{
+		cat mail-signature && echo
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-signature suppresses format.signaturefile ' '
+	test_config format.signaturefile mail-signature &&
+	git format-patch --stdout --no-signature -1 >output &&
+	check_patch output &&
+	! grep "^-- \$" output
+'
+
+test_expect_success '--signature-file overrides format.signaturefile' '
+	cat >other-mail-signature <<-\EOF
+	Use this other signature instead of mail-signature.
+	EOF
+	test_config format.signaturefile mail-signature &&
+	git format-patch --stdout \
+			--signature-file=other-mail-signature -1 >output &&
+	check_patch output &&
+	sed -e "1,/^-- \$/d" <output >actual &&
+	{
+		cat other-mail-signature && echo
+	} >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success '--signature overrides format.signaturefile' '
+	test_config format.signaturefile mail-signature &&
+	git format-patch --stdout --signature="my sig" -1 >output &&
+	check_patch output &&
+	grep "my sig" output
+'
+
 test_expect_success TTY 'format-patch --stdout paginates' '
 	rm -f pager_used &&
 	test_terminal env GIT_PAGER="wc >pager_used" git format-patch --stdout --all &&
-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
