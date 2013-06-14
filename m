From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: =?UTF-8?q?=5BPATCH=20v2=201/2=5D=20=5Bsubmodule=5D=20handle=20multibyte=20characters=20in=20name?=
Date: Fri, 14 Jun 2013 02:26:02 +0200
Message-ID: <1371169563-10267-2-git-send-email-iveqy@iveqy.com>
References: <1371169563-10267-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: iveqy@iveqy.com
X-From: git-owner@vger.kernel.org Fri Jun 14 02:23:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnHnP-0001EQ-6D
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 02:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759537Ab3FNAXE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Jun 2013 20:23:04 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:48217 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759471Ab3FNAXA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 20:23:00 -0400
Received: by mail-la0-f49.google.com with SMTP id ea20so5847858lab.22
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 17:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=Uzv1nET3tuWdO+GR9llz+x6FR8oDsZ4AAgVxKn3Izn4=;
        b=j5PwsBLuU6UyWh0F8kxxJXMcPTm6jbYPvSnXKmp8J/I5uELLFPRXPOmzhSpvbVNZg5
         dvWRVhHMW/1utKwVM72LapD4JbxhOdK8TtCZuK1NFMX1gZB8OtlT/WYT6WjMbLYKrIl4
         YFHABApkHgvK6aNL3GHRaaszoQFSK0rANR0+GaWs4CHomao1LwTrGkoRZP2rajAttqVO
         S5q1m+dK4wNGxa/7OhS0zRO3Ku/v5VdZJe3UbxDmUFMMgdTZ3e74HUABT6U1aEz1fhrF
         qAkhH0KUch6Kh3l5qKoWzJxIkeO/VXNMa4pUeTRP+PFADZjnKCnl87cJVUGkeliYiWjg
         tIWQ==
X-Received: by 10.112.63.2 with SMTP id c2mr2406333lbs.6.1371169378814;
        Thu, 13 Jun 2013 17:22:58 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id u1sm1263282lag.5.2013.06.13.17.22.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 17:22:58 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UnHq8-0002gD-U0; Fri, 14 Jun 2013 02:26:04 +0200
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1371169563-10267-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227788>

Many "git submodule" operations do not work on a submodule at a path wh=
ose
name is not in ASCII.

This is because "git ls-files" is used to find which paths are bound to
submodules to the current working tree, and the output is C-quoted by d=
efault
for non ASCII pathnames.

Tell "git ls-files" to not C-quote its output, which is easier than unw=
rapping
C-quote ourselves.

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
