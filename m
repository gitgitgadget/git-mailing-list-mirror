From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH v3] mergetools: add support for DeltaWalker
Date: Sat,  3 Mar 2012 11:56:34 -0500
Message-ID: <1330793794-5376-1-git-send-email-tim.henigan@gmail.com>
Cc: tim.henigan@gmail.com
To: git@vger.kernel.org, gitster@pobox.com, davvid@gmail.com
X-From: git-owner@vger.kernel.org Sat Mar 03 17:57:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3sGc-0008Vm-Am
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 17:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319Ab2CCQ4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 11:56:36 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51992 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970Ab2CCQ4g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 11:56:36 -0500
Received: by iagz16 with SMTP id z16so3658388iag.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 08:56:35 -0800 (PST)
Received-SPF: pass (google.com: domain of tim.henigan@gmail.com designates 10.42.168.197 as permitted sender) client-ip=10.42.168.197;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tim.henigan@gmail.com designates 10.42.168.197 as permitted sender) smtp.mail=tim.henigan@gmail.com; dkim=pass header.i=tim.henigan@gmail.com
Received: from mr.google.com ([10.42.168.197])
        by 10.42.168.197 with SMTP id x5mr9755377icy.6.1330793795713 (num_hops = 1);
        Sat, 03 Mar 2012 08:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ExgFx8t/lN7FONV8Kf6JGu/LWECbaDwjB4wzllzpTfQ=;
        b=n+mFBCcJ90zpwvTG4Lh2/kyuYOfGSDyNN3EdTVpO6BWYb+CW02RbrfUKdCGHmcKP9O
         3affFxwlyteB0cX8olsSbjSLVtkA0u6PCT9lLCh0dA2Ra7v0QoXe3QPqZsyHwBlgMVcX
         wl6xTrlnXVVwGCHwdMvQtFeC14zDbhJErZohvgKjW6REOd7xM2vS2DblHX9+gb/GiR8Q
         CCJ5cbxNpzW/ODVp+dthbMx2OmSUgti4gzRJGlv0PYGjJtuc1v5tIKGUGOowwIkUp2CO
         uBO+YsM5Lv+OuLBJ5/mwYvZP8kQjWLNPaLsBR3uqkVOOpxvFi02fbpoPQf6eRRRICGh5
         vQWg==
Received: by 10.42.168.197 with SMTP id x5mr8018392icy.6.1330793795670;
        Sat, 03 Mar 2012 08:56:35 -0800 (PST)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id mi10sm5516857igc.8.2012.03.03.08.56.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 08:56:35 -0800 (PST)
X-Mailer: git-send-email 1.7.9.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192117>

Thanks to bc7a96a8965d, it is possible to integrate new external
diff/merge tools by adding a simple shell script at mergetools/$tool.

This commit adds DeltaWalker support.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---

Changes in v3:
  - Changed script file name to lowercase to match others in mergetools
  - Added 'translate_merge_tool_path' to deal with difference between
    script file name and the actual name of the tool.

Changes in v2:
  - reworded the commit message
  - moved >/dev/null redirect to after the final fi statement
  - removed the 'status=$?' line at the end of merge_cmd()

Tested with DeltaWalker v1.9.8 on Ubuntu 11.10 and msysgit on Win7.


 mergetools/deltawalker |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 mergetools/deltawalker

diff --git a/mergetools/deltawalker b/mergetools/deltawalker
new file mode 100644
index 0000000..aba2130
--- /dev/null
+++ b/mergetools/deltawalker
@@ -0,0 +1,16 @@
+diff_cmd () {
+	"$merge_tool_path" "$LOCAL" "$REMOTE" >/dev/null 2>&1
+}
+
+merge_cmd () {
+	if $base_present
+	then
+		"$merge_tool_path" "$LOCAL" "$REMOTE" "$BASE" -merged="$PWD/$MERGED"
+	else
+		"$merge_tool_path" "$LOCAL" "$REMOTE" -merged="$PWD/$MERGED"
+	fi >/dev/null 2>&1
+}
+
+translate_merge_tool_path() {
+	echo DeltaWalker
+}
-- 
1.7.9.GIT
