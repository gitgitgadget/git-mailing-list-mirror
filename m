From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 3/7] completion: add new __gitcompadd helper
Date: Wed, 10 Apr 2013 01:57:53 -0500
Message-ID: <1365577077-12648-4-git-send-email-felipe.contreras@gmail.com>
References: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 08:59:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPp01-0007T8-Dt
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 08:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310Ab3DJG7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 02:59:11 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:37175 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab3DJG7K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 02:59:10 -0400
Received: by mail-qc0-f178.google.com with SMTP id d10so60680qca.37
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 23:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=5kUi13V43urrSf5bUafwiOk82wijFwNrll30CbbAnBE=;
        b=zdUD4coyFq5+rXoQvk489ubHh9HRxLeWYGgW4w9TXhHbruGryq2OmKllZlWr9OEeen
         dmOYjZOGt8zSdQZ8hHeE0AwjAdTkvLXPlJZo3buJK1mFT8oUaKIK0BMNmb8KGb9imMOy
         qPIGaIElJWjUWGPs6I9j6kmsvTaiPN+SkA2JwbZbbl1AU/XBZoLabsDZHLGsHQIUjrdB
         cQx/3oyucTVp5NFAayeH+PXiHYJh3z2kxwii7YMLIHV+dVCpv+oFGFqSoIq6WyvnmWws
         krXQqmYO8szLgD0ka8OlEzrcdF+3Q3ORy/6mLN9sLJnQkDvFK/I8MsRHH0oe8E+7cNyU
         HsnA==
X-Received: by 10.224.74.208 with SMTP id v16mr1176346qaj.0.1365577150120;
        Tue, 09 Apr 2013 23:59:10 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id ds5sm8626127qab.11.2013.04.09.23.59.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 23:59:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220666>

The idea is to never touch the COMPREPLY variable directly.

This allows other completion systems (i.e. zsh) to override
__gitcompadd, and do something different instead.

Also, this allows further optimizations down the line.

There should be no functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2c87fd8..90b54ab 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -195,6 +195,11 @@ _get_comp_words_by_ref ()
 }
 fi
 
+__gitcompadd ()
+{
+	COMPREPLY=($(compgen -W "$1" -P "$2" -S "$4" -- "$3"))
+}
+
 # Generates completion reply with compgen, appending a space to possible
 # completion words, if necessary.
 # It accepts 1 to 4 arguments:
@@ -211,9 +216,7 @@ __gitcomp ()
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
@@ -230,7 +233,7 @@ __gitcomp ()
 __gitcomp_nl ()
 {
 	local IFS=$'\n'
-	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
+	__gitcompadd "$1" "${2-}" "${3-$cur}" "${4- }"
 }
 
 # Generates completion reply with compgen from newline-separated possible
@@ -1820,7 +1823,7 @@ _git_config ()
 		local remote="${prev#remote.}"
 		remote="${remote%.fetch}"
 		if [ -z "$cur" ]; then
-			COMPREPLY=("refs/heads/")
+			__gitcompadd "refs/heads/"
 			return
 		fi
 		__gitcomp_nl "$(__git_refs_remotes "$remote")"
-- 
1.8.2.1
