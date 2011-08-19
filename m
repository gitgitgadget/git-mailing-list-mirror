From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 4/4] mergetools/meld: Use '--output' when available
Date: Fri, 19 Aug 2011 02:14:45 -0700
Message-ID: <20110819091444.GB18054@gmail.com>
References: <1313652227-48545-1-git-send-email-davvid@gmail.com>
 <1313652227-48545-5-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>,
	Charles Bailey <charles@hashpling.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 19 11:14:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuLAH-0008CA-3z
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 11:14:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752414Ab1HSJOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 05:14:52 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:61000 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab1HSJOv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 05:14:51 -0400
Received: by yie30 with SMTP id 30so2067854yie.19
        for <git@vger.kernel.org>; Fri, 19 Aug 2011 02:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IeFvDXTuRe/+zChkzA5M6CBEQEG8/eEwuXm617XRe5Q=;
        b=AMFsUMOsciz3goSoh5GW9zm0X0OVvDHC9KTGkglrYwliNi2n6KsD30iLfBtBXGnarE
         SEZXNXv6OcvVzInXcFb6n+qft0Sk+1OpGYLa1sP4H6WZST3hSy637F1O62uMwSNaW8WK
         xPRo4z2EIfAQFEhOIGzAaQ0e4ipcCmZa+z5Zs=
Received: by 10.236.182.4 with SMTP id n4mr5575815yhm.90.1313745291347;
        Fri, 19 Aug 2011 02:14:51 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id b4sm634022iba.15.2011.08.19.02.14.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 19 Aug 2011 02:14:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313652227-48545-5-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179686>

meld 1.5.0 and newer allow the output file to be specified
when merging multiple files.  Check whether the meld command
supports '--output' and use it when available.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 mergetools/meld |   25 ++++++++++++++++++++++++-
 1 files changed, 24 insertions(+), 1 deletions(-)

Changes since v1 with help from Jonathan Nieder:

Use $LOCAL $BASE REMOTE when calling meld.
Avoid shell portability issues by using the return status.
of --output instead of parsing --version.

diff --git a/mergetools/meld b/mergetools/meld
index 73d70ae..eaa115c 100644
--- a/mergetools/meld
+++ b/mergetools/meld
@@ -3,7 +3,30 @@ diff_cmd () {
 }
 
 merge_cmd () {
+	if test -z "${meld_has_output_option:+set}"
+	then
+		check_meld_for_output_version
+	fi
 	touch "$BACKUP"
-	"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
+	if test "$meld_has_output_option" = true
+	then
+		"$merge_tool_path" --output "$MERGED" \
+			"$LOCAL" "$BASE" "$REMOTE"
+	else
+		"$merge_tool_path" "$LOCAL" "$MERGED" "$REMOTE"
+	fi
 	check_unchanged
 }
+
+# Check whether 'meld --output <file>' is supported
+check_meld_for_output_version () {
+	meld_path="$(git config mergetool.meld.path)"
+	meld_path="${meld_path:-meld}"
+
+	if "$meld_path" --output /dev/null --help >/dev/null 2>&1
+	then
+		meld_has_output_option=true
+	else
+		meld_has_output_option=false
+	fi
+}
-- 
1.7.6.553.g1899
