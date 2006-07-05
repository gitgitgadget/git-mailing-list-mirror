From: A Large Angry SCM <gitzilla@gmail.com>
Subject: [PATCH] Additional merge-base tests (revised)
Date: Tue, 04 Jul 2006 17:35:20 -0700
Message-ID: <44AB0948.9070606@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jul 05 02:35:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxvMZ-0002Gq-Al
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 02:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWGEAfY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 20:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWGEAfY
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 20:35:24 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:43198 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932356AbWGEAfX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 20:35:23 -0400
Received: by wr-out-0506.google.com with SMTP id 69so842360wra
        for <git@vger.kernel.org>; Tue, 04 Jul 2006 17:35:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=LIH+EY3i5WqoxGGP1LwxxEQ72Xgk+sbvDKmJb8w90Tuw/MEQB2I5TXi2VgZsddEl+Awf1tJz9mQA8ufjpAjjyD2Lm3swEJ3oiwH4fyHJRD4xg/SqXy0pdElS/IGMqip9kvaqVdeSpJuTLMkUBsABUrzj8mGUmntPsiqHQgjWa48=
Received: by 10.64.210.8 with SMTP id i8mr3191390qbg;
        Tue, 04 Jul 2006 17:35:23 -0700 (PDT)
Received: from ?10.0.0.6? ( [69.160.147.208])
        by mx.gmail.com with ESMTP id 1sm2851504qbh.2006.07.04.17.35.22;
        Tue, 04 Jul 2006 17:35:22 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23333>

Signed-off-by: A Large Angry SCM <gitzilla@gmail.com>
---
This demonstrates a problem with git-merge-base.

This is a slightly revised version of the same patch as before.

 t/t6010-merge-base.sh |   45 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+)

diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index 1dce123..2b7b51c 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -44,6 +44,43 @@ A=$(doit 1 A $B)
 G=$(doit 7 G $B $E)
 H=$(doit 8 H $A $F)
 
+# Setup for second test to demonstrate that relying on timestamps in a
+# distributed SCM to provide a _consistent_ partial ordering of commits
+# leads to insanity.
+#
+#               Relative
+# Structure     timestamps
+#
+#   PL  PR        +4  +4
+#  /  \/  \      /  \/  \
+# L2  C2  R2    +3  -1  +3
+# |   |   |     |   |   |
+# L1  C1  R1    +2  -2  +2
+# |   |   |     |   |   |
+# L0  C0  R0    +1  -3  +1
+#   \ |  /        \ |  /
+#     S             0
+#
+# The left and right chains of commits can be of any length and complexity as
+# long as all of the timestamps are greater than that of S.
+
+S=$(doit  0 S)
+
+C0=$(doit -3 C0 $S)
+C1=$(doit -2 C1 $C0)
+C2=$(doit -1 C2 $C1)
+
+L0=$(doit  1 L0 $S)
+L1=$(doit  2 L1 $L0)
+L2=$(doit  3 L2 $L1)
+
+R0=$(doit  1 R0 $S)
+R1=$(doit  2 R1 $R0)
+R2=$(doit  3 R2 $R1)
+
+PL=$(doit  4 PL $L2 $C2)
+PR=$(doit  4 PR $C2 $R2)
+
 test_expect_success 'compute merge-base (single)' \
     'MB=$(git-merge-base G H) &&
      expr "$(git-name-rev "$MB")" : "[0-9a-f]* tags/B"'
@@ -56,4 +93,12 @@ test_expect_success 'compute merge-base 
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
