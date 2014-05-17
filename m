From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3] format-patch --signature-file <file>
Date: Sat, 17 May 2014 09:02:22 -0700
Message-ID: <1400342542-11256-2-git-send-email-jmmahler@gmail.com>
References: <1400342542-11256-1-git-send-email-jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 17 18:03:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wlh4r-0007nS-66
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 18:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964856AbaEQQDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 12:03:09 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:46207 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932223AbaEQQDH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 12:03:07 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb1so3846916pad.37
        for <git@vger.kernel.org>; Sat, 17 May 2014 09:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8p2q7EqP9OJ7yz/uqjJRaq+K41RLu6COLEpZ/DG1xf0=;
        b=fNWG2nR3TyCfBDP6jwJjKz44TxiC5eTk3z3XssBffAAD9h4sp0Ub2hyVVcPBz9J+JC
         d/L+1D1ovv+O1yDWrNG2LZdQszl3Kb9e1vXm8Ctn1oTfVqHlImW8aoTYSyjfxUtkSCiI
         IPSNQNBItIEQ2dABXJCoc0F3a1/PZqOEhY1x4FSqh7zxsL9Yd3LNARzyGJXlZ9X1otSt
         6/ZHrg7ygARgvigDrsZLWYgtQpa/dSEfzHvrjVAs8FLLWEUMgYO2wqD2/Do7qLV9FDQs
         ibPmstFFtrAJOwdJx9uzddFHnZ97QpjYoBaF2SHkEEYFnhPZp/MqRo37DPHseqKUkey9
         A9HA==
X-Received: by 10.66.137.109 with SMTP id qh13mr29531854pab.39.1400342586827;
        Sat, 17 May 2014 09:03:06 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id qv9sm20619947pbc.71.2014.05.17.09.03.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 17 May 2014 09:03:04 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sat, 17 May 2014 09:03:01 -0700
X-Mailer: git-send-email 2.0.0.rc2
In-Reply-To: <1400342542-11256-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249487>

Added feature that allows a signature file to be used with format-patch.

  $ git format-patch --signature-file ~/.signature -1

Now signatures with newlines and other special characters can be
easily included.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      | 13 +++++++++++++
 t/t4014-format-patch.sh            | 28 ++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

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
index 39e8836..af7d610 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -673,6 +673,7 @@ static void add_header(const char *value)
 static int thread;
 static int do_signoff;
 static const char *signature = git_version_string;
+static const char *signature_file;
 static int config_cover_letter;
 
 enum {
@@ -1230,6 +1231,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_OPTARG, thread_callback },
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
+		OPT_FILENAME(0, "signature-file", &signature_file,
+				N_("add a signature from a file")),
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
 		OPT_END()
 	};
@@ -1447,6 +1450,16 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			cover_letter = (config_cover_letter == COVER_ON);
 	}
 
+	if (signature_file) {
+		if (signature && signature != git_version_string)
+			die(_("--signature and --signature-file are mutually exclusive"));
+
+		struct strbuf buf = STRBUF_INIT;
+
+		strbuf_read_file(&buf, signature_file, 128);
+		signature = strbuf_detach(&buf, NULL);
+	}
+
 	if (in_reply_to || thread || cover_letter)
 		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
 	if (in_reply_to) {
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 9c80633..fb3dc1b 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -762,6 +762,34 @@ test_expect_success 'format-patch --signature="" suppresses signatures' '
 	! grep "^-- \$" output
 '
 
+cat > expect << EOF
+Test User <test.email@kernel.org>
+http://git.kernel.org/cgit/git/git.git
+git.kernel.org/?p=git/git.git;a=summary
+EOF
+
+test_expect_success 'format-patch --signature-file file' '
+	git format-patch --stdout --signature-file expect -1 >output &&
+	check_patch output &&
+	fgrep -x -f output expect >output2 &&
+	diff expect output2
+'
+
+test_expect_success 'format-patch --signature-file=file' '
+	git format-patch --stdout --signature-file=expect -1 >output &&
+	check_patch output &&
+	fgrep -x -f output expect >output2 &&
+	diff expect output2
+'
+
+test_expect_success 'format-patch --signature and --signature-file die' '
+	! git format-patch --stdout --signature="foo" --signature-file=expect -1 >output
+'
+
+test_expect_success 'format-patch --no-signature and --signature-file OK' '
+	git format-patch --stdout --no-signature --signature-file=expect -1 >output
+'
+
 test_expect_success TTY 'format-patch --stdout paginates' '
 	rm -f pager_used &&
 	test_terminal env GIT_PAGER="wc >pager_used" git format-patch --stdout --all &&
