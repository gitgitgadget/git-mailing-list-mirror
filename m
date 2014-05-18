From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v4] format-patch --signature-file <file>
Date: Sun, 18 May 2014 13:22:02 -0700
Message-ID: <1400444522-15523-2-git-send-email-jmmahler@gmail.com>
References: <1400444522-15523-1-git-send-email-jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 18 22:22:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm7bK-0005zc-Gq
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 22:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbaERUW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 16:22:26 -0400
Received: from mail-pb0-f44.google.com ([209.85.160.44]:50307 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbaERUW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 16:22:26 -0400
Received: by mail-pb0-f44.google.com with SMTP id rq2so4902956pbb.3
        for <git@vger.kernel.org>; Sun, 18 May 2014 13:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k4oLMynAWBq2hLwo6IUoC6bDlvg4fpJN26//1zmeUVs=;
        b=V2HKHDMb45LeIG5xqYSRXw19QJ5PdZhmsJZ84Gwkz2bIrFCOJJQHQlzgibSECyRV+V
         8I6+ld6jLDggoIKHKhd/IugaZQv2UGenYYgWsbxA0IOkxYBBOMGmeTd/G9gl6gEOt1ol
         KXoGXjqWGvxL48dDUqZ4AW7fqqhklOTRUWqUCfdKnKC5NWX/1DA6eBEPHCPpzKIYMP3f
         iSB3ORgV6kxi0X3rUNl4nppsYjaG9ODoyIijAEUKJTpnPp173X0h/rZ0VkXHFiuov9K8
         ngfkEzKnuVSI45IKlQD7wjgY5uMa848+veuY/VZ5dHjuNDGeWJ7IvlYksGCJmDIcjbPC
         3KOQ==
X-Received: by 10.68.133.163 with SMTP id pd3mr5683650pbb.166.1400444545556;
        Sun, 18 May 2014 13:22:25 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id yx3sm26141165pbb.6.2014.05.18.13.22.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 18 May 2014 13:22:23 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sun, 18 May 2014 13:22:20 -0700
X-Mailer: git-send-email 2.0.0.rc3.4.g6308767.dirty
In-Reply-To: <1400444522-15523-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249508>

Added option that allows a signature file to be used with format-patch
so that signatures with newlines and other special characters can be
easily included.

  $ git format-patch --signature-file ~/.signature -1

The config variable format.signaturefile is also provided so that it
can be added by default.

  $ git config format.signaturefile ~/.signature

  $ git format-patch -1

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 Documentation/config.txt           |  4 ++++
 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      | 16 ++++++++++++++++
 t/t4014-format-patch.sh            | 33 +++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+)

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
index 39e8836..0a8f417 100644
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
+		return git_config_string(&signature_file, var, value);
 	if (!strcmp(var, "format.coverletter")) {
 		if (value && !strcasecmp(value, "auto")) {
 			config_cover_letter = COVER_AUTO;
@@ -1230,6 +1233,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_OPTARG, thread_callback },
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
+		OPT_FILENAME(0, "signature-file", &signature_file,
+				N_("add a signature from a file")),
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
 		OPT_END()
 	};
@@ -1447,6 +1452,17 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			cover_letter = (config_cover_letter == COVER_ON);
 	}
 
+	if (signature_file) {
+		if (signature && signature != git_version_string)
+			die(_("cannot specify both signature and signature-file"));
+
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
index 9c80633..c6d44b8 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -762,6 +762,39 @@ test_expect_success 'format-patch --signature="" suppresses signatures' '
 	! grep "^-- \$" output
 '
 
+cat >expect <<-\EOF
+
+Test User <test.email@kernel.org>
+http://git.kernel.org/cgit/git/git.git
+
+git.kernel.org/?p=git/git.git;a=summary
+
+EOF
+
+test_expect_success 'format-patch --signature-file=file' '
+	git format-patch --stdout --signature-file=expect -1 >output &&
+	check_patch output &&
+	sed -n "/^-- $/,\$p" <output | head --lines=-2 | tail --lines=+2 >output2 &&
+	test_cmp expect output2
+'
+
+test_expect_success 'format-patch --signature and --signature-file die' '
+	test_must_fail git format-patch --stdout --signature="foo" --signature-file=expect -1 >output
+'
+
+test_expect_success 'format-patch --no-signature and --signature-file OK' '
+	git format-patch --stdout --no-signature --signature-file=expect -1
+'
+
+test_expect_success 'format-patch with format.signaturefile config' '
+	git config format.signaturefile expect &&
+	git format-patch --stdout -1 >output &&
+	check_patch output &&
+	sed -n "/^-- $/,\$p" <output | head --lines=-2 | tail --lines=+2 >output2 &&
+	test_cmp expect output2 &&
+	git config --unset-all format.signaturefile
+'
+
 test_expect_success TTY 'format-patch --stdout paginates' '
 	rm -f pager_used &&
 	test_terminal env GIT_PAGER="wc >pager_used" git format-patch --stdout --all &&
-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
