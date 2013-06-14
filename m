From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: =?UTF-8?q?=5B=5BPATCH=20v3=5D=201/2=5D=20=5Bsubmodule=5D=20handle=20multibyte=20characters=20in=20name?=
Date: Fri, 14 Jun 2013 17:56:04 +0200
Message-ID: <1371225365-4219-2-git-send-email-iveqy@iveqy.com>
References: <1371225365-4219-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, iveqy@iveqy.com, jens.lehmann@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 14 17:53:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnWJN-0004nV-DX
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 17:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787Ab3FNPxH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 11:53:07 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:47116 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab3FNPxG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 11:53:06 -0400
Received: by mail-la0-f47.google.com with SMTP id fe20so681676lab.34
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=QInAEGhd7S9vNt2leA+JHjb82m+xaBv6UYOIUTufPsk=;
        b=lGrzB8WebM0eF9C0wShjLJfhoUWTkVzYXIMBwnkZf/pSgobMed9szy1lLXaZqLW5fk
         Iv3tVhLw0ZHPEbSpQYNEM3ZasP6BhnEt2mlGRIpn2j8Q2eyEMyAAd18XIz4X+IRVj3fI
         YGBo2gTYtBmLx7wEVIKMNwq8/s4FuQJUijL6hFvHJ4wnd0HZ4IZSvePGIa9MhJYBs6a5
         dclP/M6EedFVItTtKwD47KgXtmfMTDYFkj7gg4wqJQJdDEXD6IJ2EyFsGLSnC1/H0qNT
         0m2phhPamNPRLe7az5nGbcuBomNYE4UBiemV2VkZi0NY1F/gawUvm43CaLHC/WztsMcP
         DviQ==
X-Received: by 10.112.182.39 with SMTP id eb7mr1373112lbc.30.1371225184396;
        Fri, 14 Jun 2013 08:53:04 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id h8sm1138689laf.1.2013.06.14.08.53.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 08:53:03 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UnWMH-00016f-GF; Fri, 14 Jun 2013 17:56:13 +0200
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1371225365-4219-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227888>

Many "git submodule" operations do not work on a submodule at a path wh=
ose
name is not in ASCII.

This is because "git ls-files" is used to find which paths are bound to
submodules to the current working tree, and the output is C-quoted by d=
efault
for non ASCII pathnames and pathnames that has a double-quote, a
backslash or a control character like a newline or a tab in thme.

Tell "git ls-files" to not C-quote its output, which is easier than unw=
rapping
C-quote ourselves.

This patch still does not allow pathnames with characters that do need =
C-quote,
but the code didn't handle them before, so it is not making things wors=
e. The
correct approach to solve the problem for all pathnames may be to use
"ls-files -z" and tell the Perl script that reads its output to read NU=
L
separated records by using $/ =3D "\0".

Solution-suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 git-submodule.sh           |  2 +-
 t/t7400-submodule-basic.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 79bfaac..bad051e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -113,7 +113,7 @@ resolve_relative_url ()
 module_list()
 {
 	(
-		git ls-files --error-unmatch --stage -- "$@" ||
+		git -c core.quotepath=3Dfalse ls-files --error-unmatch --stage -- "$=
@" ||
 		echo "unmatched pathspec exists"
 	) |
 	perl -e '
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index ff26535..d5743ee 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -868,4 +868,16 @@ test_expect_success 'submodule deinit fails when s=
ubmodule has a .git directory
 	test -n "$(git config --get-regexp "submodule\.example\.")"
 '
=20
+test_expect_success 'submodule with strange name works "=C3=A5 =C3=A4=C3=
=B6"' '
+	mkdir "=C3=A5 =C3=A4=C3=B6" &&
+	(
+		cd "=C3=A5 =C3=A4=C3=B6" &&
+		git init &&
+		touch sub
+		git add sub
+		git commit -m "init sub"
+	)
+	git submodule add "/=C3=A5 =C3=A4=C3=B6" &&
+	test -n "$(git submodule | grep "=C3=A5 =C3=A4=C3=B6")"
+'
 test_done
--=20
1.8.3.1.381.g2ab719e.dirty
