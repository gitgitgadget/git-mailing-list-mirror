From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [PATCH] Additional merge-base tests
Date: Mon, 03 Jul 2006 20:55:26 -0700
Message-ID: <44A9E6AE.10508@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Jul 04 05:55:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fxc0w-0004ma-BE
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 05:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWGDDzo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 23:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWGDDzo
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 23:55:44 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:28409 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750895AbWGDDzn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 23:55:43 -0400
Received: by py-out-1112.google.com with SMTP id c39so1485135pyd
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 20:55:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=XVk2QQeXqfAbWvBYlXLMHOuYar83VB9IwRF0x9JfVnvYu/PR+MdDMpNc1MK9iZheAG6TyqKwplDQLLlJfjdZXqqzrSVafFviMsaSTlqG4bQfAdZfrznaoF8MF/nDA9ajq5DJtyv68i/lcCUHWHya3amSm378OOM4c77UI0DaDOI=
Received: by 10.35.37.18 with SMTP id p18mr1698719pyj;
        Mon, 03 Jul 2006 20:55:33 -0700 (PDT)
Received: from ?10.0.0.6? ( [69.160.147.208])
        by mx.gmail.com with ESMTP id q36sm44047pyg.2006.07.03.20.55.32;
        Mon, 03 Jul 2006 20:55:33 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23245>

Signed-off-by: A Large Angry SCM <gitzilla@gmail.com>
---
This demonstrates a problem with git-merge-base.

 t6010-merge-base.sh |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+)

diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 1dce123..9a815bd 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -44,6 +44,31 @@ A=$(doit 1 A $B)
 G=$(doit 7 G $B $E)
 H=$(doit 8 H $A $F)
 
+# Setup for second test set
+#
+#   PL  PR
+#  /  \/  \
+# L2  C2  R2
+# |   |   |
+# L1  C1  R1
+# |   |   |
+# L0  C0  R0
+#   \ |  /
+#     S
+
+S=$(doit  0 S)
+C0=$(doit -3 C0 $S)
+L0=$(doit  2 L0 $S)
+R0=$(doit  2 R0 $S)
+C1=$(doit -2 C1 $C0)
+L1=$(doit  3 L1 $L0)
+R1=$(doit  3 R1 $R0)
+C2=$(doit -1 C2 $C1)
+L2=$(doit  4 L2 $L1)
+R2=$(doit  4 R2 $R1)
+PL=$(doit  1 PL $L2 $C2)
+PR=$(doit  1 PR $C2 $R2)
+
 test_expect_success 'compute merge-base (single)' \
     'MB=$(git-merge-base G H) &&
      expr "$(git-name-rev "$MB")" : "[0-9a-f]* tags/B"'
@@ -56,4 +81,12 @@ test_expect_success 'compute merge-base 
     'MB=$(git-show-branch --merge-base G H) &&
      expr "$(git-name-rev "$MB")" : "[0-9a-f]* tags/B"'
 
+test_expect_success 'compute merge-base (single)' \
+    'MB=$(git-merge-base PL PR) &&
+     expr "$(git-name-rev "$MB")" : "[0-9a-f]* tags/C2"'
+
+test_expect_success 'compute merge-base (all)' \
+    'MB=$(git-merge-base --all PL PR) &&
+     expr "$(git-name-rev "$MB")" : "[0-9a-f]* tags/C2"'
+
 test_done
