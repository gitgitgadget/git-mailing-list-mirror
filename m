From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 3/3] difftool: Use eval to expand '--extcmd' expressions
Date: Fri, 15 Jan 2010 14:03:44 -0800
Message-ID: <1263593024-12093-3-git-send-email-davvid@gmail.com>
References: <1263593024-12093-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, j.sixt@viscovery.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 15 23:04:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVuHE-0002qB-K3
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 23:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758063Ab0AOWEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 17:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123Ab0AOWEK
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 17:04:10 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:40612 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758035Ab0AOWEI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 17:04:08 -0500
Received: by mail-ew0-f209.google.com with SMTP id 1so608290ewy.28
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 14:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=JXMp3WYBIW26I+4O6p9dHMmio9wdAGoz7Oy6XEH5bIc=;
        b=pWjbaRDl+HeYzKTemh9FHQpSD5jJEN6AlfTmPecyYxrWhg+bKo49Hj8zO5I42HPmNG
         OnTTBPqAJ7VedD3SsyiIMPM5NRZcrfiGXxYb+E0/zm8g4HQ28VH7JQebxF3uHyNdt9ZJ
         cktm+CHDIYvg2IwXuG3AFKs19tPi0rAYQ4jns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hPIqfMw/N2HPYR2ZUUrWMF/3N14iTAF/TGVtfXB66EXh+vkgTYzz+iawsQAg/vdrv3
         mzShcIH3EAzxIoXjR69c1mDAVU2EusKAlGYZYwXQQPRSH/shA5tE6rOZIuXn63Zgr4Ts
         QymM/30SS1N5h2WL3pcIispkOOAfalwb/LVeo=
Received: by 10.213.99.81 with SMTP id t17mr232384ebn.53.1263593047302;
        Fri, 15 Jan 2010 14:04:07 -0800 (PST)
Received: from localhost (isrfasc7a1-gw.disneyanimation.com [12.188.26.241])
        by mx.google.com with ESMTPS id 10sm1149991eyd.29.2010.01.15.14.04.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Jan 2010 14:04:06 -0800 (PST)
X-Mailer: git-send-email 1.6.6.9.g8dfa7
In-Reply-To: <1263593024-12093-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137136>

It was not possible to pass quoted commands to '--extcmd'.
By using 'eval' we ensure that expressions with spaces and
quotes are supported.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Updates since v1:
* Uses a more readable quoting style as suggested by J6t.
* We no longer use a subshell.

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
+		eval $GIT_DIFFTOOL_EXTCMD '"$LOCAL"' '"$REMOTE"'
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
