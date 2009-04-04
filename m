From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] mergetool-lib: make (g)vimdiff workable under Windows
Date: Sat, 4 Apr 2009 15:17:54 +0200
Message-ID: <200904041517.55890.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Charles Bailey <charles@hashpling.org>,
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 15:19:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lq5me-0004bI-4a
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 15:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753448AbZDDNSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 09:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbZDDNSA
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 09:18:00 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:60293 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906AbZDDNR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 09:17:59 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id DC85BFC79E54;
	Sat,  4 Apr 2009 15:17:56 +0200 (CEST)
Received: from [89.59.94.8] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lq5ky-0007WU-00; Sat, 04 Apr 2009 15:17:56 +0200
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+vL2QpplOgfiJdlai6QJ923oUWw2Y8mX7Ybmmi
	KqEahZCWlcf/RHjcY+07qV3kaPW0T8C4qc28PePMtlY/8a029b
	qGVZGsPx1wD6LjPA69sA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115584>

Under Windows vimdiff and gvimdiff are not available as symbolic links,
but as batch files vimdiff.bat and gvimdiff.bat. These files weren't
found by 'type vimdiff' which led to the following error:

    The merge tool vimdiff is not available as 'vimdiff'

Even if they were found, it wouldn't work to invoke these batch files
from git-mergetool.

To solve this, use vim and gvim (vim.exe and gvim.exe) and pass the -d
command line switch over to them.

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

This patch goes on top of the current difftool/mergetool patches from David.
This is 'da/difftool' in the current 'pu' and in addition:
[PATCH] mergetool-lib: refactor run_mergetool and check_unchanged
[PATCH] mergetool-lib: specialize opendiff options when in diff mode

 git-mergetool--lib.sh |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index b8566b2..6f0e8f7 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -11,6 +11,12 @@ get_merge_tool_path () {
 	path="$1"
 	if test -z "$2"; then
 		case "$1" in
+		vimdiff)
+			path=vim
+			;;
+		gvimdiff)
+			path=gvim
+			;;
 		emerge)
 			path=emacs
 			;;
@@ -142,19 +148,19 @@ run_mergetool () {
 	vimdiff)
 		if merge_mode; then
 			touch "$BACKUP"
-			"$merge_tool_path" -c "wincmd l" "$LOCAL" "$MERGED" "$REMOTE"
+			"$merge_tool_path" -d -c "wincmd l" "$LOCAL" "$MERGED" "$REMOTE"
 			check_unchanged
 		else
-			"$merge_tool_path" -c "wincmd l" "$LOCAL" "$REMOTE"
+			"$merge_tool_path" -d -c "wincmd l" "$LOCAL" "$REMOTE"
 		fi
 		;;
 	gvimdiff)
 		if merge_mode; then
 			touch "$BACKUP"
-			"$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$MERGED" "$REMOTE"
+			"$merge_tool_path" -d -c "wincmd l" -f "$LOCAL" "$MERGED" "$REMOTE"
 			check_unchanged
 		else
-			"$merge_tool_path" -c "wincmd l" -f "$LOCAL" "$REMOTE"
+			"$merge_tool_path" -d -c "wincmd l" -f "$LOCAL" "$REMOTE"
 		fi
 		;;
 	xxdiff)
-- 
1.6.2.2.428.gea44ab
