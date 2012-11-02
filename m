From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 09/14] remote-testgit: report success after an import
Date: Fri,  2 Nov 2012 03:02:13 +0100
Message-ID: <1351821738-17526-10-git-send-email-felipe.contreras@gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 03:03:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU6bV-00018E-KG
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 03:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992558Ab2KBCDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 22:03:06 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43159 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992462Ab2KBCDE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 22:03:04 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1234245bkc.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 19:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=R9bbeDNuEK4mQyk46951FdcufCYUZlFcQ6FOACs7Neo=;
        b=c3TvSM8cLmG8TiaJc5axivhlc4mw0SbDS4diyS7jn/RdrJ7nrRb+Mi7pzTEr3ZUHKZ
         YMGITgyivKbPrYZsNAgnarkLVb8hIOlhuls5i5vQykhjjFLgwKrUl7HZbcpcVm4CjBpQ
         hdF7cqznB36RtfPd+IZsCSg63urXx+0KhFHi4SS/neR54PVUDyOowmaajFZ2SjyaxSXv
         mtFJPSz6nUUUmBG44607D6QIwqX/B7vjPS/jDxUCb4MkFTZWHcbOT+nqHE1M5RQRznyf
         oyFetOdXgAZRdoTZ5Y7UowLsh42nsJhrPQQAgObvPzyG8dmkwkqIYi+IW3eSsAMcV8+B
         xNxw==
Received: by 10.204.156.13 with SMTP id u13mr20420bkw.113.1351821784094;
        Thu, 01 Nov 2012 19:03:04 -0700 (PDT)
Received: from localhost (ip-109-43-0-51.web.vodafone.de. [109.43.0.51])
        by mx.google.com with ESMTPS id e13sm5774090bkw.12.2012.11.01.19.03.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 19:03:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208906>

Doesn't make a difference for the tests, but it does for the ones
seeking reference.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-testgit | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/git-remote-testgit b/git-remote-testgit
index 6c348b0..4e8b356 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -59,7 +59,18 @@ while read line; do
             sed -e "s#refs/heads/#${prefix}/heads/#g"
         ;;
     export)
+        declare -A before after
+
+        eval $(git for-each-ref --format='before[%(refname)]=%(objectname)')
+
         git fast-import --{import,export}-marks="$testgitmarks" --quiet
+
+        eval $(git for-each-ref --format='after[%(refname)]=%(objectname)')
+
+        for ref in "${!after[@]}"; do
+            test "${before[$ref]}" ==  "${after[$ref]}" && continue
+            echo "ok $ref"
+        done
         echo
         ;;
     '')
-- 
1.8.0
