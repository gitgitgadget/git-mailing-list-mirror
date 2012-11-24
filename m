From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p1.1 10/14] remote-testgit: report success after an import
Date: Sat, 24 Nov 2012 04:17:10 +0100
Message-ID: <1353727034-24698-11-git-send-email-felipe.contreras@gmail.com>
References: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:18:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6GA-0002E8-Bw
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630Ab2KXDSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:18:05 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61989 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932594Ab2KXDSD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:18:03 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063027bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TG7+5+n9J4Av0bb5V6A3anEdb4xpPgaPaP2X0ZDO4lI=;
        b=cWE+S2P1RyQl+N1HPVae2JEg4h95nujW/xWxq5IKxIvX0L9e4uv/kVYrCe6+6Q1Jkp
         x0uNr24bh5OGtU7r6ApEEL8lkJ7FAuVUC5Z8DSDqzuQIlfA9kL0XcFmo1Fbfp63fGy3B
         4gcOxRb/fPSuc45MwARZYrf718ix2bGZxF6W4wbDyvu4Y3xMWFpcFcxi0eULpOHNAsk3
         aYkqJe/on5vrbRj1xPZikLmEx+h2oCUFckoV8OsQJR2uTA5rvZNru8aevklrZMSFZl1s
         hNQUguTVPLDXHPl9rUelyB2baQ/uW5q3BVZJJy7a6wPOk+wYH3zqW0bG3dSKNVpmD2yR
         OymQ==
Received: by 10.204.4.145 with SMTP id 17mr1751461bkr.34.1353727082435;
        Fri, 23 Nov 2012 19:18:02 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id gy18sm5466552bkc.4.2012.11.23.19.18.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:18:01 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210294>

Doesn't make a difference for the tests, but it does for the ones
seeking reference.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-testgit | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/git-remote-testgit b/git-remote-testgit
index e140282..aba3502 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -65,7 +65,20 @@ do
 		sed -e "s#refs/heads/#${prefix}/heads/#g"
 		;;
 	export)
+		before=$(git for-each-ref --format='%(refname) %(objectname)')
+
 		git fast-import "${testgitmarks_args[@]}" --quiet
+
+		after=$(git for-each-ref --format='%(refname) %(objectname)')
+
+		# figure out which refs were updated
+		join -e 0 -o '0 1.2 2.2' -a 2 <(echo "$before") <(echo "$after") |
+		while read ref a b
+		do
+			test $a == $b && continue
+			echo "ok $ref"
+		done
+
 		echo
 		;;
 	'')
-- 
1.8.0
