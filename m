From: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: [PATCH 1/3] t7300: add tests to document behavior of clean and nested git
Date: Mon,  6 Apr 2015 13:48:22 +0200
Message-ID: <1428320904-12366-2-git-send-email-erik.elfstrom@gmail.com>
References: <1428320904-12366-1-git-send-email-erik.elfstrom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Erik=20Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 14:03:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yf5WM-0003QB-7V
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 13:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbbDFLsm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 07:48:42 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:35813 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbbDFLsk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 07:48:40 -0400
Received: by lbbuc2 with SMTP id uc2so14597771lbb.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 04:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=LcWPma0ZdWs0zfupDh0/flVYYCRDQUa79xsLYhCa2BU=;
        b=LQ7MzthT4DmGpUXl1hP9VjNJe/gDQ+ilj6/mRcvz0v9Gx+UyYaet27NpzEySbeEzI4
         kuC8V4HkgSo7zhGCnQj7pOUrwxJbz/P2DPk1cwxf8jiEGVIw96VZmOid8rSPjCNpGhtn
         +0gTHqg7/ScempWA/DI7ksgB/ObjZ42dk3UXqtdoLH1m0lNUGNDM3KAQZi+FIJ88jcF4
         S+WuP0RLyK/nNMSzDc4W4I6uocXmAy3OFTK6bI1ZBuQNuxLkGhochtVXoYFIwRC+Mlf9
         T/kUtN5bU6uwcEr4PaVIH8PYo0qOsd8OVRIGsX+HyyTZccpKOLs6WACvUysz5yov5HRx
         17Wg==
X-Received: by 10.112.188.194 with SMTP id gc2mr3829379lbc.25.1428320919307;
        Mon, 06 Apr 2015 04:48:39 -0700 (PDT)
Received: from localhost.localdomain (h38n2-lk-d2.ias.bredband.telia.com. [78.72.191.38])
        by mx.google.com with ESMTPSA id pd1sm933083lbc.9.2015.04.06.04.48.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Apr 2015 04:48:38 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.rc0.37.ga3b75b3
In-Reply-To: <1428320904-12366-1-git-send-email-erik.elfstrom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266842>

Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
---

These tests were added so that I could understand the corner case
behaviors of clean and nested repositories and document the changes in
behavior that this series will cause. The ones marked as expect
failure will be changed to expect success later in the series.

 t/t7300-clean.sh | 82 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 82 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 99be5d9..cfdf6d4 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -455,6 +455,88 @@ test_expect_success 'nested git work tree' '
 	! test -d bar
 '
=20
+test_expect_failure 'nested git (only init) should be kept' '
+	rm -fr foo bar &&
+	mkdir foo bar &&
+	(
+		cd foo &&
+		git init
+	) &&
+	(
+		cd bar &&
+		>goodbye.people
+	) &&
+	git clean -f -d &&
+	test -f foo/.git/HEAD &&
+	! test -d bar
+'
+
+test_expect_failure 'nested git (bare) should be kept' '
+	rm -fr foo bar &&
+	mkdir foo bar &&
+	(
+		cd foo &&
+		git init --bare
+	) &&
+	(
+		cd bar &&
+		>goodbye.people
+	) &&
+	git clean -f -d &&
+	test -f foo/HEAD &&
+	! test -d bar
+'
+
+test_expect_success 'giving path in nested git work tree will remove i=
t' '
+	rm -fr foo &&
+	mkdir foo &&
+	(
+		cd foo &&
+		git init &&
+		mkdir -p bar/baz &&
+		cd bar/baz &&
+		>hello.world
+		git add . &&
+		git commit -a -m nested
+	) &&
+	git clean -f -d foo/bar/baz &&
+	test -f foo/.git/HEAD &&
+	test -d foo/bar/ &&
+	! test -d foo/bar/baz
+'
+
+test_expect_success 'giving path to nested .git will not remove it' '
+	rm -fr foo &&
+	mkdir foo bar &&
+	(
+		cd foo &&
+		git init &&
+		>hello.world
+		git add . &&
+		git commit -a -m nested
+	) &&
+	git clean -f -d foo/.git &&
+	test -f foo/.git/HEAD &&
+	test -d foo/.git/refs &&
+	test -d foo/.git/objects &&
+	test -d bar/
+'
+
+test_expect_success 'giving path to nested .git/ will remove contents'=
 '
+	rm -fr foo bar &&
+	mkdir foo bar &&
+	(
+		cd foo &&
+		git init &&
+		>hello.world
+		git add . &&
+		git commit -a -m nested
+	) &&
+	git clean -f -d foo/.git/ &&
+	test 0 =3D $(ls -A foo/.git | wc -l) &&
+	test -d foo/.git
+'
+
 test_expect_success 'force removal of nested git work tree' '
 	rm -fr foo bar baz &&
 	mkdir -p foo bar baz/boo &&
--=20
2.4.0.rc0.37.ga3b75b3
