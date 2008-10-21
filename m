From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH v2] builtin-blame: Reencode commit messages according to git-log rules.
Date: Wed, 22 Oct 2008 00:55:57 +0400
Message-ID: <1224622557-6669-1-git-send-email-angavrilov@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:59:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsOJm-0005Rv-PJ
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 22:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbYJUU5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 16:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752180AbYJUU5x
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 16:57:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:46523 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbYJUU5w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 16:57:52 -0400
Received: by fg-out-1718.google.com with SMTP id 19so65741fgg.17
        for <git@vger.kernel.org>; Tue, 21 Oct 2008 13:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=sjcINpEhuUIc2cr8m0GsFmcTFXgDSWSkKmJjVWFfu00=;
        b=DxR3X3NE15QXOKCgQpiZHYXDHx54bczN37WRh0D61ZWtn1+UfgQSHJd5eBwGBij29t
         g8bicYVSRfMf+aUB5nhmOD2OFu7VTMYO16sbnbIcF4P92VSuDtpRtSxXxBCrmR2zNSiN
         jZEHaahcFiqpWdkfrly/Rq4cLx6bG0FBEa3y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=SkgmSWqwtGnEBiYEDe/IVwY5DrV+plcNI87+IZFyJ43tyH6s59oPWoXt7vnel0/8dn
         AIV+Yg2RBAzLsOa2eEebOCBJQXZwyOynj+uemGUwD6IhSNX04eFGSDTFn/VSDk6O+RyK
         Voh0EmK2MgSHqrOE5ARwsTnxVYt3RgQzOEDug=
Received: by 10.181.202.12 with SMTP id e12mr1297075bkq.138.1224622669981;
        Tue, 21 Oct 2008 13:57:49 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id f31sm17456167fkf.0.2008.10.21.13.57.47
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 21 Oct 2008 13:57:48 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98817>

Currently git-blame outputs text from the commit messages
(e.g. the author name and the summary string) as-is, without
even providing any information about the encoding used for
the data. It makes interpreting the data in multilingual
environment very difficult.

This commit changes the blame implementation to recode the
messages using the rules used by other commands like git-log.
Namely, the target encoding can be specified through the
i18n.commitEncoding or i18n.logOutputEncoding options, or
directly on the command line using the --encoding parameter.

Converting the encoding before output seems to be more
friendly to the porcelain tools than simply providing the
value of the encoding header, and does not require changing
the output format.

If anybody needs the old behavior, it is possible to
achieve it by specifying --encoding=none.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	I intentionally forced binary encoding for files
	with the localized strings, to avoid any possible
	corruption.
	
	-- Alexander

 Documentation/blame-options.txt |    7 +++
 Documentation/i18n.txt          |    6 +-
 builtin-blame.c                 |   16 +++++--
 commit.h                        |    2 +
 pretty.c                        |   21 ++++++---
 t/t8005-blame-i18n.sh           |   92 +++++++++++++++++++++++++++++++++++++++
 t/t8005/cp1251.txt              |  Bin 0 -> 68 bytes
 t/t8005/sjis.txt                |  Bin 0 -> 100 bytes
 t/t8005/utf8.txt                |  Bin 0 -> 100 bytes
 9 files changed, 130 insertions(+), 14 deletions(-)
 create mode 100755 t/t8005-blame-i18n.sh
 create mode 100644 t/t8005/cp1251.txt
 create mode 100644 t/t8005/sjis.txt
 create mode 100644 t/t8005/utf8.txt

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 5428111..1ab1b96 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -49,6 +49,13 @@ of lines before or after the line given by <start>.
 	Show the result incrementally in a format designed for
 	machine consumption.
 
+--encoding=<encoding>::
+	Specifies the encoding used to output author names
+	and commit summaries. Setting it to `none` makes blame
+	output unconverted data. For more information see the
+	discussion about encoding in the linkgit:git-log[1]
+	manual page.
+
 --contents <file>::
 	When <rev> is not specified, the command annotates the
 	changes starting backwards from the working tree copy.
diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index d2970f8..2cdacd9 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -37,9 +37,9 @@ of `i18n.commitencoding` in its `encoding` header.  This is to
 help other people who look at them later.  Lack of this header
 implies that the commit log message is encoded in UTF-8.
 
-. 'git-log', 'git-show' and friends looks at the `encoding`
-  header of a commit object, and tries to re-code the log
-  message into UTF-8 unless otherwise specified.  You can
+. 'git-log', 'git-show', 'git-blame' and friends look at the
+  `encoding` header of a commit object, and try to re-code the
+  log message into UTF-8 unless otherwise specified.  You can
   specify the desired output encoding with
   `i18n.logoutputencoding` in `.git/config` file, like this:
 +
diff --git a/builtin-blame.c b/builtin-blame.c
index 48cc0c1..2457e71 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1431,7 +1431,7 @@ static void get_commit_info(struct commit *commit,
 			    int detailed)
 {
 	int len;
-	char *tmp, *endp;
+	char *tmp, *endp, *reencoded, *message;
 	static char author_buf[1024];
 	static char committer_buf[1024];
 	static char summary_buf[1024];
@@ -1449,24 +1449,29 @@ static void get_commit_info(struct commit *commit,
 			die("Cannot read commit %s",
 			    sha1_to_hex(commit->object.sha1));
 	}
+	reencoded = reencode_commit_message(commit, NULL);
+	message   = reencoded ? reencoded : commit->buffer;
 	ret->author = author_buf;
-	get_ac_line(commit->buffer, "\nauthor ",
+	get_ac_line(message, "\nauthor ",
 		    sizeof(author_buf), author_buf, &ret->author_mail,
 		    &ret->author_time, &ret->author_tz);
 
-	if (!detailed)
+	if (!detailed) {
+		free(reencoded);
 		return;
+	}
 
 	ret->committer = committer_buf;
-	get_ac_line(commit->buffer, "\ncommitter ",
+	get_ac_line(message, "\ncommitter ",
 		    sizeof(committer_buf), committer_buf, &ret->committer_mail,
 		    &ret->committer_time, &ret->committer_tz);
 
 	ret->summary = summary_buf;
-	tmp = strstr(commit->buffer, "\n\n");
+	tmp = strstr(message, "\n\n");
 	if (!tmp) {
 	error_out:
 		sprintf(summary_buf, "(%s)", sha1_to_hex(commit->object.sha1));
+		free(reencoded);
 		return;
 	}
 	tmp += 2;
@@ -1478,6 +1483,7 @@ static void get_commit_info(struct commit *commit,
 		goto error_out;
 	memcpy(summary_buf, tmp, len);
 	summary_buf[len] = 0;
+	free(reencoded);
 }
 
 /*
diff --git a/commit.h b/commit.h
index 4c05864..3a7b06a 100644
--- a/commit.h
+++ b/commit.h
@@ -65,6 +65,8 @@ enum cmit_fmt {
 
 extern int non_ascii(int);
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
+extern char *reencode_commit_message(const struct commit *commit,
+				     const char **encoding_p);
 extern void get_commit_format(const char *arg, struct rev_info *);
 extern void format_commit_message(const struct commit *commit,
 				  const void *format, struct strbuf *sb,
diff --git a/pretty.c b/pretty.c
index 1e79943..f6ff312 100644
--- a/pretty.c
+++ b/pretty.c
@@ -783,6 +783,20 @@ void pp_remainder(enum cmit_fmt fmt,
 	}
 }
 
+char *reencode_commit_message(const struct commit *commit, const char **encoding_p)
+{
+	const char *encoding;
+
+	encoding = (git_log_output_encoding
+		    ? git_log_output_encoding
+		    : git_commit_encoding);
+	if (!encoding)
+		encoding = "utf-8";
+	if (encoding_p)
+		*encoding_p = encoding;
+	return logmsg_reencode(commit, encoding);
+}
+
 void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 			 struct strbuf *sb, int abbrev,
 			 const char *subject, const char *after_subject,
@@ -799,12 +813,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 		return;
 	}
 
-	encoding = (git_log_output_encoding
-		    ? git_log_output_encoding
-		    : git_commit_encoding);
-	if (!encoding)
-		encoding = "utf-8";
-	reencoded = logmsg_reencode(commit, encoding);
+	reencoded = reencode_commit_message(commit, &encoding);
 	if (reencoded) {
 		msg = reencoded;
 	}
diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
new file mode 100755
index 0000000..4470a92
--- /dev/null
+++ b/t/t8005-blame-i18n.sh
@@ -0,0 +1,92 @@
+#!/bin/sh
+
+test_description='git blame encoding conversion'
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/t8005/utf8.txt
+. "$TEST_DIRECTORY"/t8005/cp1251.txt
+. "$TEST_DIRECTORY"/t8005/sjis.txt
+
+test_expect_success 'setup the repository' '
+	# Create the file
+	echo "UTF-8 LINE" > file &&
+	git add file &&
+	git commit --author "$UTF8_NAME <utf8@localhost>" -m "$UTF8_MSG" &&
+
+	echo "CP1251 LINE" >> file &&
+	git add file &&
+	git config i18n.commitencoding cp1251 &&
+	git commit --author "$CP1251_NAME <cp1251@localhost>" -m "$CP1251_MSG" &&
+
+	echo "SJIS LINE" >> file &&
+	git add file &&
+	git config i18n.commitencoding shift-jis &&
+	git commit --author "$SJIS_NAME <sjis@localhost>" -m "$SJIS_MSG"
+'
+
+cat >expected <<EOF
+author $SJIS_NAME
+summary $SJIS_MSG
+author $SJIS_NAME
+summary $SJIS_MSG
+author $SJIS_NAME
+summary $SJIS_MSG
+EOF
+
+test_expect_success \
+	'blame respects i18n.commitencoding' '
+	git blame --incremental file | \
+		grep "^\(author\|summary\) " > actual &&
+	test_cmp actual expected
+'
+
+cat >expected <<EOF
+author $CP1251_NAME
+summary $CP1251_MSG
+author $CP1251_NAME
+summary $CP1251_MSG
+author $CP1251_NAME
+summary $CP1251_MSG
+EOF
+
+test_expect_success \
+	'blame respects i18n.logoutputencoding' '
+	git config i18n.logoutputencoding cp1251 &&
+	git blame --incremental file | \
+		grep "^\(author\|summary\) " > actual &&
+	test_cmp actual expected
+'
+
+cat >expected <<EOF
+author $UTF8_NAME
+summary $UTF8_MSG
+author $UTF8_NAME
+summary $UTF8_MSG
+author $UTF8_NAME
+summary $UTF8_MSG
+EOF
+
+test_expect_success \
+	'blame respects --encoding=utf-8' '
+	git blame --incremental --encoding=utf-8 file | \
+		grep "^\(author\|summary\) " > actual &&
+	test_cmp actual expected
+'
+
+cat >expected <<EOF
+author $SJIS_NAME
+summary $SJIS_MSG
+author $CP1251_NAME
+summary $CP1251_MSG
+author $UTF8_NAME
+summary $UTF8_MSG
+EOF
+
+test_expect_success \
+	'blame respects --encoding=none' '
+	git blame --incremental --encoding=none file | \
+		grep "^\(author\|summary\) " > actual &&
+	test_cmp actual expected
+'
+
+test_done
diff --git a/t/t8005/cp1251.txt b/t/t8005/cp1251.txt
new file mode 100644
index 0000000000000000000000000000000000000000..ce41e98b811b09c135115529b41e227ce5ec4ff6
GIT binary patch
literal 68
zcmZ<`Ff=kXjQ4Z&b+uJG@#w)@h4W88eR%ii#dn2^FP^*uvXr=-A!>Ys-EEaFJ^lFU
W-J^F;6+XUu_weV_w=bS5aRC6=1t)(1

literal 0
HcmV?d00001

diff --git a/t/t8005/sjis.txt b/t/t8005/sjis.txt
new file mode 100644
index 0000000000000000000000000000000000000000..2ccfbad207c6e96b1f4f528031d9e4938d364b92
GIT binary patch
literal 100
zcmWIc@(hmmbM$q!Rci5UDQYQbsZ(ePXen)JX=!R{018yLbSkt20jUxo7c8X26%5kk
k8|)6$6AV<^3{(tK+R##}0OT|PVPQ)*P@)c~tyGB%00x;U@Bjb+

literal 0
HcmV?d00001

diff --git a/t/t8005/utf8.txt b/t/t8005/utf8.txt
new file mode 100644
index 0000000000000000000000000000000000000000..f46cfc56d80797740c3ec15e166add052f905fcb
GIT binary patch
literal 100
zcmWFyakGf`bM$q!Rk|?a!lnxwF6>pfF#p2Vi%l0BF6;ve?6}yjaADzv9T&D-*as0(
t;tB<6@(p$e>RAL-+IX=EtaRUntqK<#fy{juHeT$!u=T=Tpth|_TmU(XJDmUk

literal 0
HcmV?d00001

-- 
1.6.0.20.g6148bc
