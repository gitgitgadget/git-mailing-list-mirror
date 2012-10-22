From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 2/3] completion: add new __gitcompadd helper
Date: Mon, 22 Oct 2012 03:45:41 +0200
Message-ID: <1350870342-22653-3-git-send-email-felipe.contreras@gmail.com>
References: <1350870342-22653-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 22 03:46:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQ75o-0002p9-UM
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 03:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932789Ab2JVBqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2012 21:46:00 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49953 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932688Ab2JVBqA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2012 21:46:00 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so1944188wib.1
        for <git@vger.kernel.org>; Sun, 21 Oct 2012 18:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=l7CV3IanXBIa3cuErmbRx47utslCxibh5DTCNcg9NQ0=;
        b=Fi4XKBlo1gsKXsXVufD+bi+oZ+17DqMpobKQ9vCN+Pmr9dpXMAC17ZZcyp+AzxwMS1
         MiB8WGXEiDbr7xMNvYBnVnHO0g9GLj/xDSOXnIRPmoxL0tZQI6J8xm/VtstMIUXtIhO4
         CPDzgipQErTTYfTveHLhvaHtDPfnrgnnVkKNDBUTo7+6QBAQjjmbho2yO/NX2l5MX0OG
         Ya/9l5nlejEoYSm8/b7hyKkc6BxWETYCTIjs83iaYvTbuX9Wm3LbYwwrMq9qM9q7MJYs
         IfCDz9bkYYMMeHvUv/Q9oWzupiFo2SeLJPodJC1WCwhbn/mNduVqlQhOX8B19LoDjr7t
         nGnw==
Received: by 10.180.94.102 with SMTP id db6mr17488395wib.20.1350870358998;
        Sun, 21 Oct 2012 18:45:58 -0700 (PDT)
Received: from localhost (ip-109-43-0-67.web.vodafone.de. [109.43.0.67])
        by mx.google.com with ESMTPS id m14sm48685787wie.8.2012.10.21.18.45.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 21 Oct 2012 18:45:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1350870342-22653-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208172>

The idea is to never touch the COMPREPLY variable directly.

This allows other completion systems override __gitcompadd, and do
something different instead.

Also, this allows the simplification of the completion tests (separate
patch).

There should be no functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7bdd6a8..975ae13 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -225,6 +225,11 @@ _get_comp_words_by_ref ()
 fi
 fi
 
+__gitcompadd ()
+{
+	COMPREPLY=($(compgen -W "$1" -P "$2" -S "$4" -- "$3"))
+}
+
 # Generates completion reply with compgen, appending a space to possible
 # completion words, if necessary.
 # It accepts 1 to 4 arguments:
@@ -241,9 +246,7 @@ __gitcomp ()
 		;;
 	*)
 		local IFS=$'\n'
-		COMPREPLY=($(compgen -P "${2-}" \
-			-W "$(__gitcomp_1 "${1-}" "${4-}")" \
-			-- "$cur_"))
+		__gitcompadd "$(__gitcomp_1 "${1-}" "${4-}")" "${2-}" "$cur_" ""
 		;;
 	esac
 }
@@ -260,7 +263,7 @@ __gitcomp ()
 __gitcomp_nl ()
 {
 	local IFS=$'\n'
-	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
+	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
 }
 
 __git_heads ()
@@ -1603,7 +1606,7 @@ _git_config ()
 		local remote="${prev#remote.}"
 		remote="${remote%.fetch}"
 		if [ -z "$cur" ]; then
-			COMPREPLY=("refs/heads/")
+			__gitcompadd "refs/heads/"
 			return
 		fi
 		__gitcomp_nl "$(__git_refs_remotes "$remote")"
-- 
1.8.0
