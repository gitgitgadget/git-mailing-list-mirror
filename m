From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: cleanup __gitcomp*
Date: Mon, 30 Jan 2012 02:29:31 +0200
Message-ID: <1327883371-25573-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 01:30:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrf8R-0007MN-9Q
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 01:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786Ab2A3AaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 19:30:08 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:60065 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526Ab2A3AaG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 19:30:06 -0500
Received: by werb13 with SMTP id b13so3008331wer.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 16:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=0fPgPLDiznHqDdRiL/hwrldG0LInXGi5xDdQIdwYFFY=;
        b=vASQXODxPyPDfptHePE8eOuMkIqfK6ifxaE1FlOnX/KYnNHXDiJn51wxVydE6h7vuy
         wTKV9Wa6h3oD03P2BO8GnvJ2yVIefz/TckOTnX21Ow/jiLwCEOrYgz9Sz4dGxiwsSjeL
         Usyz85JevNL6Box3WVIDniXfDFzW738qYfF/g=
Received: by 10.216.135.76 with SMTP id t54mr6330781wei.14.1327883405672;
        Sun, 29 Jan 2012 16:30:05 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi. [91.153.253.80])
        by mx.google.com with ESMTPS id ho4sm26737078wib.3.2012.01.29.16.30.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jan 2012 16:30:04 -0800 (PST)
X-Mailer: git-send-email 1.7.8.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189311>

I don't know why there's so much code; these functions don't seem to be
doing much:

 * ${1-} is the same as $1
 * no need to check $#, ${3:-$cur} is much easier
 * __gitcomp_nl doesn't seem to using the initial IFS

This makes the code much simpler.

Eventually it would be nice to wrap everything that touches compgen and
COMPREPLY in one function for the zsh wrapper.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |   24 +++++-------------------
 1 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1496c6d..accfce5 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -495,19 +495,15 @@ fi
 # 4: A suffix to be appended to each possible completion word (optional).
 __gitcomp ()
 {
-	local cur_="$cur"
-
-	if [ $# -gt 2 ]; then
-		cur_="$3"
-	fi
+	local cur_="${3:-$cur}"
 	case "$cur_" in
 	--*=)
 		COMPREPLY=()
 		;;
 	*)
 		local IFS=$'\n'
-		COMPREPLY=($(compgen -P "${2-}" \
-			-W "$(__gitcomp_1 "${1-}" "${4-}")" \
+		COMPREPLY=($(compgen -P "$2" \
+			-W "$(__gitcomp_1 "$1" "$4")" \
 			-- "$cur_"))
 		;;
 	esac
@@ -524,18 +520,8 @@ __gitcomp ()
 #    appended.
 __gitcomp_nl ()
 {
-	local s=$'\n' IFS=' '$'\t'$'\n'
-	local cur_="$cur" suffix=" "
-
-	if [ $# -gt 2 ]; then
-		cur_="$3"
-		if [ $# -gt 3 ]; then
-			suffix="$4"
-		fi
-	fi
-
-	IFS=$s
-	COMPREPLY=($(compgen -P "${2-}" -S "$suffix" -W "$1" -- "$cur_"))
+	local IFS=$'\n'
+	COMPREPLY=($(compgen -P "$2" -S "${4:- }" -W "$1" -- "${3:-$cur}"))
 }
 
 __git_heads ()
-- 
1.7.8.3
