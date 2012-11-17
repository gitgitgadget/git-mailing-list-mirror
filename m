From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 5/5] completion: refactor __gitcomp_1
Date: Sat, 17 Nov 2012 02:38:18 +0100
Message-ID: <1353116298-11798-6-git-send-email-felipe.contreras@gmail.com>
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
X-From: git-owner@vger.kernel.org Sat Nov 17 02:39:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZXND-0004aQ-3B
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 02:39:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753979Ab2KQBiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 20:38:54 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39206 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753814Ab2KQBix (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 20:38:53 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1411525bkw.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 17:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=9zEOTTFAjBTxn568qiMEj33Toz4R/Z0b6OiggJJCpBk=;
        b=x232IWAkNRHCnxCfDwwcjKBCCDc/LbYNkmcetYtgMKFlkZb4kyTEAsHM+YsEJ631Tk
         a35cfeX0OBPk/s5H1L4UFtUhB7sb7kZCeXJkBADEpNs1G+MklOaA59hM0q6WhFZlwEeY
         Yqft2c2LdQz9mYYNGQ2MCv8Nw5OpWyhlKZIjVFftUr7APL131EEamHsle/myrSybhV5K
         ZmM1uOvwRp7qDPwalgmoj3Oa6G94E0SuQXAdANxWJpyZolCU4SNKYlVpxFV/7RmK75BO
         01n1hniIZ+4Y6lY8V4JkdBmBeMnfO9tqYmpWRdcPwCnOILL3NOzbgdnvNNbGfjLNfXk4
         ueLQ==
Received: by 10.205.125.137 with SMTP id gs9mr2700082bkc.22.1353116333222;
        Fri, 16 Nov 2012 17:38:53 -0800 (PST)
Received: from localhost (ip-109-43-0-81.web.vodafone.de. [109.43.0.81])
        by mx.google.com with ESMTPS id k21sm2003619bkv.1.2012.11.16.17.38.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Nov 2012 17:38:52 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353116298-11798-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209928>

It's only used by __gitcomp, so move some code there and avoid going
through the loop again.

We could get rid of it altogether, but it's useful for zsh's completion
wrapper.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ad3e1fe..d92d11e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -58,15 +58,12 @@ __gitdir ()
 
 __gitcomp_1 ()
 {
-	local c IFS=$' \t\n'
-	for c in $1; do
-		c="$c$2"
-		case $c in
-		--*=*|*.) ;;
-		*) c="$c " ;;
-		esac
-		printf '%s\n' "$c"
-	done
+	local c=$1
+	case $c in
+	--*=*|*.) ;;
+	*) c="$c " ;;
+	esac
+	printf '%s\n' "$c"
 }
 
 # The following function is based on code from:
@@ -249,10 +246,16 @@ __gitcomp ()
 	--*=)
 		;;
 	*)
-		local IFS=$'\n'
-		__gitcompadd "$(__gitcomp_1 "${1-}" "${4-}")" "${2-}" "$cur_" ""
+		local c IFS=$' \t\n'
+		for c in ${1-}; do
+			c=`__gitcomp_1 "$c${4-}"`
+			if [[ "$c" = "$cur_"* ]]; then
+				COMPREPLY+=("${2-}$c")
+			fi
+		done
 		;;
 	esac
+
 }
 
 # Generates completion reply with compgen from newline-separated possible
-- 
1.8.0
