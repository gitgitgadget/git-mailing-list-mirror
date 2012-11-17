From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 2/5] completion: add new __gitcompadd helper
Date: Sat, 17 Nov 2012 02:38:15 +0100
Message-ID: <1353116298-11798-3-git-send-email-felipe.contreras@gmail.com>
References: <1353116298-11798-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 17 02:39:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZXN3-0004Op-Eh
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 02:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948Ab2KQBim (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 20:38:42 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39206 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab2KQBil (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 20:38:41 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1411525bkw.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 17:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=l7CV3IanXBIa3cuErmbRx47utslCxibh5DTCNcg9NQ0=;
        b=giM3Eqa85gIirmK/iYBZBn3MBVYBOI2+ELZDkDEZq6X3nKIzqxuU1EDRUVqTxQOPXW
         SDrpznooElAlxE3H3Hc9VB/JMa7/hq1WoNqAHd4BOjIC4Kbq9SV8ZQgybjRZ0SKF0EBb
         d12mrG6KHYx5cTDPD7b6K6TpB4NpozOHSa8B2jui26OTI8JCAyWe4SRS0iwWsrzJfBSM
         hPKuAF7NhXR/MCL66bst6J0Ys8gTbhbVv+wKXPKlfr8zvTxo5uEgOGHekk2CrfN++hzL
         miO4egge+csxkKpnBSvYDxwVIJGsDBdri4luJczS7rutYcKJnQPAnXdezBODW8yVHn/E
         uSlQ==
Received: by 10.204.146.19 with SMTP id f19mr2667904bkv.4.1353116320824;
        Fri, 16 Nov 2012 17:38:40 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id d16sm1956474bkw.2.2012.11.16.17.38.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Nov 2012 17:38:39 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353116298-11798-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209926>

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
