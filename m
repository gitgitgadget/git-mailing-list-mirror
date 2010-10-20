From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 2/4] run_builtin(): save "-h" detection result for later use
Date: Wed, 20 Oct 2010 10:11:58 +0700
Message-ID: <1287544320-8499-2-git-send-email-pclouds@gmail.com>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 05:12:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8P6Y-0007M5-Pb
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 05:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757445Ab0JTDM0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 23:12:26 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59880 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757335Ab0JTDMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 23:12:25 -0400
Received: by pva18 with SMTP id 18so625951pva.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 20:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Y/23xhFekAqvhDCt5kj/1ZAhxzJvHS3FXM1fRKgE0Go=;
        b=GphcgULP568eZaKoazQy2aGrtXAOMA7JDGVAA7qgWhl4rSUSSWtezp4wZLU+DS89O1
         UEIpPyQYyAxixxJemV51MCbPgNKZWMXucFP0Ih2WvtWJ7gTdcWfdNcg5JbvcZrmomf4Z
         6wvoE9jOtaonfpV9zEsr6UX+MhAKydTwcUBJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AEbvy4gVmAGcQtCNJL1U7pUQMWskS1myvopvfeH+49+xEhAHaX0TEJC4f6hnhoRRlM
         i34tsIyVI9yAzH4tcRll0W+kbKn/Lc0vT6+lDTXwHpCqA6PtWqwOf4b/XTvP85D/l8oX
         Scufj7qXtV/PtzCCjQlqtmR95M1kx53r+kVao=
Received: by 10.142.211.15 with SMTP id j15mr5397699wfg.284.1287544343876;
        Tue, 19 Oct 2010 20:12:23 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.198.15])
        by mx.google.com with ESMTPS id t38sm26354269wfc.21.2010.10.19.20.12.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 20:12:22 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 20 Oct 2010 10:12:14 +0700
X-Mailer: git-send-email 1.7.0.2.445.gcbdb3
In-Reply-To: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159387>

When run_builtin() sees "-h" as the first argument, it assumes:

 - this is the call for help usage
 - the real git command will only print help usage then exit

So it skips all setup in this case.  Unfortunately, some commands do
other things before calling parse_options(), which is often where the
help usage is printed.  Some of those things may try to access the
repository unnecessarily. If a repository is broken, the command may
die() before it prints help usage, not really helpful.

Make real commands aware of this fast path so that they can handle it
properly (i.e., print help usage then exit immediately) if they were
going to do more initialization than git_config().

Demonstrating "git foo -h" fails depends on individual commands and
is generally difficult to do. Instead GIT_TRACE is used to check
if a command does set repo. If it does, it is supposed to fail if
repo setup code chokes.

"git upload-archive" fails for another reason, but will be fixed too
when "git upload-archive -h" is converted to use startup_info->help

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h         |    1 +
 git.c           |   18 ++++++++++++++----
 t/t3905-help.sh |   24 ++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 4 deletions(-)
 create mode 100755 t/t3905-help.sh

diff --git a/cache.h b/cache.h
index 33decd9..bb57e34 100644
--- a/cache.h
+++ b/cache.h
@@ -1117,6 +1117,7 @@ const char *split_cmdline_strerror(int cmdline_er=
rno);
 /* git.c */
 struct startup_info {
 	int have_repository;
+	int help; /* git foo -h */
 };
 extern struct startup_info *startup_info;
=20
diff --git a/git.c b/git.c
index 50a1401..bb67540 100644
--- a/git.c
+++ b/git.c
@@ -246,13 +246,23 @@ struct cmd_struct {
=20
 static int run_builtin(struct cmd_struct *p, int argc, const char **ar=
gv)
 {
-	int status, help;
+	int status;
 	struct stat st;
 	const char *prefix;
=20
 	prefix =3D NULL;
-	help =3D argc =3D=3D 2 && !strcmp(argv[1], "-h");
-	if (!help) {
+	startup_info->help =3D argc =3D=3D 2 && !strcmp(argv[1], "-h");
+	if (startup_info->help) {
+		/*
+		 * Fast path for "git foo -h", no setup is done.
+		 * Other functions might set .git up automatically
+		 * and potentially die() along the way. It's best
+		 * to check this flag from the beginning, print its
+		 * help usage and exit, nothing more.
+		 */
+		;
+	}
+	else {
 		if (p->option & RUN_SETUP)
 			prefix =3D setup_git_directory();
 		if (p->option & RUN_SETUP_GENTLY) {
@@ -267,7 +277,7 @@ static int run_builtin(struct cmd_struct *p, int ar=
gc, const char **argv)
 	}
 	commit_pager_choice();
=20
-	if (!help && p->option & NEED_WORK_TREE)
+	if (!startup_info->help && p->option & NEED_WORK_TREE)
 		setup_work_tree();
=20
 	trace_argv_printf(argv, "trace: built-in: git");
diff --git a/t/t3905-help.sh b/t/t3905-help.sh
new file mode 100755
index 0000000..0dcbedf
--- /dev/null
+++ b/t/t3905-help.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+test_description=3D'tests that git foo -h should work even in potentia=
lly broken repos'
+
+. ./test-lib.sh
+
+test_help() {
+	test_expect_"$1" "$2 -h" "
+		GIT_TRACE=3D\"`pwd`\"/$2.log test_must_fail git $2 -h &&
+		test \$exit_code =3D 129 &&
+		! grep 'defaults to' $2.log
+	"
+}
+
+test_help failure branch
+test_help failure checkout-index
+test_help failure commit
+test_help failure gc
+test_help failure ls-files
+test_help failure merge
+test_help failure update-index
+test_help failure upload-archive
+
+test_done
--=20
1.7.0.2.445.gcbdb3
