From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] difftool: Fix '--gui' when diff.guitool is unconfigured
Date: Sat, 27 Mar 2010 14:58:09 -0700
Message-ID: <1269727089-9506-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 22:58:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nve1Z-00055k-Im
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 22:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033Ab0C0V6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 17:58:17 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62754 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754020Ab0C0V6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 17:58:16 -0400
Received: by gwaa18 with SMTP id a18so3313343gwa.19
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 14:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=h9v8JW31xyGSwYsvN/TxdEAksYnGMxphFVvr0AI3otA=;
        b=C6AoAbay+Fl+8ECtLPbPtmyVoihAQPdZaC8nW74GPKIvRXj6++e/BAU1pOGzcGPcJk
         1wXXlL/gOhyM3mlui5EX4irAUBD1oWa2HYC2pbMlm/3ylyp0hl8TwISCuitX2ebVNlDf
         +2DKOGSgzB3zsMrRHVoL6bIac5Qv0wThbCxtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=STr5+6yp7JHtaAvicF2htIjlIFXME4hUNIT+qlCVCSBPjj5JvHhALEAL1opO7/7LfG
         5AtksanorwBo2b5QRzIGcemRfz1bO3qODGSMmmDBie3e19++v/Ec9X0QheqpWnewEpng
         8BsJdfOw9+THhkrjmU7eSPoPnR+rcMz69LNRU=
Received: by 10.100.233.9 with SMTP id f9mr4531040anh.182.1269727095558;
        Sat, 27 Mar 2010 14:58:15 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 7sm639157ywc.4.2010.03.27.14.58.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 14:58:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.291.g5e4f6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143359>

When diff.guitool is unconfigured and "--gui" is specified
git-difftool dies with the following error message:

	config diff.guitool: command returned error: 1

Catch the error so that the "--gui" flag is a no-op when
diff.guitool is unconfigured.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

This is probably 'maint' material.

 git-difftool.perl   |   12 +++++++-----
 t/t7800-difftool.sh |    9 +++++++++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index d975d07..adc42de 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -78,11 +78,13 @@ sub generate_command
 			next;
 		}
 		if ($arg eq '-g' || $arg eq '--gui') {
-			my $tool = Git::command_oneline('config',
-			                                'diff.guitool');
-			if (length($tool)) {
-				$ENV{GIT_DIFF_TOOL} = $tool;
-			}
+			eval {
+				my $tool = Git::command_oneline('config',
+				                                'diff.guitool');
+				if (length($tool)) {
+					$ENV{GIT_DIFF_TOOL} = $tool;
+				}
+			};
 			next;
 		}
 		if ($arg eq '-y' || $arg eq '--no-prompt') {
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 19c72f5..1de83ef 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -92,6 +92,15 @@ test_expect_success 'difftool honors --gui' '
 	restore_test_defaults
 '
 
+test_expect_success 'difftool --gui works without configured diff.guitool' '
+	git config diff.tool test-tool &&
+
+	diff=$(git difftool --no-prompt --gui branch) &&
+	test "$diff" = "branch" &&
+
+	restore_test_defaults
+'
+
 # Specify the diff tool using $GIT_DIFF_TOOL
 test_expect_success 'GIT_DIFF_TOOL variable' '
 	git config --unset diff.tool
-- 
1.7.0.3.291.g5e4f6
