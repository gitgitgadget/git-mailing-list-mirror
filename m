From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 3/3] difftool: Use eval to expand '--extcmd' expressions
Date: Thu, 14 Jan 2010 23:16:02 -0800
Message-ID: <1263539762-8269-3-git-send-email-davvid@gmail.com>
References: <1263539762-8269-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 15 08:20:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVgTw-0002ja-JI
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 08:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491Ab0AOHQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 02:16:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415Ab0AOHQT
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 02:16:19 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:44225 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378Ab0AOHQS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 02:16:18 -0500
Received: by mail-yx0-f188.google.com with SMTP id 26so224339yxe.4
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 23:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4fON0xn4P1qRxCIvIh4O2wOdpre/2g0bm4pXxrq8XrE=;
        b=VIA/lz49YmSX6QWL0JK/ZN5vJz5J3kFP6DEGNNpChaiiyx1huHA5fCqSI4NzcqgHjl
         jRxrCBBRg4Fdm7Cg4zXI/bLZAACbYA20GdqezCHcjTYkZT1/CAM2lNMwJg6nOZtQmKdm
         r0gFSOI8w7WFrf0MDOGJaRpLShpuog/1qI37Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pBjb0uO1t6nhAC+qDDO6bonQ/VdkdxMO9qFPHyEG8ce2+y3JRRVu11uCh3FjJxKkfi
         qFFSd9ix2/WuZoe7dgH5Dr2tv0j9dQRJJ8RFtsUGk6AlRZXkZNovev1EdP7Gh9hj5eQV
         XquvmglPnaTR1LYxi7SDCwRa0GUr/V6t8h6m0=
Received: by 10.150.237.9 with SMTP id k9mr165796ybh.108.1263539777871;
        Thu, 14 Jan 2010 23:16:17 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 4sm610931ywd.14.2010.01.14.23.16.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Jan 2010 23:16:17 -0800 (PST)
X-Mailer: git-send-email 1.6.6.196.g1f735
In-Reply-To: <1263539762-8269-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137055>

It was not possible to pass quoted commands to '--extcmd'.
By using 'eval' we ensure that expressions with spaces and
quotes are supported.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-difftool--helper.sh |    3 +--
 t/t7800-difftool.sh     |   13 +++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
index d806eae..a1c5c09 100755
--- a/git-difftool--helper.sh
+++ b/git-difftool--helper.sh
@@ -48,11 +48,10 @@ launch_merge_tool () {
 	fi
 
 	if use_ext_cmd; then
-		$GIT_DIFFTOOL_EXTCMD "$LOCAL" "$REMOTE"
+		(eval $GIT_DIFFTOOL_EXTCMD "\"$LOCAL\"" "\"$REMOTE\"")
 	else
 		run_merge_tool "$merge_tool"
 	fi
-
 }
 
 if ! use_ext_cmd; then
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 69e1c34..a183f1d 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -235,8 +235,21 @@ test_expect_success 'difftool --extcmd cat' '
 test_expect_success 'difftool -x cat' '
 	diff=$(git difftool --no-prompt -x cat branch) &&
 	test "$diff" = branch"$LF"master
+'
+
+test_expect_success 'difftool --extcmd echo arg1' '
+	diff=$(git difftool --no-prompt --extcmd sh\ -c\ \"echo\ \$1\" branch)
+	test "$diff" = file
+'
 
+test_expect_success 'difftool --extcmd cat arg1' '
+	diff=$(git difftool --no-prompt --extcmd sh\ -c\ \"cat\ \$1\" branch)
+	test "$diff" = master
+'
 
+test_expect_success 'difftool --extcmd cat arg2' '
+	diff=$(git difftool --no-prompt --extcmd sh\ -c\ \"cat\ \$2\" branch)
+	test "$diff" = branch
 '
 
 test_done
-- 
1.6.6.6.g627fb.dirty
