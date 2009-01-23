From: Johannes Gilger <heipei@hackvalue.de>
Subject: [PATCHv3] git mergetool: Don't repeat merge tool candidates
Date: Sat, 24 Jan 2009 00:12:45 +0100
Message-ID: <1232752365-23614-1-git-send-email-heipei@hackvalue.de>
References: <7vpridr7vb.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, Johannes Gilger <heipei@hackvalue.de>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 24 00:14:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQVDy-0002TZ-7C
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 00:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757942AbZAWXMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 18:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758002AbZAWXMn
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 18:12:43 -0500
Received: from avalon.gnuzifer.de ([78.46.211.2]:60847 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757830AbZAWXMm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 18:12:42 -0500
Received: from u-6-041.vpn.rwth-aachen.de ([137.226.102.41]:46101 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1LQVCX-0008Bo-Fh; Sat, 24 Jan 2009 00:12:37 +0100
X-Mailer: git-send-email 1.6.1.40.g8ea6a
In-Reply-To: <7vpridr7vb.fsf@gitster.siamese.dyndns.org>
X-Verified-Sender: yes
X-SA-Exim-Connect-IP: 137.226.102.41
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106930>

git mergetool listed some candidates for mergetools twice, depending on
the environment.

Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
---
This improves on v2 of this patch as it appends non-gui merge-tools even 
if $DISPLAY is set. It still makes the assumption that KDE_FULL_SESSION 
and GNOME_DESKTOP_SESSION_ID are never set at the same time. If this 
were to happen the tool would simply prefer meld over kdiff3.

 git-mergetool.sh |   18 ++++++++----------
 1 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 00e1337..09f3a10 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -390,21 +390,19 @@ fi
 
 if test -z "$merge_tool" ; then
     if test -n "$DISPLAY"; then
-        merge_tool_candidates="kdiff3 tkdiff xxdiff meld gvimdiff"
         if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
-            merge_tool_candidates="meld $merge_tool_candidates"
-        fi
-        if test "$KDE_FULL_SESSION" = "true"; then
-            merge_tool_candidates="kdiff3 $merge_tool_candidates"
+            merge_tool_candidates="meld kdiff3 tkdiff xxdiff gvimdiff"
+        else
+            merge_tool_candidates="kdiff3 tkdiff xxdiff meld gvimdiff"
         fi
     fi
     if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
-        merge_tool_candidates="$merge_tool_candidates emerge"
-    fi
-    if echo "${VISUAL:-$EDITOR}" | grep 'vim' > /dev/null 2>&1; then
-        merge_tool_candidates="$merge_tool_candidates vimdiff"
+        merge_tool_candidates="$merge_tool_candidates emerge opendiff vimdiff"
+    elif echo "${VISUAL:-$EDITOR}" | grep 'vim' > /dev/null 2>&1; then
+        merge_tool_candidates="$merge_tool_candidates vimdiff opendiff emerge"
+    else
+        merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
     fi
-    merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
     echo "merge tool candidates: $merge_tool_candidates"
     for i in $merge_tool_candidates; do
         init_merge_tool_path $i
-- 
1.6.1.40.g8ea6a
