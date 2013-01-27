From: John Keeping <john@keeping.me.uk>
Subject: mergetool: include custom tools in '--tool-help'
Date: Sun, 27 Jan 2013 16:34:42 +0000
Message-ID: <20130127163442.GQ7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 17:35:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzVCL-0003Sb-4R
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 17:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286Ab3A0Qew (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 11:34:52 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:40695 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251Ab3A0Qeu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 11:34:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 6D00F22EE9;
	Sun, 27 Jan 2013 16:34:50 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5PtpBtf63k7w; Sun, 27 Jan 2013 16:34:49 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 5CC1E22DB8;
	Sun, 27 Jan 2013 16:34:49 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 3BD3C161E569;
	Sun, 27 Jan 2013 16:34:49 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RxPx1NhVic+6; Sun, 27 Jan 2013 16:34:49 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id AC96B161E564;
	Sun, 27 Jan 2013 16:34:44 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214707>

'git mergetool --tool-help' only lists builtin tools, not those that the
user has configured via a 'mergetool.<tool>.cmd' config value.  Fix this
by inspecting the tools configured in this way and adding them to the
available and unavailable lists before displaying them.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
After the recent changes to mergetool, do we want to do something like
this as well, so that 'git mergetool --tool-help' will display any tools
configured by the user/system administrator?

This is on top of jk/mergetool.

 git-mergetool--lib.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 1d0fb12..f9a617c 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -206,6 +206,29 @@ list_merge_tool_candidates () {
 	esac
 }
 
+# Adds tools from git-config to the available and unavailable lists.
+# The tools are found in "$1.<tool>.cmd".
+add_config_tools() {
+	section=$1
+
+	eval $(git config --get-regexp $section'\..*\.cmd' |
+		while read -r key value
+		do
+			tool=${key#mergetool.}
+			tool=${tool%.cmd}
+
+			tool=$(echo "$tool" |sed -e 's/'\''/'\''\\'\'\''/g')
+
+			cmd=$(eval -- "set -- $value"; echo "$1")
+			if type "$cmd" >/dev/null 2>&1
+			then
+				echo "available=\"\${available}\"'$tool'\"\$LF\""
+			else
+				echo "unavailable=\"\${unavailable}\"'$tool'\"\$LF\""
+			fi
+		done)
+}
+
 show_tool_help () {
 	unavailable= available= LF='
 '
@@ -223,6 +246,12 @@ show_tool_help () {
 		fi
 	done
 
+	add_config_tools mergetool
+	if diff_mode
+	then
+		add_config_tools difftool
+	fi
+
 	cmd_name=${TOOL_MODE}tool
 	if test -n "$available"
 	then
-- 
1.8.1.1
