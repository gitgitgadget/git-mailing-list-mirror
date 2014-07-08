From: Zoltan Klinger <zoltan.klinger@gmail.com>
Subject: [PATCH] log: fix indentation for --graph --show-signature
Date: Tue,  8 Jul 2014 21:12:28 +1000
Message-ID: <1404817948-7794-1-git-send-email-zoltan.klinger@gmail.com>
Cc: jpyeron@pdinc.us, gitster@pobox.com,
	Zoltan Klinger <zoltan.klinger@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 13:15:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4TN4-00032r-5G
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 13:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbaGHLPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 07:15:34 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33271 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139AbaGHLPd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 07:15:33 -0400
Received: by mail-pa0-f45.google.com with SMTP id rd3so7143264pab.4
        for <git@vger.kernel.org>; Tue, 08 Jul 2014 04:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=5LtiUv6hTqDMlurd6zDbct8P9aot6cdi6BW3DdNNL4U=;
        b=aAwjX0sX4DypEfyV+wsqrmROmVCrG7CxgPCxM73yWhIzJsg3wMV4g3YLlxW1VSzLlj
         kK43Kqqf+YCvhKMoVzucEeTNYvO8CKUXCZP2MOiTXiHBrRxYPxbM+S0rgzesYeJ36rK7
         0j1opxURxIczYztn4CToD3wVBYXDy3EZFbUdpmbh/e08zb/5NB8fzubtW1ma3l/1zakm
         PjOX/eqNpA7lCsgR7FOYl2VkddiLLOTzmMFSRAvZ/Es7bFhgFeP8FclXDL9AYkShRLiG
         QOkZe1Yp4KlNCYH3S/QVB4G5Fgy3cXEqCG6SrEEFxf+5gBNexUPB3FNf12T3j4ufJBGO
         U6hw==
X-Received: by 10.68.213.34 with SMTP id np2mr13683pbc.167.1404818132787;
        Tue, 08 Jul 2014 04:15:32 -0700 (PDT)
Received: from localhost.localdomain (ppp121-44-139-46.lns20.syd7.internode.on.net. [121.44.139.46])
        by mx.google.com with ESMTPSA id cc8sm3570148pdb.57.2014.07.08.04.15.30
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 08 Jul 2014 04:15:32 -0700 (PDT)
X-Mailer: git-send-email 2.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253011>

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
 log-tree.c     |  1 +
 t/t4202-log.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

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
index cb03d28..b429aff 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -3,6 +3,7 @@
 test_description='git log'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 test_expect_success setup '
 
@@ -841,4 +842,32 @@ test_expect_success 'dotdot is a parent directory' '
 	test_cmp expect actual
 '
 
+test_expect_success GPG 'log --graph --show-signature' '
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
+	git checkout -b plain master &&
+	echo aaa >bar &&
+	git add bar &&
+	git commit -m bar_commit
+	git checkout -b tagged master &&
+	echo bbb >baz &&
+	git add baz &&
+	git commit -m baz_commit
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
