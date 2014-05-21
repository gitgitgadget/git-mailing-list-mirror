From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v7 2/2] format-patch --signature-file <file>
Date: Wed, 21 May 2014 14:07:52 -0700
Message-ID: <1400706472-13471-3-git-send-email-jmmahler@gmail.com>
References: <1400706472-13471-1-git-send-email-jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 21 23:08:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnDkL-0002o1-FV
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 23:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbaEUVIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 17:08:17 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:42454 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753333AbaEUVIQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 17:08:16 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so1764315pad.37
        for <git@vger.kernel.org>; Wed, 21 May 2014 14:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hj6/DfAF9jbLD14WSSxPfBkSOMnmRoRRqKcdJNSRz04=;
        b=AAXflsrVNGrZ69nLSsLQbOr/F7c35AzUgsxBlMMSbHTuMcevuVHvkKYSrSEE1H0E9k
         XU97vLMMSUcGSDjN27zFGLdPy4lFrngp3B1vO2K2HGod0e7rLWxmyjG54UGNxm/yzrrs
         K8V4HXLvUxTwTTeq9+A6ZxN9KjhwkRaoMOv84oVKrcJNrMk2TWnEL6FzmaW2Eu1mMZno
         Gu21nB743ffmtDMubJVLHgPck5Mtk91dRq+itGiYLr1QQ8AW3UKCTfDyRulybhb5HPVo
         EwpMLqB74WYNwY11bYlFVRsyupv7Z+McEJ3Qkv9z1ajtCz4NA76f8D4WSA4WTh4hiJTN
         ZEpQ==
X-Received: by 10.68.201.68 with SMTP id jy4mr12930489pbc.64.1400706496143;
        Wed, 21 May 2014 14:08:16 -0700 (PDT)
Received: from hudson (o247-linksys-rtr.CSUChico.EDU. [132.241.18.53])
        by mx.google.com with ESMTPSA id ek2sm9596312pbd.30.2014.05.21.14.08.13
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 14:08:15 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Wed, 21 May 2014 14:08:12 -0700
X-Mailer: git-send-email 2.0.0.rc3.19.gd74db96.dirty
In-Reply-To: <1400706472-13471-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249831>

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
 t/t4014-format-patch.sh            | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+)

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
index 5acc048..28d22fd 100644
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
@@ -1452,6 +1457,17 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
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
index 9c80633..e604f65 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -762,6 +762,38 @@ test_expect_success 'format-patch --signature="" suppresses signatures' '
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
+	sed -n -e "/^-- $/,\$p" <output | sed -e "1 d" | sed -e "\$d" >output2 &&
+	test_cmp expect output2
+'
+
+test_expect_success 'format-patch with format.signaturefile config' '
+	test_config format.signaturefile expect &&
+	git format-patch --stdout -1 >output &&
+	check_patch output &&
+	sed -n -e "/^-- $/,\$p" <output | sed -e "1 d" | sed -e "\$d" >output2 &&
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
 test_expect_success TTY 'format-patch --stdout paginates' '
 	rm -f pager_used &&
 	test_terminal env GIT_PAGER="wc >pager_used" git format-patch --stdout --all &&
-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
