From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: [PATCH v2] log: fix indentation for --graph --show-signature
Date: Wed,  9 Jul 2014 12:10:21 +1000
Message-ID: <1404871821-12659-1-git-send-email-zoltan.klinger@gmail.com>
References: <1404817948-7794-1-git-send-email-zoltan.klinger@gmail.com>
Cc: jpyeron@pdinc.us, gitster@pobox.com, sunshine@sunshineco.com,
	Zoltan Klinger <zoltan.klinger@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 04:11:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4hM0-00086H-HA
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 04:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbaGICLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 22:11:25 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35636 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbaGICLY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 22:11:24 -0400
Received: by mail-pa0-f47.google.com with SMTP id kq14so8334494pab.34
        for <git@vger.kernel.org>; Tue, 08 Jul 2014 19:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=02GNE8XEHM4T5ZjQTc38qibI1tDkHjNr/LgRnTwA7R8=;
        b=L3N2IX+B0XcfyLsZUcvFFRF+mIHiJnoSSjzrpggypG8sGjforliROwyN+FWTVpAZGS
         fQtUBl6opCurvaFNXCgAMgDYODtwRs40klpmMOGOLK55qJur4hLlFsv3q7UAXGSxDNpr
         PE9cR6fbIUxO8gg3D6NsETZvX7W8RGDkJ4Yswy5gyUvGIst8fuQALpwI4VA5Z+vj3aMv
         pDkbCUIJWcyPYDQuq0So8wa7cgpe4okCN4eZEQ3U9lmUR9W1ks2bSRzvM0KupghlX0U4
         kz0xH3+61/Vd1CKfSEHoMZFeZhQCT0UAVFvWAaxySFJ/vx/NdMcE3A9Lr5UaHpiG8BcV
         3b5Q==
X-Received: by 10.67.14.231 with SMTP id fj7mr12777783pad.115.1404871883913;
        Tue, 08 Jul 2014 19:11:23 -0700 (PDT)
Received: from localhost.localdomain (202-129-81-152.perm.iinet.net.au. [202.129.81.152])
        by mx.google.com with ESMTPSA id ry10sm209679318pab.38.2014.07.08.19.11.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 08 Jul 2014 19:11:23 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1404817948-7794-1-git-send-email-zoltan.klinger@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253060>

The git log --graph --show-signature command incorrectly indents the gpg
information about signed commits and merged signed tags. It does not
follow the level of indentation of the current commit.

Example of garbled output:
$ git log --show-signature --graph
*   commit 258e0a237cb69aaa587b0a4fb528bb0316b1b776
|\  gpg: Signature made Mon, Jun 30, 2014 13:22:33 EDT using RSA key ID DA08
gpg: Good signature from "Jason Pyeron <jpye...@pdinc.us>"
Merge: 727c355 1ca13ed
| | Author: Jason Pyeron <jpye...@pdinc.us>
| | Date:   Mon Jun 30 13:22:29 2014 -0400
| |
| |     Merge of 1ca13ed2271d60ba9 branch - rebranding
| |
| * commit 1ca13ed2271d60ba93d40bcc8db17ced8545f172
| | gpg: Signature made Mon, Jun 23, 2014  9:45:47 EDT using RSA key ID DD37
gpg: Good signature from "Stephen Robert Guglielmo <s...@guglielmo.us>"
gpg:                 aka "Stephen Robert Guglielmo <srguglie...@gmail.com>"
Author: Stephen R Guglielmo <s...@guglielmo.us>
| | Date:   Mon Jun 23 09:45:27 2014 -0400
| |
| |     Minor URL updates

In log-tree.c modify show_sig_lines() function to call graph_show_oneline()
after each line of gpg information it has printed in order to preserve
the level of indentation for the next output line.

Reported-by: Jason Pyeron <jpyeron@pdinc.us>
Signed-off-by: Zoltan Klinger <zoltan.klinger@gmail.com>
---

 Changes since v1:
   t/t4202-log.sh file:
       * fix broken &&-chain in test cases
       * add test_when_finished scripts to  test cases to
         reset things to master branch

 log-tree.c     |  1 +
 t/t4202-log.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/log-tree.c b/log-tree.c
index 10e6844..f13b861 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -365,6 +365,7 @@ static void show_sig_lines(struct rev_info *opt, int status, const char *bol)
 		eol = strchrnul(bol, '\n');
 		printf("%s%.*s%s%s", color, (int)(eol - bol), bol, reset,
 		       *eol ? "\n" : "");
+		graph_show_oneline(opt->graph);
 		bol = (*eol) ? (eol + 1) : eol;
 	}
 }
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index cb03d28..99ab7ca 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -3,6 +3,7 @@
 test_description='git log'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 test_expect_success setup '
 
@@ -841,4 +842,34 @@ test_expect_success 'dotdot is a parent directory' '
 	test_cmp expect actual
 '
 
+test_expect_success GPG 'log --graph --show-signature' '
+	test_when_finished "git reset --hard && git checkout master" &&
+	git checkout -b signed master &&
+	echo foo >foo &&
+	git add foo &&
+	git commit -S -m signed_commit &&
+	git log --graph --show-signature -n1 signed >actual &&
+	grep "^| gpg: Signature made" actual &&
+	grep "^| gpg: Good signature" actual
+'
+
+test_expect_success GPG 'log --graph --show-signature for merged tag' '
+	test_when_finished "git reset --hard && git checkout master" &&
+	git checkout -b plain master &&
+	echo aaa >bar &&
+	git add bar &&
+	git commit -m bar_commit &&
+	git checkout -b tagged master &&
+	echo bbb >baz &&
+	git add baz &&
+	git commit -m baz_commit &&
+	git tag -s -m signed_tag_msg signed_tag &&
+	git checkout plain &&
+	git merge --no-ff -m msg signed_tag &&
+	git log --graph --show-signature -n1 plain >actual &&
+	grep "^|\\\  merged tag" actual &&
+	grep "^| | gpg: Signature made" actual &&
+	grep "^| | gpg: Good signature" actual
+'
+
 test_done
-- 
2.0.0
