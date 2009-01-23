From: Johannes Gilger <heipei@hackvalue.de>
Subject: [PATCHv2] git mergetool: Don't repeat merge tool candidates
Date: Fri, 23 Jan 2009 10:14:53 +0100
Message-ID: <1232702093-24313-1-git-send-email-heipei@hackvalue.de>
References: <7v7i4m1lq4.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, tytso@mit.edu,
	Johannes Gilger <heipei@hackvalue.de>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jan 23 10:16:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQI9E-0001Q7-Ir
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 10:16:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbZAWJO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 04:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753228AbZAWJO4
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 04:14:56 -0500
Received: from avalon.gnuzifer.de ([78.46.211.2]:57837 "EHLO
	avalon.gnuzifer.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbZAWJOz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 04:14:55 -0500
Received: from u-6-031.vpn.rwth-aachen.de ([137.226.102.31]:60549 helo=localhost)
	by avalon.gnuzifer.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <heipei@hackvalue.de>)
	id 1LQI7e-0001kI-GZ; Fri, 23 Jan 2009 10:14:42 +0100
X-Mailer: git-send-email 1.6.1.40.g8ea6a
In-Reply-To: <7v7i4m1lq4.fsf@gitster.siamese.dyndns.org>
X-Verified-Sender: yes
X-SA-Exim-Connect-IP: 137.226.102.31
X-SA-Exim-Mail-From: heipei@hackvalue.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106867>

git mergetool listed some candidates for mergetools twice, depending on
the environment.

Signed-off-by: Johannes Gilger <heipei@hackvalue.de>
---
The first patch had the fatal flaw that it listed nothing when DISPLAY 
and EDITOR/VISUAL were unset, we fixed that.
The order in which merge-candidates appear is still exactly the same, 
only duplicates have been stripped. The check for KDE_FULL_SESSION was 
removed since kdiff3 was added as long as DISPLAY was set and we weren't 
running gnome.

 git-mergetool.sh |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 00e1337..acdcffb 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -390,21 +390,21 @@ fi
 
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
+        merge_tool_candidates="$merge_tool_candidates emerge opendiff vimdiff"
     fi
     if echo "${VISUAL:-$EDITOR}" | grep 'vim' > /dev/null 2>&1; then
-        merge_tool_candidates="$merge_tool_candidates vimdiff"
+        merge_tool_candidates="$merge_tool_candidates vimdiff opendiff emerge"
+    fi
+    if test -z "$merge_tool_candidates" ; then
+        merge_tool_candidates="opendiff emerge vimdiff"
     fi
-    merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
     echo "merge tool candidates: $merge_tool_candidates"
     for i in $merge_tool_candidates; do
         init_merge_tool_path $i
-- 
1.6.1.40.g8ea6a
