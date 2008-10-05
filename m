From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH 2/2] check-attr: Add --stdin-paths option
Date: Sun,  5 Oct 2008 06:30:55 +0400
Message-ID: <1223173855-6173-2-git-send-email-dpotapov@gmail.com>
References: <bb6f213e0809220312m6cb8022csa3843cfaccc5b69b@mail.gmail.com>
 <1223173855-6173-1-git-send-email-dpotapov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Dmitry Potapov <dpotapov@gmail.com>
To: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 05 04:32:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmJPs-0008UG-85
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 04:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363AbYJECbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 22:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbYJECbH
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 22:31:07 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:17795 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbYJECbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 22:31:05 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1788782muf.1
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 19:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=+o/j38MydrJlQomoMF1KhjXN165i1l/KiTb5o2B5cLQ=;
        b=HJLRRBA3X7GlgBg5s3EEz0amKelO+dJJuKrn5bmZc0yK9GR8jWqt5DOku429CpRLV7
         a4UL0aVoV8IgfChYfSRQITBz1V2xkwc/a3rH6RfPxbQxGMF2KtQ7lIuunlg48o0AHX8v
         Q2gQ3IAMFdJCKQ8grs7dfOrHdTeU9OFeHo/mw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GcDBEcWr57mi+iphSo0M+IXRcSx4KR4nVtq6mSZnpm4V2U15jFDUPTywazUsE1DWXQ
         OZB7LL/lTpPsLQH4G/K+iwKsDKPrBXGFjH89B7iscmdGmF2auvbu6vi8hKJcspDzSK4e
         09zXKP5vKDwbP+0ZblVlcrPn+1qhVehIJIdkg=
Received: by 10.103.2.14 with SMTP id e14mr1788578mui.104.1223173863443;
        Sat, 04 Oct 2008 19:31:03 -0700 (PDT)
Received: from localhost (ppp83-237-185-144.pppoe.mtu-net.ru [83.237.185.144])
        by mx.google.com with ESMTPS id j2sm21017942mue.4.2008.10.04.19.31.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Oct 2008 19:31:02 -0700 (PDT)
X-Mailer: git-send-email 1.6.0
In-Reply-To: <1223173855-6173-1-git-send-email-dpotapov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97494>

This allows multiple paths to be specified on stdin.

Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
---
 Documentation/git-check-attr.txt |    4 ++
 builtin-check-attr.c             |   66 ++++++++++++++++++++++++++++++++------
 t/t0003-attributes.sh            |   17 ++++++++++
 3 files changed, 77 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 2b821f2..0839a57 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -9,6 +9,7 @@ git-check-attr - Display gitattributes information.
 SYNOPSIS
 --------
 'git check-attr' attr... [--] pathname...
+'git check-attr' --stdin-paths attr... < <list-of-paths
 
 DESCRIPTION
 -----------
@@ -17,6 +18,9 @@ For every pathname, this command will list if each attr is 'unspecified',
 
 OPTIONS
 -------
+--stdin-paths::
+	Read file names from stdin instead of from the command-line.
+
 \--::
 	Interpret all preceding arguments as attributes, and all following
 	arguments as path names. If not supplied, only the first argument will
diff --git a/builtin-check-attr.c b/builtin-check-attr.c
index 5a2e329..821eb5e 100644
--- a/builtin-check-attr.c
+++ b/builtin-check-attr.c
@@ -2,9 +2,19 @@
 #include "cache.h"
 #include "attr.h"
 #include "quote.h"
+#include "parse-options.h"
 
-static const char check_attr_usage[] =
-"git check-attr attr... [--] pathname...";
+static int stdin_paths;
+static const char * const check_attr_usage[] = {
+"git check-attr attr... [--] pathname...",
+"git check-attr --stdin-paths attr... < <list-of-paths>",
+NULL
+};
+
+static const struct option check_attr_options[] = {
+	OPT_BOOLEAN(0 , "stdin-paths", &stdin_paths, "read file names from stdin"),
+	OPT_END()
+};
 
 static void check_attr(int cnt, struct git_attr_check *check,
 	const char** name, const char *file)
@@ -27,17 +37,43 @@ static void check_attr(int cnt, struct git_attr_check *check,
 	}
 }
 
+static void check_attr_stdin_paths(int cnt, struct git_attr_check *check,
+	const char** name)
+{
+	struct strbuf buf, nbuf;
+
+	strbuf_init(&buf, 0);
+	strbuf_init(&nbuf, 0);
+	while (strbuf_getline(&buf, stdin, '\n') != EOF) {
+		if (buf.buf[0] == '"') {
+			strbuf_reset(&nbuf);
+			if (unquote_c_style(&nbuf, buf.buf, NULL))
+				die("line is badly quoted");
+			strbuf_swap(&buf, &nbuf);
+		}
+		check_attr(cnt, check, name, buf.buf);
+	}
+	strbuf_release(&buf);
+	strbuf_release(&nbuf);
+}
+
 int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
 	struct git_attr_check *check;
 	int cnt, i, doubledash;
+	const char *errstr = NULL;
+
+	argc = parse_options(argc, argv, check_attr_options, check_attr_usage,
+		PARSE_OPT_KEEP_DASHDASH);
+	if (!argc)
+		usage_with_options(check_attr_usage, check_attr_options);
 
 	if (read_cache() < 0) {
 		die("invalid cache");
 	}
 
 	doubledash = -1;
-	for (i = 1; doubledash < 0 && i < argc; i++) {
+	for (i = 0; doubledash < 0 && i < argc; i++) {
 		if (!strcmp(argv[i], "--"))
 			doubledash = i;
 	}
@@ -45,25 +81,35 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	/* If there is no double dash, we handle only one attribute */
 	if (doubledash < 0) {
 		cnt = 1;
-		doubledash = 1;
+		doubledash = 0;
 	} else
-		cnt = doubledash - 1;
+		cnt = doubledash;
 	doubledash++;
 
-	if (cnt <= 0 || argc < doubledash)
-		usage(check_attr_usage);
+	if (cnt <= 0)
+		errstr = "No attribute specified";
+	else if (stdin_paths && doubledash < argc)
+		errstr = "Can't specify files with --stdin-paths";
+	if (errstr) {
+		error (errstr);
+		usage_with_options(check_attr_usage, check_attr_options);
+	}
+
 	check = xcalloc(cnt, sizeof(*check));
 	for (i = 0; i < cnt; i++) {
 		const char *name;
 		struct git_attr *a;
-		name = argv[i + 1];
+		name = argv[i];
 		a = git_attr(name, strlen(name));
 		if (!a)
 			return error("%s: not a valid attribute name", name);
 		check[i].attr = a;
 	}
 
-	for (i = doubledash; i < argc; i++)
-		check_attr(cnt, check, argv+1, argv[i]);
+	if (stdin_paths)
+		check_attr_stdin_paths(cnt, check, argv);
+	else
+		for (i = doubledash; i < argc; i++)
+			check_attr(cnt, check, argv, argv[i]);
 	return 0;
 }
diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
index 3d8e06a..f6901b4 100755
--- a/t/t0003-attributes.sh
+++ b/t/t0003-attributes.sh
@@ -47,6 +47,23 @@ test_expect_success 'attribute test' '
 
 '
 
+test_expect_success 'attribute test: read paths from stdin' '
+
+	cat <<EOF > expect
+f: test: f
+a/f: test: f
+a/c/f: test: f
+a/g: test: a/g
+a/b/g: test: a/b/g
+b/g: test: unspecified
+a/b/h: test: a/b/h
+a/b/d/g: test: a/b/d/*
+EOF
+
+	sed -e "s/:.*//" < expect | git check-attr --stdin-paths test > actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'root subdir attribute test' '
 
 	attr_check a/i a/i &&
-- 
1.6.0.2.447.g3befd
