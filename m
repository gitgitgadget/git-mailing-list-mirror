From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 4/4] mergetools/meld: Use '--output' when available
Date: Thu, 18 Aug 2011 00:23:47 -0700
Message-ID: <1313652227-48545-5-git-send-email-davvid@gmail.com>
References: <1313652227-48545-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>,
	Charles Bailey <charles@hashpling.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 09:24:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtwxr-0005Ui-9E
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 09:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185Ab1HRHYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 03:24:18 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:33028 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166Ab1HRHYN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 03:24:13 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so3440638iye.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 00:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6K13+cHuFxX6T5oQipWiVT5PqL7wVGiJOE2aWMMsqa0=;
        b=sa+e25HugUbvSNhxrRmZGrfYH0isUvjZOBXkMUeoH+cSSBWsyFJrmzdDUr2hTcMRgn
         jgvifCEFPYQ3d3rgv7/hZB7N+mIkCipwvBQwXMYPkxnIA6hAPtRVCBIRycKqRRIRoynp
         hccgUgASm8J2bXONPEX2b45G9N1f9QL/nxb1w=
Received: by 10.42.147.68 with SMTP id m4mr425482icv.282.1313652253380;
        Thu, 18 Aug 2011 00:24:13 -0700 (PDT)
Received: from localhost.localdomain (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id hq1sm1677692icc.14.2011.08.18.00.24.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 00:24:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.476.g57292
In-Reply-To: <1313652227-48545-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179575>

meld 1.5.0 and newer allow the output file to be specified
when merging multiple files.  Check the meld version and use
the '--output' option when available.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 mergetools/meld |   33 ++++++++++++++++++++++++++++++++-
 1 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/mergetools/meld b/mergetools/meld
index 73d70ae..1923797 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -4,6 +4,37 @@ diff_cmd () {
 
 merge_cmd () {
 	touch "$BACKUP"
-	"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
+	if test "$meld_has_output_option" = true
+	then
+		"$merge_tool_path" --output "$MERGED" \
+			"$BASE" "$LOCAL" "$REMOTE"
+	else
+		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
+	fi
 	check_unchanged
 }
+
+check_meld_version () {
+	if test -n "$meld_version_checked"
+	then
+		return
+	fi
+	# Whether 'meld --output <file>' is supported
+	meld_has_output_option=false
+
+	# Filter meld --version to contain numbers and dots only
+	meld="$(meld --version 2>/dev/null | sed -e 's/[^0-9.]\+//g')"
+	meld="${meld:-0.0.0}"
+
+	meld_major="$(expr "$meld" : '\([0-9]\{1,\}\)' || echo 0)"
+	meld_minor="$(expr "$meld" : '[0-9]\{1,\}\.\([0-9]\{1,\}\)' || echo 0)"
+
+	# 'meld --output <file>' was introduced in meld 1.5.0
+	if test "$meld_major" -gt 1 ||
+		(test "$meld_major" = 1 && test "$meld_minor" -ge 5)
+	then
+		meld_has_output_option=true
+	fi
+	meld_version_checked=true
+}
+check_meld_version
-- 
1.7.6.476.g57292
