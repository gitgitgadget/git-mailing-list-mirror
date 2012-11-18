From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 3/8] completion: add new __gitcompadd helper
Date: Sun, 18 Nov 2012 11:56:48 +0100
Message-ID: <1353236213-13471-4-git-send-email-felipe.contreras@gmail.com>
References: <1353236213-13471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20Gustavsson?= <bgustavsson@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robert Zeh <robert.a.zeh@gmail.com>,
	Peter van der Does <peter@avirtualhome.com>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 18 11:57:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2ZD-0007rR-Cv
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 11:57:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595Ab2KRK5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 05:57:23 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38308 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557Ab2KRK5W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 05:57:22 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1599953bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 02:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=tAa7WwoNZ2Ga9WFYvSf0+XoHMQj0E5uVHlay+hOEiQA=;
        b=fhCDoqcwL8EwmwoNKXXbqx5xMfUa7EjuEz4QkQYvL/PsLYYD1wVLz34FIQEke92sb8
         nvBz3dGHKSM03WCAKoXkatzyiduWS9JFGgbklJzly0zta8tCGiyLuSPYADVC9w3NFVBd
         l910UFW0/JjYM063V5ETfRdWZkisghS9EzPNh6Dg8hyPMTxkbCCkUl8IJmQxjbw6QYu9
         Z6nw9Zjy1GZNQX0PwBmowFrjJA1ox8Fe3uU6vwmxuvsfcxLufAecE0jO3/6Ygo+FtXkn
         UAmDTgJAw4c8ShAJWUzXkUUicjRusBscUlL/P1vFWZs0/i6PvimbVBDHR/iE8EFVhQDy
         FMDQ==
Received: by 10.204.15.203 with SMTP id l11mr555192bka.74.1353236241867;
        Sun, 18 Nov 2012 02:57:21 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id u3sm2896487bkw.9.2012.11.18.02.57.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 02:57:20 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353236213-13471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210014>

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
index c2fb061..19e18a8 100644
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
@@ -1605,7 +1608,7 @@ _git_config ()
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
