From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v4] mergetools: add a plug-in to support DeltaWalker
Date: Mon,  5 Mar 2012 09:28:07 -0500
Message-ID: <1330957687-4313-1-git-send-email-tim.henigan@gmail.com>
Cc: tim.henigan@gmail.com
To: git@vger.kernel.org, gitster@pobox.com, davvid@gmail.com
X-From: git-owner@vger.kernel.org Mon Mar 05 15:28:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Ytj-0004UU-RF
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 15:28:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355Ab2CEO2T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 09:28:19 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49328 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932325Ab2CEO2S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 09:28:18 -0500
Received: by yhmm54 with SMTP id m54so1626691yhm.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 06:28:17 -0800 (PST)
Received-SPF: pass (google.com: domain of tim.henigan@gmail.com designates 10.50.202.69 as permitted sender) client-ip=10.50.202.69;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tim.henigan@gmail.com designates 10.50.202.69 as permitted sender) smtp.mail=tim.henigan@gmail.com; dkim=pass header.i=tim.henigan@gmail.com
Received: from mr.google.com ([10.50.202.69])
        by 10.50.202.69 with SMTP id kg5mr6706247igc.7.1330957697510 (num_hops = 1);
        Mon, 05 Mar 2012 06:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=xJ63d0TR424j4A4gvq3uVQtExb4TFYH9ecU7WGQLi50=;
        b=P9tYF55gRnoxzOhQtTGM6jKqUICLEuRTVMY0RA7pu+bqVrv9lWnFiWwvE8+OvdOINc
         dtx78mjyOfH+csgfBB7QVr/4+KvhSc7RObgI46V3dbzkNUozKzYENFwgpgNB+blrryZa
         nnLj/aZmJRNDTWyudFQy4mQBRFr+AAMe2HJNRmERFFfBT+7bJFWU9oO/JJaXrPgQNfur
         73u3dfPo0rU2SO4RwyeicH83Ljw2Tjkl5j2orlCCnIf8F8OSEZwUjugUNuv6bwpfb8z8
         dvrXc10gl5n23oDXDvHi7ShhTnIEfpJg2RhVRsa5aYfV0goLCCyaa0kkL3JCVaQb9XRJ
         fjzg==
Received: by 10.50.202.69 with SMTP id kg5mr5560610igc.7.1330957697457;
        Mon, 05 Mar 2012 06:28:17 -0800 (PST)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id ba4sm11637191igb.14.2012.03.05.06.28.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Mar 2012 06:28:15 -0800 (PST)
X-Mailer: git-send-email 1.7.9.2.334.g79716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192247>

DeltaWalker is a non-free tool popular among some users.  Add a
plug-in to support it from difftool and mergetool.

Note that the $(pwd)/ in front of $MERGED should not be necessary.
However without it, DeltaWalker crashes with a JRE exception.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
Helped-by: David Aguilar <davvid@gmail.com>
---

Changes in v4:
 - Changed all $PWD to $(pwd)
 - Added comment indicating why $MERGED is prefixed with $(pwd)/
 - Reworded commit message based on feedback from Junio Hamano
 - Added 'Helped-by: David Aguilar' to commit message

Changes in v3:
 - Changed script file name to lowercase to match others in mergetools
 - Added 'translate_merge_tool_path' to deal with difference between
  script file name and the actual name of the tool.

Changes in v2:
 - reworded the commit message
 - moved >/dev/null redirect to after the final fi statement
 - removed the 'status=$?' line at the end of merge_cmd()

Tested with DeltaWalker v1.9.8 on Ubuntu 11.10 and msysgit on Win7.


 mergetools/deltawalker |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 mergetools/deltawalker

diff --git a/mergetools/deltawalker b/mergetools/deltawalker
new file mode 100644
index 0000000..b3c71b6
--- /dev/null
+++ b/mergetools/deltawalker
@@ -0,0 +1,21 @@
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE" >/dev/null 2>&1
+}
+
+merge_cmd () {
+	# Adding $(pwd)/ in front of $MERGED should not be necessary.
+	# However without it, DeltaWalker (at least v1.9.8 on Windows)
+	# crashes with a JRE exception.  The DeltaWalker user manual,
+	# shows $(pwd)/ whenever the '-merged' options is given.
+	# Adding it here seems to work around the problem.
+	if $base_present
+	then
+		"$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" -merged="$(pwd)/$MERGED"
+	else
+		"$merge_tool_path" "$LOCAL" "$REMOTE" -merged="$(pwd)/$MERGED"
+	fi >/dev/null 2>&1
+}
+
+translate_merge_tool_path() {
+	echo DeltaWalker
+}
-- 
1.7.9.2.334.g79716
