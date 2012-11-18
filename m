From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 7/8] completion: get rid of __gitcomp_1
Date: Sun, 18 Nov 2012 11:56:52 +0100
Message-ID: <1353236213-13471-8-git-send-email-felipe.contreras@gmail.com>
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
X-From: git-owner@vger.kernel.org Sun Nov 18 11:57:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ta2ZW-00084E-Lo
	for gcvg-git-2@plane.gmane.org; Sun, 18 Nov 2012 11:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778Ab2KRK5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2012 05:57:40 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:38308 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459Ab2KRK5k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2012 05:57:40 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1599953bkw.19
        for <git@vger.kernel.org>; Sun, 18 Nov 2012 02:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=r5LMC/XHFcjiEMmD6qNGlQhX5efIUmuGwjTNKluhBS4=;
        b=fth2GaWobxICLrX0UoVa6Qs4QJCppeJaMfwd7dvy8RSWbUb2mr0y8tE2MET1nckJ4C
         nrEfmvDlRzXckzqYY+QQgahJTCYtohs0MobkaIVNtIsyDcLe1kI2iM5g2bL57FBog46P
         dnP5cWZ3Ob6n7lCTP5QO3dtFun1Xd/cSdnFcCpfzlkCGiZE9cxrr+wSVxWFG+yIYCR6r
         g9fkzqW29h1GX12Xgw6LeZh7/7i3QJijADGYqfMRfz7DYc/TdSRkHCZ8C+NsmPcYQaYz
         gQEm7WNSYqPioeBw4XE7pzo5E3JYx71vUHl5cHkQNrVK4Kn7MUpLJRGnif7Z1C5CxG0o
         ebIw==
Received: by 10.204.3.213 with SMTP id 21mr3712433bko.121.1353236259412;
        Sun, 18 Nov 2012 02:57:39 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id k21sm2896558bkv.1.2012.11.18.02.57.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Nov 2012 02:57:38 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353236213-13471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210019>

There's no point in calling a separate function that is only used in one
place. Specially considering that there's no need to call compgen, and
we traverse the words ourselves both in __gitcompadd, and __gitcomp_1.

So lets squash the functions together, and traverse only once.

This improves performance.

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0b72f24..82ea7b1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -56,19 +56,6 @@ __gitdir ()
 	fi
 }
 
-__gitcomp_1 ()
-{
-	local c IFS=$' \t\n'
-	for c in $1; do
-		c="$c$2"
-		case $c in
-		--*=*|*.) ;;
-		*) c="$c " ;;
-		esac
-		printf '%s\n' "$c"
-	done
-}
-
 # The following function is based on code from:
 #
 #   bash_completion - programmable completion functions for bash 3.2+
@@ -250,8 +237,17 @@ __gitcomp ()
 	--*=)
 		;;
 	*)
-		local IFS=$'\n'
-		__gitcompadd "$(__gitcomp_1 "${1-}" "${4-}")" "${2-}" "$cur_" ""
+		local c i=0 IFS=$' \t\n'
+		for c in $1; do
+			c="$c${4-}"
+			case $c in
+			--*=*|*.) ;;
+			*) c="$c " ;;
+			esac
+			if [[ $c == "$cur_"* ]]; then
+				COMPREPLY[i++]="${2-}$c"
+			fi
+		done
 		;;
 	esac
 }
-- 
1.8.0
