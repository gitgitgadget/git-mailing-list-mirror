From: larsxschneider@gmail.com
Subject: [PATCH] git-p4: add "--path-encoding" option
Date: Mon, 31 Aug 2015 17:40:16 +0200
Message-ID: <1441035616-39128-2-git-send-email-larsxschneider@gmail.com>
References: <1441035616-39128-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 31 17:40:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWRCE-0004VT-6q
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 17:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbbHaPkY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2015 11:40:24 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37597 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596AbbHaPkV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 11:40:21 -0400
Received: by wicmx12 with SMTP id mx12so3371144wic.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SLScBFcBgwX4HWHKpgQV8spwWVc8IdSElhe+jJj4GiU=;
        b=gKVFAsaN3ngPHAjp4GP6FwDSvqZnIqxQAoeNf/XW40cV1/5Q+PcNtt0i6B8dDkwBQH
         GQWAlSYjacZHdaj12I7LTQCvHbr6DHsRnx5SdioHIT4p7R+9fJu7jJLm00TFLnIBcH02
         rnJZfnAIPiSImoSRo1G0X230xKt1gcOWUwlO8z8XrVwXgZeNlY4SsTBVEoN9tN5t6oWU
         Qnz4+pRP83jS8OTpHooAWCc1eUe5mdq+s6Tdb6qNA3UQFqhhEVw1goTF+E1TMJRWAYP8
         NZzly+0UNAthgbaEOe99VTavjiDWeuI6vjB7tlcMOEy4k4Hlo+UAZbp7nM/Kom8Do18L
         ITCA==
X-Received: by 10.194.23.36 with SMTP id j4mr27928864wjf.105.1441035620184;
        Mon, 31 Aug 2015 08:40:20 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id fz16sm18598204wic.3.2015.08.31.08.40.19
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Aug 2015 08:40:19 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
In-Reply-To: <1441035616-39128-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276885>

=46rom: Lars Schneider <larsxschneider@gmail.com>

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/git-p4.txt        |  4 ++++
 git-p4.py                       |  6 ++++++
 t/t9821-git-p4-path-encoding.sh | 38 +++++++++++++++++++++++++++++++++=
+++++
 3 files changed, 48 insertions(+)
 create mode 100755 t/t9821-git-p4-path-encoding.sh

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 82aa5d6..98b6c0f 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -252,6 +252,10 @@ Git repository:
 	Use a client spec to find the list of interesting files in p4.
 	See the "CLIENT SPEC" section below.
=20
+----path-encoding <encoding>::
+	The encoding to use when reading p4 client paths. With this option
+	non ASCII paths are properly stored in Git. For example, the encoding=
 'cp1252' is often used on Windows systems.
+
 -/ <path>::
 	Exclude selected depot paths when cloning or syncing.
=20
diff --git a/git-p4.py b/git-p4.py
index 073f87b..2b3bfc4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1981,6 +1981,8 @@ class P4Sync(Command, P4UserMap):
                 optparse.make_option("--silent", dest=3D"silent", acti=
on=3D"store_true"),
                 optparse.make_option("--detect-labels", dest=3D"detect=
Labels", action=3D"store_true"),
                 optparse.make_option("--import-labels", dest=3D"import=
Labels", action=3D"store_true"),
+                optparse.make_option("--path-encoding", dest=3D"pathEn=
coding", type=3D"string",
+                                     help=3D"Encoding to use for paths=
"),
                 optparse.make_option("--import-local", dest=3D"importI=
ntoRemotes", action=3D"store_false",
                                      help=3D"Import into refs/heads/ ,=
 not refs/remotes"),
                 optparse.make_option("--max-changes", dest=3D"maxChang=
es",
@@ -2025,6 +2027,7 @@ class P4Sync(Command, P4UserMap):
         self.clientSpecDirs =3D None
         self.tempBranches =3D []
         self.tempBranchLocation =3D "git-p4-tmp"
+        self.pathEncoding =3D None
=20
         if gitConfig("git-p4.syncFromOrigin") =3D=3D "false":
             self.syncWithOrigin =3D False
@@ -2213,6 +2216,9 @@ class P4Sync(Command, P4UserMap):
             text =3D regexp.sub(r'$\1$', text)
             contents =3D [ text ]
=20
+        if self.pathEncoding:
+            relPath =3D relPath.decode(self.pathEncoding).encode('utf8=
', 'replace')
+
         self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
=20
         # total length...
diff --git a/t/t9821-git-p4-path-encoding.sh b/t/t9821-git-p4-path-enco=
ding.sh
new file mode 100755
index 0000000..f6bb79c
--- /dev/null
+++ b/t/t9821-git-p4-path-encoding.sh
@@ -0,0 +1,38 @@
+#!/bin/sh
+
+test_description=3D'Clone repositories with non ASCII paths'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'Create a repo containing cp1251 encoded paths' '
+	cd "$cli" &&
+
+	FILENAME=3D"$(echo "a-=C3=A4_o-=C3=B6_u-=C3=BC.txt" | iconv -f utf-8 =
-t cp1252)" &&
+	>"$FILENAME" &&
+	p4 add "$FILENAME" &&
+	p4 submit -d "test"
+'
+
+test_expect_success 'Clone repo containing cp1251 encoded paths' '
+	git p4 clone --destination=3D"$git" --path-encoding=3Dcp1252 //depot =
&&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git init . &&
+		cat >expect <<-\EOF &&
+		"a-\303\244_o-\303\266_u-\303\274.txt"
+		EOF
+		git ls-files >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
--=20
2.5.1.1.g36ff854
