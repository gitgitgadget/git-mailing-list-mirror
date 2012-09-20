From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] completion: fix shell expansion of items
Date: Thu, 20 Sep 2012 04:15:15 +0200
Message-ID: <1348107315-25095-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 20 02:15:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEUQT-0000f4-RJ
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 02:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290Ab2ITAPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 20:15:21 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37253 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238Ab2ITAPU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 20:15:20 -0400
Received: by wibhq12 with SMTP id hq12so40922wib.1
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 17:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=LFKQH4JosonLFuls6+j7A4b8bw/68jiKUXlG6SA2ZJM=;
        b=Wlpy1psK20fxAkuULDziagHa1A1qj0lERdvFDzLnUHLZRJHTLK4td9xlH/avSKGGLj
         ZUfLL+KfgFxCv2VYn/6GVHle6282u4Z6Em7ussWLBz93OTvegCje0B0wTCH2UFUli1Cd
         EGpYX7nOTnXc6b8SsG618/Jc/On7x7jw2NzOnEgqkWevbP4V/eFSv0N7DvcfHRHqconx
         dhkHnnf3E4dy0R5XVHCB7Dpx0u3/H++UqtNLAliKAjngvAXG1okyeKdQfQMwkoNWU0AF
         lrdwfeTWkvlmIXOCZJUsq3z6Jzropc7REisGAv9blFSB2Ae8Z/c8JWpwcuVf0p+ivzYo
         2Z0w==
Received: by 10.180.78.40 with SMTP id y8mr449249wiw.7.1348100118754;
        Wed, 19 Sep 2012 17:15:18 -0700 (PDT)
Received: from localhost (ip-109-43-0-104.web.vodafone.de. [109.43.0.104])
        by mx.google.com with ESMTPS id k2sm7690416wiz.7.2012.09.19.17.15.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 19 Sep 2012 17:15:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206019>

As reported by Jeroen Meijer[1]; the current code doesn't deal properly
with items (tags, branches, etc.) that have ${} in them because they get
expaned by bash while using compgen.

A simple solution is to quote the items so they get expanded properly
(\$\{\}).

In order to achieve that I took bash-completion's quote() function,
which is rather simple, and renamed it to __git_quote() as per Jeff
King's suggestion.

Solves the original problem for me.

[1] http://article.gmane.org/gmane.comp.version-control.git/201596

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index d743e56..5a5b5a0 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -225,6 +225,13 @@ _get_comp_words_by_ref ()
 fi
 fi
 
+# Quotes the argument for shell reuse
+__git_quote()
+{
+	local quoted=${1//\'/\'\\\'\'}
+	printf "'%s'" "$quoted"
+}
+
 # Generates completion reply with compgen, appending a space to possible
 # completion words, if necessary.
 # It accepts 1 to 4 arguments:
@@ -261,7 +268,7 @@ __gitcomp ()
 __gitcomp_nl ()
 {
 	local IFS=$'\n'
-	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$1" -- "${3-$cur}"))
+	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$(__git_quote "$1")" -- "${3-$cur}"))
 }
 
 __git_heads ()
-- 
1.7.10.3
