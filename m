From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 1/3] t7502-commit: add tests for summary output
Date: Thu, 27 May 2010 23:34:50 +0800
Message-ID: <1274974492-4692-2-git-send-email-rctay89@gmail.com>
References: <1274694452-4200-1-git-send-email-rctay89@gmail.com>
 <1274974492-4692-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 27 17:35:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHf7Z-00081i-EW
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 17:35:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758657Ab0E0PfZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 11:35:25 -0400
Received: from mail-pz0-f176.google.com ([209.85.222.176]:45698 "EHLO
	mail-pz0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758097Ab0E0PfW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 11:35:22 -0400
Received: by mail-pz0-f176.google.com with SMTP id 6so93007pzk.1
        for <git@vger.kernel.org>; Thu, 27 May 2010 08:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0jWHOYbpzZw4r/U27QvYjdi70kh7Ycwht4WIkBu5Kx0=;
        b=nI2pH+f4cgCcOI0Xi0tid/f1WOQaNV5yOIFXesVPRMbIuaSyHRHtMx+sEPXlLgrURM
         qCJnI0T1E3dQxsNz5UemnIGO8J9WPAMHSm79/leBNqLpS/KIrB28KEeX5S/whbM8WslA
         xDGbqJ4F8bK7e4NJRarZS+kymZqRRXDHx4Tho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=h6FITMEjIIMuIp/vOpjorEuXc6XESS/kSekr+xd9mno/KNzmDeNmzw7kgLr+LfvMk+
         LmFVmJ9Tjn58dHLyCSPXEypHCum7yofm5Yp1/b0XdBVL1n5Q/cMFLLx53CokrSeSUlrZ
         yaoiJJsvzDPZSmmEX8dDC/SzoE/5g4SvaYfrw=
Received: by 10.114.188.3 with SMTP id l3mr9165900waf.150.1274974521784;
        Thu, 27 May 2010 08:35:21 -0700 (PDT)
Received: from localhost.localdomain (cm218.zeta152.maxonline.com.sg [116.87.152.218])
        by mx.google.com with ESMTPS id r20sm11007341wam.5.2010.05.27.08.35.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 08:35:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.352.g12d15
In-Reply-To: <1274974492-4692-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147878>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changes from v1:
 - move cleanup commands into a separate function,
   output_tests_cleanup().
 - add a cleanup command to accomodate tests #20 and #22.

 t/t7502-commit.sh |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 844fb43..478b637 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -4,8 +4,51 @@ test_description='git commit porcelain-ish'

 . ./test-lib.sh

+# Arguments: [<prefix] [<commit message>]
+check_summary_oneline() {
+	test_tick &&
+	git commit -m "$2" | head -1 > act &&
+
+	# branch name
+	SUMMARY_PREFIX="$(git name-rev --name-only HEAD)" &&
+
+	# append the "special" prefix, like "root-commit", "detached HEAD"
+	if test -n "$1"
+	then
+		SUMMARY_PREFIX="$SUMMARY_PREFIX ($1)"
+	fi
+
+	# abbrev SHA-1
+	SUMMARY_POSTFIX="$(git log -1 --pretty='format:%h')"
+	echo "[$SUMMARY_PREFIX $SUMMARY_POSTFIX] $2" >exp &&
+
+	test_cmp exp act
+}
+
+test_expect_success 'output summary format' '
+
+	echo new >file1 &&
+	git add file1 &&
+	check_summary_oneline "root-commit" "initial" &&
+
+	echo change >>file1 &&
+	git add file1 &&
+	check_summary_oneline "" "a change"
+'
+
+output_tests_cleanup() {
+	# this is needed for "do not fire editor in the presence of conflicts"
+	git checkout master &&
+
+	# this is needed for the "partial removal" test to pass
+	git rm file1 &&
+	git commit -m "cleanup"
+}
+
 test_expect_success 'the basics' '

+	output_tests_cleanup &&
+
 	echo doing partial >"commit is" &&
 	mkdir not &&
 	echo very much encouraged but we should >not/forbid &&
--
1.7.1.189.g07419
