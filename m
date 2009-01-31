From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] contrib/difftool: Don't repeat merge tool candidates
Date: Sat, 31 Jan 2009 12:27:56 -0800
Message-ID: <1233433676-21944-1-git-send-email-davvid@gmail.com>
Cc: gitster@pobox.com, Markus Heidelberg <markus.heidelberg@web.de>,
	Johannes Gilger <heipei@hackvalue.de>,
	David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 31 21:28:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTMSL-0001WD-94
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 21:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbZAaU1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 15:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752464AbZAaU1U
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 15:27:20 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:62341 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbZAaU1T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 15:27:19 -0500
Received: by rv-out-0506.google.com with SMTP id k40so934332rvb.1
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 12:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=VoqDnS6wRElOAhTy+wZvcRJtU4v26vRruz43Nzy/2yg=;
        b=t/JR9fHA5rlkljODcsK22jb1HhUir1+iIKSoUHc/TI9lHylFGpbCnb3vpUDrhQmlQD
         6/3iIXcP6uCXseFSxx7t08ZEwr1Hf5NyLBtXYDT6F7vlWNfpZZCZrHiDBMyrZfM3ZjmU
         qaa6xsPkLep7e0dOasNcfi8KhX2lKdp+Iv5eA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=X/0EujYtoeQLcA62Ap+CFdPm7XprIBCL59UnG5MxkNY/4mc2IOTtkRSsGGflmxRs+h
         FJ/28+PUZi+LVjsnh1tEg58IE2JcaR1chGhFSGsCqHqDPrGk7NDjQrWZeBablkP5rcoC
         Zmtb2hfXrjfQAGjUhR7Fa7H1aiIUlJS/9Eo9I=
Received: by 10.141.20.7 with SMTP id x7mr487574rvi.119.1233433638340;
        Sat, 31 Jan 2009 12:27:18 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id f42sm2427898rvb.5.2009.01.31.12.27.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 31 Jan 2009 12:27:17 -0800 (PST)
X-Mailer: git-send-email 1.6.1.2.253.ga34a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107937>

git difftool listed some candidates for mergetools twice, depending on
the environment.

This slightly changes the behavior when both KDE_FULL_SESSION and
GNOME_DESKTOP_SESSION_ID are set at the same time; in such a case
meld is used in favor of kdiff3 (the old code favored kdiff3 in such a
case), but it should not matter in practice.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Hi Junio

This is based on top of Markus's kompare patch:
	"contrib/difftool: add support for Kompare"
	http://article.gmane.org/gmane.comp.version-control.git/107883

This syncs difftool up with the mergetool patch that's in 'next':
	"git mergetool: Don't repeat merge tool candidates"
	http://article.gmane.org/gmane.comp.version-control.git/106669


 contrib/difftool/git-difftool-helper |   31 ++++++++++++-------------------
 1 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/contrib/difftool/git-difftool-helper b/contrib/difftool/git-difftool-helper
index 10632a3..db3af6a 100755
--- a/contrib/difftool/git-difftool-helper
+++ b/contrib/difftool/git-difftool-helper
@@ -181,31 +181,24 @@ fi
 
 # Try to guess an appropriate merge tool if no tool has been set.
 if test -z "$merge_tool"; then
-
 	# We have a $DISPLAY so try some common UNIX merge tools
 	if test -n "$DISPLAY"; then
-		merge_tool_candidates="kdiff3 kompare tkdiff xxdiff meld gvimdiff"
-		# If gnome then prefer meld
-		if test -n "$GNOME_DESKTOP_SESSION_ID"; then
-			merge_tool_candidates="meld $merge_tool_candidates"
-		fi
-		# If KDE then prefer kdiff3 or kompare
-		if test "$KDE_FULL_SESSION" = "true"; then
-			merge_tool_candidates="kdiff3 kompare $merge_tool_candidates"
+		# If gnome then prefer meld, otherwise, prefer kdiff3 or kompare
+		if test -n "$GNOME_DESKTOP_SESSION_ID" ; then
+			merge_tool_candidates="meld kdiff3 kompare tkdiff xxdiff gvimdiff"
+		else
+			merge_tool_candidates="kdiff3 kompare tkdiff xxdiff meld gvimdiff"
 		fi
 	fi
-
-	# $EDITOR is emacs so add emerge as a candidate
 	if echo "${VISUAL:-$EDITOR}" | grep 'emacs' > /dev/null 2>&1; then
-		merge_tool_candidates="$merge_tool_candidates emerge"
+		# $EDITOR is emacs so add emerge as a candidate
+		merge_tool_candidates="$merge_tool_candidates emerge opendiff vimdiff"
+	elif echo "${VISUAL:-$EDITOR}" | grep 'vim' > /dev/null 2>&1; then
+		# $EDITOR is vim so add vimdiff as a candidate
+		merge_tool_candidates="$merge_tool_candidates vimdiff opendiff emerge"
+	else
+		merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
 	fi
-
-	# $EDITOR is vim so add vimdiff as a candidate
-	if echo "${VISUAL:-$EDITOR}" | grep 'vim' > /dev/null 2>&1; then
-		merge_tool_candidates="$merge_tool_candidates vimdiff"
-	fi
-
-	merge_tool_candidates="$merge_tool_candidates opendiff emerge vimdiff"
 	echo "merge tool candidates: $merge_tool_candidates"
 
 	# Loop over each candidate and stop when a valid merge tool is found.
-- 
1.6.1.2.253.ga34a
