From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: [PATCH] mergetool-lib: add new merge tool TortoiseMerge
Date: Sat, 4 Apr 2009 15:18:02 +0200
Message-ID: <200904041518.03325.markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Charles Bailey <charles@hashpling.org>,
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 15:19:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lq5me-0004bI-Se
	for gcvg-git-2@gmane.org; Sat, 04 Apr 2009 15:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbZDDNSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 09:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753690AbZDDNSG
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 09:18:06 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:60400 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbZDDNSF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 09:18:05 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id ABC8EFC79EFB;
	Sat,  4 Apr 2009 15:18:03 +0200 (CEST)
Received: from [89.59.94.8] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lq5l5-00011C-00; Sat, 04 Apr 2009 15:18:03 +0200
User-Agent: KMail/1.9.9
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18vzm6cJ/2kL1nSCnvm1R/Dg7Ux1mwHNeGMuDlf
	0McMipOn8p0oYe4uSMXc9a+dguZMhKK/UEbt/VhCz5CffzVExV
	v/zhQnLF6IqkhSTU+KrQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115585>

TortoiseMerge comes with TortoiseSVN or TortoiseGit for Windows. It can
only be used as a merge tool with an existing base file. It cannot be
used without a base nor as a diff tool.

The documentation only mentions the slash '/' as command line option
prefix, which refused to work, but the parser also accepts the dash '-'

See http://code.google.com/p/msysgit/issues/detail?id=226

Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
---

This patch goes on top of the current difftool/mergetool patches from David.
This is 'da/difftool' in the current 'pu' and in addition:
[PATCH] mergetool-lib: refactor run_mergetool and check_unchanged
[PATCH] mergetool-lib: specialize opendiff options when in diff mode

I couldn't recognize a special order so I put tortoisemerge at the end
of the list.

 git-mergetool--lib.sh |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 6f0e8f7..4ad2cb5 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -51,10 +51,13 @@ check_unchanged () {
 
 valid_tool () {
 	case "$1" in
-	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge | diffuse)
+	kdiff3 | kompare | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | ecmerge | diffuse | tortoisemerge)
 		if test "$1" = "kompare" && ! diff_mode; then
 			return 1
 		fi
+		if test "$1" = "tortoisemerge" && ! merge_mode; then
+			return 1
+		fi
 		;; # happy
 	*)
 		if test -z "$(get_custom_cmd "$1")"; then
@@ -225,6 +228,16 @@ run_mergetool () {
 		fi
 		status=$?
 		;;
+	tortoisemerge)
+		if $base_present; then
+			touch "$BACKUP"
+			"$merge_tool_path" -base:"$BASE" -mine:"$LOCAL" -theirs:"$REMOTE" -merged:"$MERGED"
+			check_unchanged
+		else
+			echo "TortoiseMerge cannot be used without a base" 1>&2
+			status=1
+		fi
+		;;
 	*)
 		if test -n "$merge_tool_cmd"; then
 			if merge_mode &&
-- 
1.6.2.2.428.gea44ab
