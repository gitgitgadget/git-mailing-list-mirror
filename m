From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 7/7] mergetool--lib: Improve show_tool_help() output
Date: Fri, 25 Jan 2013 01:43:54 -0800
Message-ID: <1359107034-14606-8-git-send-email-davvid@gmail.com>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 10:44:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyfpy-00082T-Pc
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 10:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756064Ab3AYJoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 04:44:22 -0500
Received: from mail-ia0-f176.google.com ([209.85.210.176]:46547 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755764Ab3AYJoR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 04:44:17 -0500
Received: by mail-ia0-f176.google.com with SMTP id i18so282291iac.35
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 01:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=9Jvtu6PvOIuj/ZWupON2cPa/HvKFGxfjmICx2g3Uc64=;
        b=rKahATZ9LnP16tiGHv4eg7AgupA0uV8k586NoEFntjlBXoHFkf7CqDS6TyjDu+qQgX
         nDma2aS+juyJDjMoLyUZgNCve6xjSxPqWdjVgurpgTK4uHNzSydlB5DTlwwSU6rSIlBm
         yPpTUJIbxgd4FzqVny0gwRthW+PjLJHiZF80+w7yNxh5ln5G3OyAt1heK1c2L5tMrMwl
         IftxOB4zcrZKq1CcWlWxbofw5kjCw8V5db3PEUzWGaVrGVRVPEg1iSaTkzg1loc71zMs
         PeuRnWWY6YxIXskkJchAlrCt+ThlKJI7I1gz/N1TDr4eOG5Y6Y0SB9xfvIaHlu0gGg6e
         /58Q==
X-Received: by 10.42.162.138 with SMTP id y10mr3087396icx.44.1359107056452;
        Fri, 25 Jan 2013 01:44:16 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id gs6sm314611igc.11.2013.01.25.01.44.14
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 25 Jan 2013 01:44:15 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.367.g22b1720.dirty
In-Reply-To: <1359107034-14606-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214527>

Check the can_diff and can_merge functions before deciding whether to
add the tool to the available/unavailable lists.  This makes --tool-help context-
sensitive so that "git mergetool --tool-help" displays merge tools only
and "git difftool --tool-help" displays diff tools only.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool--lib.sh | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index db8218a..c547c59 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -168,17 +168,33 @@ list_merge_tool_candidates () {
 }
 
 show_tool_help () {
-	list_merge_tool_candidates
 	unavailable= available= LF='
 '
-	for i in $tools
+
+	scriptlets="$(git --exec-path)"/mergetools
+	for i in "$scriptlets"/*
 	do
-		merge_tool_path=$(translate_merge_tool_path "$i")
+		. "$scriptlets"/defaults
+		. "$i"
+
+		tool="$(basename "$i")"
+		if test "$tool" = "defaults"
+		then
+			continue
+		elif merge_mode && ! can_merge
+		then
+			continue
+		elif diff_mode && ! can_diff
+		then
+			continue
+		fi
+
+		merge_tool_path=$(translate_merge_tool_path "$tool")
 		if type "$merge_tool_path" >/dev/null 2>&1
 		then
-			available="$available$i$LF"
+			available="$available$tool$LF"
 		else
-			unavailable="$unavailable$i$LF"
+			unavailable="$unavailable$tool$LF"
 		fi
 	done
 
-- 
1.8.1.1.367.g22b1720.dirty
