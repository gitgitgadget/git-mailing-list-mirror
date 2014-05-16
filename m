From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2] format-patch --signature-file <file>
Date: Thu, 15 May 2014 18:31:21 -0700
Message-ID: <1400203881-2794-2-git-send-email-jmmahler@gmail.com>
References: <1400203881-2794-1-git-send-email-jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 03:32:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl70L-0001JL-PS
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 03:32:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbaEPBcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 21:32:05 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:54002 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbaEPBcD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 21:32:03 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so1799488pab.8
        for <git@vger.kernel.org>; Thu, 15 May 2014 18:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JHTrIu+vuizdxnMjVRhHDA30RxPw7GQGkz2rexPLhW8=;
        b=Yt11FV9FL0Lpd4SiXAebfTC3hSs/V83b4GlfwVS22TJe13v/N4IXp9CCxGYbwtFZOo
         /tOAb4IYxt8M2DRs1MNG8Shq6cSfxpTel9a765cilMf1dUxpqR+m5uJlv3fI1Ip9e7nt
         F4jn2BWYNTT7sSz3ot2Uc0e6VmXZ6CTJiMf8xcf/0HZYC3qaKZqomvsopiK1evZAdmfy
         Q1SfSd+/oc7lQ418W7z1CnMIxgYNdMlEe23Fn8HYEQHZ/SKRcMdlp6mJ75WyI1Y3j6yn
         mrkcAZ2ILWZf+gEd0xHRLvEYmVy2Qk2QYDHaKqjcFJJ1Ki1d2AIQuNZkeec75MpGCNqO
         RcJw==
X-Received: by 10.68.178.131 with SMTP id cy3mr16764780pbc.146.1400203922786;
        Thu, 15 May 2014 18:32:02 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id qv9sm11389254pbc.71.2014.05.15.18.31.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 15 May 2014 18:32:01 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Thu, 15 May 2014 18:31:58 -0700
X-Mailer: git-send-email 2.0.0.rc2
In-Reply-To: <1400203881-2794-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249271>

Added feature that allows a signature file to be used with format-patch.

  $ git format-patch --signature-file ~/.signature -1

Now signatures with newlines and other special characters can be
easily included.

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 Documentation/git-format-patch.txt |  7 +++++++
 builtin/log.c                      | 24 ++++++++++++++++++++++++
 t/t4014-format-patch.sh            | 13 +++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 5c0a4ab..dd57841 100644
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
@@ -233,6 +234,12 @@ configuration options in linkgit:git-notes[1] to use this workflow).
 	signature option is omitted the signature defaults to the Git version
 	number.
 
+--signature-file=<file>::
+	Add a signature, by including the contents of a file, to each message
+	produced. Per RFC 3676 the signature is separated from the body by a
+	line with '-- ' on it. If the signature option is omitted the signature
+	defaults to the Git version number.
+
 --suffix=.<sfx>::
 	Instead of using `.patch` as the suffix for generated
 	filenames, use specified suffix.  A common alternative is
diff --git a/builtin/log.c b/builtin/log.c
index 39e8836..4a7308d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1147,6 +1147,27 @@ static int from_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int signature_file_callback(const struct option *opt, const char *arg,
+							int unset)
+{
+	const char **signature = opt->value;
+	static char buf[1024];
+	size_t sz;
+	FILE *fd;
+
+	fd = fopen(arg, "r");
+	if (fd) {
+		sz = sizeof(buf);
+		sz = fread(buf, 1, sz - 1, fd);
+		if (sz) {
+			buf[sz] = '\0';
+			*signature = buf;
+		}
+		fclose(fd);
+	}
+	return 0;
+}
+
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
 	struct commit *commit;
@@ -1230,6 +1251,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_OPTARG, thread_callback },
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
+		{ OPTION_CALLBACK, 0, "signature-file", &signature, N_("signature-file"),
+				N_("add a signature from contents of a file"),
+			    PARSE_OPT_NONEG, signature_file_callback },
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
 		OPT_END()
 	};
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 9c80633..19b67e3 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -762,6 +762,19 @@ test_expect_success 'format-patch --signature="" suppresses signatures' '
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
 test_expect_success TTY 'format-patch --stdout paginates' '
 	rm -f pager_used &&
 	test_terminal env GIT_PAGER="wc >pager_used" git format-patch --stdout --all &&
-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
