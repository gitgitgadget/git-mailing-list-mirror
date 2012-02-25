From: =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
Subject: [PATCH] grep -P: Fix matching ^ and $
Date: Sat, 25 Feb 2012 10:24:28 +0100
Message-ID: <1330161868-7954-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	=?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 10:24:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1Drw-0007k2-Ac
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 10:24:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568Ab2BYJYi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 04:24:38 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53559 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755537Ab2BYJYf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 04:24:35 -0500
Received: by eaah12 with SMTP id h12so1382449eaa.19
        for <git@vger.kernel.org>; Sat, 25 Feb 2012 01:24:34 -0800 (PST)
Received-SPF: pass (google.com: domain of michal.kiedrowicz@gmail.com designates 10.213.9.73 as permitted sender) client-ip=10.213.9.73;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of michal.kiedrowicz@gmail.com designates 10.213.9.73 as permitted sender) smtp.mail=michal.kiedrowicz@gmail.com; dkim=pass header.i=michal.kiedrowicz@gmail.com
Received: from mr.google.com ([10.213.9.73])
        by 10.213.9.73 with SMTP id k9mr1715182ebk.96.1330161874148 (num_hops = 1);
        Sat, 25 Feb 2012 01:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=UiP3UMltIaRMObS6JSdeGa9hebt+eWj04GJfVtkokH8=;
        b=pZJ0N6l6qSBuHr8fkNmDcYZZzrhORzm2PKFAJDFEEmuBQsum5cQgPeZ48P4vJVRBIO
         wA6/6rxGmTxFkbV4cRSA97j5ImYiFAOsiWWliHBR4af1jQgr082hpb74VrjMG376ETGY
         idp6G7k4thOwy3SbMZWTjBKEiy7BuEF6QQUBY=
Received: by 10.213.9.73 with SMTP id k9mr1290540ebk.96.1330161873943;
        Sat, 25 Feb 2012 01:24:33 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id u11sm21770389eeb.1.2012.02.25.01.24.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 25 Feb 2012 01:24:30 -0800 (PST)
X-Mailer: git-send-email 1.7.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191511>

When `git-grep` is run with -P/--perl-regexp, it doesn't match ^ and $ =
at
the beginning/end of the line.  This is because PCRE normally matches ^
and $ at the beginning/end of the whole text, not for each line, and gi=
t-grep
firstly passes a large chunk of text (possibly containing many lines) t=
o
pcre_exec() before it splits the text into lines.  This makes `git-grep=
 -P`
behave differently from `git-grep -E` and also from `grep -P` and `pcre=
grep`:

	$ cat file
	a
	 b
	$ git --no-pager grep --no-index -P '^ ' file
	$ git --no-pager grep --no-index -E '^ ' file
	file: b
	$ grep -c -P '^ ' file
	 b
	$ pcregrep -c '^ ' file
	 b

Reported-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>
---
 grep.c          |    2 +-
 t/t7810-grep.sh |   23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletions(-)

diff --git a/grep.c b/grep.c
index 3821400..f492d26 100644
--- a/grep.c
+++ b/grep.c
@@ -79,7 +79,7 @@ static void compile_pcre_regexp(struct grep_pat *p, c=
onst struct grep_opt *opt)
 {
 	const char *error;
 	int erroffset;
-	int options =3D 0;
+	int options =3D PCRE_MULTILINE;
=20
 	if (opt->ignore_case)
 		options |=3D PCRE_CASELESS;
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 75f4716..dd6e6d5 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -47,6 +47,13 @@ test_expect_success setup '
 	echo vvv >t/v &&
 	mkdir t/a &&
 	echo vvv >t/a/v &&
+	{
+		echo "line without leading space1"
+		echo " line with leading space1"
+		echo " line with leading space2"
+		echo " line with leading space3"
+		echo "line without leading space2"
+	} >space &&
 	git add . &&
 	test_tick &&
 	git commit -m initial
@@ -893,4 +900,20 @@ test_expect_success 'mimic ack-grep --group' '
 	test_cmp expected actual
 '
=20
+cat >expected <<EOF
+space: line with leading space1
+space: line with leading space2
+space: line with leading space3
+EOF
+
+test_expect_success 'grep -E "^ "' '
+	git grep -E "^ " space >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success "grep -P '^ '" '
+	git grep -P "^ " space >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.7.8.4
